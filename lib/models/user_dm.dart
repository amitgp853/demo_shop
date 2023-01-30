import 'address_dm.dart';
import 'name_dm.dart';

class UserDm {
  UserDm({
    this.address,
    this.id,
    this.email,
    this.username,
    this.password,
    this.name,
    this.phone,
    this.v,
  });

  UserDm.fromJson(dynamic json) {
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    id = json['id'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    phone = json['phone'];
    v = json['__v'];
  }
  Address? address;
  int? id;
  String? email;
  String? username;
  String? password;
  Name? name;
  String? phone;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (address != null) {
      map['address'] = address!.toJson();
    }
    map['id'] = id;
    map['email'] = email;
    map['username'] = username;
    map['password'] = password;
    if (name != null) {
      map['name'] = name!.toJson();
    }
    map['phone'] = phone;
    map['__v'] = v;
    return map;
  }
}
