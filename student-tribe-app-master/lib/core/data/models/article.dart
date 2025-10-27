import 'package:architecture/core/data/models/user.dart';
import 'package:architecture/core/utils/common_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class ArticleModel {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(fromJson: parsedHtmlString)
  final String title;
  final String thumbnailImg;
  final String content;
  final String? tag;
  final List<String> likes;
  final List<RichTextModel> richContent;
  final int? readTime;
  final int viewsCount;
  final int commentsCount;
  final UserModel author;

  @JsonKey(fromJson: mandatoryDateTimeFromString)
  final DateTime createdAt;

  const ArticleModel(
      {required this.id,
      required this.title,
      required this.thumbnailImg,
      required this.content,
      this.tag,
      required this.likes,
      required this.author,
      required this.richContent,
      this.readTime,
      required this.viewsCount,
      required this.commentsCount,
      required this.createdAt});

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}

@JsonSerializable(explicitToJson: true)
@immutable
class RichTextModel {
  final String type;
  final String data;

  const RichTextModel({required this.type, required this.data});

  Map<String, dynamic> toJson() => _$RichTextModelToJson(this);

  factory RichTextModel.fromJson(Map<String, dynamic> json) =>
      _$RichTextModelFromJson(json);
}
