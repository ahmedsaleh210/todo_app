import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/register/register_cubit.dart';
import 'package:todo_app/modules/register/register_states.dart';
import 'package:todo_app/modules/signin/signin_screen.dart';
import 'package:todo_app/shared/widgets/components.dart';

import '../../shared/widgets/TextFormField.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/local/firebase_errors.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final register = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,TodoRegiserStates>(
        listener: (context,state) {
          if(state is RegisterSuccessState){
            navigateAndFinish(context, SignInScreen());
            showToast('Signed up Successfully');
          }
          else if (state is RegisterErrorState){
            showToast(Errors.show(state.error.code));
          }
        },
        builder: (context,state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  createShape(context),
                  Text('Sign up',style: Theme.of(context).textTheme.headline3,),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: register,
                      child: Column(
                        children: [
                          defaultFormField(
                              context,
                              controller: name,
                              type: TextInputType.name,
                              validator: (value) {
                                if(value.isEmpty) {
                                  return 'email is empty';
                                }
                                return null;
                              },
                              label: 'Name',
                              prefix: Icons.lock_outline_rounded),
                          const SizedBox(height: 15,),
                          defaultFormField(
                              context,
                              controller: email,
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if(value.isEmpty) {
                                  return 'email is empty';
                                }
                                return null;
                              },
                              label: 'Email',
                              prefix: Icons.email),
                          const SizedBox(height: 15,),
                          defaultFormField(
                              context,
                              controller: password,
                              secure: true,
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if(value.isEmpty) {
                                  return 'password is empty';
                                }
                                else if(value.toString().length<6){
                                  return 'password must be at least 6 characters';
                                }
                                else if(value.toString()!=confirmPassword.text){
                                  return 'Does not match';
                                }
                                return null;
                              },
                              label: 'Password',
                              prefix: Icons.lock_outline_rounded),
                          const SizedBox(height: 15,),
                          defaultFormField(
                              context,
                              controller: confirmPassword,
                              secure: true,
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if(value.isEmpty) {
                                  return 'Confirm password is empty';
                                }
                                else if(value.toString()!=password.text){
                                  return 'Does not match';
                                }
                                return null;
                              },
                              label: 'Confirm Password',
                              prefix: Icons.lock_outline_rounded),
                        ],
                      ),
                    ),
                  ),
                  state is !RegisterLoadingState?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: defaultButton(
                      context,
                      onTap: () {
                        if(register.currentState!.validate()){
                          RegisterCubit.get(context).userRegister
                            (
                            name: name.text,
                            email: email.text,
                            password: password.text,
                          );
                        }
                      },
                      text: 'Sign up',),
                  ):
                  const Center(child: CircularProgressIndicator(),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?',style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                      TextButton(
                        onPressed: () {
                          navigateTo(context, SignInScreen());
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(60, 30),),
                        child: const Text('Sign in',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,

                          ),),
                      ),
                    ],)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
