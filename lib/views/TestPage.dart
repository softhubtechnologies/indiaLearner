import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/TestDetailsBloc.dart';
import 'package:india_learner/blocs/TestHistoryBloc.dart';
import 'package:india_learner/blocs/TestSubmissionBloc.dart';
import 'package:india_learner/models/SubtestModel.dart';
import 'package:india_learner/models/TestDetailsModel.dart';
import 'package:india_learner/models/TestHistoryModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/widget/ResultPage.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  SubtestDetailsList subtestDetailsList;

  TestPage(this.subtestDetailsList);

  TestPageState createState() => TestPageState(subtestDetailsList);
}

class TestPageState extends State<TestPage> {
  SubtestDetailsList subtestDetailsList;

  TestPageState(this.subtestDetailsList);
  int indexQuestion = 0;
  List<dynamic> listOptions = [];
  String answer;
  dynamic negativeMark = 0, totalNegativeMarks = 0;
  int duration;
  List<TestItemDetails> listQuestions = [];
  List<String> questionsList = ['with the reference to the administritave tribunals act of 1985 consider the following statements: '];
  List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  List<String> optionsToselect = ['1 Only', '2 Only', 'Both 1 & 2', 'neighther 1 nor 2'];
  int indexOpselected, result = 0, markOfQuestion;
  Map<String, dynamic> resultMap = {};
  AsyncSnapshot<List<TestDetailsList>> snapshotTemp;
  List<dynamic> resultList = [];
  @override
  void initState() {
    // TODO: implement initState
    testDetailsBloc.getTestDetails(subtestDetailsList);
    testHistoryBloc.getTestHistory();

    super.initState();
  }

  String theme;
  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;

