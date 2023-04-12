import 'package:actual/common/utils/data_utils.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'restaurant_detail_model.g.dart';

// RestaurantDetailModel restaurantDetailModelFromJson(String str) =>
//     RestaurantDetailModel.fromJson(json.decode(str));
// String restaurantDetailModelToJson(RestaurantDetailModel data) =>
//     json.encode(data.toJson());

@JsonSerializable()
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
      _$RestaurantDetailModelFromJson(json);
}

@JsonSerializable()
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
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  String imgUrl;
  String detail;
  int price;

  factory RestaurantProduct.fromJson(Map<String, dynamic> json) =>
      _$RestaurantProductFromJson(json);
}
