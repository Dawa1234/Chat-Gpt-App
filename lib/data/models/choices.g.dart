// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choices.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoicesModel _$ChoicesModelFromJson(Map<String, dynamic> json) => ChoicesModel(
      message: json['message'] == null
          ? null
          : MessageModel.fromJson(json['message'] as Map<String, dynamic>),
      finish_reason: json['finish_reason'] as String?,
      index: json['index'] as int?,
    );

Map<String, dynamic> _$ChoicesModelToJson(ChoicesModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'finish_reason': instance.finish_reason,
      'index': instance.index,
    };
