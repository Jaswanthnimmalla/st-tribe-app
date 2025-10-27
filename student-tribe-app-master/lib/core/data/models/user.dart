import 'package:architecture/core/data/models/education.dart';
import 'package:architecture/core/data/models/experience.dart';
import 'package:architecture/core/data/models/skill.dart';
import 'package:architecture/core/utils/common_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class UserModel {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final String email;
  final String? cognitoId;
  final String? number;
  final String? gender;
  final String profileImg;
  final String? aboutMe;
  final String? location;
  final String? studentIdImg;
  final num? profileCompletionPercentage;
  final String? referralLink;
  final num? stCoins;
  final bool? profileCompleted;

  @JsonKey(fromJson: dateTimeFromString)
  final DateTime? dateOfBirth;

  @JsonKey(defaultValue: [])
  final List<SkillModel> skills;
  @JsonKey(defaultValue: [])
  final List<EducationModel> education;
  @JsonKey(defaultValue: [])
  final List<ExperienceModel> experience;

  const UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.cognitoId,
      required this.number,
      required this.gender,
      required this.profileImg,
      required this.aboutMe,
      required this.location,
      this.dateOfBirth,
      this.studentIdImg,
      required this.skills,
      required this.education,
      required this.experience,
      this.profileCompletionPercentage,
      this.referralLink,
      this.stCoins,
      this.profileCompleted
      });

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
