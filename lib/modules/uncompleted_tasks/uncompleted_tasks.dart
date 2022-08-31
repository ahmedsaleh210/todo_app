import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/layout/cubit/states.dart';

import '../../shared/widgets/task_widget.dart';


class UnCompletedTasksScreen extends StatelessWidget {
  const UnCompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state){
        var tasks = AppCubit.get(context).unCompletedTasks;
        return BuildCondition(
          condition: tasks.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                if(state is GetTasksLoading || state is RemoveTaskLoading)...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: LinearProgressIndicator(),
                  ),
                  const SizedBox(height: 5,),
                ],
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) => buildTaskItem(
                        tasks[index],
                        context,
                        Colors.lightBlue,
                        doneVisible: false),
                    itemCount: tasks.length),
              ],
            ),
          ),
          fallback: (context) =>Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.menu,
                  size: 100,
                  color: Colors.grey,
                ),
                Text('No Tasks Yet',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),)
              ],
            ),
          ) ,
        );
      },
    );
  }
}
