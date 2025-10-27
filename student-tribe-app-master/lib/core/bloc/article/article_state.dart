part of 'article_bloc.dart';

sealed class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

final class ArticleInitialState extends ArticleState {}

final class ArticleLoadingState extends ArticleState {}

final class ArticleErrorState extends ArticleState {
  final String error;
  const ArticleErrorState({
    required this.error,
  });
}

final class ArticlesSuccessfulState extends ArticleState {
  final List<ArticleModel> list;
  const ArticlesSuccessfulState(this.list);
}

final class MyArticlesSuccessfulState extends ArticleState {
  final List<ArticleModel> list;
  const MyArticlesSuccessfulState(this.list);
}

final class CommentsSuccessfulState extends ArticleState {
  final List<CommentModel> list;
  const CommentsSuccessfulState(this.list);
}

final class CommentAddedSuccessfulState extends ArticleState {}

final class ArticleCreatedSuccessfulState extends ArticleState {}

final class OneArticleSuccessfulState extends ArticleState {
  final ArticleModel article;
  const OneArticleSuccessfulState(this.article);
}


class LikeArticleByIdSuccessFullState extends ArticleState{}
class DislikeArticleByIdSuccessFullState extends ArticleState{}

class DeleteArticleByIdSuccessFullState extends ArticleState{}