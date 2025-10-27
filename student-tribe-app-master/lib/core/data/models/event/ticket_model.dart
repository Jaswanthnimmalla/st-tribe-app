import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel {
  String? ticket;
  int? qty;
  @JsonKey(name: "_id")
  String? id;
  String? title;
  int? price;

  int showPrice;

  TicketModel(
      {this.title,
      this.price,
      this.id,
      this.qty = 0,
      this.showPrice = 0,
      this.ticket = ""});

  // Generate `Tickets` from JSON
  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  // Convert `TicketModel` to JSON
  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
