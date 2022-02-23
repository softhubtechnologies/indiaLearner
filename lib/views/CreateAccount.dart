import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:india_learner/models/SignupModel.dart';
import 'package:india_learner/networking/ApiHandler.dart';
import 'package:india_learner/networking/ApiProvider.dart';
import 'package:india_learner/networking/EndApi.dart';
import 'package:india_learner/networking/Repository.dart';
import 'package:india_learner/utils/AppStrings.dart';
import 'package:india_learner/utils/ToastMessage.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/CategoriesPage.dart';

class CreateAccount extends StatefulWidget {
  CreateAccountState createState() => CreateAccountState();
}

class CreateAccountState extends State<CreateAccount> {
  TextEditingController fnameCtrl, lNameCtrl, mnoCtrl, emailCtrl, passwordCtrl, confirmPassCtrl, bioCtrl;
  bool isObsecurePass = true, isObsecurePassConfirm = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initControllers();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  var querydata;

  @override
  Widget build(BuildContext context) {
    querydata = MediaQuery.of(context).size.height;
    print("HEIGHT ${querydata}");
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
          "Create Account",
          style: TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: Get.size.height + 50,
          width: Get.size.width,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Form(key: _formKey, autovalidate: autovalidate, child: getForm()),
              Container(
                color: Colors.white,
                height: 30,
              ),
            ],
          ),
        ),
      )),
    );
  }

  getForm() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: querydata < 600 ? 70 : 80,
          child: TextFormField(
            controller: fnameCtrl,
            validator: (arg) => validateFields(arg: arg, fields: Fields.Fname),
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'First name',
              errorStyle: Utils.errorHeight,
              enabledBorder: Utils.textFieldBorder,
              focusedErrorBorder: Utils.errorBorder,
              focusedBorder: Utils.textFieldBorder,
              errorBorder: Utils.errorBorder,
              disabledBorder: Utils.textFieldBorder,
              helperText: ' ',
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: querydata < 600 ? 70 : 80,
          child: TextFormField(
            controller: lNameCtrl,
            validator: (arg) => validateFields(arg: arg, fields: Fields.Lname),
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Last name',
              errorStyle: Utils.errorHeight,
              enabledBorder: Utils.textFieldBorder,
              focusedBorder: Utils.textFieldBorder,
              focusedErrorBorder: Utils.errorBorder,
              errorBorder: Utils.errorBorder,
              disabledBorder: Utils.textFieldBorder,
              helperText: ' ',
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: querydata < 600 ? 70 : 80,
          child: TextFormField(
            controller: mnoCtrl,
            maxLength: 10,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            validator: (arg) => validateFields(arg: arg, fields: Fields.Mno),
            autofocus: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                isDense: true,
                hintText: 'Mobile number',
                errorStyle: Utils.errorHeight,
                enabledBorder: Utils.textFieldBorder,
                focusedBorder: Utils.textFieldBorder,
                focusedErrorBorder: Utils.errorBorder,
                disabledBorder: Utils.textFieldBorder,
                errorBorder: Utils.errorBorder,
                helperText: ' ',
                helperStyle: TextStyle(fontSize: 0, height: 0),
                counterText: " "),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: querydata < 600 ? 70 : 80,
          child: TextFormField(
            autofocus: false,
            controller: bioCtrl,
            validator: (arg) => validateFields(arg: arg, fields: Fields.Bio),
            decoration: InputDecoration(
              hintText: 'Bio',
              errorStyle: Utils.errorHeight,
              enabledBorder: Utils.textFieldBorder,
              focusedBorder: Utils.textFieldBorder,
              focusedErrorBorder: Utils.errorBorder,
              errorBorder: Utils.errorBorder,
              disabledBorder: Utils.textFieldBorder,
              helperText: ' ',
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: querydata < 600 ? 70 : 80,
          child: TextFormField(
            controller: emailCtrl,
            validator: (arg) => validateFields(arg: arg, fields: Fields.Email),
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Email',
              errorStyle: Utils.errorHeight,
              enabledBorder: Utils.textFieldBorder,
              focusedBorder: Utils.textFieldBorder,
              disabledBorder: Utils.textFieldBorder,
              errorBorder: Utils.errorBorder,
              focusedErrorBorder: Utils.errorBorder,
              helperText: ' ',
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: querydata < 600 ? 70 : 80,
          child: TextFormField(
            controller: passwordCtrl,
            validator: (arg) => validateFields(arg: arg, fields: Fields.Password),
            autofocus: false,
            obscureText: isObsecurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObsecurePass == true ? isObsecurePass = false : isObsecurePass = true;
                    });
                  },
                  icon: Icon(isObsecurePass == true ? Icons.visibility : Icons.visibility_off)),
              errorStyle: Utils.errorHeight,
              enabledBorder: Utils.textFieldBorder,
              focusedBorder: Utils.textFieldBorder,
              disabledBorder: Utils.textFieldBorder,
              errorBorder: Utils.errorBorder,
              focusedErrorBorder: Utils.errorBorder,
              helperText: ' ',
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: querydata < 600 ? 70 : 80,
          child: TextFormField(
            controller: confirmPassCtrl,
            validator: (arg) => validateFields(arg: arg, fields: Fields.ConfirmPassord),
            autofocus: false,
            obscureText: isObsecurePassConfirm,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObsecurePassConfirm == true ? isObsecurePassConfirm = false : isObsecurePassConfirm = true;
                    });
                  },
                  icon: Icon(isObsecurePassConfirm == true ? Icons.visibility : Icons.visibility_off)),
              hintText: 'Confirm password',
              errorStyle: Utils.errorHeight,
              enabledBorder: Utils.textFieldBorder,
              focusedBorder: Utils.textFieldBorder,
              disabledBorder: Utils.textFieldBorder,
              errorBorder: Utils.errorBorder,
              focusedErrorBorder: Utils.errorBorder,
              helperText: ' ',
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: querydata < 600 ? 50 : 55,
          width: MediaQuery.of(context).size.width / 2,
          child: RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
              }
              setState(() {
                autovalidate = true;
              });
              if (fnameCtrl.text.length != 0 && lNameCtrl.text.length != 0 && mnoCtrl.text.length != 0 && bioCtrl.text.length != 0 && emailCtrl.text.length != 0 && passwordCtrl.text.length != 0 && confirmPassCtrl.text.length != 0) {
                Repository.signup(fName: fnameCtrl.text, lName: lNameCtrl.text, email: emailCtrl.text, mno: mnoCtrl.text, bio: bioCtrl.text, password: passwordCtrl.text);
              }
            },
            child: Text(
              "Signup",
              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),
            ),
            color: Colors.cyan,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
      ],
    );
  }

  void initControllers() {
    fnameCtrl = TextEditingController();
    lNameCtrl = TextEditingController();
    mnoCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    confirmPassCtrl = TextEditingController();
    bioCtrl = TextEditingController();
  }

  validateFields({String arg, Fields fields}) {
    switch (fields) {
      case Fields.Fname:
        if (arg.length == 0) {
          return AppSrings.fnameError;
        }
        break;
      case Fields.Lname:
        if (arg.length == 0) {
          return AppSrings.lnameError;
        }
        break;
      case Fields.Password:
        if (arg.length == 0) {
          return AppSrings.passwordError;
        }
        break;
      case Fields.Mno:
        if (arg.length != 10) {
          return AppSrings.mobileError;
        }
        break;
      case Fields.Bio:
        if (arg.length == 0) {
          return AppSrings.bioError;
        }
        break;
      case Fields.Email:
        if (arg.length == 0) {
          return AppSrings.emailError;
        }
        break;
      case Fields.Password:
        if (arg.length == 0) {
          return AppSrings.passwordError;
        }
        break;
      case Fields.ConfirmPassord:
        if (arg.length == 0) {
          return AppSrings.confiremPasswordError;
        }
        break;
    }
  }

  void sbmitAndSignup() {
    var obj = {"first_name": fnameCtrl.text, "last_name": lNameCtrl.text, "mobile_number": mnoCtrl.text, "email": emailCtrl.text, "password": passwordCtrl.text, "bio": bioCtrl.text};
    ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.createAccount, map: obj).then((value) {
      print("RESPONSE ${value.toString()}");
      if (value['Status_code'] == '200') {
        ToastMessage.showToast(message: value['Message'], type: true);
        SignupModel signupModel = SignupModel.fromJson(value);
        Database.initDatabase();
        Database.saveUserId(signupModel.result.userId);
        Get.to(CategoriesPage());
        print("RESPONSE ID ${Database.getUserID()}");
      } else {
        ToastMessage.showToast(message: value['Message'], type: false);
      }
    });
  }
}

enum Fields { Fname, Lname, Mno, Email, Bio, Password, ConfirmPassord }
enum FieldError { Empty, Invalid }
