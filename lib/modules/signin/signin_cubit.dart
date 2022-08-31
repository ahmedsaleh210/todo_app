import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/modules/signin/signin_states.dart';
import 'package:todo_app/shared/local/shared_preferences.dart';

import '../../models/user_model.dart';

class LoginCubit extends Cubit<TodoLoginStates>{
  LoginCubit():super(LoginInitState());
  static LoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }){
    emit(LoginLoadingState());
    FirebaseAuth.instance.
    signInWithEmailAndPassword(email: email, password: password)
        .then((value){
      getUserDetails(value.user?.uid);
      CacheHelper.saveData(key: 'isSocialUser', value: 'Default');
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((onError){
      emit(LoginErrorState(onError));
    });
  }
  void getUserDetails(uId){
    UserModel? userDetails;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get().then((value) {
      userDetails = UserModel.fromJson(value.data()!);
      CacheHelper.saveData(key: 'name', value: userDetails?.name);
    });
  }

  GoogleSignInAccount? googleAccount;
  Future googleLogin() async{
    final googleUser = await GoogleSignIn().signIn();
    if(googleUser==null) return;
    googleAccount = googleUser;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
    );
    FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      User? userInfo = value.user;
      await FirebaseFirestore.instance.collection('users').doc(userInfo?.uid).get().then((value) {
        if (!value.exists){
          createUser(
              name: userInfo?.displayName,
              email: userInfo?.email,
              uID: userInfo?.uid,
              isSocialUser: 'Google',
          );
        }
        else {
          print('Already Exists');
        }
      });
      CacheHelper.saveData(key: 'isSocialUser', value: 'Google');
      emit(GoogleLoginSuccess(userInfo?.uid,userInfo?.displayName));
    }).catchError((onError){
      print(onError.toString());
    });
  }

  Future signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
          permissions: [
            'email',
            'public_profile'
          ]
      );
      emit(FacebookLoginLoading());
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
      // Once signed in, return the UserCredential
      FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).then((value) async {
        User? userInfo = value.user;
        await FirebaseFirestore.instance.collection('users').doc(userInfo?.uid).get().then((value) {
          if (!value.exists){
            createUser(
              name: userInfo?.displayName,
              email: userInfo?.email,
              uID: userInfo?.uid,
              isSocialUser: 'Facebook',
            );
          }
          else {
            print('Already Exists');
          }
        });
        CacheHelper.saveData(key: 'isSocialUser', value: 'Facebook');
        emit(FacebookLoginSuccess(userInfo?.uid,userInfo?.displayName));
      }).catchError((onError){
        emit(FacebookLoginError());
      });
    }catch(e){
      emit(FacebookLoginError());
    }
  }

  Future createUser({
    required String? name,
    required String? email,
    required String? uID,
    required String isSocialUser,
  }) async{
    emit(CreateUserLoadingState());
    UserModel model = UserModel(
        name:name,
        email:email,
        uID:uID,
        isSocialUser: isSocialUser,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .set(model.toJson()).then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState());
    });
  }
}
