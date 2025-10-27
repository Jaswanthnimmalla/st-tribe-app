part of 'intership_bloc.dart';

sealed class IntershipEvent extends Equatable {
  const IntershipEvent();

  @override
  List<Object> get props => [];
}

class GetInternshipsEvent extends IntershipEvent {
  final Map<String, dynamic> sortBy;

  GetInternshipsEvent({this.sortBy = const {"sort": "-createdAt"}});
}

class GetIntershipByIdEvent extends IntershipEvent {
  final String id;

  GetIntershipByIdEvent({required this.id});
}

class GetMyApplicationsEvent extends IntershipEvent {
  GetMyApplicationsEvent();
}

// class GetAllInternshipApplicationsEvent extends IntershipEvent {
//   final String id;

//   GetAllInternshipApplicationsEvent({required this.id});
// }

class ApplyInternShipEvent extends IntershipEvent {
  final String id;
  final Map data;
  ApplyInternShipEvent({required this.id,required this.data});
}

class CheckInternShipEvent extends IntershipEvent {
  final String id;

  CheckInternShipEvent({required this.id});
}
