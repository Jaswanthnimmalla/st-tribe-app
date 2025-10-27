import 'package:json_annotation/json_annotation.dart';
part 'groupbyin.g.dart';

@JsonSerializable()
class GroupByInModel {
  @JsonKey(name: "_id")
  String? id;
  String? title;
  String? about;
  String? coverImg;
  String? startDate;
  num target;
  num sold;
  String? location;
  bool? featured;
  String? offerEndDate;
  num? originalPrice;
  num? discountedPrice;
  String? createdAt;
  String? updatedAt;
  bool? purchased;
  String? status;
  dynamic pendingBookingId;

  GroupByInModel(
      {this.id,
      this.title,
      this.about,
      this.coverImg,
      this.startDate,
      required this.target,
      required this.sold,
      this.location,
      this.featured,
      this.offerEndDate,
      this.originalPrice,
      this.discountedPrice,
      this.createdAt,
      this.updatedAt,
      this.purchased,
      this.status,
      this.pendingBookingId
      });

  Map<String, dynamic> toJson() => _$GroupByInModelToJson(this);

  factory GroupByInModel.fromJson(Map<String, dynamic> json) =>
      _$GroupByInModelFromJson(json);
}
