import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ResultPage extends StatefulWidget {
  int total;
  int negativeMarks, obtainedQuestions;
  ResultPage({this.total, this.negativeMarks, this.obtainedQuestions});

  ResultPageState createState() => ResultPageState(
        total: total,
      );
}

class ResultPageState extends State<ResultPage> {
  int total;
  int negativeMarks, obtainedQuestions;
  ResultPageState({this.total, this.negativeMarks, this.obtainedQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          'Result',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87),
        ),
      ),
      body: Container(
        width: Get.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Lottie.asset('assets/jsonassets/congrats.json'),
            Text(
              'Result:  ${total} marks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
            Text(
              'Negative marks:  ${negativeMarks} ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
            /*Text(
              'Obtained questions:  ${obtainedQuestions} ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87),
            )*/
          ],
        ),
      ),
    );
  }
}
