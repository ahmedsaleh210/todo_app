import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/style/colors.dart';

import '../../layout/cubit/cubit.dart';

Widget createDateItems(width,height,DateTime now,isSelected,context,index) {
  return  Padding(
    padding: EdgeInsets.symmetric(horizontal: width*0.023,vertical: height*0.002),
    child: InkWell(
      onTap: () {
        if(AppCubit.get(context).isSelected[index]!=true) {
          AppCubit.get(context).dateToggle(index);
        }
      },
      child: Container(
        width: width*0.16,
        decoration: BoxDecoration(
          color: isSelected?AppColors.lightAppBar:Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow:[
            AppCubit.get(context).isDark?
            const BoxShadow(
              color: Colors.white,
              blurRadius: .6, // soften the shadow
              spreadRadius: .2,
            ):
            BoxShadow(
              color: Colors.grey.withOpacity(.4),
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 1.0,

            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height*0.015),
          child: Column(
            children: [
              Text(DateFormat('EEE').format(now),style: TextStyle(
                  color: isSelected?Colors.white:Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: width*0.04,
                height: 1.2,

              ),),
              const Spacer(),
              Text('${now.day}',style: TextStyle(
                height: 1,
                  color: isSelected?Colors.white:Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: width*0.04
              ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
