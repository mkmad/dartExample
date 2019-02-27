import 'package:flutter/material.dart';

// Create a custom stateful widget
class ScaffoldStatefullWidget extends StatefulWidget {
  String title;

  ScaffoldStatefullWidget({Key key, this.title}) : super(key: key);

  // It is necessary to create states of every
  // stateful widget
  @override
  State<StatefulWidget> createState() {
    return new CustomState(title: this.title);
  }
}

// This class creates a state for the CustomStatefulWidget
// Note: how it extends State and its of type <CustomStatefulWidget>
class CustomState extends State<ScaffoldStatefullWidget> {
  String title;

  int tapped = 0;

  void updateUI() {
    // The setState call updates all the variables and redraws the UI
    // therefore updating the variables in the UI (tapped in this case)
    setState(() {
      this.tapped += 1;
    });
  }

  CustomState({this.title});

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

      // Creates and sets params for body of scaffold
      // The hierarchy of the body is:
      // Container -> Column -> [Inkwell]
      body: new Container(
        //color: Colors.grey,
        // set the alignment of the container to center
        alignment: Alignment.center,
        child: new Column(
            // align the column also the center
            mainAxisAlignment: MainAxisAlignment.center,
            // The column can have many children each of which will
            // be a row in the column
            children: <Widget>[
              // Expanded widget stretches all its child widgets to occupy
              // the remaining space below
              // Note: Expanded will divide the space equally (depending on
              // the number of Expanded statements)
              new Expanded(
                  child: new Text("StateFull Widget",
                      style: new TextStyle(
                          color: Colors.deepOrange.shade700,
                          fontSize: 30,
                          fontWeight: FontWeight.w600))),

              new Expanded(
                  child: new Center(
                      child: new Text("Pressed $tapped times",
                          style: new TextStyle(
                              color: Colors.deepOrange.shade700,
                              fontSize: 30,
                              fontWeight: FontWeight.w600)))),

              new Expanded(
                  // Note: If you use Center widget as the child of the Expanded then
                  // the widget that's the child of Center will be positioned in the
                  // central space of the expanded space
                  child: new Center(
                      // FlatButton will just set the button attributes without the corner radius
                      child: new FlatButton(
                          color: Colors.deepOrange,
                          textColor: Colors.white,
                          // Call updateUI which in-turn sets the state of the CustomState Widget and redraws
                          // the UI
                          onPressed: updateUI,
                          child: new Text("Press Me",
                              style: new TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600))))),
            ]),
      ),

      // Creates and sets params for floatingActionButton
      floatingActionButton: new FloatingActionButton(
        onPressed: () => debugPrint("Floating Button Touched"),
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
