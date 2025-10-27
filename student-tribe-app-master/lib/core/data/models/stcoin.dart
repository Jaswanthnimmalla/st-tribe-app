// ignore: file_names
import 'package:json_annotation/json_annotation.dart';

part 'stcoin.g.dart';

@JsonSerializable()
class StcoinModel {
  @JsonKey(name: "_id")
  String? id;
  String? user;
  String? description;
  num? amount;
  String? tag;
  String? createdAt;
  String? updatedAt;
  String? rzpTransactionId;

  StcoinModel(
      {this.id,
      this.user,
      this.description,
      this.amount,
      this.tag,
      this.createdAt,
      this.updatedAt,
      this.rzpTransactionId});

  Map<String, dynamic> toJson() => _$StcoinModelToJson(this);

  factory StcoinModel.fromJson(Map<String, dynamic> json) =>
      _$StcoinModelFromJson(json);
}
