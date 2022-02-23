import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/models/SubtestModel.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/utils/dimens.dart';
import 'package:india_learner/views/TestPage.dart';
import 'package:provider/provider.dart';

class TestInstructions extends StatelessWidget {
  SubtestDetailsList subtestDetailsList;
  String testType, theme;

  TestInstructions({this.subtestDetailsList, this.testType});

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(TestPage(subtestDetailsList));
        },
        backgroundColor: Colors.cyan,
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 15,
        ),
      ),
      appBar: AppBar(
        backgroundColor: theme == Constants.lightTheme ? color.lightText : color.darkAppBar,
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
        title: Text('Instructions', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Card(
                  child: getFirstBox(),
                )),
            Expanded(
                flex: 5,
                child: Card(
                  child: geSecondBox(),
                )),
            Expanded(
                flex: 5,
                child: Card(
                  child: getThirdBox(),
                )),
            Expanded(flex: 5, child: getButtonsColumn()),
          ],
        ),
      ),
    );
  }

  circleShape(Color color) {
    return Container(
      height: 14,
      width: 14,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: color),
    );
  }

  getStar() {
    return Icon(
      Icons.star,
      color: Colors.orange,
      size: 20,
    );
  }

  getFirstBox() {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 18),
      child: Column(
        children: [
          Row(
            children: [
              circleShape(Colors.deepPurple),
              SizedBox(
                width: 12,
              ),
              Text(
                'Question is attempted',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              circleShape(Colors.black.withOpacity(0.8)),
              SizedBox(
                width: 12,
              ),
              Text(
                'Question is Unattempted',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              circleShape(Colors.deepOrange),
              SizedBox(
                width: 12,
              ),
              Text(
                'Question is attempted and marked for review',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              circleShape(Colors.red),
              SizedBox(
                width: 12,
              ),
              Text(
                'Question is Unattempted and marked for review',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }

  geSecondBox() {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 12),
      child: Column(
        children: [
          Row(
            children: [
              getStar(),
              SizedBox(
                width: 12,
              ),
              Text(
                'You can filter the list of question',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              getStar(),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Text(
                  'Filter options are provided at the top of navigation drawer:',
                  maxLines: 2,
                  style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              getStar(),
              SizedBox(
                width: 12,
              ),
              Text(
                'There are three filters',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Container(
              padding: EdgeInsets.only(left: 26),
              child: Column(
                children: [
                  Row(
                    children: [
                      circleShape(Colors.red),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Attempted- List Attempted Questions',
                        style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      circleShape(Colors.red),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Unattempted- List Unattempted Questions',
                        style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      circleShape(Colors.red),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Marked- List Marked Questions',
                        style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                ],
              ))
        ],
      ),
    );
  }

  getThirdBox() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Row(
            children: [
              getStar(),
              SizedBox(
                width: 12,
              ),
              Text(
                'Use',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.star,
                color: Colors.black54,
                size: 18,
              ),
              Text(
                'Icon to mark a question for review',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              getStar(),
              SizedBox(
                width: 12,
              ),
              Text(
                'Use A/अ to toggle between Hindi and English',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              getStar(),
              SizedBox(
                width: 12,
              ),
              Text(
                'Use ',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.power_settings_new_rounded,
                size: 17,
              ),
              Text(
                ' button to submit test ',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              getStar(),
              SizedBox(
                width: 12,
              ),
              Text(
                'Use ',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.arrow_forward_ios_sharp,
                size: 15,
              ),
              Text(
                ' to go to next question',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
          Row(
            children: [
              getStar(),
              SizedBox(
                width: 12,
              ),
              Text(
                'Use ',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.arrow_back_ios,
                size: 15,
              ),
              Text(
                ' to go to previous question ',
                style: TextStyle(fontSize: dimens.instrStrSize, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 7,
          ),
        ],
      ),
    );
  }

  getButtonsColumn() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 18,
          ),
          Text(
            "Choose your preferred language",
            style: TextStyle(fontSize: 15, color: Colors.cyan, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: Get.size.width / 3,
                child: RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                  color: Colors.cyan,
                  child: Text(
                    'ENGLISH',
                    style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              SizedBox(
                height: 50,
                width: Get.size.width / 3,
                child: RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                  color: Colors.cyan,
                  child: Text(
                    'HINDI',
                    style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
