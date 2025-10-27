// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      coverImg: json['coverImg'] as String,
      type: json['type'] as String,
      hostName: json['hostName'] as String,
      startDate: mandatoryDateTimeFromString(json['startDate'] as String),
      endDate: mandatoryDateTimeFromString(json['endDate'] as String),
      entryType: json['entryType'] as String,
      tickets: (json['tickets'] as List<dynamic>)
          .map((e) => EventTicketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      location:
          EventLocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'coverImg': instance.coverImg,
      'type': instance.type,
      'hostName': instance.hostName,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'entryType': instance.entryType,
      'tickets': instance.tickets.map((e) => e.toJson()).toList(),
      'location': instance.location.toJson(),
    };

EventLocationModel _$EventLocationModelFromJson(Map<String, dynamic> json) =>
    EventLocationModel(
      type: json['type'] as String,
      meetingLink: json['meetingLink'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$EventLocationModelToJson(EventLocationModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'meetingLink': instance.meetingLink,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'state': instance.state,
    };

EventTicketModel _$EventTicketModelFromJson(Map<String, dynamic> json) =>
    EventTicketModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      price: json['price'] as num,
    );

Map<String, dynamic> _$EventTicketModelToJson(EventTicketModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'price': instance.price,
    };
