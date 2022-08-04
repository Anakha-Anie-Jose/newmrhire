class JobModel{
  String jobTitle;
  String description;
  String deadline;
  String time;
  String Address;
  String email;
  String phone;
  String location;

  JobModel({required this.jobTitle,required this.email,required this.description,required this.Address,required this.deadline,required this.time,required this.phone,required this.location});
//JobModel();
Map<String, dynamic>toJson()=>{'jobTitle':jobTitle,'email':email,'description':description,'time':time,'deadline':deadline,'Address':Address,'phone':phone,'location':location};
  JobModel.fromSnapshot(snapshot)
  :    jobTitle=snapshot.data()['jobTitle'],
        email=snapshot.data()['email'],
        description=snapshot.data()['description'],
        time=snapshot.data()['time'],
        deadline=snapshot.data()['deadline'],
        Address=snapshot.data()['Address'],
         phone=snapshot.data()['phone'],
      location=snapshot.data()['location'];

}