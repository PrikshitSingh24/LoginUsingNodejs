import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assignment/guest/guest.dart';
import 'package:assignment/welcomScreen/page_1/page1.dart';
import 'package:assignment/welcomScreen/page_2/page2.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({Key? key}) : super(key: key);

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  //controller to keep track of what page we are on..
  PageController _controller=PageController();
  //if we are on the last page
  bool onLastPage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ PageView(
          controller: _controller,
          onPageChanged: (index){
            setState(() {
              onLastPage=(index==1);
            });
          },
          children: [
            page1(),
            page2(),
          ],
        ),
          Container(
            alignment: Alignment(0,0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:[
                SmoothPageIndicator(controller: _controller, count: 2),
                  SizedBox(height: 20,),
                  onLastPage
                  ? ElevatedButton(
                    onPressed: () {
                      _controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                    },
                    child: Text('Previous',style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.limeAccent
                    ),
                  ): ElevatedButton(
                    onPressed: () {
                      _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                    },
                    child: Text('   Next    ',style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.limeAccent,
                    ),
                  ),
                  SizedBox(height: 20,),
              ],
          ),
    ),
      ],
      ),
    );
  }
}
