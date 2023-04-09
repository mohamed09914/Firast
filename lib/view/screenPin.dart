import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:report/view/MainActivity.dart';
import 'package:report/view_model/DB_healper.dart';
import '../model/login.dart';
var data = new DatabaseHelper1();
final List<Login> log =<Login>[];
TextEditingController text=TextEditingController();
TextEditingController text1=TextEditingController();
late bool _New = false;
late bool _show = false;
late String Num1 ;
late String _Error='...';
final val1 = data.getAllLogin();
class Log extends StatefulWidget {
  const Log({Key? key}) : super(key: key);
  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  @override
  void initState() {
lob();
      super.initState();
  }
  lob(){
  var a = data.getCountLogin();
  a.then((value) {
    if(value?.toInt()==0){
      setState((){_New=true;});
    }else{
      setState((){_show=true;});
    }

  });
}
  Future add(password) async {
      Login login = Login(1,password.toString());
      int ad = await data.saveLogin(login);
      print('ok add user to local data:$ad');
  }

  Future get_data() async{
    log.clear();
    final val = await data.getAllLogin();
    val.forEach((element){
      log.add(Login.map(element));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: _New,
              child: Column(
                children: [
                  Text('مرحبا بك في تطبيق بلاغاتي لرفع ومتابعة البلاغات الخاصة بالشركة السودانية لتوزيع الكهرباء',
                  textAlign: TextAlign.center,
                    style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),),
                  SizedBox(height: 5,),
                  Text('الرجاء إدخال رمز التأمين المكون من أربعة أرقام',
                  textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5,),
                  PinCodeTextField(
                      autofocus: true,
                      controller: text1,
                      maxLength: 4,
                      highlight: true,
                      hasUnderline: false,
                      hideCharacter:true,
                      pinBoxColor: Colors.black12,
                      highlightPinBoxColor: Colors.white,
                      onDone: (value){
                        setState((){
                          _show=true;
                          Num1 = value;
                          _Error = '...';
                        });
                      },
                      highlightColor: Colors.black12,
                      defaultBorderColor: Colors.orangeAccent,
                      hasTextBorderColor: Colors.black12,
                    ),
                  Visibility(visible: _show,child: Text('اعد ادخال رمز التأمين',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),)
                ],
              ),
            ),
            Visibility(visible: _show,
              child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: PinCodeTextField(
                autofocus: true,
                controller: text,
                maxLength: 4,
                highlight: true,
                hasUnderline: false,
                hideCharacter:true,
                pinBoxColor: Colors.black12,
                highlightPinBoxColor: Colors.white,
                onDone: (value) async {
                  if(_New==true){
                    if(value == Num1){
                      setState((){
                        add(value);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => mainactivity(),
                          ),
                              (route) => false,
                        );
                      });
                    }else{
                      text1.clear();
                      text.clear();
                      setState(() {
                        _Error='خطاء في رقم التأمين';
                        _show = false;
                      });
                    }
                  }else{
                    var t = data.getLogin(value);
                    t.then((e){
                      if(value == e?.password){
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => mainactivity(),
                          ),
                              (route) => false,
                        );
                      }else{
                        setState(() {
                          _Error = 'خطاء في رقم التأمين الخاص بك';
                        });
                      }
                    });
                  }
                },
                highlightColor: Colors.black12,
                defaultBorderColor: Colors.orangeAccent,
                hasTextBorderColor: Colors.black12,
              ),
            ),),
            Text(_Error),
            /*Expanded(
              child: FutureBuilder(
                  future: get_data(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: log.length,
                        itemBuilder: (context, position) {
                          return Card(
                            shadowColor: Colors.black38,
                            color: Colors.white54,
                            elevation: 1.0,
                            child: ListTile(
                              onTap: (){

                              },
                              title: SizedBox(width: double.infinity,child: new Text('${log[position].password}',textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              )),
                              subtitle: Text('${log[position].id}'),
                            ),
                          );
                        });
                  }),
            ),*/
          ],
        ),

      ),
    );
  }
}

