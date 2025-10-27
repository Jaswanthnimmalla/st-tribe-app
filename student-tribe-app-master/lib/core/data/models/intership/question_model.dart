import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel {
  String? question;
  String? idealAnswer;
  @JsonKey(name: "_id")
  String? id;
  String answer;

  QuestionModel({this.question, this.idealAnswer, this.id,this.answer=""});

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
