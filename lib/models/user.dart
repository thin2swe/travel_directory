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

  static User empty =
      User(id: 0, userName: "", password: "", email: "", phone: "");

  User.map(dynamic obj) {
    if (obj != null) {
      this.id = obj['id'];
      this.userName = obj['userName'];
      this.password = obj['password'];
      this.email = obj['email'];
      this.phone = obj['phone'];
    } else {
      User.empty;
    }
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
