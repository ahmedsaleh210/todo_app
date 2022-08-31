import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/shared/style/colors.dart';
import '../style/customclipper.dart';

 Widget myDivider() =>  Padding(
   padding: const EdgeInsets.symmetric(horizontal: 20.0),
   child: Container(
     height: 1,
     color: Colors.grey[300],
     width: double.infinity,
   ),
 );

    void navigateTo(context,widget) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
    }

Widget createShape(context) {
  bool isDark = AppCubit.get(context).isDark;
  return Stack(
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              padding: const EdgeInsets.only(bottom: 450),
              color: isDark?Colors.amber.withOpacity(0.7):AppColors.lightAppBar.withOpacity(.8),
              height: 220,
              alignment: Alignment.center,

            ),
          ),
          ClipPath(
            clipper: WaveClipper(waveDeep: 0, waveDeep2: 100 ),
            child: Container(
              padding: EdgeInsets.only(bottom: 50),
              color: isDark?Colors.amber.withOpacity(0.3):AppColors.lightButton.withOpacity(0.3),
              height: 180,
              alignment: Alignment.center,

            ),
          ),

        ],
      );
}

void navigateAndFinish(context,widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget,),
          (route) => false

  );
}

showToast(msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
  );
}



