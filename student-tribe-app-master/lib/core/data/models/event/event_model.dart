import 'package:architecture/core/data/entity/create_booking_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../intership/question_model.dart';
import 'ticket_model.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  LocationModel? location;
  @JsonKey(name: "_id")
  String? id;
  String? title;
  String? description;
  String? type;
  String? hostName;
  String? coverImg;
  String? startDate;
  String? endDate;
  String? status;
  String? entryType;
  num? bookingPrice;
  List<TicketModel>? tickets;
  List<AttendeesModel>? attendees;
  String? createdAt;
  String? updatedAt;
  @JsonKey(defaultValue: false)
  bool bookmarked;
  String? previousBookingId;
  dynamic pendingOrderId;
  List<QuestionModel>? questions;

  EventModel(
      {this.location,
      this.id,
      this.title,
      this.description,
      this.type,
      this.hostName,
      this.coverImg,
      this.startDate,
      this.endDate,
      this.status,
      this.entryType,
      this.tickets,
      this.createdAt,
      this.updatedAt,
      this.attendees,
      this.bookingPrice,
      this.bookmarked = false,
      this.previousBookingId,
      this.questions,
      this.pendingOrderId
      });

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
}

@JsonSerializable()
class LocationModel {
  String? type;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? meetingLink;

  LocationModel(
      {this.type,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.state,
      this.meetingLink});

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}
