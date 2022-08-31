import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/layout/cubit/states.dart';
import 'package:todo_app/shared/widgets/components.dart';
import 'package:todo_app/shared/style/colors.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/widgets/TextFormField.dart';
import '../../shared/widgets/buttons.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  final dateController_2 = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {
        if(state is CreateTaskSucess){
          showToast('Added Task Successfully');
        }
      },
      builder: (context,state) {
        double h = MediaQuery.of(context).size.height;
        double w = MediaQuery.of(context).size.width;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Add New Task'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w*0.06,vertical: h*0.016),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h*0.02,),
                    Center(child: Image.asset('assets/icons/clipboard.png',height: h*0.12,)),
                    Padding(
                      padding: EdgeInsets.only(top: h*0.01,bottom: h*0.01),
                      child: const Text('Title'),
                    ),
                    defaultFormField_2(
                        context,
                        controller: titleController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Time is Empty';
                          }
                          return null;
                        },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h*0.02,bottom: h*0.01),
                      child: const Text('Date'),
                    ),
                    defaultFormField_2(
                        context,
                        controller: dateController,
                        type: TextInputType.text,
                        suffix: Icons.calendar_today_outlined,
                      readOnly: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Time is Empty';
                        }
                        return null;
                      },
                      onTap: () {
                        showDatePicker(context: context, initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse("2026-09-10"),
                          builder: (context,child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: AppCubit.get(context).isDark?
                              const ColorScheme.light(
                                  primary: Colors.amber
                              ):
                              ColorScheme.light(
                                  primary: AppColors.lightAppBar
                              ),
                           ),
                            child: child!,
                          );
                          }
                        ).then((value) {
                          dateController_2.text = value.toString();
                          dateController.text = DateFormat.yMMMd().format(value!);
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h*0.02,bottom: h*0.01),
                      child: const Text('Time'),
                    ),
                    defaultFormField_2(
                        context,
                        controller: timeController,
                        type: TextInputType.text,
                        suffix: Icons.watch_later_outlined,
                        readOnly: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Time is Empty';
                          }
                          return null;
                        },
                        onTap: () {
                          showTimePicker(context: context,
                              initialTime: TimeOfDay.now()).then((value) {
                            timeController.text = value!.format(context).toString();
                          });
                        },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h*0.02,bottom: h*0.006),
                      child: const Text('Reminder'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.96),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [const BoxShadow(
                          spreadRadius: 0.2,
                          blurRadius: 0.2,
                        )]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0,right:5),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            alignment: AlignmentDirectional.bottomStart,
                            style:  Theme.of(context).textTheme.bodyText2,
                            hint: const Text('Choose'),
                            value: AppCubit.get(context).dropDownValue,
                            icon: const Icon(Icons.keyboard_arrow_down,),
                            items: AppCubit.get(context).items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              AppCubit.get(context).changeDropValue(newValue);
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h*0.05,),
                    state is !CreateTaskLoading?
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w*0.1),
                      child: defaultButton(
                        context,
                        onTap: () {

                          if(formKey.currentState!.validate()){
                            if(AppCubit.get(context).dropDownValue==null){
                              showToast('Please choose reminder');
                              return;
                            }
                            AppCubit.get(context).
                            createTask(
                                title: titleController.text,
                                time: timeController.text,
                                date: dateController_2.text,
                                orderDate: DateTime.now().toString(),
                                status: false);
                          }
                        },
                        text: 'Add Task',),
                    )
                    :
                       const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
