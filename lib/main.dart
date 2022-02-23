// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:india_learner/MyHttpOverrides.dart';
import 'package:india_learner/utils/ThemeModel.dart';
import 'package:india_learner/views/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (_, model, __) {
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(), // Provide light theme.
              darkTheme: ThemeData.dark(), // Provide dark theme.
              themeMode: model.mode, // Decides which theme to show.
              home: SplashScreen() /*Scaffold(
              appBar: AppBar(title: Text('Light/Dark Theme')),
              body: ElevatedButton(
                onPressed: () => model.toggleMode(),
                child: Text('Toggle Theme'),
              ),
            ),*/
              );
        },
      ),
    )
        /*GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      home: SplashScreen(),
    )*/
        ;
  }
}
