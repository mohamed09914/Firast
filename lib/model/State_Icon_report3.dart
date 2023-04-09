import 'package:flutter/material.dart';

class State_Icon3 extends StatelessWidget {
  const State_Icon3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        color: Colors.greenAccent,
        child: Padding(
          padding: EdgeInsets.only(
            left: 110.0,
            top: 10.0,
            right: 110.0,
            bottom: 10.0,
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle_outline,
                size: 150,
                color: Colors.white,)
            ],
          ),
        ),
      ),
    );
  }
}