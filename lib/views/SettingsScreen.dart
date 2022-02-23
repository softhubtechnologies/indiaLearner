import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:india_learner/utils/AppStrings.dart';
import 'package:india_learner/utils/Color.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/views/EditProfile.dart';
import 'package:india_learner/views/MyEnrollments.dart';
import 'package:india_learner/views/widget/ForgotPasswordPage.dart';
import 'package:india_learner/views/widget/HelpAndSupport.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  List<String> listMenu = ['My account', 'Change password', 'Courses registered', 'Help & support', 'Terms & conditions', 'Privacy & policies'];
  List<IconData> listIcons = [Icons.account_box, Icons.lock, Icons.event, Icons.help, Icons.add_photo_alternate_sharp, Icons.privacy_tip];

  String theme;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    theme = Provider.of<ThemeModel>(context, listen: false).mode == ThemeMode.dark ? Constants.darkTheme : Constants.lightTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme == Constants.lightTheme ? Colors.white : color.darkAppBar,
        elevation: 4,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme == Constants.lightTheme ? Colors.black87 : Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 15, color: theme == Constants.lightTheme ? Colors.black87 : color.darkText),
        ),
      ),
      body: Container(
        height: Get.size.height,
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          navigate(index);
                        },
                        leading: Icon(listIcons[index], color: theme == Constants.lightTheme ? Colors.black87 : color.darkText),
                        trailing: Icon(Icons.arrow_forward_ios_sharp, color: theme == Constants.lightTheme ? Colors.black87 : color.darkText),
                        title: Text(
                          listMenu[index],
                          style: TextStyle(color: theme == Constants.lightTheme ? Colors.black87 : color.darkText),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  void navigate(int index) {
    switch (index) {
      case 0:
        Get.to(EditProfile());
        break;
      case 1:
        Get.to(ForgotPasswordPage());
        break;
      case 2:
        Get.to(MyEnrollments());
        break;
      case 3:
        Get.to(HelpandSupport());
        break;
      case 4:
        displayTermsDialog();
        break;

      case 5:
        displayPrivacy();
        break;
    }
  }

  void displayTermsDialog() async {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
            child: Material(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('Terms & Conditions', style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w800)),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Html(
                              data: AppSrings.termsString,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void displayPrivacy() async {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
            child: Material(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('Privacy & policies', style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.w800)),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Html(
                              data: AppSrings.termsString,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
