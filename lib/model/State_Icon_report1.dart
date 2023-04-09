import 'package:flutter/material.dart';

class State_Icon1 extends StatelessWidget {
  const State_Icon1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        width: double.infinity,
        color: Colors.black26,
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