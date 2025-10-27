import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable()
class PaymentModel {
  num? buyInAmount;
  num? ticketAmount;
  num? bookingAmount;
  String? transactionId;

  PaymentModel(
      {this.buyInAmount,
      this.ticketAmount,
      this.bookingAmount,
      this.transactionId});

  // Generate `PaymentModel` from JSON
  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  // Convert `Payment` to JSON
  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
