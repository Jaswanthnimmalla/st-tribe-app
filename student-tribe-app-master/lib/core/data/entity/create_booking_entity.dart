import 'package:json_annotation/json_annotation.dart';

import '../models/event/payment_model.dart';
import '../models/event/ticket_model.dart';

part 'create_booking_entity.g.dart';

@JsonSerializable()
class CreateEventBookingEntity {
  List<TicketModel>? tickets;
  PaymentModel? payment;
  String? paymentMethod;
  num? stCoins;
  List<AttendeesModel>? attendees;
  List<dynamic>?answers;
  num? amount;

  CreateEventBookingEntity(
      {this.tickets,
      this.payment,
      this.paymentMethod,
      this.attendees,
      this.stCoins,
      this.answers,
      this.amount
      });

  // Generate `CreateEventEntity` from JSON
  factory CreateEventBookingEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateEventBookingEntityFromJson(json);

  // Convert `CreateEventBookingEntity` to JSON
  Map<String, dynamic> toJson() => _$CreateEventBookingEntityToJson(this);
}

class AttendeesModel {
  String? name;
  String? email;
  String? phone;

  AttendeesModel({this.name, this.email, this.phone});

  AttendeesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}
