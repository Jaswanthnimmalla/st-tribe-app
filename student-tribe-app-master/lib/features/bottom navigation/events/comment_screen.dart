import 'package:architecture/core/bloc/article/article_bloc.dart';
import 'package:architecture/core/data/models/comment.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/presentation/widgets/border_textfield.dart';
import '../export.dart';

@RoutePage()
class CommentScreen extends StatefulWidget {
  final String articleId;
  const CommentScreen(this.articleId, {super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<CommentModel> comments = [];
  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(GetArticleCommentsEvent(widget.articleId));
  }

  void callArticleApis() {
    // context
    //     .read<ArticleBloc>()
    //     .add(const GetAllArticlesEvent(query: {
    //       "sort":"-createdAt",

    //     }));
    context.read<ArticleBloc>().add(GetOneArticleEvent(widget.articleId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<ArticleBloc, ArticleState>(
          listener: (context, state) {
            if (state is ArticleLoadingState) {
              showOverlayLoader(context);
            } else if (state is CommentsSuccessfulState) {
              hideOverlayLoader(context);
              setState(() {
                comments = state.list;
              });
              callArticleApis();
            } else if (state is CommentAddedSuccessfulState) {
              hideOverlayLoader(context);
              context
                  .read<ArticleBloc>()
                  .add(GetArticleCommentsEvent(widget.articleId));
              setState(() {
                commentController.text = "";
              });
            } else if (state is ArticleErrorState) {
              hideOverlayLoader(context);
              showErrorSnackbar(context, state.error);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 26),
                  color: AppColors.primary,
                  child: const CustomAppBar(
                    middleText: "Comments",
                    middleColor: AppColors.white,
                  ),
                ),
                const Vspace(18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Comments(${comments.length})",
                    style: AppTheme.bodyText3
                        .copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                const Vspace(25),
                ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 16,
                              foregroundImage:
                                  comments[index].author.profileImg.isEmpty
                                      ? null
                                      : NetworkImage(
                                          comments[index].author.profileImg),
                            ),
                            const Hspace(8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comments[index].author.name,
                                    style: AppTheme.bodyText3
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    DateFormat("MMM d, yyyy").format(
                                        comments[index].createdAt.toLocal()),
                                    style: AppTheme.bodyText3.copyWith(
                                        color: const Color(0xFF57423F)),
                                  ),
                                  const Vspace(14),
                                  Text(
                                    comments[index].content,
                                    style: AppTheme.bodyText3
                                        .copyWith(fontSize: 16.sp),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<ArticleBloc>().add(
                                    LikeCommentEvent(
                                        !comments[index].likes.contains(context
                                            .read<ProfileBloc>()
                                            .userModel
                                            ?.id),
                                        widget.articleId,
                                        comments[index].id));
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Image.asset(
                                  AppImages.heart,
                                  height: 16,
                                  width: 17,
                                  color: !comments[index].likes.contains(context
                                          .read<ProfileBloc>()
                                          .userModel
                                          ?.id)
                                      ? null
                                      : AppColors.primary,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Hspace(3),
                            Text(
                              "${comments[index].likes.length}",
                              style: AppTheme.bodyText3
                                  .copyWith(color: const Color(0xFF57423F)),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Vspace(20),
                    itemCount: comments.length)
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            // height: kToolbarHeight,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19484848),
                  blurRadius: 10,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                    child: BorderedTextFormField(
                  hintText: "Add a Comment",
                  noBorder: true,
                  controller: commentController,
                )),
                GestureDetector(
                  onTap: () {
                    print(commentController.text.length);
                    if (commentController.text.length > 3) {
                      context.read<ArticleBloc>().add(AddCommentsEvent(
                          widget.articleId, commentController.text));
                    }
                  },
                  child: Text(
                    "Post",
                    style: AppTheme.bodyText3.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
