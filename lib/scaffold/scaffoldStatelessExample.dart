import "package:flutter/material.dart";

class ScaffoldStatelessWidget extends StatelessWidget {
  String title;

  ScaffoldStatelessWidget({Key key, this.title}) : super(key: key);

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
              // Inkwell is a rectangular area of a Material that responds to touch.
              // it has the onTap function keyword that responds to touchs

              /*
              new InkWell(
                child: new Text("InkWell Button!"),
                onTap: () => debugPrint("Button Tapped!"),
              ),
              */

              // Adding a custom button (see below for details on how
              // this button is built)
              new CustomButton(),
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

  // required function since this class extends StatelessWidget
  // Note: This function builds and returns the StatelessWidget
  @override
  Widget build(BuildContext context) {
    return createScafflod();
  }
}

// Build a custom widget (here a custom button which responds to
// gestures ) and return it to one of the children in the
// container column of the body
// Note: This is a separate class and not part of the Scaffold class
//       above
// Also Note: This is a StatelessWidget and it doesn't require you
//            to create a state
class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Assign a event handler to opTap that responds to tap
      // Note: onTap should be a function returning a widget
      // onTap: createSnackBar(context) will not work
      onTap: () => createSnackBar(context),

      // Create a container that will serve as a button and
      // since this container is a child of GestureDetector
      // it will respond to all the touch events of the
      // GestureDetector
      child: new Container(
        // Create a text field that serves as the button text
        child: new Text("Custom Button"),

        // Note: Since the container is a large canvas we need
        //       decorate it to look like a button
        decoration: new BoxDecoration(
            // Note: We get the default button color based on the current
            //       material theme by calling the Theme attribute
            color: Theme.of(context).buttonColor,

            // assigning a border radius to the container
            borderRadius: new BorderRadius.circular(5.0)),

        // We need this padding because the container wraps around
        // the largest child inside it so without this padding the container
        // would just be the size of the Text field
        padding: new EdgeInsets.all(18.0),
      ),
    );
  }

  // This function serves as an event handler for the GestureDetector's onTap
  createSnackBar(BuildContext context) {
    // create a snackbar
    final sb = new SnackBar(
      // setting the text of the background color
      content: new Text("Button tapped"),
      // setting the background color
      backgroundColor: Colors.deepOrange.shade700,
      // setting how long you want the snack bar to stay in screen
      duration: new Duration(seconds: 2),
    );

    // attach a snack bar to the scaffold

    // This line translates to, show snack bar using the
    // scaffold who's context is 'context'
    // Note: Scaffold (like the Theme var) is a global attribute
    //       which we can make use of in such scenarios
    Scaffold.of(context).showSnackBar(sb);
  }
}
