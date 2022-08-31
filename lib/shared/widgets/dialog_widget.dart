import 'package:flutter/material.dart';

import '../../layout/cubit/cubit.dart';

Future<dynamic> showThemeDialog(context){
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppCubit.get(context).isDark?Colors.black54:Colors.white,
          title: Center(child: Text(
              'Change Theme',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.bold
              ),)),
          actions: <Widget>[
            ListTile(
              horizontalTitleGap: 1,
              minLeadingWidth: 1.0,
              contentPadding:const EdgeInsets.all(0.0),
              title: Text('Light',style: Theme.of(context).textTheme.bodyText2,),
              leading: Radio<Themes>(
                value: Themes.light,
                groupValue: AppCubit.get(context).theme,
                onChanged: (value) {
                  if(AppCubit.get(context).isDark==true)
                  {
                    AppCubit.get(context).changeAppMode();
                  }
                  else{
                    dismissDialog(context);
                  }
                },
                activeColor: Colors.blueAccent,
              ),
            ),
            ListTile(
              horizontalTitleGap: 1,
              minLeadingWidth: 1.0,
              contentPadding:const EdgeInsets.all(0.0),
              title: Text('Dark',style: Theme.of(context).textTheme.bodyText2),
              leading: Radio<Themes>(
                value: Themes.dark,
                groupValue: AppCubit.get(context).theme,
                onChanged: (value) {
                  if(AppCubit.get(context).isDark==false)
                  {
                    AppCubit.get(context).changeAppMode();
                  }
                  else{
                    dismissDialog(context);
                  }
                },
                activeColor: Colors.blueAccent,
              ),
            ),

          ],
        );
      });
}

dismissDialog(context) {
  Navigator.pop(context);
}