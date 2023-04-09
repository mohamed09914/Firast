import 'dart:async';
import 'package:flutter/material.dart';
import 'package:report/view/screenPin.dart';

class loadTime extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return load();
  }
}
class load extends State<loadTime> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), GoToPin);
  }
  GoToPin(){
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Log(),
      ),
          (route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
         child: SizedBox(
           width: double.infinity,
           height: double.infinity,
           child: Container(
             alignment: Alignment.center,
             child: Column(
               children: [
                 Padding(padding: const EdgeInsets.only(bottom: 10.0,top: 220,left: 130,right: 130),
                   child: Image.asset(
                     'images/index.png',
                   ),
                 ),
                 SizedBox(height: 3,),
                 Padding(
                   padding: EdgeInsets.only(
                     left: 0.0,
                     top: 0.0,
                     right: 0.0,
                     bottom: 10.0,
                   ),
                   child: new Column(
                     children: [
                       new Text(
                         "الشركة السودانية لتوزيع الكهرباء المحدودة",
                         style: TextStyle(
                           fontSize: 18,
                         ),
                       ),
                       new Text(
                         "Sudanese Electricity Distribution Co.Ltd",
                         style: TextStyle(
                           color: Colors.red,
                         ),
                       ),
                     ],
                   ),
                 ),
                 SizedBox(height: 2,),
                 CircularProgressIndicator(
                   backgroundColor: Colors.orangeAccent,

                 ),
               ],
             ),
           ),
         ),
      ),
    );
  }
}
