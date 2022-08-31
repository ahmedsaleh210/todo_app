import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/modules/register/register_screen.dart';
import 'package:todo_app/modules/signin/signin_cubit.dart';
import 'package:todo_app/modules/signin/signin_states.dart';
import 'package:todo_app/shared/widgets/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/widgets/TextFormField.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/local/firebase_errors.dart';
import '../../shared/signin_details.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final email = TextEditingController();
  final password = TextEditingController();
  final login = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,TodoLoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState
              || state is GoogleLoginSuccess
                 || state is FacebookLoginSuccess
          ){
            getSignInDetails(state,context);
            AppCubit.get(context).getNotificationsWhenLogin();
          }
          else if (state is LoginErrorState){
            showToast(Errors.show(state.error.code));
          }
          else if (state is FacebookLoginError){
            showToast('Can\'n connect with Facebook');
          }
          else if (state is FacebookLoginLoading || state is GoogleLoginLoading){
            showToast('Wait for moment');
          }

        },
        builder: (context,state){
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  createShape(context),
                  Text('Sign in',style: Theme.of(context).textTheme.headline3,),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: login,
                      child: Column(
                        children: [
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
                              type: TextInputType.emailAddress,
                              secure: true,
                              validator: (value) {
                                if(value.isEmpty) {
                                  return 'password is empty';
                                }
                                return null;
                              },
                              label: 'Password',
                              prefix: Icons.lock_outline_rounded),
                        ],
                      ),
                    ),
                  ),
                  state is !LoginLoadingState?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: defaultButton(
                      context,
                      onTap: () {
                        if(login.currentState!.validate()){
                          LoginCubit.get(context).userLogin(
                              email: email.text,
                              password: password.text);
                        }
                      },
                      text: 'Sign in',),
                  )
                  :
                      const Center(child: CircularProgressIndicator(),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?',style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),),
                      TextButton(
                        onPressed: () {
                          navigateTo(context, RegisterScreen());
                        },
                        style: TextButton.styleFrom(padding: const EdgeInsets.all(4)),
                        child: const Text('Register',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold

                        ),),
                      ),
                    ],),
                  myDivider(),
                  const SizedBox(height: 15,),
                  Text('Or Connect With',style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: AppCubit.get(context).isDark?Colors.white70:Colors.grey,
                    fontSize: 15,
                  )),
                  const SizedBox(height: 7,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: socialButton(
                              context: context,
                              onTap: () {
                                LoginCubit.get(context).signInWithFacebook();
                              },
                              label: 'Facebook',
                              color: const Color(0xff4267B2),
                              icon: FontAwesomeIcons.facebook,
                              iconColor: Colors.white
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: socialButton(
                              context: context,
                              onTap: () {
                                LoginCubit.get(context).googleLogin();
                              },
                              label: 'Google',
                              color: const Color(0xffDB4437),
                              icon: FontAwesomeIcons.google,
                              iconColor: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
