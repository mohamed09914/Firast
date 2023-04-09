import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/TestConnetion.dart';
import '../model/user.dart';
import '../view_model/Database_healper.dart';
import 'MainActivity.dart';
import 'Report.dart';

TextEditingController _phone = new TextEditingController();
TextEditingController _gbsRe = new TextEditingController();
List<String> _location = ['خطوره', 'عام', 'خاص'];
List<String> _D = ['حريق في المحول الرئيسي', 'حريق في العمود', 'سلك واقع علي الطريق', 'عامود واقع', 'المحول الرئيسي واقع'];
List<String> _public = ['فصل في المحول الرئيسي', 'تذبذب في التيار الكهربائي'];
List<String> _prive = ['عدم أمكانية إدخال الكهرباء', 'ظهور رسالة أو شكل بالشاشة', 'شاشة العداد لا تعمل', 'صرف زائد أو عداد يعمل بالسالب', 'فصل في العداد الخاص'];
late bool showD = false;
late bool showP = false;
late bool showPriv = false;
var db = new DatabaseHelper();
late String time;

int num(int min, int max) {
  Random random = new Random();
  int X = random.nextInt(max - min) + min;
  return X;
}

int Number_Re = 0;

class re_data extends StatefulWidget {
  String Name_;
  String NumberCouter;
  String libriry;

  re_data(
      {required this.Name_, required this.libriry, required this.NumberCouter});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return readclass(
        Name_: Name_, libriry: libriry, NumberCouter: NumberCouter);
  }
}

class readclass extends State<re_data> {
  String Name_;
  String NumberCouter;
  String libriry;

  readclass(
      {required this.Name_, required this.libriry, required this.NumberCouter});

  String _vul = _location.first;
  String _vulType = 'وصف البلاغ';
  String _phonenumber = '';
  String _loction = '';
  String _Type = '';
  String _Nc = '';
  CollectionReference notice = FirebaseFirestore.instance.collection("notice");
  final counterNUM = FirebaseFirestore.instance.collection('notice');

