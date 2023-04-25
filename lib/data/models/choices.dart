import 'package:chatgpt/data/models/message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'choices.g.dart';

@JsonSerializable()
class ChoicesModel {
  MessageModel? message;
  String? finish_reason;
  int? index;

  ChoicesModel({this.message, this.finish_reason, this.index});

  factory ChoicesModel.fromJson(Map<String, dynamic> json) =>
      _$ChoicesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChoicesModelToJson(this);
}
