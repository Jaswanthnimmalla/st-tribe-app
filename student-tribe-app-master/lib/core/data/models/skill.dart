import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'skill.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class SkillModel {
  @JsonKey(name: "_id")
  final String id;
  final String name;

  const SkillModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$SkillModelToJson(this);

  factory SkillModel.fromJson(Map<String, dynamic> json) =>
      _$SkillModelFromJson(json);
}
