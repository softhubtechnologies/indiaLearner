import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:india_learner/blocs/UpdatePasswordBloc.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/views/Login.dart';

class UpdatePasswordPage extends StatefulWidget {
  String email;

  UpdatePasswordPageState createState() => UpdatePasswordPageState(email: email);
  UpdatePasswordPage({this.email});
}

class UpdatePasswordPageState extends State<UpdatePasswordPage> {
  String email;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UpdatePasswordPageState({this.email});

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              child: TextFormField(
                obscureText: true,
                controller: newPasswordController,
                decoration: InputDecoration(hintText: "New Password", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 50,
              child: TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Confirm Password", border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black54))),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  child: RaisedButton(
                    onPressed: () {
                      if (newPasswordController.text.length > 0 && confirmPasswordController.text.length > 0) {
                        if (newPasswordController.text == confirmPasswordController.text) {
                          updatePasswordBloc.updatePassword(email: email, password: newPasswordController.text);
                          updatePasswordBloc.updatePasswordStream.listen((event) {
                            if (event.statusCode == "200") {
                              ToastMessage.showToast(message: "Password updated successfully", type: true);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return Login();
                              }));
//                              Get.offAll(Login());
                            }
                          });
                        } else {
                          ToastMessage.showToast(message: "Password dosen't match with confirm password", type: false);
                        }
                      } else {
                        ToastMessage.showToast(message: "Please enter password", type: false);
                      }
                    },
                    color: color.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Update',
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
