import 'package:actual/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.imageUrl,
  });

//
  String id;
  String username;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  String imageUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}