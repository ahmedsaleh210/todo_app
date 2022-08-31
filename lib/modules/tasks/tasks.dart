import 'package:buildcondition/buildcondition.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/layout/cubit/states.dart';

import '../../shared/widgets/task_widget.dart';


class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state){
        double h = MediaQuery.of(context).size.height;
        var cubit = AppCubit.get(context);
        var tasks = cubit.allTasks;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: h*0.01,),
              if(state is GetTasksLoading || state is RemoveTaskLoading || state is GetDoneTasksLoading)...[
               const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: LinearProgressIndicator(),
                ),
                const SizedBox(height: 5,),
              ],
              state is !GetTasksLoading?BuildCondition(
                condition:tasks.isNotEmpty ,
                builder:(context) => Column(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                        itemBuilder: (context, index) => buildTaskItem(
                            tasks[index],
                            context,
                            Colors.black26,
                            doneVisible: true,
                            index: index,
                           state: state
                        ),
                        itemCount: tasks.length),
                  ],
                ),
                fallback:(context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: h*0.05),
                      Icon(
                        Icons.menu,
                        size: h*0.13,
                        color: Colors.grey,
                      ),
                      Text('No Tasks Yet',
                      style: TextStyle(
                        fontSize: h*.035,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),)
                    ],
                  ),
                ) ,
              ):const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        );
        },
    );
  }
}
