part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends HomeState {}

class SearchLoadingState extends HomeState {}

class SearchByQuerySuccessFullState extends HomeState {
  final List<InternshipModel> internshipList;
  final List<EventModel> eventsList;
  final List<ArticleModel> articleList;

  const SearchByQuerySuccessFullState(
      {required this.internshipList,
      required this.eventsList,
      required this.articleList});
}

class SearchFailureState extends HomeState {
  final String error;

  const SearchFailureState({required this.error});
}
