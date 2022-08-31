class TaskModel{
  String? title;
  String? time;
  String? date;
  String? taskID;
  String? orderDate;
  bool? status;
  int? notificationID;
  String? notificationStatus;
  TaskModel({this.title, this.time, this.date,this.taskID,this.orderDate,this.status,this.notificationID,this.notificationStatus});
  TaskModel.fromJson(Map <String,dynamic> json){
    title = json['title'];
    date = json['date'];
    time = json['time'];
    taskID = json['taskID'];
    orderDate = json['orderDate'];
    status = json['status'];
    notificationID = json['notificationID'];
    notificationStatus = json['notificationStatus'];
  }
  Map<String,dynamic> toJson(){
    return
      {
        'title':title,
        'date':date,
        'time':time,
        'taskID':taskID,
        'orderDate':orderDate,
        'status':status,
        'notificationID':notificationID,
        'notificationStatus':notificationStatus,
      };
  }
}