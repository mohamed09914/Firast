import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:report/view/MenuSid.dart';
import 'package:report/view/ReplayRe.dart';
import 'package:report/view/Webview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'UploadRe.dart';

class mainactivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return main_screen();
  }
}

class main_screen extends State<mainactivity> {
@override
  void initState() {
    r_permission();
    super.initState();
  }
Future<void> r_permission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if(settings.authorizationStatus == AuthorizationStatus.authorized){
    print('User granted permission');
  }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
    print('User granted provisional permission');
  }else{
    print('User declined or has not accepted permission');
  }
}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "بلاغاتي",
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      drawer: menu_sid(),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 100.0,
                  top: 15.0,
                  right: 100.0,
                  bottom: 0.0,
                ),
                child: Column(
                  children: [
                    new Image.asset(
                      'images/index.png',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 55.0,
                  top: 0.0,
                  right: 55.0,
                  bottom: 0.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5, right: 5, left: 5),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => uploadre(),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        //  border: Border.all(width: 5,color: Colors.black,style: BorderStyle.solid),
                                        color: Colors.orangeAccent,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(50),
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      //width: double.infinity,
                                      padding: EdgeInsets.only(
                                        right: 15,
                                        left: 15,
                                        top: 5,
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        "تسجيل بلاغ",
                                        style: TextStyle(
                                          fontSize: 20,
                                          // backgroundColor: Colors.red,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      size: 45,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      width: 3,
                                      style: BorderStyle.solid,
                                      color: Colors.orangeAccent,
                                    )),
                                primary: Colors.white,
                                padding: EdgeInsets.all(0),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => replay(),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        //  border: Border.all(width: 5,color: Colors.black,style: BorderStyle.solid),
                                        color: Colors.orangeAccent,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(50),
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 15,
                                        left: 15,
                                        top: 5,
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        "متابعة حالة البلاغ",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.access_time,
                                      size: 45,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      width: 3,
                                      style: BorderStyle.solid,
                                      color: Colors.orangeAccent,
                                    )),
                                primary: Colors.white,
                                padding: EdgeInsets.all(0),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => webview(),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        //  border: Border.all(width: 5,color: Colors.black,style: BorderStyle.solid),
                                        color: Colors.orangeAccent,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(50),
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      padding: EdgeInsets.only(
                                        right: 15,
                                        left: 15,
                                        top: 5,
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        "الإرشادات المرجعية",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18),
                                    child: Icon(
                                      Icons.integration_instructions_outlined,
                                      size: 45,
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                      width: 3,
                                      style: BorderStyle.solid,
                                      color: Colors.orangeAccent,
                                    )),
                                primary: Colors.white,
                                padding: EdgeInsets.all(0),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 40.0,
                right: 20.0,
                bottom: 0.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: new FloatingActionButton(
                        onPressed: () async {
                          final Uri url =
                              Uri(scheme: 'https', host: 'www.facebook.com');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: new Icon(
                          Icons.facebook_outlined,
                          size: 55,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: new FloatingActionButton(
                        onPressed: () async {
                          final Uri tel = Uri(
                            scheme: 'tel',
                            path: '4848',
                          );
                          if (await canLaunchUrl(tel)) {
                            await launchUrl(tel);
                          }
                        },
                        child: new Icon(
                          Icons.phone,
                          size: 40,
                          color: Colors.green,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: new FloatingActionButton(
                        onPressed: () async {
                          final Uri email = Uri(
                            scheme: 'mailto',
                            path: 'info@sedc.com.sd',
                          );
                          if (await canLaunchUrl(email)) {
                            await launchUrl(email);
                          }
                        },
                        child: new Icon(
                          Icons.email_outlined,
                          color: Colors.redAccent,
                          size: 40,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: new FloatingActionButton(
                        onPressed: () async {
                          final Uri url =
                              Uri(scheme: 'https', host: 'www.sedc.com.sd');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: new Icon(
                          Icons.open_in_browser,
                          color: Colors.blue,
                          size: 45,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 0.0,
                top: 0.0,
                right: 0.0,
                bottom: 0.0,
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
          ],
        ),
      ),
    );
  }
}
