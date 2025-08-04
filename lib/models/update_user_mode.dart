// To parse this JSON data, do
//
//     final updateusermodel = updateusermodelFromJson(jsonString);

import 'dart:convert';

Updateusermodel updateusermodelFromJson(String str) => Updateusermodel.fromJson(json.decode(str));

String updateusermodelToJson(Updateusermodel data) => json.encode(data.toJson());

class Updateusermodel {
    String message;

    Updateusermodel({
        required this.message,
    });

    factory Updateusermodel.fromJson(Map<String, dynamic> json) => Updateusermodel(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
