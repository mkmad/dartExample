import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Create a custom stateful widget
class RequestsWidget extends StatefulWidget {
  String title;

  RequestsWidget({Key key, this.title}) : super(key: key);

  // It is necessary to create states of every
  // stateful widget
  @override
  State<StatefulWidget> createState() {
    return new CustomState(title: this.title);
  }
}

// This class creates a state for the CustomStatefulWidget
// Note: how it extends State and its of type <CustomStatefulWidget>
class CustomState extends State<RequestsWidget> {
  String title;

  CustomState({this.title});

  List data;

  // Async request call to fetch the posts from a given url
  // Note: This function returns a Future<List> which gets
  //       converted to List if this function is called by
  //       another async function
  Future<List> getData() async {
    // The url to hit
    String url = "https://jsonplaceholder.typicode.com/posts";

    // Http get function, note the await before the http.get
    // Also note: I chain the results here, get(url) returns a response
    //            that is passed to 'then' statement (which gets executed only
    //            if there is a response objects), I then return response.body
    //            or throw an error depending on the response's status code
    //            that is then passed along to the next 'then' statement where
    //            I decode the body. This final decoded body is then passed
    //            as a return value to this function

    // Also Note: decode the json from the response body and return as a
    //            list of dict's, i.e. [{...}, {...}, ...]

    // Also Note: I set the value of data inside setState that's again inside
    //            of 'then' statement. This is how you use steState inside async
    //            functions. If you call setState outside then the async function
    //            might update an incorrect value since the async function escapes
    //            and computes a new value, hence - always use setState inside the
    //            'then' statement. In a way 'then' statements acts as completion handlers

    Future<List> result = await http.get(url).then((response) {
      return response.statusCode == 200
          ? response.body
          : throw 'Error when getting data';
    }).then((body) {
      setState(() {
        // We update the value of data inside setState, which will update the
        // each of the values of ListTile inside the ListView.builder in the body
        // section
        data = json.decode(body);
        return data;
      });
    });

    return result;
  }

  // This async function acts as the handler for the floating button.
  // Since it calls an async function (getData) it also needs the
  // keyword async in its function definition. Similar to how we used
  // await for http.get we need to use await before calling getData
  // Also Note: Even though this function is also async we don't use
  //            async when mapping this function to the onPressed handler
  //            of the floating action button
  void listData() async {
    // Get the data from getData function asynchronously
    // Must have the await keyword when calling async functions
    await getData();
  }

  // This function is a list tap handler. It creates a alert box
  // every time a list item is tapped
  void handleListTap(BuildContext context, int position) {
    debugPrint("Position: $position tapped");

    // Create a alert dialog widget
    // Note: The onPressed of the FlatButton uses
    //       Navigator which keeps track of all the
    //       screens and when we say pop in a given context
    //       then its going to pop the top most screen
    //       (in this case the alert dialog)
    var alert = new AlertDialog(
      title: new Text(data[position]['title']),
      actions: <Widget>[
        new FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: new Text("OK")),
      ],
    );

    // show the alert dialog widget
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

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
          backgroundColor: Colors.deepOrange.shade700,
          title: new Text(this.title),
          centerTitle: true,
          // The action widgets are the right icons in the appBar
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => debugPrint("Send icon Tapped!")),
            new IconButton(
                icon: new Icon(Icons.search),
                onPressed: () => debugPrint("Send icon Tapped!")),
          ]),

      // ListView builder builds a scrollable list view
      // It takes in itemCount and itemBuilder as two main params
      body: ListView.builder(
        // Note: data var is built dynamically, hence when the body widget tries
        //       to layout the other widget, data is still null hence I have the
        //       itemCount set to 0 if the data is null
        itemCount: data == null ? 0 : data.length,
        // itemBuilder returns a column that's defined in this closure
        itemBuilder: (BuildContext context, int position) {
          return new Column(
            children: <Widget>[
              new Divider(
                height: 3.5,
              ),
              new ListTile(
                title: data == null
                    ? new Text("")
                    : new Text(
                        "${data[position]["title"]}",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                subtitle: data == null
                    ? new Text("")
                    : new Text("${data[position]["body"]}"),
                leading: CircleAvatar(
                  backgroundColor: Colors.orangeAccent,
                  child: new Text("X"),
                ),
                // Note: See how I am calling a function with params for the onTap handler
                onTap: () => handleListTap(context, position),
              ),
            ],
          );
        },
      ),

      // Creates and sets params for floatingActionButton
      // Note: Here the onPressed of the floatingActionButton
      //       is mapped to a async function
      floatingActionButton: new FloatingActionButton(
        onPressed: listData,
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
