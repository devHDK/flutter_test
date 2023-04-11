// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

RestaurantModel restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) =>
    json.encode(data.toJson());

class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  String id;
  String name;
  String thumbUrl;
  List<String> tags;
  RestaurantPriceRange priceRange;
  double ratings;
  int ratingsCount;
  int deliveryTime;
  int deliveryFee;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"],
        name: json["name"],
        thumbUrl: json["thumbUrl"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        priceRange: RestaurantPriceRange.values
            .firstWhere((e) => e.name == json['priceRange']),
        ratings: json["ratings"]?.toDouble(),
        ratingsCount: json["ratingsCount"],
        deliveryTime: json["deliveryTime"],
        deliveryFee: json["deliveryFee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbUrl": thumbUrl,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "priceRange": priceRange,
        "ratings": ratings,
        "ratingsCount": ratingsCount,
        "deliveryTime": deliveryTime,
        "deliveryFee": deliveryFee,
      };
}
