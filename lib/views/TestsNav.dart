import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/TestTypeBloc.dart';
import 'package:india_learner/models/TestTypeModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/SubscriptionPage.dart';
import 'package:india_learner/views/TestHistoryPage.dart';
import 'package:india_learner/views/TestListPage.dart';
import 'package:india_learner/views/WrittenTestWidget.dart';
import 'package:provider/provider.dart';

class TestsNav extends StatefulWidget {
  TestsNavState createState() => TestsNavState();
}

class TestsNavState extends State<TestsNav> {
  List<String> listTestName = ['Free Test', 'Paid Test', 'Quiz', 'Written/Mains', 'Test history'];
  List<IconData> listIcons = [Icons.paste, Icons.monetization_on_outlined, Icons.notes, Icons.edit, Icons.recent_actors];
  String theme;

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    testTypeBloc.getAllTestTypes();
    return Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.to(TestHistoryPage());
          },
          child: Container(
            width: Get.size.width / 3,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color.primaryColor,
            ),
            child: Center(
              child: Text(
                "Test history",
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
//          height: Get.size.height,
                child: Expanded(
                    child: StreamBuilder(
                  stream: testTypeBloc.testTypeStream,
                  builder: (context, AsyncSnapshot<List<TestTypeList>> snapshot) {
                    if (snapshot.hasData) {
                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        childAspectRatio: 1.8,
                        children: List.generate(snapshot.data.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              navigate(index, snapshot);
                            },
                            child: Container(
                              height: 140,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: theme == Constants.lightTheme ? Colors.white : color.darkCard, boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: const Offset(
                                    5.0,
                                    0.5,
                                  ),
                                  blurRadius: 10.4,
                                  spreadRadius: 0.4,
                                )
                              ]),
                              child: Center(
                                child: Row(
                                  //mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 18,
                                    ),
                                    Icon(
                                      listIcons[index],
                                      color: theme == Constants.lightTheme ? Colors.black87 : color.darkText,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      snapshot.data[index].testType,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: theme == Constants.lightTheme ? Colors.black87 : color.darkText,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    } else {
                      return Utils.loader;
                    }
                  },
                )),
              )
            ],
          ),
        ));
  }

  void navigate(int index, AsyncSnapshot<List<TestTypeList>> snapshot) {
    /*index != 3
        ? Get.to(TestListPage(
      testTypeId: snapshot.data[index].id,
    ))
        : Get.to(WrittenTestWidget());
   */
    switch (index) {
      case 0:
        Get.to(TestListPage(
          testTypeId: snapshot.data[index].id,
        ));
        break;
      case 1:
        Database.getPlan() != null && Database.getPlan() != ""
            ? Get.to(TestListPage(
                testTypeId: snapshot.data[index].id,
              ))
            : Get.to(SubscriptionPage());
        break;
      case 2:
        Get.to(TestListPage(
          testTypeId: snapshot.data[index].id,
        ));
        break;
      case 3:
        Get.to(WrittenTestWidget());
        break;
    }
  }
}
