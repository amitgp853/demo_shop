class Geolocation {
  Geolocation({
    this.lat,
    this.long,
  });

  Geolocation.fromJson(dynamic json) {
    lat = json['lat'];
    long = json['long'];
  }
  String? lat;
  String? long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['long'] = long;
    return map;
  }
}
