import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/views/CategoriesPage.dart';
import 'package:india_learner/views/CreateAccount.dart';
import 'package:india_learner/views/widget/ForgotPasswordPage.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class Login extends StatefulWidget {
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool loginWithMobile = false;
  double dimens;
  TextEditingController emailCtrl, passwordCtrl;
  bool isObsecure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.black54));
    initControllers();
  }

  @override
  Widget build(BuildContext context) {
    dimens = MediaQuery.of(context).size.height;

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
          "Login",
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              height: Get.size.height,
              width: Get.size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 7,
                    child: getLoginForm(),
                  ),
                  Expanded(flex: 3, child: Container())
                ],
              )),
        ),
      ),
    );
  }

  getLoginForm() {
    return loginWithMobile == false
        ? Column(
            children: [
              SizedBox(
                height: 10,
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
                height: 18,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: dimens < 700 ? 50 : 55,
                child: TextField(
                  controller: emailCtrl,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    enabledBorder: Utils.textFieldBorder,
                    focusedBorder: Utils.textFieldBorder,
                    disabledBorder: Utils.textFieldBorder,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: dimens < 700 ? 50 : 55,
                child: TextField(
                  controller: passwordCtrl,
                  obscureText: isObsecure,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObsecure == true ? isObsecure = false : isObsecure = true;
                          });
                        },
                        icon: Icon(isObsecure == true ? Icons.visibility : Icons.visibility_off)),
                    enabledBorder: Utils.textFieldBorder,
                    focusedBorder: Utils.textFieldBorder,
                    disabledBorder: Utils.textFieldBorder,
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                height: dimens < 700 ? 42 : 55,
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  onPressed: () {
                    Repository.login(email: emailCtrl.text, password: passwordCtrl.text);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  color: Colors.cyan,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        loginWithMobile = true;
                      });
                    },
                    child: Text('Login with mobile number', style: TextStyle(fontSize: 12, color: Colors.cyan, fontWeight: FontWeight.w600)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(ForgotPasswordPage());
                    },
                    child: Text('Forgot Password', style: TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.w600)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(CreateAccount());
                },
                child: Text.rich(TextSpan(text: 'New user ', style: TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w700), children: <InlineSpan>[TextSpan(text: "Create new account?", style: TextStyle(fontSize: 14, color: Colors.cyan, fontWeight: FontWeight.w700))])),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          )
        : Column(
            children: [
              SizedBox(
                height: 10,
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
                height: 14,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                height: dimens < 700 ? 45 : 55,
                child: TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    enabledBorder: Utils.textFieldBorder,
                    focusedBorder: Utils.textFieldBorder,
                    disabledBorder: Utils.textFieldBorder,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    // width: MediaQuery.of(context).size.width,
                    height: 55,
                    child: PinCodeTextField(
                      autofocus: false,
                      hideCharacter: false,
                      highlight: true,
                      pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 14),
                      highlightColor: Colors.black,
                      defaultBorderColor: Colors.black38,
                      hasTextBorderColor: Colors.black38,
                      highlightPinBoxColor: Colors.white,
                      maxLength: 4,
                      // maskCharacter: "*",
                      onTextChanged: (text) {
                        setState(() {});
                      },
                      pinBoxWidth: 50,
                      pinBoxHeight: 55,
                      hasUnderline: false,
                      wrapAlignment: WrapAlignment.spaceAround,
                      pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      pinTextStyle: TextStyle(fontSize: 22.0),
                      pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                      pinBoxColor: Colors.white,
                      pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                      pinBoxRadius: 10.0,
//                    highlightAnimation: true,
                      highlightAnimationBeginColor: Colors.black,
                      highlightAnimationEndColor: Colors.white12,
                      keyboardType: TextInputType.number,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 35,
              ),
              SizedBox(
                height: dimens < 700 ? 48 : 55,
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  //   Login with otp button
                  onPressed: () {
                    Get.offAll(CategoriesPage());
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                  color: Colors.cyan,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    loginWithMobile = false;
                  });
                },
                child: Text('Login with email', style: TextStyle(fontSize: 12, color: Colors.cyan, fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(CreateAccount());
                },
                child: Text.rich(TextSpan(text: 'New user ', style: TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w700), children: <InlineSpan>[TextSpan(text: "Create new account?", style: TextStyle(fontSize: 14, color: Colors.cyan, fontWeight: FontWeight.w700))])),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
  }

  void initControllers() {
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
  }
}
