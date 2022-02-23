import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/TeachersBloc.dart';
import 'package:india_learner/models/TeacherListModel.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:provider/provider.dart';

import 'MessagePage.dart';

class TeachersScreen extends StatefulWidget {
  TeachersScreenState createState() => TeachersScreenState();
}

class TeachersScreenState extends State<TeachersScreen> {
  List<TeacherList> listTeachers = [];
  String theme, className;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;

    teachersBloc.featchAllTeacher();
    return Scaffold(
      appBar: AppBar(),
      body: getEducatorList(),
    );
  }

  getEducatorList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: teachersBloc.getTeachersStream,
              builder: (context, AsyncSnapshot<List<TeacherList>> snapshot) {
                if (snapshot.hasData) {
                  print("Runtimettype ${snapshot.hasData}");
                  listTeachers = snapshot.data;
                  print("Teachers ${listTeachers.toString()}");
                  return Expanded(
                    child: listTeachers.length > 0
                        ? ListView.builder(
                            itemCount: listTeachers.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(MessagePage(
                                    teacherId: listTeachers[index].id,
                                  ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10, top: 5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 90,
                                        width: Get.size.width / 4,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: listTeachers[index].file != null && listTeachers[index].file != ''
                                              ? Image.network(
                                                  listTeachers[index].file,
                                                  height: 30,
                                                  width: 30,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset('assets/images/teachers.jpg'),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            listTeachers[index].name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Utils.loader,
                              )
                            ],
                          ),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Utils.loader,
                      )
                    ],
                  );
                } else {
                  return Column(
                    children: [Utils.noData],
                  );
                }
              })
        ],
      ),
    );
  }
}
