import 'package:architecture/core/data/models/intership/intership_model.dart';
import 'package:architecture/core/domain/usecases/search_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/article.dart';
import '../../data/models/event/event_model.dart';

part 'home_event.dart';
part 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SearchUseCase _searchUseCase;
  HomeBloc({required SearchUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(SearchInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SearchByQueryEvent>(handleSearch);
  }

  void handleSearch(SearchByQueryEvent event, Emitter<HomeState> emit) async {
    try {
      emit(SearchLoadingState());
      var data = await _searchUseCase.handleSearch(event.query);
      List<dynamic> internshipList = data['data']['data']["internships"];
      List<dynamic> eventsList = data['data']['data']["events"];
      List<dynamic> articlesList = data['data']['data']["articles"];
      emit(SearchByQuerySuccessFullState(
        internshipList:
            internshipList.map((e) => InternshipModel.fromJson(e)).toList(),
        articleList: articlesList.map((e) => ArticleModel.fromJson(e)).toList(),
        eventsList: eventsList.map((e) => EventModel.fromJson(e)).toList(),
      ));
    } catch (e) {
      DioError err = e as DioError;
      emit(SearchFailureState(error: err.response?.data["message"]));
    }
  }
}
