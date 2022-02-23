import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_learner/utils/AppStrings.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/views/CreateAccount.dart';
import 'package:india_learner/views/Login.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: Get.size.width,
        height: Get.size.height,
        color: Colors.white,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/appIcon.jpeg',
                      scale: 0.6,
                      height: 130,
                      width: 130,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text.rich(TextSpan(
                        text: 'India',
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Learner',
                            style: TextStyle(
                              fontSize: 26,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ])),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      AppSrings.appQuote,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () {
                        Get.to(Login());
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16, color: color.btnTextColor, fontWeight: FontWeight.w800),
                      ),
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () {
                        Get.to(CreateAccount());
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(fontSize: 16, color: color.btnTextColor, fontWeight: FontWeight.w800),
                      ),
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
