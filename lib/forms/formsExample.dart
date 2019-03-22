import 'package:flutter/material.dart';

// Create a Form Widget
class CustomForm extends StatefulWidget {
  String title;

  CustomForm({Key key, this.title}) : super(key: key);

  @override
  CustomFormState createState() {
    return CustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class CustomFormState extends State<CustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  String title;

  // initialize
  CustomFormState({this.title});

  // build the forms for the scaffold body
  Widget buildForms() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
              child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.subject),
                title: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  onSaved: (value) => debugPrint("Form field saved"),
                ),
              ),

              // Note: need the builder here because the snackbar
              //       was not getting the proper build context
              Builder(
                builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, we want to show a Snackbar
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  // build the scaffold
  Scaffold createScafflod(BuildContext context) {
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
          title: new Text("FormBuilder"),
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

      body: buildForms(),

      // Creates and sets params for floatingActionButton
      // Note: Here the onPressed of the floatingActionButton
      //       is mapped to a async function
      floatingActionButton: new FloatingActionButton(
        onPressed: () => debugPrint("Float pressed"),
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
    return createScafflod(context);
  }
}
