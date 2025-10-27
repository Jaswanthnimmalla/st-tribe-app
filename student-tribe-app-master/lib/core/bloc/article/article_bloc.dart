import 'package:architecture/core/data/models/article.dart';
import 'package:architecture/core/data/models/comment.dart';
import 'package:architecture/core/domain/usecases/article_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'article_event.dart';
part 'article_state.dart';

@lazySingleton
class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleUseCase _articleUseCase;
  ArticleBloc({required ArticleUseCase articleUseCase})
      : _articleUseCase = articleUseCase,
        super(ArticleInitialState()) {
    on<ArticleEvent>((event, emit) {});
    on<GetAllArticlesEvent>(handleGetAllArticles);
    on<GetOneArticleEvent>(handleGetOneArticle);
    on<GetArticleCommentsEvent>(handleGetArticleComments);
    on<AddCommentsEvent>(handleAddComments);
    on<LikeCommentEvent>(handleLikeComments);
    on<CreateArticleEvent>(handleCreateArticleEvent);
    on<UpdateArticleEvent>(handleUpdateMyArticleEvent);
    on<GetMyArticlesEvent>(handleGetMyArticlesEvent);
    on<DeleteArticleByIdEvent>(handleDeleteArticleEvent);
    on<LikeArticleByIdEvent>(handleLikeArticleById);
    on<DislikeArticleByIdEvent>(handleDislikeArticleById);
  }

  void handleDeleteArticleEvent(
      DeleteArticleByIdEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());
      await _articleUseCase.handleDeleteArticleById(event.id);
      emit(DeleteArticleByIdSuccessFullState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }

  void handleUpdateMyArticleEvent(
      UpdateArticleEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());
      await _articleUseCase.handleUpdateArticle(event.data);
      emit(ArticleCreatedSuccessfulState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetMyArticlesEvent(
      GetMyArticlesEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());
      dynamic data = await _articleUseCase.getMyArticles(event.status);
      List<ArticleModel> articles = [];
      for (var item in data) {
        articles.add(ArticleModel.fromJson(item));
      }
      emit(MyArticlesSuccessfulState(articles));
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }

  void handleCreateArticleEvent(
      CreateArticleEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());
      await _articleUseCase.handleCreateArticle(
          {"title": event.title, "content": event.content});
      emit(ArticleCreatedSuccessfulState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }

  void handleLikeComments(
      LikeCommentEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());
      if (event.like) {
        await _articleUseCase.handleLikeArticleComment(
            event.articleId, event.commentId);
      } else {
        await _articleUseCase.handleRemoveLikeArticleComment(
            event.articleId, event.commentId);
      }
      emit(CommentAddedSuccessfulState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }

  void handleAddComments(
      AddCommentsEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());
      await _articleUseCase
          .handleCreateComment(event.id, {"content": event.comment});
      emit(CommentAddedSuccessfulState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetArticleComments(
      GetArticleCommentsEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());
      dynamic data = await _articleUseCase.handleGetArticleComments(event.id);
      List<CommentModel> comments = [];
      for (var item in data) {
        print(item);
        comments.add(CommentModel.fromJson(item));
      }
      emit(CommentsSuccessfulState(comments));
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetAllArticles(
      GetAllArticlesEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());

      dynamic data = await _articleUseCase.handleGetAllArticles(event.query);
      List<ArticleModel> articles = [];
      for (var item in data) {
        articles.add(ArticleModel.fromJson(item));
      }
      emit(ArticlesSuccessfulState(articles));
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }

  void handleGetOneArticle(
      GetOneArticleEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());
      dynamic data = await _articleUseCase.handleGetOneArticle(event.id);
      ArticleModel articleModel = ArticleModel.fromJson(data);
      emit(OneArticleSuccessfulState(articleModel));
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }

  void handleLikeArticleById(
      LikeArticleByIdEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());
      await _articleUseCase.handleLikeArticleById(event.id);

      emit(LikeArticleByIdSuccessFullState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }

  void handleDislikeArticleById(
      DislikeArticleByIdEvent event, Emitter<ArticleState> emit) async {
    try {
      emit(ArticleLoadingState());
      await _articleUseCase.handleRemoveLikeArticleById(event.id);
      emit(DislikeArticleByIdSuccessFullState());
    } catch (e) {
      DioError err = e as DioError;
      emit(ArticleErrorState(error: err.response?.data["message"]));
    }
  }
}
