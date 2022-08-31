import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/modules/register/register_states.dart';

class RegisterCubit extends Cubit<TodoRegiserStates>{
RegisterCubit():super(RegisterInitState());
static RegisterCubit get(context) => BlocProvider.of(context);
void userRegister({
  required String name,
  required String email,
  required String password,
}){
emit(RegisterLoadingState());
FirebaseAuth.instance.
createUserWithEmailAndPassword(email: email, password: password)
    .then((value){
      createUser(
          name: name,
          email: email,
          uID: value.user!.uid,
          isSocialUser: 'Default'
      );
      emit(RegisterSuccessState());
}).catchError((onError){
  print(onError.code);
  emit(RegisterErrorState(onError));

});
}


void createUser({
  required String name,
  required String email,
  required String uID,
  required String isSocialUser,
}){
  emit(CreateUserLoadingState());
  UserModel model = UserModel(
      name:name,
      email:email,
      uID:uID,
      isSocialUser: isSocialUser,
  );
  FirebaseFirestore.instance
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