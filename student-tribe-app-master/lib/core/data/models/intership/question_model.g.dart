// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      question: json['question'] as String?,
      idealAnswer: json['idealAnswer'] as String?,
      id: json['_id'] as String?,
      answer: json['answer'] as String? ?? "",
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'question': instance.question,
      'idealAnswer': instance.idealAnswer,
      '_id': instance.id,
      'answer': instance.answer,
    };
