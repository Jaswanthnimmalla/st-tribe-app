// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class GetMyProfileSuccessFullState extends ProfileState {
  final UserModel userModel;
  final DateTime updatedDate;

  const GetMyProfileSuccessFullState(
      {required this.userModel, required this.updatedDate});

  @override
  List<Object> get props => [updatedDate];
}

class ProfileErrorState extends ProfileState {
  final String error;
  const ProfileErrorState({
    required this.error,
  });
}

class UpdateSkillSuccessFullState extends ProfileState {
  const UpdateSkillSuccessFullState();
}

class AddOrUpdateEducationalDetailsSuccessFullState extends ProfileState {
  const AddOrUpdateEducationalDetailsSuccessFullState();
}

class AddOrUpdateExperienceDetailsSuccessFullState extends ProfileState {
  const AddOrUpdateExperienceDetailsSuccessFullState();
}

class UpdateProfileSuccessState extends ProfileState {}

class GetAllSkillsSuccessState extends ProfileState {
  final List<SkillModel> skills;
  const GetAllSkillsSuccessState(this.skills);
}

class BookmarkAddedSuccessState extends ProfileState {}

class GetBookmarkedInternshipsSuccessState extends ProfileState {
  final List<InternshipModel> internships;
  const GetBookmarkedInternshipsSuccessState(this.internships);
}

class GetBookmarkedEventsSuccessState extends ProfileState {
  final List<EventModel> events;
  const GetBookmarkedEventsSuccessState(this.events);
}

class GetLeaderBoardSuccessFullState extends ProfileState {
  final List<LeaderBoardModel> leaderBoardList;

  const GetLeaderBoardSuccessFullState({required this.leaderBoardList});
}

class GetStCoinsTransActionHistorySuccessFull extends ProfileState {
  final List<StcoinModel> stCoinsHistory;

  const GetStCoinsTransActionHistorySuccessFull({required this.stCoinsHistory});
}

class BuyStCoinSuccessFullState extends ProfileState {}

class DeleteUserProfileSuccessFullState extends ProfileState {

  DeleteUserProfileSuccessFullState();

}