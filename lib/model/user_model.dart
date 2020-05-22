import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String name;
  String avatar;
  String email;
  String position;
  String userId;
  String token;
  String normandyUserId;/// Normany的用户ID */

  UserModel(this.name,this.avatar,this.email,this.position,this.userId,this.token,this.normandyUserId);
  //不同的类使用不同的mixin即可，注意格式一定要写正确
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
