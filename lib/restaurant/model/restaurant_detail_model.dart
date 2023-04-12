import 'dart:convert';
import 'package:actual/restaurant/model/restaurant_model.dart';

RestaurantDetailModel restaurantDetailModelFromJson(String str) =>
    RestaurantDetailModel.fromJson(json.decode(str));
String restaurantDetailModelToJson(RestaurantDetailModel data) =>
    json.encode(data.toJson());

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProduct> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailModel(
        id: json["id"],
        name: json["name"],
        thumbUrl: '${json["thumbUrl"]}',
        tags: List<String>.from(json["tags"].map((x) => x)),
        priceRange: RestaurantPriceRange.values
            .firstWhere((e) => e.name == json['priceRange']),
        ratings: json["ratings"].toDouble(),
        ratingsCount: json["ratingsCount"],
        deliveryTime: json["deliveryTime"],
        deliveryFee: json["deliveryFee"],
        detail: json["detail"],
        products: List<RestaurantProduct>.from(
            json["products"].map((x) => RestaurantProduct.fromJson(x))),
      );

  @override
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
        "detail": detail,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class RestaurantProduct {
  RestaurantProduct({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  String id;
  String name;
  String imgUrl;
  String detail;
  int price;

  factory RestaurantProduct.fromJson(Map<String, dynamic> json) =>
      RestaurantProduct(
        id: json["id"],
        name: json["name"],
        imgUrl: json["imgUrl"],
        detail: json["detail"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imgUrl": imgUrl,
        "detail": detail,
        "price": price,
      };
}
