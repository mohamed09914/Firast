class User {
  late String _username;
  late String _counter;
  late int _id;
  late String columnLoction;
  late String columnNotice;
  late String columnOffice;
  late String columnPhone;
  late String columnState;
  late String columnTime;
  late String columnType;

  User(this._id,this._username, this._counter, this.columnLoction,this.columnNotice,this.columnOffice,this.columnPhone,this.columnState,this.columnTime,this.columnType);

  User.map(dynamic obj) {
    this._username = obj['username'];
    this._counter = obj['counter'];
    this._id = obj['id'];
    this.columnLoction = obj['Loction'];
    this.columnNotice = obj['Notice'];
    this.columnOffice = obj['Office'];
    this.columnPhone = obj['Phone'];
    this.columnState = obj['State'];
    this.columnTime = obj['Time'];
    this.columnType = obj['Type'];
  }

  //getters
  String get username => _username;

  String get counter => _counter;

  int get id => _id;

  String get Loction => columnLoction;

  String get Notice => columnNotice;

  String get Office => columnOffice;

  String get Phone => columnPhone;

  String get State => columnState;

  String get Time => columnTime;

  String get Type => columnType;

  //Map Connstructors
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["counter"] = _counter;
    map["id"] = _id;
    map['Loction']=columnLoction;
    map['Notice']=columnNotice;
    map['Office']=columnOffice;
    map['Phone']=columnPhone;
    map['State']=columnState;
    map['Time']=columnTime;
    map['Type']=columnType;
    return map;
  }

  User.fromMap(Map<String, dynamic> map){
    this._username = map["username"];
    this._counter = map["counter"];
    this._id = map["id"];
    this.columnLoction = map['Loction'];
    this.columnNotice = map['Notice'];
    this.columnOffice = map['Office'];
    this.columnPhone = map['Phone'];
    this.columnState = map['State'];
    this.columnTime = map['Time'];
    this.columnType = map['Type'];
  }
}