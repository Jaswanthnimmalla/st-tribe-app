// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['_id'] as String,
      content: json['content'] as String,
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      createdAt: mandatoryDateTimeFromString(json['createdAt'] as String),
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'likes': instance.likes,
      'author': instance.author.toJson(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
