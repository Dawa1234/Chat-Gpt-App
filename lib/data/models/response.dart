import 'package:chatgpt/data/models/choices.dart';
import 'package:chatgpt/data/models/usage.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class ResponseModel {
  String? id;
  String? object;
  int? created;
  String? model;
  Usage? usage;
  List<ChoicesModel>? choices;

  ResponseModel(
      {this.id,
      this.object,
      this.created,
      this.model,
      this.usage,
      this.choices});

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