    return Scaffold(
      drawer: getDrawer(),
      appBar: AppBar(
        backgroundColor: theme == Constants.lightTheme ? Colors.white : color.darkAppBar,
        automaticallyImplyLeading: false,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black87,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
        actions: [
          IconButton(
              onPressed: () {
                calculateMarks();
                navigate();
              },
              icon: Icon(
                Icons.power_settings_new_rounded,
                color: Colors.black54,
                size: 28,
              )),
          SizedBox(
            width: 10,
          ),
        ],
        title: Text(subtestDetailsList.subtest, style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      bottomNavigationBar: getBottomNav(),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 55,
              child: Card(
                elevation: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: color.testCircleColor,
                          radius: 16.0,
                          child: Center(
                            child: Text(
                              '1',
                              style: TextStyle(fontSize: 14, color: color.btnTextColor),
                            ),
                          ),
                        )),
                    Expanded(flex: 3, child: Container()),
                    Expanded(
                        flex: 4,
                        child: StreamBuilder(
                          stream: testDetailsBloc.testDetailsStream,
                          builder: (context, AsyncSnapshot<TestDetailsModel> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.statusCode == "200" && snapshot.data.exists != "1") {
                                return CountdownTimer(
                                  endTime: DateTime.now().add(Duration(minutes: int.parse(snapshot.data.testDetailsList[0].testTime))).millisecondsSinceEpoch,
                                  textStyle: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w800),
                                  onEnd: navigate,
                                );
                              } else if (snapshot.data.statusCode != "200") {
                                return Container(
                                  child: Utils.noData,
                                );
                              }
                            } else if (snapshot.connectionState == ConnectionState.waiting) {
                              return Utils.loader;
                            } else {
                              return Container();
                            }
                          },
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(
                          'अ',
                          style: TextStyle(fontSize: 24, color: Colors.black87.withOpacity(0.6), fontWeight: FontWeight.w700),
                        )),
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.star,
                          color: Colors.black54,
                          size: 30,
                        ))
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: testDetailsBloc.testDetailsStream,
                builder: (context, AsyncSnapshot<TestDetailsModel> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.statusCode == "200") {
                      if (snapshot.data.exists == "0") {
                        listQuestions = snapshot.data.testDetailsList[0].testItemDetails;
                        duration = int.parse(snapshot.data.testDetailsList[0].testTime);
                        if (snapshot.data.testDetailsList[0].mark != "") {
                          markOfQuestion = int.parse(snapshot.data.testDetailsList[0].mark);
                        }
                        if (snapshot.data.testDetailsList[0].negativeMark != "" && snapshot.data.testDetailsList[0].negativeMark != null) {
                          negativeMark = double.parse(snapshot.data.testDetailsList[0].negativeMark);
                        }
                        //print("SSSSSSSSS ${snapshot.data[0].testItemDetails.length}");
                        return Container(
                          width: Get.size.width / 1.1,
                          height: Get.size.height / 2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 14,
                              ),
                              Text(listQuestions[indexQuestion].question, style: TextStyle(fontSize: 14, height: 1.2, color: Colors.black87, fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: 6,
                              ),
                              Expanded(flex: 4, child: getoptions()),
                              Expanded(flex: 6, child: getOptionSelection()),
                            ],
                          ),
                        );
                      } else if (snapshot.data.exists == "1") {
                        return Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data.message,
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Obtain Marks: " + snapshot.data.testResultList[0].obtainMarks,
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Total Marks: " + snapshot.data.testResultList[0].totalMarks,
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                        );
                      }
                    } else {
                      return Utils.noData;
                    }
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return Utils.loader;
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Utils.noData,
                        )
                      ],
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  getBottomNav() {
    return SizedBox(
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 1,
                child: RaisedButton(
                    color: Colors.cyan,
                    onPressed: () {
                      print("${listQuestions.length}${indexQuestion}");
                      if (listQuestions.length > indexQuestion && indexQuestion != 0) {
                        setState(() {
                          indexQuestion = --indexQuestion;
                        });
                      }
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.white,
                    ))),
            SizedBox(
              width: 4,
            ),
            Expanded(
                flex: 5,
                child: RaisedButton(
                  color: Colors.black54,
                  onPressed: () {}, /*child:
            Text('SKIP', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500))*/
                )),
            SizedBox(
              width: 4,
            ),
            Expanded(
                flex: 1,
                child: RaisedButton(
                    color: Colors.cyan,
                    onPressed: () {
                      calculateMarks();
                      print("RESULT LLL ${resultList.toString()}");

                      if (listQuestions.length - 1 != indexQuestion) {
                        setState(() {
                          indexQuestion = ++indexQuestion;
                        });
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                      size: 20,
                    ))),
          ],
        ),
      ),
      height: 50,
      width: Get.size.width,
    );
  }

  getoptions() {
    return Container(
      margin: EdgeInsets.only(left: 22),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          int tempIndex = index + 1;
          answer = listQuestions[indexQuestion].answer;
          print("ANSWER ${answer}");
          listOptions.add(listQuestions[indexQuestion].option1);
          listOptions.add(listQuestions[indexQuestion].option2);
          listOptions.add(listQuestions[indexQuestion].option3);
          listOptions.add(listQuestions[indexQuestion].option4);
          return Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(tempIndex.toString() + ". " + listOptions[index], style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600)),
          );
        },
      ),
    );
  }

  getOptionSelection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Which of statements given above are correct ?', style: TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w600))],
        ),
        Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  int tempIndex = index + 1;
                  return GestureDetector(
                    onTap: () {
                      print(index);
                      setState(() {
                        indexOpselected = index;
                        print("ANSWER ${listQuestions[indexQuestion].answer}");
                        print("OPSELECTED ${listOptions[indexOpselected]}");
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 25, top: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: indexOpselected != index ? Colors.black54 : Colors.green,
                                ),
                                child: Center(
                                  child: Text(tempIndex.toString(), style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600)),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(listOptions[index], style: TextStyle(fontSize: 14, color: indexOpselected != index ? Colors.black87 : Colors.green, fontWeight: FontWeight.w600))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }))
      ],
    );
  }

  Widget getDrawer() {
    Timer(Duration(seconds: 3), () {
      setState(() {});
    });
    return Drawer(
      child: SafeArea(
        child: Container(
          width: Get.size.width,
          height: 100,
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Test history",
                        style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )),
              Container(
                width: Get.size.width,
                height: 1,
                color: Colors.black54,
              ),
              Expanded(
                  flex: 8,
                  child: StreamBuilder(
                    stream: testHistoryBloc.testHistoryStream,
                    builder: (context, AsyncSnapshot<TestHistoryModel> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data.testResultList.length,
                          itemBuilder: (context, index) {
                            return Container(
                                child: ListTile(
                              leading: Icon(Icons.receipt),
                              title: Text("TestName: " + snapshot.data.testResultList[index].testName),
                              subtitle: Text("Marks: " + snapshot.data.testResultList[index].obtainMarks),
                            ));
                          },
                        );
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return Utils.loader;
                      } else {
                        return Utils.noData;
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void navigate() {
    print(resultList.toString());

    int total = 0, obtainedQuestins = 0;
    // Get.to(ResultPage(total: total));

    Map<String, dynamic> mapTemp = {};
    List<dynamic> listTemp = [];
    print("totalMarks neg  ${resultList.toString()}");

    for (int i = 0; i < resultList.length; i++) {
      print(resultList[i]);
      mapTemp = resultList[i];
      mapTemp.forEach((key, value) {
        print("KEYS ${total + mapTemp[key]['marks']}");
        listTemp.add(mapTemp[key]['marks']);
        obtainedQuestins = obtainedQuestins + 1;
      });
    }
    for (int i = 0; i < listTemp.length; i++) {
      total = total + listTemp[i];
    }
    print("KEYS ${listTemp}");

    int totalMarks = listQuestions.length * markOfQuestion;
    print("totalMarks ${totalMarks} ${total}");

    total = total - totalNegativeMarks;
    testSubmissionBloc.submitTest(testName: subtestDetailsList.subtest, answerSheet: "", testType: "", obtainMarks: total.toString(), totalMarks: totalMarks.toString());
    print("totalMarks neg ${totalNegativeMarks} ${total} ${resultList.toString()}");

    Get.off(ResultPage(
      total: total,
      negativeMarks: negativeMark,
      obtainedQuestions: listTemp.length,
    ));
  }

  void calculateMarks() {
    if (indexOpselected != null) {
      if (listQuestions[indexQuestion].answer == listOptions[indexOpselected]) {
        setState(() {
          resultMap.clear();
          resultMap["marks"] = markOfQuestion;
          Map<String, dynamic> mapTemp = {};
          if (!mapTemp.containsKey(listQuestions[indexQuestion].id)) {
            mapTemp[listQuestions[indexQuestion].id] = resultMap;
            resultList.add(mapTemp);
          }
        });
        print("RESULT ${result.toString()}");
      } else {
        setState(() {
          totalNegativeMarks = totalNegativeMarks + negativeMark;
        });
      }
      indexOpselected = null;
    }
  }
}
