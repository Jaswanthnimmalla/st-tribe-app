import 'package:architecture/core/utils/common_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class EventModel {
  @JsonKey(name: "_id")
  final String id;
  final String title;
  final String description;
  final String coverImg;
  final String type;
  final String hostName;

  @JsonKey(fromJson: mandatoryDateTimeFromString)
  final DateTime startDate;

  @JsonKey(fromJson: mandatoryDateTimeFromString)
  final DateTime endDate;

  final String entryType;

  final List<EventTicketModel> tickets;
  final EventLocationModel location;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImg,
    required this.type,
    required this.hostName,
    required this.startDate,
    required this.endDate,
    required this.entryType,
    required this.tickets,
    required this.location,
  });

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}

@JsonSerializable(explicitToJson: true)
@immutable
class EventLocationModel {
  final String type;
  final String meetingLink;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;

  const EventLocationModel({
    required this.type,
    required this.meetingLink,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
  });
  Map<String, dynamic> toJson() => _$EventLocationModelToJson(this);

  factory EventLocationModel.fromJson(Map<String, dynamic> json) =>
      _$EventLocationModelFromJson(json);
}

@JsonSerializable(explicitToJson: true)
@immutable
class EventTicketModel {
  @JsonKey(name: "_id")
  final String id;
  final String title;
  final num price;

  const EventTicketModel({
    required this.id,
    required this.title,
    required this.price,
  });
  Map<String, dynamic> toJson() => _$EventTicketModelToJson(this);

  factory EventTicketModel.fromJson(Map<String, dynamic> json) =>
      _$EventTicketModelFromJson(json);
}
