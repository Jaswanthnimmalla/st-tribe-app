import 'package:architecture/core/utils/common_methods.dart';
import 'package:json_annotation/json_annotation.dart';

part 'education.g.dart';

@JsonSerializable(explicitToJson: true)
class EducationModel {
  @JsonKey(name: "_id")
  String id;
  String instituteName;
  String degree;
  String course;

  @JsonKey(fromJson: mandatoryDateTimeFromString)
  DateTime startDate;

  @JsonKey(fromJson: dateTimeFromString)
  DateTime? endDate;

  double grade;

  EducationModel({
    required this.id,
    required this.instituteName,
    required this.degree,
    required this.course,
    required this.startDate,
    this.endDate,
    required this.grade,
  });

  Map<String, dynamic> toJson() => _$EducationModelToJson(this);

  factory EducationModel.fromJson(Map<String, dynamic> json) =>
      _$EducationModelFromJson(json);
}
