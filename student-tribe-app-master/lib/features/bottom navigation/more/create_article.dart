import 'package:architecture/core/bloc/article/article_bloc.dart';
import 'package:architecture/core/data/models/article.dart';
import 'package:architecture/core/presentation/widgets/app_dilogs.dart';
import 'package:architecture/core/presentation/widgets/border_textfield.dart';

import '../export.dart';

@RoutePage()
class CreateArticle extends StatefulWidget {
  final ArticleModel? articleModel;
  const CreateArticle({this.articleModel, super.key});

  @override
  State<CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String barTitle = '';

  @override
  void initState() {
    super.initState();
    if (widget.articleModel != null) {
      titleController.text = widget.articleModel!.title;
      contentController.text = widget.articleModel!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ArticleBloc, ArticleState>(
        listener: (context, state) async {
          if (state is ArticleLoadingState) {
            showOverlayLoader(context);
          } else if (state is ArticleCreatedSuccessfulState) {
            hideOverlayLoader(context);
            await showSuccessMessage(
              context,
              message: "Article saved successfully!",
            );
            context.router.pop();
          } else if (state is ArticleErrorState) {
            hideOverlayLoader(context);
            showErrorSnackbar(context, state.error);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 26),
                color: AppColors.primary,
                child: CustomAppBar(
                  middleColor: Colors.white,
                  middleText: titleController.text,
                  rightText: "Submit",
                  rightTextOnTap: () async {
                    if (titleController.text.length <= 10) {
                      showErrorSnackbar(
                        context,
                        "Title must be more than 10 characters",
                      );
                      return;
                    }
                    if (contentController.text.length <= 50) {
                      showErrorSnackbar(
                        context,
                        "Content must be more than 50 characters",
                      );
                      return;
                    }
                    showConfirmDialog(
                      context: context,
                      message: 'Are you sure you want save this article',
                      cancelTap: () {
                        context.router.pop();
                      },
                      confirmTap: () {
                        context.router.pop();
                        if (widget.articleModel == null) {
                          context.read<ArticleBloc>().add(
                            CreateArticleEvent(
                              titleController.text,
                              contentController.text,
                            ),
                          );
                        } else {
                          context.read<ArticleBloc>().add(
                            UpdateArticleEvent({
                              "id": widget.articleModel!.id,
                              "title": titleController.text,
                              "content": contentController.text,
                            }),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BorderedTextFormField(
                  hintText: "Write title here...",
                  maxline: 2,
                  controller: titleController,
                  onChange: (val) {
                    setState(() {
                      barTitle = val;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BorderedTextFormField(
                  hintText: "Write Something here...",
                  minLines: 15,
                  maxline: null,
                  maxLength: 300,
                  controller: contentController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}
