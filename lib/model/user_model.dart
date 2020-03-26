import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String name;
  String avatar;
  String token;

  UserModel(this.name, this.avatar, this.token);
  //不同的类使用不同的mixin即可，注意格式一定要写正确
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}