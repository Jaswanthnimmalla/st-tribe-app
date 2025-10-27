// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      buyInAmount: json['buyInAmount'] as num?,
      ticketAmount: json['ticketAmount'] as num?,
      bookingAmount: json['bookingAmount'] as num?,
      transactionId: json['transactionId'] as String?,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'buyInAmount': instance.buyInAmount,
      'ticketAmount': instance.ticketAmount,
      'bookingAmount': instance.bookingAmount,
      'transactionId': instance.transactionId,
    };
