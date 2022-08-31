
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/layout/cubit/states.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/shared/constants.dart';
import 'package:todo_app/shared/local/shared_preferences.dart';
import 'package:todo_app/shared/local/notifications.dart';



enum Themes {light,dark}

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  List<TaskModel> allTasks = [];
  List<TaskModel> dateTasks = [];
  List<TaskModel> doneTasks = [];
  List<TaskModel> searchResult = [] ;
  List<TaskModel> unCompletedTasks = [];
  List<String> items = [
    'At the moment',
    '1 minute before',
    '5 minutes before',
    'None',
  ];

  String? dropDownValue;

  void changeDropValue(value)
  {
    dropDownValue = value;
    emit(ChangeItem());
  }


  void changeBottomSheetState (
  {
  required bool isShow,
  required IconData icon,
}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheet());
  }

void createTask({
  required String title,
  required  String time,
  required String date,
  required String orderDate,
  required bool status,
}) {
    emit(CreateTaskLoading());
    int notificationID = unCompletedTasks.length;
    TaskModel model = TaskModel(
      title: title,
      time: time,
      date: date,
      orderDate: orderDate,
      status: status,
      notificationID: notificationID,
      notificationStatus: dropDownValue,
      taskID: null
    );
    String taskID = '' ;
    FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .collection('tasks')
    .add(model.toJson()).then((value) {
      taskID = value.id;
      FirebaseFirestore.instance.collection('users').doc(uId).collection('tasks').doc(value.id).update(
          {'taskID':value.id}).then((value) {
            model.taskID = taskID;
      });
      getTasks().then((value) {
        print(notificationID);
        if(getNotificationDate(date, time).isAfter(DateTime.now()))
       {
         createTaskNotification(
           title: title,
           date: date,
           time: time,
           notificationID: notificationID,
           notificationStatus: dropDownValue.toString(),
         );
       } else print('Test Error');
      });
    emit(CreateTaskSucess());
}).catchError((onError){
  print(onError.toString());
  emit(CreateTaskError());
});
}
Future<void> getTasks()async{
  emit(GetTasksLoading());
  await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .orderBy('orderDate')
        .get()
        .then((value) {
      allTasks.clear();
      unCompletedTasks.clear();
      value.docs.forEach((element) {
            TaskModel model = TaskModel.fromJson(element.data());
              allTasks.add(model);
          });
      value.docs.forEach((element) {
        TaskModel model = TaskModel.fromJson(element.data());
        if(model.status==false){
          unCompletedTasks.add(model);
        }
      });
      getTaskByDate();
      emit(GetTasksSucess());
    }).catchError((onError){
      emit(GetTasksError());
      print(onError.toString());
    });
}

  void getDoneTasks(){
    emit(GetDoneTasksLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .orderBy('orderDate')
        .get()
        .then((value) {
      doneTasks.clear();
      value.docs.forEach((element) {
        TaskModel model = TaskModel.fromJson(element.data());
        if(model.status==true) {
          doneTasks.add(model);
        }
      });
      emit(GetDoneTasksSucess());
    }).catchError((onError){
      emit(GetDoneTasksError());
      print(onError.toString());
    });
  }


void removeTask(TaskModel model){
  emit(RemoveTaskLoading());
  FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .collection('tasks')
      .doc(model.taskID)
      .delete().then((value) {
        getTasks().then((value) {
          if(isSearchOpened){
            searchTask(searchText);
          }
        });
        if (model.status==true){
          getDoneTasks();
        }
        else if (model.status==false&&model.notificationID!=null) {
          NotificationServices.cancelNotifications(model.notificationID!.toInt());
          print('${model.notificationID} has deleted');
        }
        emit(RemoveTaskSucess());
  }).catchError((error){
    emit(RemoveTaskError());
    print(error.toString());
  });
}
  void moveTaskToDone(TaskModel model,index){
    bool? status = allTasks[index].status;
    status = !status!;
    allTasks[index].status = status;
    emit(MoveToDoneTaskLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('tasks')
        .doc(model.taskID)
        .update({'status':status}).then((value) {
          NotificationServices.cancelNotifications(model.notificationID!.toInt());
      getTasks();
      getDoneTasks();
      emit(MoveToDoneTaskSucess());
    }).catchError((error){
      status = !status!;
      allTasks[index].status = status;
      emit(MoveToDoneTaskError());
      print(error.toString());
    });
  }

  void signOut(){
    dynamic isSocial = CacheHelper.getData(key: 'isSocialUser');
    FirebaseAuth.instance.signOut().then((value) async {
      if(isSocial=='Google'){
        await GoogleSignIn().disconnect();
      }
      else if (isSocial=='Facebook'){
        FacebookAuth.instance.logOut();
      }
      CacheHelper.removeToken(key: 'uId');
      CacheHelper.removeToken(key: 'name');
      CacheHelper.removeToken(key: 'isSocialUser');
      NotificationServices.cancelAllNotifications();
      emit(SignoutSuccess());
    }).catchError((onError){
      print(onError.toString());
      emit(SignoutError());
    });
  }

  List<DateTime> daysInMonth = [];
  List<bool> isSelected = [];

  void getDate() {
    DateTime now = DateTime.now();
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    DateTime today = DateTime(now.year, now.month , now.day-2);
    for(int i =now.day;i<=lastDayOfMonth.day+2;i++){
      daysInMonth.add(today);
      today = today.add(const Duration(days: 1));
      isSelected.add(false);
    }
  }


  int currentIndex = 0;
  DateTime? selectedDate;
  void dateToggle(index)
  {
      selectedDate = daysInMonth[index];
      isSelected[currentIndex] = false;
      currentIndex = index;
      isSelected[currentIndex] = true;
      getTaskByDate();
  }

  void getTaskByDate(){
    emit(DateToggleLoading());
    dateTasks.clear();
    allTasks.forEach((element) {
      if(DateTime.parse(element.date.toString()).day==daysInMonth[currentIndex].day) {
        dateTasks.add(element);
      }
    });
    emit(DateToggle(selectedDate));
  }

  bool isDark = true;
  Themes theme = Themes.light;
  void changeAppMode ({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      theme = isDark==false?Themes.light:Themes.dark;
      emit(ChangeAppMode());
    } else
    {
      isDark = !isDark;
      theme = isDark==false?Themes.light:Themes.dark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppMode());
      });
    }
  }

  bool isSearchOpened = false;
  String searchText = ''; //use for update ui when delete task from searching text
  Future<void> searchTask (String text) async {
    emit(SearchLoadingState());
    searchText = text;
    searchResult.clear();
    allTasks.forEach((element) {
      if(element.title!.contains(text))
        searchResult.add(element);
    });

    emit(SearchSucessState());
  }
  void initNotification(){
    NotificationServices.init();
  }

  void getNotificationsWhenLogin()
  {
    for(int i =0;i<unCompletedTasks.length;i++){
      DateTime date =  getNotificationDate(
          unCompletedTasks[i].date.toString(),
          unCompletedTasks[i].time.toString()
      );
     if(date.isAfter(DateTime.now())){
       NotificationServices.showScheduleNotification(
           id: unCompletedTasks[i].notificationID!.toInt(),
           title: unCompletedTasks[i].title.toString(),
           body: 'You have task to do it now!!',
           date: date,
       );
       print('done');
     }
     else print('false');
    }
  }

  void createTaskNotification({
    required String title,
     required String date,
    required String time,
    required int notificationID,
    required String notificationStatus,
})
  {
      NotificationServices.showScheduleNotification(
          id: notificationID,
          title: title,
          body: 'You have task to do it now!!',
          date: getNotificationDate(date, time)
      );
  }

  DateTime getNotificationDate(String date, String time){
    final DateTime dateTime = DateTime(
      DateTime.parse(date).year,
      DateTime.parse(date).month,
      DateTime.parse(date).day,
      DateFormat.jm().parse(time).hour,
        DateFormat.jm().parse(time).minute
    );
    return dateTime;
  }
}