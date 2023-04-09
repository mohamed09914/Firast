import 'package:flutter/material.dart';

class State_Icon2 extends StatelessWidget {
  const State_Icon2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        color: Colors.orangeAccent,
            child: Padding(
              padding: EdgeInsets.only(
                left: 110.0,
                top: 10.0,
                right: 110.0,
                bottom: 10.0,
              ),
              child: Column(
                children: [
                  Icon(Icons.access_time,
                    size: 150,
                    color: Colors.white,)
                ],
              ),
            ),
      ),
    );
  }
}