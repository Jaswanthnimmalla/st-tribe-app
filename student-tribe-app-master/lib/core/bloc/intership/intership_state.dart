part of 'intership_bloc.dart';

sealed class InternshipState extends Equatable {
  const InternshipState();

  @override
  List<Object> get props => [];
}

final class IntershipInitial extends InternshipState {}

class InternshipLoadingState extends InternshipState {}

class GetInternshipsSuccessFullState extends InternshipState {
  final List<InternshipModel> internships;

  GetInternshipsSuccessFullState(this.internships);
}

class GetInternshipByIdSuccessFullState extends InternshipState {
  final InternshipModel interships;

  GetInternshipByIdSuccessFullState(this.interships);
}

class GetMyApplicationSuccessFullState extends InternshipState {
  final List<ApplicationModel> applications;

  GetMyApplicationSuccessFullState(this.applications);
}

class ApplyInternShipSuccessState extends InternshipState {
  ApplyInternShipSuccessState();
}

// class GetAllInternshipApplicationsSuccessFullState extends IntershipState{
//   final List<ApplicationModel> applications;

//   GetAllInternshipApplicationsSuccessFullState(this.applications);
// }

class InternshipErrorState extends InternshipState {
  final String error;

  InternshipErrorState({required this.error});
}

class CheckInternShipSuccessState extends InternshipState {
  final bool applied;
  final bool bookmarked;
  CheckInternShipSuccessState(this.applied, this.bookmarked);
}
