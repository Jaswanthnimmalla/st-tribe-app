part of 'events_bloc.dart';

sealed class Event extends Equatable {
  const Event();

  @override
  List<Object> get props => [];
}

class GetAllEvents extends Event {
  final Map<String, dynamic> sortBy;

  GetAllEvents({required this.sortBy});
}

class GetEventByIdEvent extends Event {
  final String id;
  final bool handleSilently;
  GetEventByIdEvent({required this.id, this.handleSilently = false});
}

class GetMyBookingsEvent extends Event {
  GetMyBookingsEvent();
}

class CreateEventBookingEvent extends Event {
  final String id;

  CreateEventBookingEvent({required this.id});
}

class GetRzpDetailsEvent extends Event {
  final String id;
  final num amount;

  const GetRzpDetailsEvent({required this.id, required this.amount});
}


class GetRzpOrderEventsEvent extends Event {
  final String id;
  final Map body;
  final bool isFromGroupBuyIn;

  const GetRzpOrderEventsEvent({required this.id, required this.body,required this.isFromGroupBuyIn});
}
