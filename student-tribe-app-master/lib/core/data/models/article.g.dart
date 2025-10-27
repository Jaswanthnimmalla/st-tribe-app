// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      id: json['_id'] as String,
      title: parsedHtmlString(json['title'] as String),
      thumbnailImg: json['thumbnailImg'] as String,
      content: json['content'] as String,
      tag: json['tag'] as String?,
      likes: (json['likes'] as List<dynamic>).map((e) => e as String).toList(),
      author: UserModel.fromJson(json['author'] as Map<String, dynamic>),
      richContent: (json['richContent'] as List<dynamic>)
          .map((e) => RichTextModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      readTime: json['readTime'] as int?,
      viewsCount: json['viewsCount'] as int,
      commentsCount: json['commentsCount'] as int,
      createdAt: mandatoryDateTimeFromString(json['createdAt'] as String),
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'thumbnailImg': instance.thumbnailImg,
      'content': instance.content,
      'tag': instance.tag,
      'likes': instance.likes,
      'richContent': instance.richContent.map((e) => e.toJson()).toList(),
      'readTime': instance.readTime,
      'viewsCount': instance.viewsCount,
      'commentsCount': instance.commentsCount,
      'author': instance.author.toJson(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

RichTextModel _$RichTextModelFromJson(Map<String, dynamic> json) =>
    RichTextModel(
      type: json['type'] as String,
      data: json['data'] as String,
    );

Map<String, dynamic> _$RichTextModelToJson(RichTextModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };
