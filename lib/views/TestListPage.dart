import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/blocs/SubtestBloc.dart';
import 'package:india_learner/models/SubtestModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/TestInfoPage.dart';
import 'package:provider/provider.dart';

class TestListPage extends StatefulWidget {
  String testTypeId;

  TestListPage({this.testTypeId});

  TestListPageState createState() => TestListPageState(testTypeId: testTypeId);
}

class TestListPageState extends State<TestListPage> {
  String theme;
  String testTypeId;

  TestListPageState({this.testTypeId});

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    subtestBloc.getAllSubTest(testTypeId: testTypeId);
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
            Get.back();
          },
        ),
        title: Text('Test', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              //color: Colors.grey,
              padding: EdgeInsets.only(top: 10),
              width: Get.size.width - 20,
              child: Card(
                child: StreamBuilder(
                  stream: subtestBloc.subTestStream,
                  builder: (context, AsyncSnapshot<List<SubtestDetailsList>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(TestInfoPage(snapshot.data[index], testTypeId));
                              },
                              child: Container(
                                color: theme == Constants.darkTheme ? color.darkCard : Colors.white,
                                padding: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              margin: EdgeInsets.only(left: 4),
                                              height: 50,
                                              width: 45,
                                              decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(3)),
                                              child: Center(
                                                child: Text(
                                                  ("100" + index.toString()),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: theme == Constants.darkTheme ? color.darkText : color.lightText,
                                                  ),
                                                ),
                                              ),
                                            )),
                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(left: 6, top: 4),
                                                  height: 40,
                                                  //   color: Colors.white,
                                                  child: Text(
                                                    snapshot.data[index].subtest,
                                                    maxLines: 2,
                                                    style: TextStyle(fontSize: 12, color: theme == Constants.darkTheme ? color.darkText : color.lightText, fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            )),
                                        Expanded(
                                            child: Container(
                                          child: Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: theme == Constants.darkTheme ? color.darkText : color.lightText,
                                          ),
                                        ))
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 11),
                                      height: 1,
                                      color: Colors.black12,
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return Utils.loader;
                    } else {
                      return Utils.noData;
                    }
                  },
                ),
              ))
        ],
      ),
    );
  }
}
