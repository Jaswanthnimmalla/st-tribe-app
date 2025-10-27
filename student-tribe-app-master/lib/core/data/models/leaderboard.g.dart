// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderBoardModel _$LeaderBoardModelFromJson(Map<String, dynamic> json) =>
    LeaderBoardModel(
      stCoins: json['stCoins'] as int?,
      name: json['name'] as String?,
      profileImg: json['profileImg'] as String?,
      profileCompletionPercentage: json['profileCompletionPercentage'] as num?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$LeaderBoardModelToJson(LeaderBoardModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'stCoins': instance.stCoins,
      'name': instance.name,
      'profileImg': instance.profileImg,
      'profileCompletionPercentage': instance.profileCompletionPercentage,
    };
