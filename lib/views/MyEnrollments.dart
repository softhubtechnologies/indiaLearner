import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/EnrollmentsBloc.dart';
import 'package:india_learner/models/EnrollmentsModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/Utils.dart';

class MyEnrollments extends StatefulWidget {
  MyEnrollmentsState createState() => MyEnrollmentsState();
}

class MyEnrollmentsState extends State<MyEnrollments> {
  List<dynamic> listEnrollments = [];
  String theme;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qetJson();
  }

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    enrollmentsBloc.fetchAllEnrollments();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme == Constants.lightTheme ? Colors.white : color.darkAppBar,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black87,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('My Enrollments', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: enrollmentsBloc.enrollmentsListStream,
          builder: (context, AsyncSnapshot<List<EnrollmentsList>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.length > 0
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.only(top: 22),
                            child: Container(
                                //margin:EdgeInsets.only(top:20,left:14),
                                //height:90,
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(top: 10, left: 14),
                                        height: 65,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          color: Colors.cyan.withOpacity(0.3),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.orange,
                                            size: 30,
                                          ),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  width: 18,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width / 2,
                                      child: Text(
                                        snapshot.data[index].className != null ? snapshot.data[index].className : "",
                                        style: TextStyle(fontSize: 14, height: 1.4, color: Colors.black87, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Plan name: " + snapshot.data[index].planName,
                                          style: TextStyle(fontSize: 14, height: 1.2, color: Colors.black45, fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      snapshot.data[index].subcategoryId,
                                      style: TextStyle(
                                        fontSize: 14,
                                        height: 1.2,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(text: snapshot.data[index].startDate, style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6)), children: <InlineSpan>[
                                        TextSpan(text: ' To ', style: TextStyle(fontSize: 15, color: Colors.black), children: <InlineSpan>[
                                          TextSpan(
                                            text: snapshot.data[index].endDate,
                                            style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.6)),
                                          )
                                        ])
                                      ]),
                                    )
                                  ],
                                )
                              ],
                            )));
                      },
                    )
                  : Utils.noData;
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Utils.loader;
            } else {
              Utils.noData;
            }
          },
        ),
      ),
    );
  }

  void qetJson() async {
    var jsonText = await rootBundle.loadString('assets/jsonassets/json');
    print("jsonText ${jsonText}");
    var map = json.decode(jsonText);
    setState(() {
      listEnrollments = map['list'];
    });
    print("jsonText jsonText${listEnrollments.toString()}");
  }
}
