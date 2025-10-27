import 'package:architecture/core/data/entity/create_booking_entity.dart';
import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:architecture/core/data/models/event/payment_model.dart';
import 'package:architecture/core/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ticket_model.dart';

part 'booking_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingModel {
  PaymentModel? payment;
  UserModel? user;
  EventModel? event;
  List<TicketModel>? tickets;
  List<AttendeesModel>? attendees;
  String? paymentMethod;
  String? transactionId;
  String? createdAt;
  String? updatedAt;
  String? id;

  BookingModel(
      {this.payment,
      this.user,
      this.event,
      this.tickets,
      this.attendees,
      this.paymentMethod,
      this.transactionId,
      this.createdAt,
      this.updatedAt,
      this.id});

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
}

@JsonSerializable()
class BookingTicketModel {
  String? id;
  String? ticket;

  BookingTicketModel({
    this.id,
    this.ticket,
  });

  Map<String, dynamic> toJson() => _$BookingTicketModelToJson(this);

  factory BookingTicketModel.fromJson(Map<String, dynamic> json) =>
      _$BookingTicketModelFromJson(json);
}
