import 'package:assignment/home/page1/page1.dart';
import 'package:assignment/home/page2/page2.dart';
import 'package:assignment/welcomScreen/config/config.dart';
import 'package:assignment/welcomScreen/page_2/model/login_request_model.dart';
import 'package:assignment/welcomScreen/services/api_services.dart';
import 'package:assignment/welcomScreen/services/shared_services.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  PageController _controller=PageController();
  bool onLastPage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {
              SharedService.logout(context);
            },
            icon: Icon(Icons.logout),
            color: Colors.white,
          )
        ],
      ),
      body:  Stack(
        children:[ PageView(
          controller: _controller,
          onPageChanged: (index){
            setState(() {
              onLastPage=(index==1);
            });
          },
          children: [
            page1Home(),
            page2Home(),
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
                  child: Text('  Profile  ',style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.limeAccent
                  ),
                ): ElevatedButton(
                  onPressed: () {
                    _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                  child: Text('Location',style: TextStyle(color: Colors.black),),
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
  Widget userProfile() {
    return FutureBuilder(
      future: APIService.getUserProfile(LoginRequestModel()),
      builder: (
          BuildContext context,
          AsyncSnapshot<String> model,
          ) {
        if (model.hasData) {
          return Center(child: Text(model.data!,style: TextStyle(color: Colors.black),));
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
