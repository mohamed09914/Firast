import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../model/TestConnetion.dart';
import 'ReData.dart';
import 'ReplayRe.dart';
import 'Report.dart';

TextEditingController _ide = new TextEditingController();

class uploadre extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return uploadClass();
  }
}

class uploadClass extends State<uploadre> {
  late bool submit = false;
  late bool fne = false;
  late bool NIGet = false;
  late bool NITGet = false;
  late String _name = "--";
  late String _number = "--";
  late String _librery = "--";
  late String IDcounter = '';
  late String _Error = '...';
  final counterNUM = FirebaseFirestore.instance.collection('counters');
  final counterNUMh = FirebaseFirestore.instance.collection('notice');
  late String CounDoc = '';
  late String Type_State = '';
  late String Notice_ID = '';

  void _showdialog(x) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('Notice'),
            content: Text(
              "${x + '${Notice_ID}'}",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () => {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => replay(),
                          ),
                          (route) => route.isFirst,
                        ),
                      },
                  child: Text(
                    'متابعة حالة البلاغ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  )),
            ],
          );
        });
  }

  vul_data() {
    _name = "--";
    _number = "--";
    _librery = "--";
    IDcounter = '';
    _Error = '...';
    CounDoc = '';
    Type_State = '';
  }

  Future searchVul(x) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            ));
          });
      await FirebaseFirestore.instance
          .collection("counters")
          .where('num_counter', isEqualTo: x)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          CounDoc = element.reference.id;
          searchVulnotice(x);
          fne = true;
        });
      });
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  Future search_ID(x) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            ));
          });
      final DocumentSnapshot Doc = await counterNUM.doc(x).get().then((value) {
        _librery = value.data()!['bureau_cu'];
        _name = value.data()!['name_cu'];
        _number = value.data()!['num_counter'];
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                re_data(Name_: _name, libriry: _librery, NumberCouter: _number),
          ),
        );
        return value;
      });
    } catch (e) {
      print(e);
    }
  }
  d1v(x) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ));
        });
    await FirebaseFirestore.instance
        .collection("notice")
        .where('ID_counter', isEqualTo: x)
        .where('State', isEqualTo: 'تم رفع البلاغ',)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        NIGet = true;
        NITGet = true;
        search_IDnotice(element.reference.id);
      });
    });
    Navigator.of(context).pop();
  }
  d2v(x) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ));
        });
    await FirebaseFirestore.instance
        .collection("notice")
        .where('ID_counter', isEqualTo: x)
        .where('State', isEqualTo: 'قيد التنفيذ',)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        NIGet = true;
        NITGet = true;
        search_IDnotice(element.reference.id);
      });
    });
    Navigator.of(context).pop();
  }

  Future searchVulnotice(x) async {
    try {
      d1v(x);
      d2v(x);
    } catch (e) {
      print(e);
    }
  }

  Future search_IDnotice(x) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            ));
          });
      final DocumentSnapshot Doc = await counterNUMh.doc(x).get().then((value) {
        Type_State = value.data()!['State'];
        Notice_ID = value.data()!['ID'];
          print('tttttttttttttttttttttttttttttttttttttttt${Type_State}');
        return value;
      });
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fne = false;
    NIGet = false;
    NITGet = false;
    vul_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "تسجيل بلاغ",
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: <Widget>[
          Visibility(
            visible: Provider.of<InternetConnectionStatus>(context) ==
                InternetConnectionStatus.disconnected,
            child: const InternetNotAvailable(),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.orangeAccent,
                    style: BorderStyle.solid,
                    width: 1.5),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    maxLength: 11,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    controller: _ide,
                    onChanged: (x) {
                      IDcounter = x;
                      if(IDcounter.length == 11){
                        setState(() {
                          searchVul(IDcounter);
                          submit = true;
                        });
                      }else{
                        setState(() {
                          submit = false;
                        });
                      }
                    },
                    onSubmitted: (value) {
                    },
                    decoration: InputDecoration(
                      hintText: "أدخل رقم العداد",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: submit
                            ? () => {
                                  if (IDcounter != '')
                                    {
                                      IDcounter = '',
                                      _ide.clear(),
                                      if (fne == true)
                                        {
                                          if (NIGet == true)
                                            {
                                              if (NITGet == false)
                                                {
                                                  search_ID(CounDoc),
                                                  setState(() {
                                                    submit = false;
                                                    fne = false;
                                                    NIGet = false;
                                                  }),
                                                }
                                              else
                                                {
                                                  setState(() {
                                                    submit = false;
                                                    fne = false;
                                                    NIGet = false;
                                                    NITGet = false;
                                                  }),
                                                  _showdialog(
                                                      'You have to notice is active...'),
                                                },
                                              NIGet = false,
                                            }
                                          else
                                            {
                                              search_ID(CounDoc),
                                              setState(() {
                                                submit = false;
                                                fne = false;
                                                NIGet = false;
                                                NITGet = false;
                                              }),
                                            },
                                          fne = false,
                                        }
                                      else
                                        {
                                          setState(() {
                                            submit = false;
                                            fne = false;
                                            NIGet = false;
                                            NITGet = false;
                                          }),
                                          Get.snackbar(
                                            'Error Report',
                                            'Error in the number counter',
                                            colorText: Colors.white,
                                            backgroundColor: Colors.black54,
                                            snackPosition: SnackPosition.TOP,
                                            padding: EdgeInsets.only(
                                              bottom: 30,
                                              left: 10,
                                              right: 10,
                                              top: 20,
                                            ),
                                          ),
                                        }
                                    }
                                  else
                                    {
                                      setState(() {
                                        fne = false;
                                        NIGet = false;
                                        NITGet = false;
                                        submit = false;
                                        IDcounter = '';
                                        _ide.clear();
                                      }),
                                      Get.snackbar(
                                        'Error Report',
                                        'Text Field Is Empyt... Pless Enter Counter Number',
                                        colorText: Colors.white,
                                        backgroundColor: Colors.black54,
                                        snackPosition: SnackPosition.TOP,
                                        padding: EdgeInsets.only(
                                          bottom: 30,
                                          left: 10,
                                          right: 10,
                                          top: 20,
                                        ),
                                      ),
                                    }
                                }
                            : null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "إرســال",
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
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${_Error}',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
