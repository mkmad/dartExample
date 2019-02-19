import "package:flutter/material.dart";


class ScaffoldHome extends StatelessWidget{

  String title;

  ScaffoldHome({Key key, this.title}): super(key: key);

  Scaffold createScafflod(){
    /*
      Scaffold has many in-built widgets like AppBar,
      floatingActionButton, bottomNavigationBar, body etc..

      So, we dclare the properties of these widgets and return
      the scaffold

     */

    return new Scaffold(

      // Creates and sets params for AppBar
      appBar: new AppBar(
        backgroundColor: Colors.deepOrange.shade700,
        title: new Text(this.title) ,
      ),

      // Creates and sets params for body of scaffold
      body: new Container(
        color: Colors.grey,
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

          new BottomNavigationBarItem(icon: new Icon(Icons.account_box, color: Colors.black26), title: new Text("Account")),
          new BottomNavigationBarItem(icon: new Icon(Icons.restaurant_menu, color: Colors.black26), title: new Text("Menu")),
          new BottomNavigationBarItem(icon: new Icon(Icons.pages, color: Colors.black26), title: new Text("Options")),
          new BottomNavigationBarItem(icon: new Icon(Icons.settings, color: Colors.black26), title: new Text("Settings"))
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