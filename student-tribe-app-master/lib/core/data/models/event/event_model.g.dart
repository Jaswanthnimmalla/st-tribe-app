// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      hostName: json['hostName'] as String?,
      coverImg: json['coverImg'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      status: json['status'] as String?,
      entryType: json['entryType'] as String?,
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      attendees: (json['attendees'] as List<dynamic>?)
          ?.map((e) => AttendeesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookingPrice: json['bookingPrice'] as num?,
      bookmarked: json['bookmarked'] as bool? ?? false,
      previousBookingId: json['previousBookingId'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pendingOrderId: json['pendingOrderId'],
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'hostName': instance.hostName,
      'coverImg': instance.coverImg,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'status': instance.status,
      'entryType': instance.entryType,
      'bookingPrice': instance.bookingPrice,
      'tickets': instance.tickets,
      'attendees': instance.attendees,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'bookmarked': instance.bookmarked,
      'previousBookingId': instance.previousBookingId,
      'pendingOrderId': instance.pendingOrderId,
      'questions': instance.questions,
    };

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      type: json['type'] as String?,
      addressLine1: json['addressLine1'] as String?,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      meetingLink: json['meetingLink'] as String?,
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'state': instance.state,
      'meetingLink': instance.meetingLink,
    };
