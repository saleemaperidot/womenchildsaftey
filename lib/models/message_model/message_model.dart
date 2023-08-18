import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  String? senderId;
  String? recieverId;
  String? message;
  String? datatime;
  String? typeOfMessage;

  MessageModel(
      {this.senderId,
      this.recieverId,
      this.message,
      this.datatime,
      this.typeOfMessage});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return _$MessageModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
