class Login {
  late String _password;
  late int _id;
  Login(this._id,this._password);
  Login.map(dynamic obj) {
    this._password = obj['password'];
    this._id = obj['id'];
  }
  //getters
  String get password => _password;
  int get id => _id;
  //Map Connstructors
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["password"] = _password;
    map["id"] = _id;
    return map;
  }

  Login.fromMap(Map<String, dynamic> map){
    this._password = map["password"];
    this._id = map["id"];
  }
}