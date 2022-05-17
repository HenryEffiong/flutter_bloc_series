class Person {
  String? name;
  int? age;

  Person({this.name, this.age});

  Person.fromJson(dynamic json) {
    name = json["name"];
    age = json["age"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["age"] = age;
    return map;
  }
}
