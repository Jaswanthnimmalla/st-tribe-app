// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceModel _$ExperienceModelFromJson(Map<String, dynamic> json) =>
    ExperienceModel(
      id: json['_id'] as String,
      role: json['role'] as String,
      employmentType: json['employmentType'] as String,
      location: json['location'] as String,
      startDate: mandatoryDateTimeFromString(json['startDate'] as String),
      endDate: dateTimeFromString(json['endDate'] as String?),
      orgName: json['orgName'] as String?,
    );

Map<String, dynamic> _$ExperienceModelToJson(ExperienceModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'role': instance.role,
      'employmentType': instance.employmentType,
      'location': instance.location,
      'orgName': instance.orgName,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
