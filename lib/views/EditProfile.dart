import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:india_learner/blocs/UpdataProfileBloc.dart';
import 'package:india_learner/models/ShowProfileModel.dart';
import 'package:india_learner/networking/ApiHandler.dart';
import 'package:india_learner/networking/ApiProvider.dart';
import 'package:india_learner/networking/EndApi.dart';
import 'package:india_learner/utils/AppStrings.dart';
import 'package:india_learner/utils/Constants.dart';
import 'package:india_learner/utils/Utils.dart';
import 'package:india_learner/utils/database.dart';
import 'package:india_learner/views/CreateAccount.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class EditProfile extends StatefulWidget {
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool autovalidate = false;
  var querydata;
  String croppedImage, profileUrl;
  bool isObsecurePass = true, isObsecurePassConfirm = true;
  String theme;
  final picker = ImagePicker();
  File image;
  String profileImage;
  static String uploadImageUrl;

  TextEditingController fnameCtrl, lNameCtrl, mnoCtrl, emailCtrl, passwordCtrl, confirmPassCtrl, bioCtrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initControllers();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    querydata = MediaQuery.of(context).size.height;
    theme = MediaQuery.of(context).platformBrightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme == Constants.lightTheme ? Colors.black87 : Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        child: SizedBox(
          height: querydata < 600 ? 50 : 55,
          width: MediaQuery.of(context).size.width / 3,
          child: RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
              }
              setState(() {
                autovalidate = true;
              });
              if (fnameCtrl.text.length != 0 && lNameCtrl.text.length != 0 && mnoCtrl.text.length != 0 && bioCtrl.text.length != 0 && emailCtrl.text.length != 0) {
                updateProfile();
              }
            },
            child: Text(
              "Update",
              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),
            ),
            color: Colors.cyan,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.only(top: 20),
          width: Get.size.width,
          color: Colors.white,
          height: Get.size.height,
          child: Form(key: _formKey, autovalidate: autovalidate, child: getForm()),
        ),
      ),
    );
  }

  getForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: Stack(
              children: [
                profileImage == null
                    ? CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                            clipBehavior: Clip.hardEdge,
                            child: Image.asset(
                              'assets/images/teachers.jpg',
                              fit: BoxFit.cover,
                            )))
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: Image.network(
                          "https://indialearner.in/admin/uploads/images/61e5a94491d0f.jpg",
                          fit: BoxFit.fill,
                        ),
                      )
              ],
            )),
        SizedBox(
          height: 10,
        ),
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
        /*SizedBox(
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
        ),*/
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

  void getUserDetails() {
    Database.initDatabase();
    var obj = {'user_id': Database.getUserID()};
    ApiHandler.postApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.showProfile, map: obj).then((value) {
      print("VVVVVVV ${value.toString()}");
      final result = ShowProfileModel.fromJson(value).result;
      fnameCtrl.text = result[0].firstName;
      lNameCtrl.text = result[0].lastName;
      mnoCtrl.text = result[0].mobileNumber;
      emailCtrl.text = result[0].email;
      bioCtrl.text = result[0].bio;
      profileImage = result[0].profileImage;
    });
  }

  void updateProfile() {
    print("sdfghjk");
    Database.initDatabase();
    print("sdfghjk ${Database.getUserID()}");
    var obj = {"user_id": Database.getUserID(), "first_name": fnameCtrl.text, "last_name": lNameCtrl.text, "mobile_number": mnoCtrl.text, "email": emailCtrl.text, "bio": bioCtrl.text, "profile_image": uploadImageUrl};
    updateProfileBloc.updateProfile(request: obj);
    Future.delayed(Duration(seconds: 2), () {
      /*updateProfileBloc.updateStream.listen((event) {

      });*/
    });
    /*var obj = {"user_id": Database.getUserID(), "first_name": fnameCtrl.text, "last_name": lNameCtrl.text, "mobile_number": mnoCtrl.text, "email": emailCtrl.text, "bio": bioCtrl.text};
    ApiHandler.putApi(baseUrl: ApiProvider.baseUrl, endApi: EndApi.editProfile, map: json.encode(obj)).then((value) {
      if (value['Status_code'] == '200') {
        ToastMessage.showToast(message: 'Updated successfully', type: true);
      } else {
        ToastMessage.showToast(message: 'Update Failed', type: false);
      }
      print("RESPONSE ${value.toString()}");
    });*/
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        getImageFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getImageFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future getImageFromGallery() async {
    List<String> extensions;

    String filePath = await FilePicker.getFilePath(type: FileType.any, allowedExtensions: extensions);

    String dir = (await getApplicationDocumentsDirectory()).path;

    String extension = File(filePath).path.split('.').last;

    String fileName = "answerSheet";

    String newPath = path.join(dir, fileName + '.' + extension);

    File f = await File(filePath);

    File ff = await File(f.path).copy(newPath);

    String fName = ff.path.split('/').last;

    uploader(fileName: fName, directory: dir);

    /*final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        _cropImage();
      }
    });*/
  }

  Future getImageFromCamera() async {
    /*final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        _cropImage();
        setState(() {});
        String fileName = croppedImage.split('/').last;
        var dir = croppedImage;
        uploader(fileName: fileName, directory: dir);
      }
    });*/
    final picker = ImagePicker();
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);

    File file = File(pickedFile.path);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String imageName = 'rentswale';
    String extension = File(file.path).path.split('.').last;

    String newPath = path.join(dir, imageName + '.' + extension);

    File f = await File(pickedFile.path);
    File ff = await File(f.path).copy(newPath);
    String fileName = ff.path.split('/').last;

    uploader(fileName: fileName, directory: dir);
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        cropStyle: CropStyle.circle,
        maxWidth: 200,
        maxHeight: 200,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9]
            : [CropAspectRatioPreset.original, CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio5x3, CropAspectRatioPreset.ratio5x4, CropAspectRatioPreset.ratio7x5, CropAspectRatioPreset.ratio16x9],
        androidUiSettings: AndroidUiSettings(toolbarTitle: 'Cropper', toolbarColor: Colors.cyan, toolbarWidgetColor: Colors.white, initAspectRatio: CropAspectRatioPreset.ratio5x4, lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        croppedImage = croppedFile.path;
        String fileName = croppedImage.split('/').last;
        var dir = croppedImage;
        uploader(fileName: fileName, directory: dir);
        // uploadImage("ShubhamLarotiImage","https://xy2y3lhble.execute-api.ap-south-1.amazonaws.com/dev");
      });
    }
  }

  static Future<Map<String, dynamic>> uploader({fileName, directory}) async {
    dynamic prog;
    Map<String, dynamic> map;
    final uploader = FlutterUploader();
    //String fileName = await file.path.split('/').last;

    final taskId = await uploader.enqueue(url: ApiProvider.fileUploadUrl, files: [FileItem(filename: fileName, savedDir: directory)], method: UploadMethod.POST, headers: {"apikey": "api_123456", "userkey": "userkey_123456"}, showNotification: true);
    final subscription = uploader.progress.listen((progress) {});

    final subscription1 = uploader.result.listen((result) {
//    print("Progress result ${result.response}");

      // return result.response;
    }, onError: (ex, stacktrace) {});
    subscription1.onData((data) async {
      map = await json.decode(data.response);
      print("PATH data ${map.toString()}");
      print("PATH Url ${map['url']}");

      uploadImageUrl = map['url'];
      print("PATH AFTER Url ${uploadImageUrl}");
    });
  }
}
