import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static var textFieldBorder = OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black38));

  static var errorHeight = TextStyle(height: 0.4);
  static var errorBorder = OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.red));

  static var loader = Center(
    child: CircularProgressIndicator(),
  );

  static var linearLoader = LinearProgressIndicator();
  static var noData = Center(
    child: Text('No data'),
  );

  static void launchUrl({String zoomLink}) async {
    await await launch("https://us05web.zoom.us/j/81770167728");
    //await canLaunch("") ? await launch("https://mail.google.com/mail/") : throw 'Could not launch';
  }
}
