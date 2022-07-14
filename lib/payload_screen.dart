import 'package:flutter/material.dart';

class PayloadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
          padding: EdgeInsets.all(25),
          child: Text(
              // payload,
            "タップしたときに別のページの飛ばす処理",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              )
          )
      ),
    ));
  }
}
