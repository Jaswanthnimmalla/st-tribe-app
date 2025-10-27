part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SearchByQueryEvent extends HomeEvent {
  final Map<String, dynamic> query;

  const SearchByQueryEvent({required this.query});
}
