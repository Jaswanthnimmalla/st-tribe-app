import 'package:architecture/core/data/models/user.dart';

import 'intership_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'application_model.g.dart';

@JsonSerializable()
class ApplicationModel {
  @JsonKey(name: "_id")
  String? id;
  UserModel? user;
  InternshipModel? internship;
  String? status;

  ApplicationModel({this.id, this.user, this.internship, this.status});

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicationModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApplicationModelToJson(this);
}
