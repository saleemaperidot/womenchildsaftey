// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      type: json['type'] as String?,
      childEmail: json['childEmail'] as String?,
      parentEmail: json['parentEmail'] as String?,
      secondParent: json['secondParent'] as String?,
      alternativeguardian: json['alternativeguardian'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'phone': instance.phone,
      'email': instance.email,
      'password': instance.password,
      'type': instance.type,
      'childEmail': instance.childEmail,
      'parentEmail': instance.parentEmail,
      'secondParent': instance.secondParent,
      'alternativeguardian': instance.alternativeguardian,
    };
