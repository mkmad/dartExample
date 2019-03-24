import 'package:flutter/material.dart';
import 'package:flutter_app/animationExamples/animation.dart';

void main() {
  runApp(
    new MaterialApp(
      // Stateless Widget
      //home: new ScaffoldStatelessWidget(title: title,),

      /// State full Widget
      // home: new ScaffoldStatefullWidget(title: title),

      /// Login page
      //home: new Login(),

      /// Requests page
      //home: new RequestsWidget(title: "Requests Example",),

      /// Weather search page
      //home: new WeatherSearch(title: "Weather Search",),

      /// text storage
      //home: new TextStorageWidget(title: "Text Storage",)

      /// shared preferences (no-sql db)
      //home: new SharedPreferencesStorageWidget(title: "NoSql Storage"),

      /// firestore db
      //home: new FireStoreDB(title: "FireStore storage"),

      /// custom form
      //home: new CustomForm(title: "Custom Form")
      /// animation page
      home: new AnimationExample(
        title: "Animation Home",
      ),

      /// setting theme of the application
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
      ),

      /// required to remove the debug banner
      debugShowCheckedModeBanner: false,
    ),
  );
}
