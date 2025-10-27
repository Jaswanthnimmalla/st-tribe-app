import 'package:architecture/core/utils/common_methods.dart';
import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable(explicitToJson: true)
class ExperienceModel {
  @JsonKey(name: "_id")
  String id;
  String role;
  String employmentType;
  String location;
  String? orgName;

  @JsonKey(fromJson: mandatoryDateTimeFromString)
  DateTime startDate;

  @JsonKey(fromJson: dateTimeFromString)
  DateTime? endDate;

  ExperienceModel(
      {required this.id,
      required this.role,
      required this.employmentType,
      required this.location,
      required this.startDate,
      this.endDate,
      this.orgName});

  Map<String, dynamic> toJson() => _$ExperienceModelToJson(this);

  factory ExperienceModel.fromJson(Map<String, dynamic> json) =>
      _$ExperienceModelFromJson(json);
}
