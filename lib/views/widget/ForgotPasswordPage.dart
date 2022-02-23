import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_learner/blocs/OtpVerifyBloc.dart';
import 'package:india_learner/blocs/SendOtpBloc.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ToastMessage.dart';

import 'UpdatePasswordPage.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController otpCtrl = TextEditingController();
  bool verifyOtp = false;
  String otp;

  String theme;

  @override
  Widget build(BuildContext context) {
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme == Constants.lightTheme ? Colors.white : color.darkAppBar,
        title: Text(
          "Update password",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            )),
      ),
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: verifyOtp == false ? forgotPassword() : verifyOtpWidget(),
      )),
    );
  }

  forgotPassword() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 50,
          child: TextFormField(
            controller: emailCtrl,
            decoration: InputDecoration(hintText: "Enter email", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width / 2,
          child: RaisedButton(
            onPressed: () {
              if (emailCtrl.text.length > 0) {
                sendOtpBloc.sendOtp(email: emailCtrl.text);
                sendOtpBloc.sendOtpResponseStream.listen((event) {
                  if (event.statusCode == "200") {
                    setState(() {
                      otp = event.user[0].otp;
                      verifyOtp = true;
                      otpCtrl.text = otp;
                    });
                    ToastMessage.showToast(message: event.message, type: true);
                  }
                });
              } else {
                ToastMessage.showToast(message: "Please enter email", type: false);
              }
              //Get.to(UpdatePasswordPage());
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: color.primaryColor,
            child: Text(
              'Forgot',
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  verifyOtpWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 50,
          child: TextFormField(
            controller: otpCtrl,
            decoration: InputDecoration(hintText: "Enter OTP", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width / 2,
          child: RaisedButton(
            onPressed: () {
              if (otpCtrl.text.length > 0) {
                otpVerifyBloc.verifyOtp(email: emailCtrl.text, otp: otpCtrl.text);

                otpVerifyBloc.otpVerifyStream.listen((event) {
                  if (event.statusCode == "200") {
                    print("EEEEEEEEE  ${event}");
                    ToastMessage.showToast(message: event.message, type: true);
                    Get.off(UpdatePasswordPage(
                      email: emailCtrl.text,
                    ));
                  } else {
                    ToastMessage.showToast(message: "Verification failed", type: false);
                  }
                });
              } else {
                ToastMessage.showToast(message: "Please enter OTP", type: false);
              }
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: color.primaryColor,
            child: Text(
              'Verify OTP',
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
