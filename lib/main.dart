import 'dart:math';

import 'package:flutter/material.dart';
import 'facts.dart';
import 'colors.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation.addListener(() {
      this.setState(() {});
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  String getRandomElement(List<String> list) {
    var i = random.nextInt(list.length);
    return list[i];
  }

  void showfacts() {
    setState(() {
      dispfact = getRandomElement(facts);
      dispcolor = someColors[Random().nextInt(someColors.length)];
      animationController.reset();
      animationController.forward();
    });
  }

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dispcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Did you Know?",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
                child: Opacity(
                  opacity: animation.value * 1,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, animation.value * -50.0, 0.0),
                      child: Text(
                        dispfact,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w300),
                      )),
                ),
              ),
              MaterialButton(
                color: Colors.white,
                minWidth: 160.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 18.0),
                  child: Text(
                    "Show Another Fun Fact",
                    style: TextStyle(fontSize: 15.0, color: dispcolor),
                  ),
                ),
                onPressed: showfacts,
              )
            ],
          ),
        ),
      ),
    );
  }
}
