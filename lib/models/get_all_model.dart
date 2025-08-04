// To parse this JSON data, do
//
//     final getallmodel = getallmodelFromJson(jsonString);

import 'dart:convert';

Getallmodel getallmodelFromJson(String str) => Getallmodel.fromJson(json.decode(str));

String getallmodelToJson(Getallmodel data) => json.encode(data.toJson());

class Getallmodel {
    int count;
    List<Row> rows;

    Getallmodel({
        required this.count,
        required this.rows,
    });

    factory Getallmodel.fromJson(Map<String, dynamic> json) => Getallmodel(
        count: json["count"],
        rows: List<Row>.from(json["rows"].map((x) => Row.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
    };
}

class Row {
    int id;
    String username;
    int age;
    DateTime createdAt;
    DateTime updatedAt;

    Row({
        required this.id,
        required this.username,
        required this.age,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json["id"],
        username: json["username"],
        age: json["age"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "age": age,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
