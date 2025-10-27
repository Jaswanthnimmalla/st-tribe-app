// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stcoin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StcoinModel _$StcoinModelFromJson(Map<String, dynamic> json) => StcoinModel(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      description: json['description'] as String?,
      amount: json['amount'] as num?,
      tag: json['tag'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      rzpTransactionId: json['rzpTransactionId'] as String?,
    );

Map<String, dynamic> _$StcoinModelToJson(StcoinModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'description': instance.description,
      'amount': instance.amount,
      'tag': instance.tag,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'rzpTransactionId': instance.rzpTransactionId,
    };
