import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import '../model/TestConnetion.dart';
import '../model/user.dart';
import '../view_model/Database_healper.dart';
import 'Report.dart';

TextEditingController _idr = new TextEditingController();
late String _id = '';
final counterNUM = FirebaseFirestore.instance.collection('notice');
late bool Rs = false;
late bool submit = false;
var db = new DatabaseHelper();
final List<User> _notice = <User>[];

class replay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return reblays();
  }
}

class reblays extends State<replay> {
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
          .where('ID', isEqualTo: x)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          Rs = true;
          // search_ID(element.reference.id);
        });
      });
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  Future search_ID(x) async {
    try {
      final DocumentSnapshot Doc = await counterNUM.doc(x).get().then((value) {
        setState(() {});
        return value;
      });
    } catch (e) {
      print(e);
    }
  }

  Future getdata() async {
    _notice.clear();
    final notice = await db.getAllUsers();
    notice.forEach((element) {
      _notice.add(User.map(element));
    });
  }

  _handleDelete(int id, int index) async {
    await db.deleteUser(id);
    setState(() {
      _notice.removeAt(index);
    });
  }
  @override
  initState() {
   // getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "متابعة حالة البلاغ",
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
          SizedBox.fromSize(
            size: Size.square(15),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.orangeAccent,
                  style: BorderStyle.solid,
                  width: 1.5),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(18),
            padding: EdgeInsets.only(
              bottom: 5,
              right: 10,
              left: 10,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    controller: _idr,
                    onChanged: (x) {
                      _id = x;
                      setState(() {
                        submit = false;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "أدخل رقم المتابعة",
                      prefixIcon: Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.orangeAccent,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    onSubmitted: (val) {
                      setState(() {
                        searchVul(_id);
                        submit = true;
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    onPressed: submit
                        ? () => {
                              setState(() {
                                if (_id != '') {
                                  if (Rs == true) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Report(Counter: '${_id}'),
                                      ),
                                    );
                                    submit = false;
                                    _idr.clear();
                                    Rs=false;
                                  } else {
                                    //9643352
                                    Get.snackbar(
                                      'Error Report',
                                      'Error in the number ...',
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
                                } else {
                                  Get.snackbar(
                                    'Error Report',
                                    'Text Field Is Empyt... Pless Enter The Number',
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

                            }
                        : null,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "بـحـث",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      alignment: Alignment.centerRight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: getdata(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: _notice.length,
                      itemBuilder: (context, position) {
                        return Card(
                          shadowColor: Colors.black38,
                          color: Colors.white54,
                          elevation: 1.0,
                          child: ListTile(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Report(Counter: '${_notice[position].id}'),
                                ),
                              );
                            },
                            title: SizedBox(width: double.infinity,child: new Text(_notice[position].username,textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            )),
                            subtitle: Row(
                              children: [
                                Expanded(child: Column(
                                  children: [
                                    SizedBox(width: double.infinity, child: Text(_notice[position].counter,textAlign: TextAlign.left,)),
                                    SizedBox(width: double.infinity, child: Text(_notice[position].Time,textAlign: TextAlign.left,)),
                                  ],
                                )),
                                Expanded(child: Column(
                                  children: [
                                    SizedBox(width: double.infinity, child: Text(_notice[position].Office,textAlign: TextAlign.right,)),
                                    SizedBox(width: double.infinity, child: Text('${_notice[position].id}',textAlign: TextAlign.right,)),
                                  ],
                                )),
                              ],
                            ),
                            trailing: new Listener(
                              key: Key(_notice[position].username),
                                child: Icon(
                                  Icons.highlight_remove,
                                  color: Colors.redAccent,
                                  size: 35,
                                ),
                              onPointerDown: (pointerEvent) =>
                                  _handleDelete(_notice[position].id, position),
                            ),

                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}