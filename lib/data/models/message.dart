import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class MessageModel {
  String? role;
  String? content;

  MessageModel({this.role, this.content});

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
