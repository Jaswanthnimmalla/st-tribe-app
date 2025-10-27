// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      payment: json['payment'] == null
          ? null
          : PaymentModel.fromJson(json['payment'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      event: json['event'] == null
          ? null
          : EventModel.fromJson(json['event'] as Map<String, dynamic>),
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      attendees: (json['attendees'] as List<dynamic>?)
          ?.map((e) => AttendeesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethod: json['paymentMethod'] as String?,
      transactionId: json['transactionId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'payment': instance.payment?.toJson(),
      'user': instance.user?.toJson(),
      'event': instance.event?.toJson(),
      'tickets': instance.tickets?.map((e) => e.toJson()).toList(),
      'attendees': instance.attendees?.map((e) => e.toJson()).toList(),
      'paymentMethod': instance.paymentMethod,
      'transactionId': instance.transactionId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'id': instance.id,
    };

BookingTicketModel _$BookingTicketModelFromJson(Map<String, dynamic> json) =>
    BookingTicketModel(
      id: json['id'] as String?,
      ticket: json['ticket'] as String?,
    );

Map<String, dynamic> _$BookingTicketModelToJson(BookingTicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticket': instance.ticket,
    };
