import 'dart:developer';

import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:architecture/core/data/models/intership/intership_model.dart';
import 'package:architecture/core/data/models/skill.dart';
import 'package:architecture/core/data/models/stcoin.dart';
import 'package:architecture/core/domain/usecases/profile_usecase.dart';
import 'package:architecture/main.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/leaderboard.dart';
import '../../data/models/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@lazySingleton
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase _profileUseCase;
  UserModel? userModel;

  ProfileBloc({required ProfileUseCase profileUseCase})
      : _profileUseCase = profileUseCase,
        super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<GetMyProfileEvent>(getMyProfile);
    on<AddOrUpdateEducationalDetailsEvent>(addEducationalDetails);
    on<UpdateSkillEvent>(updateSkill);
    on<AddOrUpdateExperienceDetailsEvent>(addExperienceDetails);
    on<UpdateProfileEvent>(updateMyProfile);
    on<GetAllSkillsEvent>(handleGetAllSkills);
    on<GetMyBookmarksEvent>(handleGetMyBookmarksEvent);
    on<AddToBookmarksEvent>(handleAddToBookmarksEvent);
    on<GetLeaderBoardEvent>(handleGetLeaderBoard);
    on<GetStCoinsTransActionHistoryEvent>(handleGetStCoinsHistory);
    on<BuyStCoinEvent>(handleBuyStCoins);
    on<AddReferalEvent>(handleAddReferal);
    on<DeleteUserProfileEvent>(handleDeleteUserProfile);
  }

  void handleAddToBookmarksEvent(
      AddToBookmarksEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      await _profileUseCase
          .handleAddToBookmark({"type": event.type, "id": event.id});
      emit(BookmarkAddedSuccessState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetMyBookmarksEvent(
      GetMyBookmarksEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      dynamic data = await _profileUseCase.handleGetBookmarks(event.type);
      if (event.type == "bookmarkedInternships") {
        List<InternshipModel> internships = [];
        for (var internship in data["data"]) {
          internships.add(InternshipModel.fromJson(internship));
        }
        emit(GetBookmarkedInternshipsSuccessState(internships));
      } else if (event.type == "bookmarkedEvents") {
        List<EventModel> events = [];
        for (var event in data["data"]) {
          events.add(EventModel.fromJson(event));
        }
        emit(GetBookmarkedEventsSuccessState(events));
      }
    } catch (e, stack) {
      log(e.toString());
      log(stack.toString());
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetAllSkills(
      GetAllSkillsEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      dynamic data = await _profileUseCase.handleGetAllSkills();
      List<SkillModel> skills = [];
      for (var skill in data["data"]["data"]) {
        skills.add(SkillModel.fromJson(skill));
      }
      emit(GetAllSkillsSuccessState(skills));
    } catch (e) {
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void getMyProfile(GetMyProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      if (!event.handleSilently) emit(ProfileLoadingState());
      dynamic data = await _profileUseCase.handleGetMyProfile();
      userModel = UserModel.fromJson(data["data"]["data"]);
      emit(GetMyProfileSuccessFullState(
          userModel: userModel!, updatedDate: DateTime.now()));
    } catch (e) {
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void updateSkill(UpdateSkillEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());

      await _profileUseCase.handleUpdateSkill({"skills": event.skills});
      emit(const UpdateSkillSuccessFullState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void addEducationalDetails(AddOrUpdateEducationalDetailsEvent event,
      Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      if (event.isUpdate) {
        await _profileUseCase.handleUpdateEducationalDetails({
          "instituteName": event.instituteName,
          "degree": event.degree,
          "course": event.course,
          "startDate": event.startDate,
          "endDate": event.endDate,
          "grade": event.grade
        }, event.id!);
      } else {
        await _profileUseCase.handleAddEducationalDetails({
          "instituteName": event.instituteName,
          "degree": event.degree,
          "course": event.course,
          "startDate": event.startDate,
          "endDate": event.endDate,
          "grade": event.grade
        });
      }

      emit(const AddOrUpdateEducationalDetailsSuccessFullState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void addExperienceDetails(AddOrUpdateExperienceDetailsEvent event,
      Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());

      if (event.isUpdate) {
        await _profileUseCase.handleUpdateExperienceDetails({
          "role": event.role,
          "employmentType": event.employmentType,
          "location": event.location,
          "startDate": event.startDate,
          "endDate": event.endDate,
          "orgName": event.organisation
        }, event.id);
      } else {
        await _profileUseCase.handleAddExperienceDetails({
          "role": event.role,
          "employmentType": event.employmentType,
          "location": event.location,
          "startDate": event.startDate,
          "endDate": event.endDate,
          "orgName": event.organisation
        });
      }
      emit(const AddOrUpdateExperienceDetailsSuccessFullState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void updateMyProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());

      await _profileUseCase.handleUpdateMyProfile(event.formData);
      emit(UpdateProfileSuccessState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetLeaderBoard(
      GetLeaderBoardEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());

      var data = await _profileUseCase.handleGetLeaderBoard();
      List<dynamic> list = data['data']['data'];
      emit(GetLeaderBoardSuccessFullState(
          leaderBoardList:
              list.map((e) => LeaderBoardModel.fromJson(e)).toList()));
    } catch (e) {
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetStCoinsHistory(GetStCoinsTransActionHistoryEvent event,
      Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());

      var data =
          await _profileUseCase.handleStCoinsTransactionHistory(event.query);
      List<dynamic> list = data['data']['data'];
      emit(GetStCoinsTransActionHistorySuccessFull(
          stCoinsHistory: list.map((e) => StcoinModel.fromJson(e)).toList()));
    } catch (e) {
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void handleBuyStCoins(
      BuyStCoinEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());

      emit(BuyStCoinSuccessFullState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }

  void handleAddReferal(
      AddReferalEvent event, Emitter<ProfileState> emit) async {
    try {
      await _profileUseCase.handleAddReferal({"userId": event.referralUserId});
    } catch (e) {
      logger.e("Referral Error $e");
    }
  }

  void handleDeleteUserProfile(
      DeleteUserProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoadingState());
      await _profileUseCase.handleDeleteUserProfile();

      emit(DeleteUserProfileSuccessFullState());
    } catch (e) {
      DioError err = e as DioError;

      logger.e("Delete User Error $e");
      emit(ProfileErrorState(error: err.response?.data["message"]));
    }
  }
}
