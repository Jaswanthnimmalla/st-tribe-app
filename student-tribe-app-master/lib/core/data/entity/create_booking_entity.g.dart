// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_booking_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEventBookingEntity _$CreateEventBookingEntityFromJson(
        Map<String, dynamic> json) =>
    CreateEventBookingEntity(
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      payment: json['payment'] == null
          ? null
          : PaymentModel.fromJson(json['payment'] as Map<String, dynamic>),
      paymentMethod: json['paymentMethod'] as String?,
      attendees: (json['attendees'] as List<dynamic>?)
          ?.map((e) => AttendeesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      stCoins: json['stCoins'] as num?,
      answers: json['answers'] as List<dynamic>?,
      amount: json['amount'] as num?,
    );

Map<String, dynamic> _$CreateEventBookingEntityToJson(
        CreateEventBookingEntity instance) =>
    <String, dynamic>{
      'tickets': instance.tickets,
      'payment': instance.payment,
      'paymentMethod': instance.paymentMethod,
      'stCoins': instance.stCoins,
      'attendees': instance.attendees,
      'answers': instance.answers,
      'amount': instance.amount,
    };
