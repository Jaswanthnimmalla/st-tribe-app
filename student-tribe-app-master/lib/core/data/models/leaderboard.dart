// ignore: file_names
import 'package:json_annotation/json_annotation.dart';

part 'leaderboard.g.dart';

@JsonSerializable()
class LeaderBoardModel {
  @JsonKey(name: "_id")
  String? id;
  int? stCoins;
  String? name;
  String? profileImg;
  num? profileCompletionPercentage;

  LeaderBoardModel(
      {this.stCoins,
      this.name,
      this.profileImg,
      this.profileCompletionPercentage,
      this.id});

  Map<String, dynamic> toJson() => _$LeaderBoardModelToJson(this);

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderBoardModelFromJson(json);
}