  void _showdialogEnd(x) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
              "${x}",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            actions: [
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => mainactivity(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Text('نعم'))
            ],
          );
        });
  }

  void _showdialog(x) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
              "${x}",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          );
        });
  }

  Future Add_Notice() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.orangeAccent,
          ));
        });
    await notice.add({
      'ID': '${Number_Re}',
      'ID_counter': '${NumberCouter}',
      'Loction': '${_gbsRe.text}',
      'Name': '${Name_}',
      'Notice': '${_vulType}',
      'Office': '${libriry}',
      'Phone': '${_phone.text}',
      'State': 'تم رفع البلاغ',
      'Time': '${time}',
      'Type': '${_vul}',
      'Token': '${_Nc}',
    }).then((value) => {
          print('${value.id}'),
        });
    Navigator.of(context).pop();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => Report(Counter: '${Number_Re}'),
      ),
      (route) => route.isFirst,
    );
  }

  Future add() async {
    try {
      User user = new User(Number_Re, Name_, NumberCouter, _gbsRe.text,
          '${_vulType}', libriry, _phone.text, '', '${time}', '${_Type}');
      int ad = await db.saveUser(user);
      print('ok add user to local data:$ad');
    } catch (e) {
      print('Errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ...$e');
    }
  }
  
  void getToken() async{
    await FirebaseMessaging.instance.getToken().then(
        (token) {
          setState(() {
            _Nc = token!;
            print("My Tokin is $_Nc");
          });
        }
    );
  }

  @override
  void initState() {
    showD=false;
    showP=false;
    showPriv=false;
    Number_Re = num(142434, 12253845);
    time = DateFormat('yyyy-MM-dd KK:mm:ss').format(DateTime.now());
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "تسجيل بلاغ",
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Visibility(
              visible: Provider.of<InternetConnectionStatus>(context) ==
                  InternetConnectionStatus.disconnected,
              child: const InternetNotAvailable(),
            ),
            Container(
              color: Colors.black26,
              padding: EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${Number_Re}",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: Text(
                                      ":",
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "رقم البلاغ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${NumberCouter.toString()}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      ":",
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "رقم العداد",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${Name_}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      ":",
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "إسم العميل",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${libriry}",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      ":",
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "المكتب",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${time}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      ":",
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "زمن البلاغ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                " ...في أنتظار التسجيل",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                //textDirection: TextDirection.rtl,
                                textAlign: TextAlign.right,
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      ":",
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "حالة البلاغ",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.fromSize(
                    size: Size.square(10),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      onChanged: (x) {
                        _phonenumber = x;
                      },
                      controller: _phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Icon(
                            Icons.phone,
                            color: Colors.orangeAccent,
                            size: 35,
                          ),
                        ),
                        hintText: "أدخل رقم الهاتف",
                        contentPadding: EdgeInsets.only(
                          right: 15,
                          left: 15,
                          top: 15,
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size.square(10),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //DropdownButtonHideUnderline(
                        DropdownButtonFormField<String>(
                          icon: SizedBox.shrink(),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.orangeAccent,
                                  size: 35,
                                )),
                            // contentPadding: EdgeInsets.zero,//only(top: 18,bottom: 58,right: 10,left: 20,),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.orangeAccent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.orangeAccent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            filled: true,
                            // fillColor: Colors.pink,
                          ),
                          hint: Container(
                            child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "نوع البلاغ",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )),
                          ),
                          //value: _vul,
                          isExpanded: true,
                          //elevation: 16,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              _vul = newValue!;
                              if(newValue=='خطوره'){
                                showD=true;
                                showP=false;
                                showPriv=false;
                              };
                              if(newValue=='عام'){
                                showD=false;
                                showP=true;
                                showPriv=false;
                              };
                              if(newValue=='خاص'){
                                showD=false;
                                showP=false;
                                showPriv=true;
                              };
                            });
                          },
                          items: _location
                              .map<DropdownMenuItem<String>>((String newValue) {
                            return DropdownMenuItem(
                              // alignment: Alignment.centerRight,
                              value: newValue,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  newValue,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox.fromSize(
                    size: Size.square(10),
                  ),
                  Visibility(visible: showD,child:  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //DropdownButtonHideUnderline(
                        DropdownButtonFormField<String>(
                          icon: SizedBox.shrink(),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.orangeAccent,
                                  size: 35,
                                )),
                            // contentPadding: EdgeInsets.zero,//only(top: 18,bottom: 58,right: 10,left: 20,),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.orangeAccent),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.orangeAccent),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                            ),
                            filled: true,
                            // fillColor: Colors.pink,
                          ),
                          hint: Container(
                            child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "وصف البلاغ",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )),
                          ),
                          //value: _vul,
                          isExpanded: true,
                          //elevation: 16,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              _vulType = newValue!;
                            });
                          },
                          items: _D
                              .map<DropdownMenuItem<String>>((String newValue) {
                            return DropdownMenuItem(
                              // alignment: Alignment.centerRight,
                              value: newValue,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  newValue,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  )),
                  Visibility(visible: showP,child:  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //DropdownButtonHideUnderline(
                        DropdownButtonFormField<String>(
                          icon: SizedBox.shrink(),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.orangeAccent,
                                  size: 35,
                                )),
                            // contentPadding: EdgeInsets.zero,//only(top: 18,bottom: 58,right: 10,left: 20,),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.orangeAccent),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.orangeAccent),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                            ),
                            filled: true,
                            // fillColor: Colors.pink,
                          ),
                          hint: Container(
                            child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "وصف البلاغ",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )),
                          ),
                          //value: _vul,
                          isExpanded: true,
                          //elevation: 16,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              _vulType = newValue!;
                            });
                          },
                          items:_public
                              .map<DropdownMenuItem<String>>((String newValue) {
                            return DropdownMenuItem(
                              // alignment: Alignment.centerRight,
                              value: newValue,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  newValue,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  )),
                  Visibility(visible: showPriv,child:  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //DropdownButtonHideUnderline(
                        DropdownButtonFormField<String>(
                          icon: SizedBox.shrink(),
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.orangeAccent,
                                  size: 35,
                                )),
                            // contentPadding: EdgeInsets.zero,//only(top: 18,bottom: 58,right: 10,left: 20,),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.orangeAccent),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  style: BorderStyle.solid,
                                  color: Colors.orangeAccent),
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                            ),
                            filled: true,
                            // fillColor: Colors.pink,
                          ),
                          hint: Container(
                            child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "وصف البلاغ",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )),
                          ),
                          //value: _vul,
                          isExpanded: true,
                          //elevation: 16,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              _vulType = newValue!;
                            });
                          },
                          items: _prive
                              .map<DropdownMenuItem<String>>((String newValue) {
                            return DropdownMenuItem(
                              // alignment: Alignment.centerRight,
                              value: newValue,
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  newValue,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  )),
                  SizedBox.fromSize(
                    size: Size.square(10),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.right,
                      controller: _gbsRe,
                      onChanged: (x) {
                        _loction = x;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.orangeAccent,
                            size: 35,
                          ),
                        ),
                        hintText: "موقع منطقة سكنك - معلم بارز",
                        contentPadding: EdgeInsets.only(
                          right: 15,
                          left: 15,
                          top: 15,
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          _showdialogEnd('هل انت متأكد من إلغاء إجراء البلاغ'),
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "إلـغـاء",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          primary: Colors.orangeAccent,
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size.square(20),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          setState(() {
                            if (_phonenumber != '') {
                              if (_vulType != '') {
                                if (_loction != '') {
                                  Add_Notice();
                                  add();
                                } else {
                                  _showdialog('الرجاء تحديد الموقع');
                                }
                              } else {
                                _showdialog('الرجاء توضيح البلاغ');
                              }
                            } else {
                              Get.snackbar(
                                'Error Report',
                                'The Number Phone is Empyte ...',
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
                            }
                          }),
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "تـسجيل",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          primary: Colors.orangeAccent,
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
