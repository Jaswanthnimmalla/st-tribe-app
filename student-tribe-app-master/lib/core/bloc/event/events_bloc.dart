import 'package:architecture/core/data/entity/create_booking_entity.dart';
import 'package:architecture/core/data/models/event/booking_model.dart';
import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:architecture/core/data/models/event/payment_model.dart';
import 'package:architecture/core/domain/usecases/events_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'events_event.dart';
part 'events_state.dart';

@lazySingleton
class EventBloc extends Bloc<Event, EventState> {
  final EventUseCase _eventUseCase;

  CreateEventBookingEntity createEventBookingEntity = CreateEventBookingEntity(
      payment: PaymentModel(),
      paymentMethod: "",
      tickets: [],
      attendees: [],
      answers: []);

  EventBloc({required EventUseCase eventUseCase})
      : _eventUseCase = eventUseCase,
        super(EventsInitial()) {
    on<Event>((event, emit) {});
    on<GetAllEvents>(handleGetAllEvents);
    on<GetEventByIdEvent>(handleGetEventById);
    on<GetMyBookingsEvent>(handleGetMyBookings);
    on<CreateEventBookingEvent>(handleCreateEventBooking);
    on<GetRzpDetailsEvent>(handleGetRzpDetails);
    on<GetRzpOrderEventsEvent>(handleGetRzpOrderEvents);
  }

  void handleGetAllEvents(GetAllEvents event, Emitter<EventState> emit) async {
    try {
      emit(EventLoadingState());
      var data = await _eventUseCase.handleGetEvents(event.sortBy);
      List<dynamic> list = data["data"]["data"];
      emit(GetAllEventsSuccessFullState(
          events: list.map((e) => EventModel.fromJson(e)).toList()));
    } catch (e) {
      DioError err = e as DioError;
      emit(EventErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetEventById(
      GetEventByIdEvent event, Emitter<EventState> emit) async {
    try {
      if (!event.handleSilently) emit(EventLoadingState());
      var data = await _eventUseCase.handleGetEventsById(event.id);

      emit(GetEventByIdSuccessFullState(
          event: EventModel.fromJson(
            data["data"]["data"],
          ),
          dateTime: DateTime.now()));
    } catch (e) {
      DioError err = e as DioError;
      emit(EventErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetMyBookings(
      GetMyBookingsEvent event, Emitter<EventState> emit) async {
    try {
      emit(EventLoadingState());
      var data = await _eventUseCase.handleGetMyBookings();
      List<dynamic> list = data["data"]["data"];
      emit(GetMyBookingSuccessFullState(
          bookingModelList:
              list.map((e) => BookingModel.fromJson(e)).toList()));
    } catch (e) {
      DioError err = e as DioError;
      emit(EventErrorState(error: err.response?.data["message"]));
    }
  }

  void handleCreateEventBooking(
      CreateEventBookingEvent event, Emitter<EventState> emit) async {
    try {
      emit(EventLoadingState());

      emit(CreateEventBookingSuccessFullState());
    } catch (e) {
      DioError err = e as DioError;
      emit(EventErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetRzpDetails(
      GetRzpDetailsEvent event, Emitter<EventState> emit) async {
    try {
      emit(EventLoadingState());
      var data =
          await _eventUseCase.handleGetRzpDetails(event.id, event.amount);
      emit(GetRzpSuccessState(
          data["data"]["data"]["id"], data["data"]["data"]["rzpKey"]));
    } catch (e) {
      DioError err = e as DioError;
      emit(EventErrorState(error: err.response?.data["message"]));
    }
  }

  //!Get razorpayorder Events
  void handleGetRzpOrderEvents(
      GetRzpOrderEventsEvent event, Emitter<EventState> emit) async {
    try {
      emit(EventLoadingState());
      var data = await _eventUseCase.handleGetRzpOrderEvents(
          event.id, event.body, event.isFromGroupBuyIn);
      emit(GetRzpSuccessState(
          data["data"]["data"]["id"], data["data"]["data"]["rzpKey"]));
    } catch (e) {
      DioError err = e as DioError;
      emit(EventErrorState(error: err.response?.data["message"]));
    }
  }
}
