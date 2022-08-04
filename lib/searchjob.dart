import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'homescreen1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/job.dart';
import 'jobdetails.dart';
//imported google's material design library
class SearchJob extends StatefulWidget {
  const SearchJob({Key? key}) : super(key: key);

  @override
  _SearchJobState createState() => _SearchJobState();
}
class _SearchJobState extends State<SearchJob> {
  JobModel model = new JobModel(jobTitle: '',
      email: '',
      Address: '',
      description: '',
      deadline: '',
      time: '',
      phone:'',
     location:'');
  List<JobModel> jobList = [];

  @override
  void initState ()  {
    super.initState();
     getjobs();

  }
Future getjobs() async{
  var data = await FirebaseFirestore.instance
      .collection("postjob").get();

  // final uid=user?.uid;
  setState(() {
    jobList = List.from(data.docs.map((doc) => JobModel.fromSnapshot(doc)));
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //actions: [
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen1()));
            },
          ),
       // ],
        title: Text('Look for the feasible jobs!'),
        backgroundColor: Colors.purple[400],
        centerTitle: true,
      ),
      //AppBar
      // body: jobList.length == 0
      //     ? Center(child: Text('No jobs found! ${model.Address}'))
      //     : ListView.builder(
      //     itemBuilder: (_, index) {
      //       return CardUI(jobList[index].Address, jobList[index].jobTitle);
      //     }
      // ),
      body:SafeArea(
        child:ListView.builder(
          itemCount: jobList.length,
          itemBuilder: (context,index) {
            //return Text("$index");
            return CardUI(jobList[index].Address, jobList[index].jobTitle,jobList[index].description,jobList[index].location,jobList[index].deadline,jobList[index].phone,jobList[index].time);
          },
        )
      ),
    );
  }

  Widget CardUI(String address, String title,String desc,String location,String deadline,String phone,String time) {
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
                     "lib/assets/images/errands1.png"),
                 radius: 100,
                ), //CircleAvatar
              ), //CircleAvatar
              SizedBox(
                height: 10,
              ), //SizedBox
              Text(
                '$title',
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
                '$location',
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
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  onPressed: () {

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => jobdetails(

                          title: '$title',
                          description: '$desc',
                          location: '$location',
                          deadline: '$deadline',
                          phone: '$phone',
                          time: '$time',
                          address:'$address'
                        )));
                  },
                  //color: Colors.purple,
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
