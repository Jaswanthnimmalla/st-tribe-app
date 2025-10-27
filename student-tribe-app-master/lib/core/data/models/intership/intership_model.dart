import 'package:architecture/core/data/models/intership/question_model.dart';
import 'package:architecture/core/data/models/skill.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intership_model.g.dart';

@JsonSerializable()
class InternshipModel {
  Duration? duration;
  Compensation? compensation;
  @JsonKey(name: "_id")
  String? id;
  String? title;
  String? type;
  String? description;
  String? location;
  String? companyName;
  String? companyLogo;
  String? companyDescription;
  int? numberOfOpenings;
  List<SkillModel>? skills;
  String? expectedStartDate;
  String? expiryDate;
  String? status;
  List<QuestionModel>? questions;
  String? createdAt;
  String? updatedAt;

  InternshipModel({
    this.duration,
    this.compensation,
    this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.location,
    required this.numberOfOpenings,
    this.skills,
    required this.expectedStartDate,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.questions,
    this.companyName,
    this.companyLogo,
    this.expiryDate
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) =>
      _$InternshipModelFromJson(json);
  Map<String, dynamic> toJson() => _$InternshipModelToJson(this);
}

@JsonSerializable()
class Duration {
  int? months;
  int? years;

  Duration({this.months, this.years});

  factory Duration.fromJson(Map<String, dynamic> json) =>
      _$DurationFromJson(json);
  Map<String, dynamic> toJson() => _$DurationToJson(this);
}

@JsonSerializable()
class Compensation {
  String method;
  int? amount;
  num? minimum;
  num? maximum;

  Compensation({required this.method, this.amount, this.minimum, this.maximum});

  factory Compensation.fromJson(Map<String, dynamic> json) =>
      _$CompensationFromJson(json);
  Map<String, dynamic> toJson() => _$CompensationToJson(this);
}


// "compensation": {
//                     "method": "range",
//                     "minimum": 20000,
//                     "maximum": 30000,
//                     "amount": 10000
//                 },