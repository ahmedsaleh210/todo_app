import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/homelayout.dart';
import 'package:todo_app/modules/signin/signin_screen.dart';
import 'package:todo_app/shared/BlocObserver.dart';
import 'package:todo_app/shared/constants.dart';
import 'package:todo_app/shared/local/shared_preferences.dart';
import 'package:todo_app/shared/style/themes.dart';

import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
//test
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CacheHelper.init();
  final Widget startWidget;
  uId = CacheHelper.getData(key: 'uId');
  dynamic isDark = CacheHelper.getData(key: 'isDark');
  if (uId != null) {
    startWidget = HomeLayout();
  } else {
    startWidget = SignInScreen();
  }
  runApp(
      DevicePreview(
          builder: (BuildContext context) { return MyApp(startWidget: startWidget,isDark: isDark,); },
      )
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final dynamic isDark;
  const MyApp({Key? key,required this.startWidget,required this.isDark}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getDate()..changeAppMode(
        fromShared: isDark
      )..getTasks()..getDoneTasks()..initNotification(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: AppCubit.get(context).isDark==true?ThemeMode.dark:ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}