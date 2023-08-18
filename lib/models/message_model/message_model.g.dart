// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      senderId: json['senderId'] as String?,
      recieverId: json['recieverId'] as String?,
      message: json['message'] as String?,
      datatime: json['datatime'] as String?,
      typeOfMessage: json['typeOfMessage'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'recieverId': instance.recieverId,
      'message': instance.message,
      'datatime': instance.datatime,
      'typeOfMessage': instance.typeOfMessage,
    };
