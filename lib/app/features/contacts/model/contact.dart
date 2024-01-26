class Contact {
  int? id;
  int? userId;
  String? name;
  String? phone;

  Contact({
    this.id,
    this.userId,
    this.name,
    this.phone,
  });

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
