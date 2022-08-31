
import 'package:firebase_auth/firebase_auth.dart';

abstract class TodoLoginStates {
}

class LoginInitState extends TodoLoginStates{}

class LoginLoadingState extends TodoLoginStates{}

class LoginSuccessState extends TodoLoginStates{
final String uId;
LoginSuccessState(this.uId);
}

class LoginErrorState extends TodoLoginStates{
  final FirebaseAuthException error;
  LoginErrorState(this.error);
}

class GoogleLoginSuccess extends TodoLoginStates{
  String? uId;
  String? name;
  GoogleLoginSuccess(this.uId,this.name);
}

class GoogleLoginError extends TodoLoginStates{}

class GoogleLoginLoading extends TodoLoginStates{}

class FacebookLoginSuccess extends TodoLoginStates{
  String? uId;
  String? name;
  FacebookLoginSuccess(this.uId,this.name);
}

class FacebookLoginError extends TodoLoginStates{}

class FacebookLoginLoading extends TodoLoginStates{}

class CreateUserLoadingState extends TodoLoginStates{}

class CreateUserSuccessState extends TodoLoginStates{}

class CreateUserErrorState extends TodoLoginStates{}