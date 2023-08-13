// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);



import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String? name;
  double? description;
  String? id;

  ProductModel({
    this.name,
    this.id,
    this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    name: json["name"],
    description: json["description"]?.toDouble(),
    id: json["id"],
  );

  factory ProductModel.fromFirebaseSnapshot(DocumentSnapshot doc){
    final data = doc.data()! as Map<String, dynamic>;
    data["id"] = doc.id;
    return ProductModel.fromJson(data);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };
}