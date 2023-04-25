import 'package:json_annotation/json_annotation.dart';
part 'usage.g.dart';

@JsonSerializable()
class Usage {
  int? prompt_tokens;
  int? completion_tokens;
  int? total_tokens;

  Usage({this.prompt_tokens, this.completion_tokens, this.total_tokens});

  factory Usage.fromJson(Map<String, dynamic> json) => _$UsageFromJson(json);

  Map<String, dynamic> toJson() => _$UsageToJson(this);
}
