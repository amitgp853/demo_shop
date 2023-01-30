class Name {
  Name({
    this.firstname,
    this.lastname,
  });

  Name.fromJson(dynamic json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
  }
  String? firstname;
  String? lastname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    return map;
  }
}
