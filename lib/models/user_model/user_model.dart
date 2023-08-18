import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;
  String? username;
  String? phone;
  String? email;
  String? password;
  String? type;
  String? childEmail;
  String? parentEmail;
  String? secondParent;
  String? alternativeguardian;

  UserModel(
      {required this.id,
      required this.username,
      required this.phone,
      required this.email,
      required this.password,
      required this.type,
      this.childEmail,
      this.parentEmail,
      this.secondParent,
      this.alternativeguardian});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
