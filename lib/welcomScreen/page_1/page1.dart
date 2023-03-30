import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class page1 extends StatelessWidget {
  const page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Column(
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: EdgeInsets.all(30),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText("Welcome,\n please sign in ",speed:Duration(milliseconds: 90),textStyle: TextStyle(
                  fontSize: 50,
                  color: Colors.red,
                  fontFamily: 'raleway',
                ))
              ],
              totalRepeatCount: 1,
            ),
          ),
          SizedBox(height: 40,),
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText("----------------------->",speed:Duration(milliseconds: 90),textStyle: TextStyle(
                fontSize: 50,
                color: Colors.red,
              ))
            ],
            totalRepeatCount: 1,
          ),
        ],
      ),
    );
  }
}
