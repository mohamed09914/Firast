import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../model/State_Icon_erport2.dart';
import '../model/State_Icon_report1.dart';
import '../model/State_Icon_report3.dart';
import '../model/TestConnetion.dart';
import 'MainActivity.dart';

class Report extends StatefulWidget {
  final String Counter;

  Report({required this.Counter});

  @override
  State<StatefulWidget> createState() {
    return page_Test(Get_Counter: Counter);
  }
}

class page_Test extends State<Report> {
  final String Get_Counter;
  final counterNUM = FirebaseFirestore.instance.collection('notice');
  late String _name = '';
  late String _numbercounter = '';
  late String _librery = '';
  late String _phoneNumber = '';
  late String _typeNotice = '';
  late String _smeNotice = '';
  late String _location = '';
  late String _Time = '';
  late String _StateNotice = '';
  late String HashCode;
  CollectionReference notice = FirebaseFirestore.instance.collection("notice");

  page_Test({required this.Get_Counter});

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
                  child: Text('OK'))
            ],
          );
        });
  }

  void _showdialogok(x) {
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
                    setState(() {
                      _StateNotice='تم التنفيذ';
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text('REFRASH'))
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

  Future searchVul(x) async {
    try {
      await FirebaseFirestore.instance
          .collection("notice")
          .where('ID', isEqualTo: x)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          HashCode=element.reference.id;
          search_ID(element.reference.id);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future search_ID(x) async {
    try {
      final DocumentSnapshot Doc = await counterNUM.doc(x).get().then((value) {
        setState(() {
          _name = value.data()!['Name'];
          _numbercounter = value.data()!['ID_counter'];
          _librery = value.data()!['Office'];
          _phoneNumber = value.data()!['Phone'];
          _typeNotice = value.data()!['Type'];
          _smeNotice = value.data()!['Notice'];
          _location = value.data()!['Loction'];
          _Time = value.data()!['Time'];
          _StateNotice = value.data()!['State'];
        });
        return value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future Update_Notice(hash) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ));
        });
    await notice.doc(hash).update({
      'State': 'تم التنفيذ',
    }).then((value) => {
    });
    Navigator.of(context).pop();
    _showdialogok('تم إغلاق البلاغ بنجاح');
  }

  @override
  void initState() {
    searchVul(Get_Counter);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: Provider.of<InternetConnectionStatus>(context) ==
                      InternetConnectionStatus.disconnected,
                  child: const InternetNotAvailable(),
                ),
                Visibility(
                  visible: _StateNotice == 'تم رفع البلاغ',
                  child: const State_Icon1(),
                ),
                Visibility(
                  visible: _StateNotice == 'قيد التنفيذ',
                  child: const State_Icon2(),
                ),
                Visibility(
                  visible: _StateNotice == 'تم التنفيذ',
                  child: const State_Icon3(),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "${_StateNotice}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orangeAccent,
                        style: BorderStyle.solid,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 3, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${Get_Counter}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              ":",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            "رقم البلاغ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orangeAccent,
                        style: BorderStyle.solid,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 3, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${_numbercounter}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              ":",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            "رقم العداد",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orangeAccent,
                        style: BorderStyle.solid,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 3, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${_name}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              ":",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            "إسم العميل",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orangeAccent,
                        style: BorderStyle.solid,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 3, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${_librery}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              ":",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            "المكتب",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orangeAccent,
                        style: BorderStyle.solid,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 3, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${_phoneNumber}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              ":",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            "رقم الهاتف",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orangeAccent,
                        style: BorderStyle.solid,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 3, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${_typeNotice}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              ":",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            "نوع البلاغ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orangeAccent,
                        style: BorderStyle.solid,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 3, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${_smeNotice}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              ":",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            "وصف البلاغ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orangeAccent,
                        style: BorderStyle.solid,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 3, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${_location}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              ":",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            "الموقع",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orangeAccent,
                        style: BorderStyle.solid,
                        width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.only(top: 3, left: 15, right: 15),
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${_Time}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              ":",
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Text(
                            "زمن التبليغ",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  color: Colors.orangeAccent,
                  child: Row(
                    children: [
                      Expanded(child: TextButton(
                        onPressed:_StateNotice!='تم التنفيذ'? (){
                          setState(() {
                            Update_Notice(HashCode);
                          });
                          //_showdialog('تم إغلاق البلاغ بنجاح');
                        }:null,
                        child: Text('إغلاق البلاغ',style: TextStyle(color: Colors.white,fontSize: 18,),),
                      )),
                      Expanded(child: TextButton(
                        onPressed: (){
                          _showdialogEnd('إستخدم رقم المتابعة الخاص بك لمتابعة البلاغ فيما بعد'
                              '${Get_Counter}');
                        },
                        child: Text('تأكيد',style: TextStyle(color: Colors.white,fontSize: 18,),),
                      )),
                       ],
                  ),
                ),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
