import 'package:flutter/material.dart';
import 'package:india_learner/blocs/SchedulesBloc.dart';
import 'package:india_learner/models/SchedulesModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatefulWidget {
  SchedulePageState createState() => SchedulePageState();
}

class SchedulePageState extends State<SchedulePage> {
  String theme;

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;

    scheduleBloc.fetchSchedules();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "My Schedule",
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: scheduleBloc.scheduleListStream,
          builder: (context, AsyncSnapshot<List<ScheduleList>> snapshot) {
            if (snapshot.hasData) {
              List<ScheduleList> scheduleList = snapshot.data.toList();
              print("LLLLLLL ${scheduleList.runtimeType}");
              return ListView.builder(
                  itemCount: scheduleList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Icon(
                                  Icons.alarm,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        scheduleList[index].courseName ?? "",
                                        style: TextStyle(fontSize: 15, height: 2, color: theme == Constants.lightTheme ? Colors.black87 : color.darkText, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  scheduleList[index].startTime != null
                                      ? Text(
                                          scheduleList[index].startTime ?? "" + " To " + scheduleList[index].endTime,
                                          style: TextStyle(fontSize: 15, height: 2, color: Colors.black87.withOpacity(0.5), fontWeight: FontWeight.w700),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  /*Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      'Desc',
                                      style: TextStyle(fontSize: 14, height: 1.4, color: Colors.black87, fontWeight: FontWeight.w700),
                                    ),
                                  ),*/
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      /*Text(
                                        scheduleList[index].course[0].startDate != null ? scheduleList[index].course[0].startDate : "",
                                        style: TextStyle(fontSize: 14, height: 1.2, color: Colors.black45, fontWeight: FontWeight.w600),
                                      ),*/
                                      /*Text(
                                        scheduleList[index].time[0].startTime != null ? scheduleList[index].time[0].startTime : "",
                                        style: TextStyle(fontSize: 14, color: Colors.black45, fontWeight: FontWeight.w400),
                                      ),*/
                                    ],
                                  ),
                                  /*Text(
                                    ,
                                    style: TextStyle(
                                      fontSize: 14,
                                      height: 1.2,
                                      color: Colors.black87,
                                    ),
                                  ),*/
                                ],
                              ))
                        ],
                      ),
                    );
                  });
            } else {
              return Utils.loader;
            }
          },
        ),
      ),
    );
  }
}
