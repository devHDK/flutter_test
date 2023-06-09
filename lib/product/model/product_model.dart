import 'package:actual/common/model/model_with_id.dart';
import 'package:actual/common/utils/data_utils.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  ProductModel({
    required this.id,
    required this.restaurant,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  @override
  String id;
  RestaurantModel restaurant;
  String name;
  @JsonKey(fromJson: DataUtils.pathToUrl)
  String imgUrl;
  String detail;
  int price;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
