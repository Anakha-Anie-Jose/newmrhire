
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'homescreen1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'viewprof.dart';
import 'model/employee.dart';
//imported google's material design library
class viewlist extends StatefulWidget {
  const viewlist({Key? key}) : super(key: key);

  @override
  _viewlistState createState() => _viewlistState();
}
class _viewlistState extends State<viewlist> {
  EmpModel model = new EmpModel(

      Name: '',
      address: '',
      description: '',
      title: '',
      state: '',
      phone:'',
      pin:'',
       url:'',);
  List<EmpModel> EmpList = [];

  @override
  void initState ()  {
    super.initState();
    getjobs();

  }
  Future getjobs() async{
    var data = await FirebaseFirestore.instance
        .collection("gethired").get();


    setState(() {
      EmpList = List.from(data.docs.map((doc) => EmpModel.fromSnapshot(doc)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen1()));
            },
          ),

        title: Text('Get an Employee for you!'),
        backgroundColor: Colors.purple[400],
        centerTitle: true,
      ),

      body:SafeArea(
          child:ListView.builder(
            itemCount: EmpList.length,
            itemBuilder: (context,index) {
              //return Text("$index");
              return CardUI(EmpList[index].Name, EmpList[index].address,EmpList[index].description,EmpList[index].phone,EmpList[index].pin,EmpList[index].title,EmpList[index].state,EmpList[index].state);
            },
          )
      ),
    );
  }

  Widget CardUI(String name,String address,String desc,String phone,String pin,String title,String state,String url) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      color: Colors.purple[100],
      child: SizedBox(
        width: 300,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple[500],
                radius: 108,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "lib/assets/images/avatar.png"),

                  radius: 100,
                ), //CircleAvatar
              ), //CircleAvatar
              SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                '$name',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.purple[900],
                  fontWeight: FontWeight.w500,
                ), //Textstyle
              ), //Text
              SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                '$title',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.purple[900],
                ), //Textstyle
              ), //Text
              SizedBox(
                height: 10,
              ), //SizedBox
              SizedBox(
                width: 80,
                child: FloatingActionButton(
                  onPressed: () {

                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => viewprofile(

                            name:'$name',
                            title: '$title',
                            description: '$desc',
                             phone: '$phone',
                             pin:'$pin',
                             address:'$address',
                             state: '$state',
                              url:'$url',
                        )));
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  //color:Colors.purple,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
//Icon(Icons.touch_app),
                        Text('Visit'),
                      ],
                    ), //Row
                  ), //Padding
                ), //RaisedButton
              ) //SizedBox
            ],
          ), //Column
        ), //Padding
      ),
    );

// ]
  }
}


@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
