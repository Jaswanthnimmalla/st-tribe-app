// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'group_by_in_bloc.dart';

sealed class GroupByInState extends Equatable {
  const GroupByInState();

  @override
  List<Object> get props => [];
}

final class GroupByInInitial extends GroupByInState {}

class GroupByInLoadingState extends GroupByInState {}

class GetAllGroupByInSuccessFullState extends GroupByInState {
  final List<GroupByInModel> groupByInList;
  GetAllGroupByInSuccessFullState({
    required this.groupByInList,
  });
}

class GetGroupByInByIdSuccessFullState extends GroupByInState {
  final GroupByInModel groupByIn;
  final DateTime dateTime;
  GetGroupByInByIdSuccessFullState({
    required this.groupByIn,
    required this.dateTime,
  });

  @override
  List<Object> get props => [groupByIn, dateTime];
}

class GroupByInPurchaseSuccessState extends GroupByInState {}

class GroupByInFailureState extends GroupByInState {
  final String error;

  GroupByInFailureState({required this.error});
}
