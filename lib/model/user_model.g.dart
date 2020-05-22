// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(json['name'] as String, json['avatar'] as String,
      json['email'] as String,json['position'] as String,json['userId'] as String,json['token'] as String,json['normandyUserId'] as String);
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'email': instance.email,
      'position': instance.position,
      'userId': instance.userId,
      'token': instance.token,
      'normandyUserId': instance.normandyUserId
    };
