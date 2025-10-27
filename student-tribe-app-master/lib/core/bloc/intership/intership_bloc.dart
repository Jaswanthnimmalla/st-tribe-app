import 'package:architecture/core/data/models/intership/application_model.dart';
import 'package:architecture/core/domain/usecases/internship_usecase.dart';
import 'package:architecture/features/bottom%20navigation/export.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/intership/intership_filter_model.dart';
import '../../data/models/intership/intership_model.dart';

part 'intership_event.dart';
part 'intership_state.dart';

@lazySingleton
class InternshipBloc extends Bloc<IntershipEvent, InternshipState> {
  final InternShipUseCase _internShipUseCase;
  IntershipFilter intershipFilter = IntershipFilter(
      location: [],
      jobTitle: [],
      skills: [],
      stipend: ["3000", "6000", "8000", "10000", "15000+"],
      duration: ["1 months", "2 months", "3 months", "6 months"]);
  InternshipBloc({required InternShipUseCase internShipUseCase})
      : _internShipUseCase = internShipUseCase,
        super(IntershipInitial()) {
    on<IntershipEvent>((event, emit) {});
    on<GetInternshipsEvent>(getInterships);
    on<GetIntershipByIdEvent>(getIntershipById);
    on<GetMyApplicationsEvent>(getMyApplications);
    on<ApplyInternShipEvent>(applyInternship);
    on<CheckInternShipEvent>(checkInternship);
  }

  void getInterships(
      GetInternshipsEvent event, Emitter<InternshipState> emit) async {
    try {
      emit(InternshipLoadingState());
      dynamic data = await _internShipUseCase.handleGetInterships(event.sortBy);
      List<dynamic> list = data["data"]["data"];
      emit(GetInternshipsSuccessFullState(
          list.map((e) => InternshipModel.fromJson(e)).toList()));
    } catch (e) {
      DioError err = e as DioError;
      emit(InternshipErrorState(error: err.response?.data["message"]));
    }
  }

  void getIntershipById(
      GetIntershipByIdEvent event, Emitter<InternshipState> emit) async {
    try {
      emit(InternshipLoadingState());
      dynamic data = await _internShipUseCase.handleGetIntershipById(event.id);
      emit(GetInternshipByIdSuccessFullState(
          InternshipModel.fromJson(data["data"]["data"])));
    } catch (e) {
      DioError err = e as DioError;
      emit(InternshipErrorState(error: err.response?.data["message"]));
    }
  }

  void getMyApplications(
      GetMyApplicationsEvent event, Emitter<InternshipState> emit) async {
    try {
      emit(InternshipLoadingState());
      dynamic data = await _internShipUseCase.handleGetMyApplications();
      List<dynamic> list = data["data"]["data"];
      emit(GetMyApplicationSuccessFullState(list.map((e) {
        (e["user"] as Map<String, dynamic>).remove('skills');
        return ApplicationModel.fromJson(e);
      }).toList()));
    } catch (e) {
      DioError err = e as DioError;
      emit(InternshipErrorState(error: err.response?.data["message"]));
    }
  }

  void applyInternship(
      ApplyInternShipEvent event, Emitter<InternshipState> emit) async {
    try {
      emit(InternshipLoadingState());

      emit(ApplyInternShipSuccessState());
    } catch (e) {
      DioError err = e as DioError;
      emit(InternshipErrorState(error: err.response?.data["message"]));
    }
  }

  void checkInternship(
      CheckInternShipEvent event, Emitter<InternshipState> emit) async {
    try {
      emit(InternshipLoadingState());
      dynamic data = await _internShipUseCase.handleCheckInternship(event.id);

      emit(CheckInternShipSuccessState(
          data["data"]["data"]["applied"], data["data"]["data"]["bookmarked"]));
    } catch (e) {
      DioError err = e as DioError;
      emit(InternshipErrorState(error: err.response?.data["message"]));
    }
  }
}
