import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/layout/cubit/states.dart';

import '../../shared/widgets/components.dart';
import '../../shared/widgets/date_widget.dart';
import '../../shared/widgets/task_widget.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if(AppCubit.get(context).selectedDate!=null)
          {
            AppCubit.get(context).getTaskByDate();
          }
        return BlocConsumer<AppCubit,AppStates>(
          listener: (context,state) {},
          builder: (context,state) {
            var cubit = AppCubit.get(context);
            var h = MediaQuery.of(context).size.height;
            var w = MediaQuery.of(context).size.width;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Schedule'),
                elevation: 1,
                leading: IconButton(
                  icon: const Icon(
                      Icons.arrow_back_ios_outlined
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: h*0.105,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index) => createDateItems(w, h, cubit.daysInMonth[index], cubit.isSelected[index], context, index),
                            itemCount: cubit.daysInMonth.length
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: h*.01),
                      child: myDivider(),
                    ),
                    if(AppCubit.get(context).selectedDate!=null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w*0.04),
                      child: Row(
                        children: [
                            Text(DateFormat('E').format(DateTime.parse(cubit.selectedDate.toString())),style: const TextStyle(
                            fontSize: 18,
                                fontWeight: FontWeight.w500

                            ),),
                          const Spacer(),
                          Text(DateFormat('yMMMMd').format(DateTime.parse(cubit.selectedDate.toString())),style: const TextStyle(
                          fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    BuildCondition(
                      condition:cubit.dateTasks.isNotEmpty ,
                      builder:(context) => ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => buildTaskItem(
                              cubit.dateTasks[index],
                              context,
                              Colors.black26,
                              doneVisible: false,
                          ),
                          itemCount: cubit.dateTasks.length),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
