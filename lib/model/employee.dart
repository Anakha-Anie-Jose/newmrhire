import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class EmpModel{
  String Name;
  String description;
  String title;
  String address;
  String phone;
  String pin;
  String state;
  String url;


  EmpModel({required this.url,required this.Name,required this.title,required this.description,required this.address,required this.pin,required this.state,required this.phone});
  Map<String, dynamic>toJson()=>{'url':url,'Name':Name,'title':title,'description':description,'pin':pin,'Address':address,'phone':phone,'state':state};
  EmpModel.fromSnapshot(snapshot)
      :    Name=snapshot.data()['Name'],
        title=snapshot.data()['title'],
        description=snapshot.data()['description'],
        address=snapshot.data()['address'],
        phone=snapshot.data()['phone'],
       state=snapshot.data()['state'],
        pin=snapshot.data()['pin'],
      url=snapshot.data()['url'];


}