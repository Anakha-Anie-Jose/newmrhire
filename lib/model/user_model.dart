class UserModel{
  String uid;
  String email;
  String firstName;
  String lastName;

  UserModel({required this.uid,required this.email,required this.firstName,required this.lastName});


   factory UserModel.fromMap(map){
     return UserModel(
       uid:map['uid'],
       email:map['email'],
       firstName:map['firstName'],
       lastName:map['lastName'],
     );
   }

   Map<String,dynamic> toMap(){
     return{
       'uid':uid,
       'email':email,
       'firstName':firstName,
       'lastName':lastName,
     };
   }
}