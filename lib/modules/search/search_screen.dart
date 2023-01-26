

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/layout/cubit/states.dart';

import '../../shared/widgets/task_widget.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state){
        var tasks = AppCubit.get(context).searchResult;
        double h = MediaQuery.of(context).size.height;
        double w = MediaQuery.of(context).size.width;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Search'),
            leading: IconButton(
              icon: const Icon(
                  Icons.arrow_back_ios_outlined
              ),
              onPressed: () {
                Navigator.pop(context);
                AppCubit.get(context).isSearchOpened = false;
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: w*0.035,left: w*0.035,top: h*0.03),
                  child: TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                      suffixIcon: const Icon(Icons.search,color: Colors.grey,),
                      hintStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                      fillColor: Colors.white,
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),

                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      AppCubit.get(context).searchTask(value.toString());
                    },
                  ),
                ),
                BuildCondition(
                  condition: state is !GetTasksLoading,
                  builder:(context) => BuildCondition(
                    condition: tasks.isNotEmpty ,
                    builder: (context) => Column(
                      children: [
                        SizedBox(height: h*0.015,),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) => buildTaskItem(
                              tasks[index],
                              context,
                              Colors.lightGreen,
                              doneVisible: false,
                              index: index,
                            ),
                            itemCount: tasks.length),
                      ],
                    ),
                    fallback: (context) => Padding(
                      padding: EdgeInsets.symmetric(vertical: h/4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.menu,
                            size: 100,
                            color: Colors.grey,
                          ),
                          Text('No Tasks Found',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),)
                        ],
                      ),
                    ) ,
                  ),
                  fallback: (context) => const Center(child: CircularProgressIndicator(color: Colors.blue,),),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
