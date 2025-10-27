// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    ApplicationModel(
      id: json['_id'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      internship: json['internship'] == null
          ? null
          : InternshipModel.fromJson(
              json['internship'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ApplicationModelToJson(ApplicationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'internship': instance.internship,
      'status': instance.status,
    };
