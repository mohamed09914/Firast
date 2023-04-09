import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:report/view/ReplayRe.dart';
import 'package:report/view/UploadRe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Webview.dart';

class menu_sid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return menu_run();
  }
}
class menu_run extends State<menu_sid>{

  void _showdialog() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Padding(
          padding: EdgeInsets.only(
          left: 0.0,
            top: 5.0,
            right: 0.0,
            bottom: 5.0,
          ),
          child: Column(
          children: [
          new Image.asset(
          'images/_icon.png',
          ),
          ],
          ),
          ),
            content: Column(
              children: [
                Text("Thank you for Rating Us", style: TextStyle(fontSize: 16, color: Colors.black),),
                SizedBox(height: 3,),
                RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.orangeAccent,),
                    onRatingUpdate: (rating) {
                      print(rating);
                    }
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context,false),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  )),
            ],
          );
        });
  }

  void _showdialog1() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Padding(
              padding: EdgeInsets.only(
                left: 0.0,
                top: 5.0,
                right: 0.0,
                bottom: 5.0,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'images/_icon.png',
                  ),
                  Text('1.0.0'),
                ],
              ),
            ),
            content: Column(
              children: [
                SizedBox(width: double.infinity,child: Text("تطبيقنا", textAlign: TextAlign.right,style: TextStyle(fontSize: 20, color: Colors.black),)),
                SizedBox(height: 3,),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "بلاغاتي تطبيق يقدم الخدمات التي توفرها الشركة السودانية لتوزيع الكهرباء لعملائها، من رفع بلاغ ومتابعة حالة مع توفير إرشادات عن بعض الأعطال التي لا تحتاج إلى تدخل المهندسين ، أملين في المستقبل علي تقديم جميع الخدمات التي تتوفر للعملاء والعاملين من قبل الشركة السودانية لتوزيع الكهرباء",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 16, color: Colors.black),),
                ),
                SizedBox(height: 3,),
                SizedBox(width: double.infinity,child: Text("أهدافنا", textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 20, color: Colors.black),)),
                SizedBox(height: 3,),
                SizedBox(width: double.infinity,
                  child: Text("نهدف لتسهيل الوصول بين العملاء ومكتب توفير الخدمات التابعة للشركة السودانية لتوزيع الكهرباء، وإلي تقليل ضغط العمل في مراكز الخدمات الخاصة بالشركة",
                   textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 16, color: Colors.black),),
                ),
                SizedBox(height: 3,),
                SizedBox(width: double.infinity,child: Text("فريقنا",textAlign: TextAlign.right, style: TextStyle(fontSize: 20, color: Colors.black),)),
                SizedBox(height: 3,),
                SizedBox(width: double.infinity,child: Text(
                  "تطور بلاغاتي علي يد كل من - عبد الناصر محمد احمد - محمد تاج السر عطا المنان - محمد عثمان محمد عثمان - محمد كمال صديق أحمداي - بأشراف الأستاذ الجليل تاج الدين موسى بخيت - كرسالة بكلاريوس شرف من جامعة أمدرمان الإسلامية",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 16, color: Colors.black),)),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context,false),
                  child: Text(
                    'إغلاق',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox.fromSize(size: Size.square(50),),
            Container(
              child: Padding(padding: EdgeInsets.only(left: 65.0,top: 0.0,right: 65.0,bottom: 0.0, ),
                child: Column(
                  children: [
                    new Image.asset('images/index.png',),
                  ],

                ),
              ),
            ),
             Column(
                children: [
                  Container(
                    child: Padding(padding: EdgeInsets.only(left: 0.0,top: 0.0,right: 0.0,bottom: 30.0,),
                      child : new Column(
                        children :[
                          new Text("الشركة السودانية لتوزيع الكهرباء المحدودة",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          new Text("Sudanese Electricity Distribution Co.Ltd",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),),
                  ),
                  Container(
                    child: Padding(padding: EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed:()=> Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context)=> uploadre(),
                                  ),
                                      (route) => route.isFirst,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("تسجيل بلاغ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),),
                                   // SizedBox(width: 15),
                                  ],),
                                style: ButtonStyle(
                                  alignment: Alignment.centerRight,
                                ),),),
                          ),
                          Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: () => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context)=> replay(),
                                  ),
                                      (route) => route.isFirst,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("متابعة حالة البلاغ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),),
                                    //SizedBox(width: 15),
                                  ],),
                                style: ButtonStyle(
                                  alignment: Alignment.centerRight,
                                ),),),
                          ),
                          Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: ()=>Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => webview(),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("الإرشادات المرجعية",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),),
                                    //SizedBox(width: 15),
                                  ],),
                                style: ButtonStyle(
                                  alignment: Alignment.centerRight,
                                ),),),
                          ),
                          Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: (){
                                  Get.snackbar(
                                    'Coming Soon',
                                    'This service is coming soon ...',
                                    colorText: Colors.white,
                                    backgroundColor: Colors.black54,
                                    snackPosition: SnackPosition.TOP,
                                    padding: EdgeInsets.only(
                                      bottom: 30,
                                      left: 10,
                                      right: 10,
                                      top: 20,
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("خدمات شراء الكهرباء",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),),
                                    //SizedBox(width: 15),
                                  ],),
                                style: ButtonStyle(
                                  alignment: Alignment.centerRight,
                                ),),),
                          ),
                          Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: (){
                                  Get.snackbar(
                                    'Coming Soon',
                                    'This service is coming soon ...',
                                    colorText: Colors.white,
                                    backgroundColor: Colors.black54,
                                    snackPosition: SnackPosition.TOP,
                                    padding: EdgeInsets.only(
                                      bottom: 30,
                                      left: 10,
                                      right: 10,
                                      top: 20,
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("خدمات توصيل الكهرباء",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),),
                                    //SizedBox(width: 15),
                                  ],),
                                style: ButtonStyle(
                                  alignment: Alignment.centerRight,
                                ),),),
                          ),
                          Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: (){
                                  Get.snackbar(
                                    'Coming Soon',
                                    'This service is coming soon ...',
                                    colorText: Colors.white,
                                    backgroundColor: Colors.black54,
                                    snackPosition: SnackPosition.TOP,
                                    padding: EdgeInsets.only(
                                      bottom: 30,
                                      left: 10,
                                      right: 10,
                                      top: 20,
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("خدمات قطاع العاملين",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),),
                                    //SizedBox(width: 15),
                                  ],),
                                style: ButtonStyle(
                                  alignment: Alignment.centerRight,
                                ),),),
                          ),
                          Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: (){
                                  Get.snackbar(
                                    'Coming Soon',
                                    'This service is coming soon ...',
                                    colorText: Colors.white,
                                    backgroundColor: Colors.black54,
                                    snackPosition: SnackPosition.TOP,
                                    padding: EdgeInsets.only(
                                      bottom: 30,
                                      left: 10,
                                      right: 10,
                                      top: 20,
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("خدمات قطاع الموردين",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),),
                                   // SizedBox(width: 15),
                                  ],),
                                style: ButtonStyle(
                                  alignment: Alignment.centerRight,
                                ),),),
                          ),
                          Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: (){
                                  _showdialog1();
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("حول التطبيق",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),),
                                    //SizedBox(width: 15),
                                  ],),
                                style: ButtonStyle(
                                  alignment: Alignment.centerRight,
                                ),),),
                          ),
                          Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: (){
                                  _showdialog();
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("تقييم التطبيق",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),),
                                   // SizedBox(width: 15),
                                  ],),
                                style: ButtonStyle(
                                  alignment: Alignment.centerRight,
                                ),),),
                          ),
                        ],),),
                  ),
                  Center(
                    child: Row(
                      children: [
                        Expanded(child: Container(
                          child: TextButton(
                            onPressed: () async {
                              final Uri url = Uri(scheme: 'https', host: 'www.facebook.com');
                              if(await canLaunchUrl(url)){
                              await launchUrl(url);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.facebook,
                                  size: 45,),
                              ],),
                            style: ButtonStyle(
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ),),
                        Expanded(child: Container(
                          child: TextButton(
                            onPressed: () async {
                              final Uri tel = Uri(
                                scheme: 'tel',
                                path: '4848',
                              );
                              if(await canLaunchUrl(tel)){
                              await launchUrl(tel);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.local_phone_outlined,
                                  size: 45,
                                  color: Colors.green,),
                              ],),
                            style: ButtonStyle(
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ),),
                        Expanded(child: Container(
                          child: TextButton(
                            onPressed: () async {
                              final Uri email = Uri(
                                scheme: 'mailto',
                                path: 'info@sedc.com.sd',
                              );
                              if(await canLaunchUrl(email)){
                              await launchUrl(email);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.email_outlined,
                                  color: Colors.red,
                                  size: 45,),
                              ],),
                            style: ButtonStyle(
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ),),
                        Expanded(child: Container(
                          child: TextButton(
                            onPressed: () async {
                              final Uri url = Uri(scheme: 'https', host: 'www.sedc.com.sd');
                              if(await canLaunchUrl(url)){
                              await launchUrl(url);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.open_in_browser,
                                  size: 45,),
                              ],),
                            style: ButtonStyle(
                              alignment: Alignment.centerRight,
                            ),
                          ),
                        ),),
                      ],
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                  color: Colors.black38,
                                  width: 1.5,
                                )
                            ),
                        ),
                        child: Text(
                            "Bachelor's thesis from O.I.U"
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}