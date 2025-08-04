// To parse this JSON data, do
//
//     final deleteusermodel = deleteusermodelFromJson(jsonString);

import 'dart:convert';

Deleteusermodel deleteusermodelFromJson(String str) => Deleteusermodel.fromJson(json.decode(str));

String deleteusermodelToJson(Deleteusermodel data) => json.encode(data.toJson());

class Deleteusermodel {
   final String message;

    Deleteusermodel({
        required this.message,
    });

    factory Deleteusermodel.fromJson(Map<String, dynamic> json) => Deleteusermodel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
