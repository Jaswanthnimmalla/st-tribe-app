import 'package:architecture/core/data/models/groupbyin.dart';
import 'package:architecture/core/domain/usecases/groupbyin_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'group_by_in_event.dart';
part 'group_by_in_state.dart';

@lazySingleton
class GroupByInBloc extends Bloc<GroupByInEvent, GroupByInState> {
  final GroupByInUseCase _groupByInUseCase;
  GroupByInBloc({required GroupByInUseCase groupByInUseCase})
      : _groupByInUseCase = groupByInUseCase,
        super(GroupByInInitial()) {
    on<GroupByInEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetAllGroupByInEvent>(handleGetAllGroupByIn);
    on<GetGroupByInByIdEvent>(handleGetGroupByInId);
    on<CreateGroupBuyInBookingEvent>(handleGroupBuyInBooking);
  }

  void handleGroupBuyInBooking(
      CreateGroupBuyInBookingEvent event, Emitter<GroupByInState> emit) async {
    try {
      emit(GroupByInLoadingState());
      await _groupByInUseCase.handleGroupBuyInBooking(event.id, {
        "qty": event.qty,
        "payment": event.payment,
        "paymentMethod": event.paymentMethod,
        "stCoins": event.stCoins
      });

      emit(GroupByInPurchaseSuccessState());
    } catch (e) {
      DioError err = e as DioError;
      emit(GroupByInFailureState(error: err.response?.data["message"]));
    }
  }

  void handleGetAllGroupByIn(
      GetAllGroupByInEvent event, Emitter<GroupByInState> emit) async {
    try {
      emit(GroupByInLoadingState());
      List<dynamic> list = await _groupByInUseCase.handleGetAllGroupByIns();

      emit(GetAllGroupByInSuccessFullState(
          groupByInList: list.map((e) => GroupByInModel.fromJson(e)).toList()));
    } catch (e) {
      DioError err = e as DioError;
      emit(GroupByInFailureState(error: err.response?.data["message"]));
    }
  }

  void handleGetGroupByInId(
      GetGroupByInByIdEvent event, Emitter<GroupByInState> emit) async {
    try {
      if (!event.handleSilently) emit(GroupByInLoadingState());

      var data = await _groupByInUseCase.handleGetGroupByInById(event.id);

      emit(GetGroupByInByIdSuccessFullState(
          groupByIn: GroupByInModel.fromJson(
            data["data"]["data"],
          ),
          dateTime: DateTime.now()));
    } catch (e) {
      DioError err = e as DioError;
      emit(GroupByInFailureState(error: err.response?.data["message"]));
    }
  }
}
