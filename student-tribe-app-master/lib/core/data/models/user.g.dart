// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      cognitoId: json['cognitoId'] as String?,
      number: json['number'] as String?,
      gender: json['gender'] as String?,
      profileImg: json['profileImg'] as String,
      aboutMe: json['aboutMe'] as String?,
      location: json['location'] as String?,
      dateOfBirth: dateTimeFromString(json['dateOfBirth'] as String?),
      studentIdImg: json['studentIdImg'] as String?,
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => SkillModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      education: (json['education'] as List<dynamic>?)
              ?.map((e) => EducationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      experience: (json['experience'] as List<dynamic>?)
              ?.map((e) => ExperienceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      profileCompletionPercentage: json['profileCompletionPercentage'] as num?,
      referralLink: json['referralLink'] as String?,
      stCoins: json['stCoins'] as num?,
      profileCompleted: json['profileCompleted'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'cognitoId': instance.cognitoId,
      'number': instance.number,
      'gender': instance.gender,
      'profileImg': instance.profileImg,
      'aboutMe': instance.aboutMe,
      'location': instance.location,
      'studentIdImg': instance.studentIdImg,
      'profileCompletionPercentage': instance.profileCompletionPercentage,
      'referralLink': instance.referralLink,
      'stCoins': instance.stCoins,
      'profileCompleted': instance.profileCompleted,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'skills': instance.skills.map((e) => e.toJson()).toList(),
      'education': instance.education.map((e) => e.toJson()).toList(),
      'experience': instance.experience.map((e) => e.toJson()).toList(),
    };
