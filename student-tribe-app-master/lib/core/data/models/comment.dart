import 'package:architecture/core/data/models/user.dart';
import 'package:architecture/core/utils/common_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class CommentModel {
  @JsonKey(name: "_id")
  final String id;
  final String content;
  final List<String> likes;
  final UserModel author;

  @JsonKey(fromJson: mandatoryDateTimeFromString)
  final DateTime createdAt;

  const CommentModel(
      {required this.id,
      required this.content,
      required this.likes,
      required this.author,
      required this.createdAt});

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
