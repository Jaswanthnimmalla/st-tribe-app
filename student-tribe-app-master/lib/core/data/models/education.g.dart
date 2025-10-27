// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationModel _$EducationModelFromJson(Map<String, dynamic> json) =>
    EducationModel(
      id: json['_id'] as String,
      instituteName: json['instituteName'] as String,
      degree: json['degree'] as String,
      course: json['course'] as String,
      startDate: mandatoryDateTimeFromString(json['startDate'] as String),
      endDate: dateTimeFromString(json['endDate'] as String?),
      grade: (json['grade'] as num).toDouble(),
    );

Map<String, dynamic> _$EducationModelToJson(EducationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'instituteName': instance.instituteName,
      'degree': instance.degree,
      'course': instance.course,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'grade': instance.grade,
    };
