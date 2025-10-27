part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();

  @override
  List<Object> get props => [];
}

class GetAllArticlesEvent extends ArticleEvent {
  final Map<String,dynamic> query;

  const GetAllArticlesEvent({this.query =const {}});
}

class GetOneArticleEvent extends ArticleEvent {
  final String id;
  const GetOneArticleEvent(this.id);
}

class GetMyArticle extends ArticleEvent {
  final String status;
  const GetMyArticle({this.status = "approved"});
}

class GetMyArticlesEvent extends ArticleEvent {
  final String status;
  const GetMyArticlesEvent({this.status = "approved"});
}

class CreateArticleEvent extends ArticleEvent {
  final String title;
  final String content;

  const CreateArticleEvent(this.title, this.content);
}

class UpdateArticleEvent extends ArticleEvent {
  final Map<String, dynamic> data;

  const UpdateArticleEvent(this.data);
}

class GetArticleCommentsEvent extends ArticleEvent {
  final String id;
  const GetArticleCommentsEvent(this.id);
}

class AddCommentsEvent extends ArticleEvent {
  final String id;
  final String comment;
  const AddCommentsEvent(this.id, this.comment);
}

class LikeCommentEvent extends ArticleEvent {
  final bool like;
  final String commentId;
  final String articleId;
  const LikeCommentEvent(this.like, this.articleId, this.commentId);
}

class LikeArticleByIdEvent extends ArticleEvent {
  final String id;

  const LikeArticleByIdEvent({required this.id});
}

class DislikeArticleByIdEvent extends ArticleEvent {
  final String id;

  const DislikeArticleByIdEvent({required this.id});
}



class DeleteArticleByIdEvent extends ArticleEvent {
  final String id;

  const DeleteArticleByIdEvent({required this.id});
}
