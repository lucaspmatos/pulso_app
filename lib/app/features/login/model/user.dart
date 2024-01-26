class User {
  int? id;
  String? name;
  int? age;
  String? username;

  User({this.id, this.name, this.age, this.username});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['age'] = age;
    data['username'] = username;
    return data;
  }
}

class UserSession {
  User? user;
  String currentRoute = '';
  static UserSession? _instance;

  static UserSession get instance {
    _instance ??= UserSession();
    return _instance!;
  }
}
