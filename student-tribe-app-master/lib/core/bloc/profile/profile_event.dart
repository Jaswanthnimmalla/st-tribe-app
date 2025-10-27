// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetMyProfileEvent extends ProfileEvent {
  final bool handleSilently;
  const GetMyProfileEvent({this.handleSilently = false});
}

class GetMyBookmarksEvent extends ProfileEvent {
  final String type;

  const GetMyBookmarksEvent(this.type);
}

class AddToBookmarksEvent extends ProfileEvent {
  final String type;
  final String id;

  const AddToBookmarksEvent(this.type, this.id);
}

class GetAllSkillsEvent extends ProfileEvent {}

class UpdateSkillEvent extends ProfileEvent {
  final List<String> skills;

  const UpdateSkillEvent(this.skills);
}

class AddOrUpdateEducationalDetailsEvent extends ProfileEvent {
  final String instituteName;
  final String degree;
  final String course;
  final String startDate;
  final String? endDate;
  final double grade;
  final bool isUpdate;
  final String? id;

  const AddOrUpdateEducationalDetailsEvent(
      {required this.instituteName,
      required this.degree,
      required this.course,
      required this.startDate,
      this.endDate,
      required this.grade,
      this.isUpdate = false,
      this.id});
}

class AddOrUpdateExperienceDetailsEvent extends ProfileEvent {
  final String role;
  final String employmentType;
  final String startDate;
  final String? endDate;
  final String location;
  final bool isUpdate;
  final String id;
  final String organisation;

  const AddOrUpdateExperienceDetailsEvent(
      this.role,
      this.employmentType,
      this.startDate,
      this.endDate,
      this.location,
      this.isUpdate,
      this.id,
      this.organisation);
}

class UpdateProfileEvent extends ProfileEvent {
  // final String aboutMe;
  // final String location;
  // final String birthday;
  // final String gender;
  // final String number;
  final FormData formData;

  const UpdateProfileEvent(
      {
      // required this.aboutMe,
      // required this.location,
      // required this.birthday,
      // required this.gender,
      // required this.number,
      required this.formData});
}

class GetLeaderBoardEvent extends ProfileEvent {}

class GetStCoinsTransActionHistoryEvent extends ProfileEvent {
  final Map<String, dynamic> query;

  const GetStCoinsTransActionHistoryEvent(this.query);
}

class BuyStCoinEvent extends ProfileEvent {
  final String transactionId;

  const BuyStCoinEvent({required this.transactionId});
}

class AddReferalEvent extends ProfileEvent {
  final String referralUserId;

  AddReferalEvent({required this.referralUserId});
}

class DeleteUserProfileEvent extends ProfileEvent {}
