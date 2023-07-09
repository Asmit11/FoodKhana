// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final String? username;
  final String? email;
  final String? address;
  final int? phone;
  final String? gender;
  final String? name;
  final String? description;

  ProductModel({
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.gender,
    required this.name,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      username: json["username"],
      email: json["email"],
      address: json["address"],
      phone: json["phone"],
      gender: json["gender"],
      name: json["name"],
      description: json["description"]
  );

  factory ProductModel.fromFirebaseSnapshot(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    data["id"]=doc.id;
    return ProductModel.fromJson(data);
  }

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "address": address,
    "phone": phone,
    "gender": gender,
    "name": name,
    "description": description
  };
}