import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/cubit/states.dart';
import 'package:todo_app/shared/widgets/dialog_widget.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/widgets/buttons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            leading: IconButton(
              icon: const Icon(
                  Icons.arrow_back_ios_outlined
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: w*0.02),
            child: Column(
              children: [
                SizedBox(height: h*0.02,),
                customButton2(
                    context:context,
                    title:'Account Info',
                    h:h,
                    onTap: () {
                }),
                customButton2(context:context, title:'Change Theme',h:h, onTap: (){
                  showThemeDialog(context);
                }),
                customButton2(context:context, title:'Sign out',h:h,onTap: (){
                  AppCubit.get(context).signOut();
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
