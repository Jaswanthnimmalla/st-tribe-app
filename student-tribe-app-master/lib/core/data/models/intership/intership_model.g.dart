// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intership_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InternshipModel _$InternshipModelFromJson(Map<String, dynamic> json) =>
    InternshipModel(
      duration: json['duration'] == null
          ? null
          : Duration.fromJson(json['duration'] as Map<String, dynamic>),
      compensation: json['compensation'] == null
          ? null
          : Compensation.fromJson(json['compensation'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      title: json['title'] as String?,
      type: json['type'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      numberOfOpenings: json['numberOfOpenings'] as int?,
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      expectedStartDate: json['expectedStartDate'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      companyName: json['companyName'] as String?,
      companyLogo: json['companyLogo'] as String?,
      expiryDate: json['expiryDate'] as String?,
    )..companyDescription = json['companyDescription'] as String?;

Map<String, dynamic> _$InternshipModelToJson(InternshipModel instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'compensation': instance.compensation,
      '_id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'description': instance.description,
      'location': instance.location,
      'companyName': instance.companyName,
      'companyLogo': instance.companyLogo,
      'companyDescription': instance.companyDescription,
      'numberOfOpenings': instance.numberOfOpenings,
      'skills': instance.skills,
      'expectedStartDate': instance.expectedStartDate,
      'expiryDate': instance.expiryDate,
      'status': instance.status,
      'questions': instance.questions,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

Duration _$DurationFromJson(Map<String, dynamic> json) => Duration(
      months: json['months'] as int?,
      years: json['years'] as int?,
    );

Map<String, dynamic> _$DurationToJson(Duration instance) => <String, dynamic>{
      'months': instance.months,
      'years': instance.years,
    };

Compensation _$CompensationFromJson(Map<String, dynamic> json) => Compensation(
      method: json['method'] as String,
      amount: json['amount'] as int?,
      minimum: json['minimum'] as num?,
      maximum: json['maximum'] as num?,
    );

Map<String, dynamic> _$CompensationToJson(Compensation instance) =>
    <String, dynamic>{
      'method': instance.method,
      'amount': instance.amount,
      'minimum': instance.minimum,
      'maximum': instance.maximum,
    };
