import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;

// Create a custom stateful widget
class WeatherHome extends StatefulWidget {
  String title;

  WeatherHome({Key key, this.title}) : super(key: key);

  // It is necessary to create states of every
  // stateful widget
  @override
  State<StatefulWidget> createState() {
    return new CustomState(title: this.title);
  }
}

// This class creates a state for the CustomStatefulWidget
// Note: how it extends State and its of type <CustomStatefulWidget>
class CustomState extends State<WeatherHome> {
  String title;
  var temperature;

  CustomState({this.title});

  // Async request call to fetch the posts from a given url
  // Note: This function returns a Future<List> which gets
  //       converted to List if this function is called by
  //       another async function
  Future<Map> getWeather(String city) async {
    // The url to hit
    String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${utils.appId}&units=metric";

    // Note: I chain the results here, get(url) returns a response
    //       that is passed to 'then' statement (which gets executed only
    //       if there is a response objects), I then return response.body
    //       or throw an error depending on the response's status code
    //       that is then passed along to the next 'then' statement where
    //       I decode the body. This final decoded body is then passed
    //       as a return value to this function

    // Also Note: I set the value of data inside setState that's again inside
    //            of 'then' statement. This is how you use steState inside async
    //            functions. If you call setState outside then the async function
    //            might update an incorrect value since the async function escapes
    //            and computes a new value, hence - always use setState inside the
    //            'then' statement. In a way 'then' statements acts as completion
    //            handlers

    // IMP: Calling setState inside the Future func is causing the scaffold
    //      widget to redraw and call FutureBuilder again which in turn is
    //      calling this function again, causing an infinite loop. So, I've
    //      commented it out

    var data;

    // Http get function, note the await before the http.get
    Future<Map> result = await http.get(url).then((response) {
      return response.statusCode == 200
          ? response.body
          : throw 'Error when getting data';
    }).then((body) {
      // This is the data I am returning to the futureBuilder
      data = json.decode(body);

      // We can also call setState inside the 'then' statements

      //  setState(() {
      //    // We update the value of data inside setState, which will update the
      //    // each of the values of ListTile inside the ListView.builder in the body
      //    // section
      //    temperature = data["main"]["temp_max"];
      //  });
    });

    return data;
  }

  // This is a function that builds a future widget which like any
  // other widget can be used anywhere (child, children etc)

  // The two important keys in the FutureBuilder are builder and
  // future. The builder is where you actually build the widget using
  // the inputs provided by the future function, AsyncSnapshot holds
  // the result which we can use. The future key expects a future
  // async function (getWeather in this case), so the FutureBuilder
  // waits for the async future function to compute and return data
  // which it uses to build the widget
  Widget futureWidget(String city) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        // return widget according to the data provided
        if (snapshot.hasData) {
          Map data = snapshot.data;
          return new Container(
            child: new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    "${data["main"]["temp_max"].toString()} C",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          );
        } else {
          // returns a CircularProgressIndicator if snapshot has no data
          return new CircularProgressIndicator();
        }
      },
      future: getWeather(city),
    );
  }

  // Here is set all initial states, I also call on the async getWeather
  // function here to set the temperature in the beginning

  //  @override
  //  void initState() {
  //    // This is the proper place to make the async calls
  //    // This way they only get called once
  //
  //    // During development, if you change this code,
  //    // you will need to do a full restart instead of just a hot reload
  //
  //    // You can't use async/await here,
  //    // We can't mark this method as async because of the @override
  //    getWeather("Delhi").then((result) {
  //      // If we need to rebuild the widget with the resulting data,
  //      // make sure to use `setState`
  //      if (result != null) {
  //        setState(() {
  //          temperature = result["main"]["temp_max"];
  //        });
  //      }
  //    });
  //  }

  Scaffold createScafflod() {
    /*
      Scaffold has many in-built widgets like AppBar,
      floatingActionButton, bottomNavigationBar, body etc..

      So, we declare the properties of these widgets and return
      the scaffold

     */

    return new Scaffold(
      // Creates and sets params for AppBar
      appBar: new AppBar(
          backgroundColor: Colors.white,
          title: new Text(
            this.title,
            style: new TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          // The action widgets are the right icons in the appBar
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.menu),
                color: Colors.grey,
                onPressed: () => debugPrint("Menu Tapped!")),
          ]),

      // Creates and sets params for body of scaffold

      // Since we are going to stack widgets one on top of the
      // other we can use stack widget which will allow
      // all its children (widgets) inside it to be
      // stacked on top of each other

      body: new Stack(
        children: <Widget>[
          // background image, specify height & width and also
          // specify that the fit is BoxFit.fill
          new Center(
            child: new Image.asset(
              "images/umbrella.png",
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),

          // Create a text at the top right corner of the screen
          new Container(
            alignment: Alignment.topRight,
            // This margin/padding is important to align it in the right
            // corner
            margin: const EdgeInsets.fromLTRB(0.0, 11.0, 21.0, 0.0),
            child: new Text(
              "Current Weather",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 22.0),
            ),
          ),

          // Center image
          new Container(
            alignment: Alignment.center,
            child: new Image.asset("images/light_rain.png"),
          ),

          // Another text field, pay attention to the edge insets
          // This time I set top and right margins to align the
          // text slightly below the center and slightly to the
          // left

          // Also Note: The child of the container returns a future
          // widget, that builds a widget using the data returned
          // from async function calls
          new Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(55.0, 375.0, 0, 0),
            child: futureWidget("Chicago"),
          )
        ],
      ),

      // Creates and sets params for floatingActionButton
      floatingActionButton: new FloatingActionButton(
        onPressed: () => getWeather("Toronto"),
        backgroundColor: Colors.pink,
        // tooltip describes what the button does when its long pressed
        tooltip: 'prints button pressed',
        child: new Icon(Icons.add),
      ),

      // Creates and sets params for bottomNavigationBar
      // Note: bottomNavigationBar requires atleast 2 items
      bottomNavigationBar: new BottomNavigationBar(
        // have to declare the type if there are more
        // than 3 navigation items
        type: BottomNavigationBarType.fixed,

        // The actual buttons
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.account_box, color: Colors.black26),
              title: new Text("Account")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.restaurant_menu, color: Colors.black26),
              title: new Text("Menu")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.pages, color: Colors.black26),
              title: new Text("Options")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.settings, color: Colors.black26),
              title: new Text("Settings"))
        ],

        // action handler for item pressed (note: its index based)
        onTap: (int i) => debugPrint("Hey Touched $i"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return createScafflod();
  }
}
