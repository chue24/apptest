// To parse this JSON data, do
//
//     final postusermodel = postusermodelFromJson(jsonString);

import 'dart:convert';

Postusermodel postusermodelFromJson(String str) => Postusermodel.fromJson(json.decode(str));

String postusermodelToJson(Postusermodel data) => json.encode(data.toJson());

class Postusermodel {
    String message;

    Postusermodel({
        required this.message,
    });

    factory Postusermodel.fromJson(Map<String, dynamic> json) => Postusermodel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
