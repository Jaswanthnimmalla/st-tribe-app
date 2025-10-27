part of 'events_bloc.dart';

sealed class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

final class EventsInitial extends EventState {}

class EventLoadingState extends EventState {}

class GetAllEventsSuccessFullState extends EventState {
  final List<EventModel> events;

  GetAllEventsSuccessFullState({required this.events});
}

class GetEventByIdSuccessFullState extends EventState {
  final EventModel event;
  final DateTime dateTime;

  GetEventByIdSuccessFullState({required this.event,required this.dateTime});
}

class GetMyBookingSuccessFullState extends EventState {
  final List<BookingModel> bookingModelList;

  GetMyBookingSuccessFullState({required this.bookingModelList});
}

class CreateEventBookingSuccessFullState extends EventState {}

class GetRzpSuccessState extends EventState {
  final String orderId;
  final String rzpKey;
  const GetRzpSuccessState(this.orderId, this.rzpKey);
}

class EventErrorState extends EventState {
  final String error;

  const EventErrorState({required this.error});
}


