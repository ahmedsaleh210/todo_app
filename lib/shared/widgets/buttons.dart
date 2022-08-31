import 'package:flutter/material.dart';

import '../../layout/cubit/cubit.dart';

customButton2({required context, required title, required h,required Function onTap,IconData? icon}){
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if(icon!=null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(icon),
          ),
          Text(title,style: TextStyle(
              fontSize: h*0.02,
              fontWeight: FontWeight.w600
          ),),
          const Spacer(),
          Icon(Icons.arrow_forward_ios,color:
          AppCubit.get(context).isDark?
          Colors.white.withOpacity(0.8):
          Colors.black.withOpacity(0.6),
          ),
          SizedBox(height: h*0.035,),
        ],
      ),
    ),
  );
}

Widget defaultButton(context,
    {
      required Function onTap,
      required String text,
      bool isRadius = true,
      bool isEnabled = true,
      double radius = 20,
    }
    ) {
  var height = MediaQuery.of(context).size.height;
  return Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration
      (
        borderRadius: isRadius? BorderRadius.circular(radius):null,
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor
    ),
    width: double.infinity,
    height: height/14.2,
    child: MaterialButton(
      onPressed: isEnabled==true?() {
        onTap();
      }:null,
      child: Text(
          text,
          style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white,
              fontSize: height/40
          ),
      ),
    ),
  );
}

Widget socialButton(
{
  required BuildContext context,
  required Color color,
  required String label,
  required IconData icon,
  required Function onTap,
  Color? iconColor,
})
{
  var h = MediaQuery.of(context).size.height;
  var w = MediaQuery.of(context).size.width;

  return Container(
    width: double.infinity,
    height: h/20,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration
      (
        borderRadius: BorderRadius.circular(25),
        color: color
    ),
    child: MaterialButton(
      onPressed: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: iconColor??iconColor,),
          SizedBox(width: w*0.015,),
          Text(
            label,
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white,
              fontSize: w/25
          ),
    ),
        ],
      ),
    ),
  );
}
