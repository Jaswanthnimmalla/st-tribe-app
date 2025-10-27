// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      title: json['title'] as String?,
      price: json['price'] as int?,
      id: json['_id'] as String?,
      qty: json['qty'] as int? ?? 0,
      showPrice: json['showPrice'] as int? ?? 0,
      ticket: json['ticket'] as String? ?? "",
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'ticket': instance.ticket,
      'qty': instance.qty,
      '_id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'showPrice': instance.showPrice,
    };
