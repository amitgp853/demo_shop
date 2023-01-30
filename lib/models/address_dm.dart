import 'geolocation_dm.dart';

class Address {
  Address({
    this.geolocation,
    this.city,
    this.street,
    this.number,
    this.zipcode,
  });

  Address.fromJson(dynamic json) {
    geolocation = json['geolocation'] != null
        ? Geolocation.fromJson(json['geolocation'])
        : null;
    city = json['city'];
    street = json['street'];
    number = json['number'];
    zipcode = json['zipcode'];
  }
  Geolocation? geolocation;
  String? city;
  String? street;
  int? number;
  String? zipcode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (geolocation != null) {
      map['geolocation'] = geolocation!.toJson();
    }
    map['city'] = city;
    map['street'] = street;
    map['number'] = number;
    map['zipcode'] = zipcode;
    return map;
  }
}
