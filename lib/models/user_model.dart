class UserModel{
  String? name;
  String? email;
  String? uID;
  String? isSocialUser;
  UserModel({this.name, this.email, this.uID,this.isSocialUser});
  UserModel.fromJson(Map <String,dynamic> json){
    name = json['name'];
    email = json['email'];
    uID = json['uId'];
    isSocialUser = json['isSocialUser'];
  }
  Map<String,dynamic> toJson(){
    return
      {
        'name':name,
        'email':email,
        'uId':uID,
        'isSocialUser': isSocialUser
      };
  }
}