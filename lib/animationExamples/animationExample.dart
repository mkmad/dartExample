import 'package:flutter/material.dart';

import 'chain_animation.dart';

// Create a custom stateful widget
class AnimationExample extends StatefulWidget {
  String title;

  AnimationExample({Key key, this.title}) : super(key: key);

  // It is necessary to create states of every
  // stateful widget
  @override
  State<StatefulWidget> createState() {
    return new CustomState(title: this.title);
  }
}

// This class creates a state for the CustomStatefulWidget
// Note: how it extends State and its of type <CustomStatefulWidget>
class CustomState extends State<AnimationExample>
    with SingleTickerProviderStateMixin {
  String title;

  CustomState({this.title});

  // required animation objects
  AnimationController _animationController;
  Animation<double> _animation;
  Animation<double> _tweenAnimation;

  // initialize
  @override
  void initState() {
    super.initState();
    // initialize the animation controller
    _animationController = new AnimationController(
        vsync: this, duration: const Duration(seconds: 5));

    // initialize a curved animation to the animation object
    _animation =
        new CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    // animation Completion listener
    _animation.addListener(() {
      setState(() {
        debugPrint("Animation value: ${_animation.value}");
        debugPrint("Animation Controller value: ${_animationController.value}");
      });
    });

    // animation status listener
    _animation.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          debugPrint("Animation complete");
          _animationController.reverse(from: 1.0);
          break;
        case AnimationStatus.reverse:
          debugPrint("Reversing animation");
          break;
        case AnimationStatus.dismissed:
          debugPrint("animation dismissed");
          break;
        case AnimationStatus.forward:
          debugPrint("Moving forward with animation");
          break;
      }
    });

    // initialize a tween animation
    _tweenAnimation =
        new Tween(begin: 0.0, end: 100.0).animate(_animationController);

    // animation Completion listener
    _tweenAnimation.addListener(() {
      setState(() {
        debugPrint("Tween Animation value: ${_tweenAnimation.value}");
        debugPrint(
            "Tween Animation Controller value: ${_animationController.value}");
      });
    });

    // animation status listener
    _tweenAnimation.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          debugPrint("Animation complete");
          _animationController.reverse(from: 1.0);
          break;
        case AnimationStatus.reverse:
          debugPrint("Reversing animation");
          break;
        case AnimationStatus.dismissed:
          debugPrint("animation dismissed");
          break;
        case AnimationStatus.forward:
          debugPrint("Moving forward with animation");
          break;
      }
    });

    // move forward with the animation
    _animationController.forward(from: 0.1);
  }

  // clear things(states, animations etc., here)
  @override
  void dispose() {
    // dispose all the animation here
    _animationController.dispose();
    super.dispose();
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

      // Creates and sets params for body of scaffold
      body: new Center(
          child: new Column(
        children: <Widget>[
          new Container(
            child: Text(
              "Animation",
              // increase the font size along with the _animation.value
              style: new TextStyle(fontSize: 25 * _animation.value),
            ),
          ),
          new SizedBox(
            height: 25.0,
          ),
          new Container(
            child: Text(
              _animationController.isAnimating
                  ? _tweenAnimation.value.toString()
                  : "Tween Animation",
              // increase the font size along with the _animation.value
              style: new TextStyle(fontSize: 0.2 * _tweenAnimation.value),
            ),
          ),
          new SizedBox(
            height: 25.0,
          ),

          // render a Animation widget
          new ChainAnimation(
            animation: _animation,
          ),

          new SizedBox(
            height: 25.0,
          ),

          new RaisedButton(
              child: new Text(
                "Animate Again",
                style: new TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              color: Colors.deepOrange,
              onPressed: () => {
                    // Note: This is how you start an animation
                    _animationController.forward(from: 0.1)
                  }),
        ],
      )),

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
