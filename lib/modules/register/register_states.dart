import 'package:firebase_auth/firebase_auth.dart';

abstract class TodoRegiserStates {}

class RegisterInitState extends TodoRegiserStates{}

class RegisterLoadingState extends TodoRegiserStates{}

class RegisterSuccessState extends TodoRegiserStates{}

class RegisterErrorState extends TodoRegiserStates{
  final FirebaseAuthException error;
  RegisterErrorState(this.error);
}


class CreateUserLoadingState extends TodoRegiserStates{}

class CreateUserSuccessState extends TodoRegiserStates{}

class CreateUserErrorState extends TodoRegiserStates{}