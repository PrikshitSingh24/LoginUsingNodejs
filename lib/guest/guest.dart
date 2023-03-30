import 'package:flutter/material.dart';

class guest extends StatefulWidget {
  const guest({Key? key}) : super(key: key);

  @override
  State<guest> createState() => _guestState();
}

class _guestState extends State<guest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Guest Screen"),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      backgroundColor: Colors.yellow,
    );

  }
}
