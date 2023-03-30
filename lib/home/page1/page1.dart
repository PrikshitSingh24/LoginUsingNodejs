import 'package:assignment/home/page2/page2.dart';
import 'package:assignment/welcomScreen/page_2/page2.dart';
import 'package:assignment/welcomScreen/page_2/register.dart';
import 'package:assignment/welcomScreen/services/shared_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class page1Home extends StatefulWidget {
  const page1Home({Key? key}) : super(key: key);

  @override
  State<page1Home> createState() => _page1HomeState();
}

class _page1HomeState extends State<page1Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
            child: Text('Profile',style: TextStyle(
              fontSize: 50,
              color: Colors.red,
            ),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: TitledContainer(
            titleColor: Colors.red,
            title: "username",
            textAlign: TextAlignTitledContainer.Left,
            fontSize: 14.0,
            backgroundColor: Colors.yellow,
            child: Container(
              width: 350,
                height: 50,
              decoration: BoxDecoration(
                color: Colors.yellow,
                border: Border.all(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(padding:EdgeInsets.symmetric(vertical: 15,horizontal: 10),child: Text(page2.username!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18)))
            ),
          ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: TitledContainer(
            titleColor: Colors.red,
            title: "email",
            textAlign: TextAlignTitledContainer.Left,
            fontSize: 14.0,
            backgroundColor: Colors.yellow,
            child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(padding:EdgeInsets.symmetric(vertical: 15,horizontal: 10),child:
                Text("Name of the user",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),
                ),
                ),
            ),
          ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: TitledContainer(
            titleColor: Colors.red,
            title: "Address",
            textAlign: TextAlignTitledContainer.Left,
            fontSize: 14.0,
            backgroundColor: Colors.yellow,
            child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(padding:EdgeInsets.symmetric(vertical: 15,horizontal: 10),child: Text(page2Home.address,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 18),))
            ),
          ),
        ),
      ],
    );
  }
}
