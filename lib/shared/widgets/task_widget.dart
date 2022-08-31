import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/task_model.dart';
import '../compare_dates.dart';

Widget buildTaskItem(TaskModel model,context,Color color,
    {required bool doneVisible, index,AppStates? state})
{
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  return Padding(

    padding: EdgeInsets.symmetric(horizontal: w*0.03,vertical: h*0.006),

    child: InkWell(
      onTap: () {
       print( compareDate(
         DateTime.now().subtract(Duration(minutes: 2)),
         DateTime.now(),
       ));
      },
      child: Container(
        decoration: BoxDecoration(
            color:
            model.status==true?
            //0xffDDAF18
            const Color(0xffDBAF1D).withOpacity(0.8)
                :const Color(0xff8E8A8A).withOpacity(0.8),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w*0.03,vertical: h*0.02),
          child: Row(

            children: [
              if (doneVisible!=false)
                IconButton(onPressed: () {
                  AppCubit.get(context).moveTaskToDone(model, index);
                }, icon: model.status==false? Icon(Icons.check_circle_outline,size: h*0.035,): Icon(Icons.check_circle_rounded,size: h*0.035,),),
              SizedBox(width: w*0.02,),
              SizedBox(
                width: w*0.25,
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Text('${model.title}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: w*0.045
                              )

                          ),
                          SizedBox(height: h*0.008,),

                          Text(DateFormat.yMMMd().format(DateTime.parse(model.date.toString())),
                              style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.white70,
                                  fontSize: w*0.03
                              )

                          ),

                        ],

                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text('${model.time}',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: w*0.04
              ),),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).removeTask(model);
                  },
                  icon:  Icon(Icons.delete,size: w*0.065,color: Colors.black,)
              )
            ],

          ),
        ),
      ),
    ),

  );
}
