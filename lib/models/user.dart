class User {
  int? id;
  String userName = "";
  String password = "";
  String? email;
  String? phone;

  User(
      {this.id,
      required this.userName,
      required this.password,
      this.email,
      this.phone});

  User.map(dynamic obj) {
    this.id = obj['id'];
    this.userName = obj['userName'];
    this.password = obj['password'];
    this.email = obj['email'];
    this.phone = obj['phone'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['userName'] = userName;
    map['password'] = password;
    map['email'] = email;
    map['phone'] = phone;
    return map;
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      userName: map['userName'],
      password: map['password'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}
