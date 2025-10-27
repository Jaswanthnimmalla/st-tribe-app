// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:architecture/core/bloc/article/article_bloc.dart';
import 'package:architecture/core/data/models/article.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../core/presentation/widgets/app_dilogs.dart';
import '../../../core/presentation/widgets/popup_menu.dart';
import '../export.dart';
import '../widgets/comment_post_button.dart';

@RoutePage()
class MoreDetails extends StatefulWidget {
  final String id;
  const MoreDetails(this.id, {super.key});

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  ArticleModel? article;
  String reportMessage = "";

  BranchLinkProperties lp = BranchLinkProperties();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ArticleBloc>().add(GetOneArticleEvent(widget.id));
  }

  bool checkIfArticleLiked() {
    if (article?.likes != null && article!.likes.isNotEmpty) {
      if (article!.likes.indexWhere(
            (element) => element == context.read<ProfileBloc>().userModel!.id,
          ) !=
          -1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ArticleBloc, ArticleState>(
        listener: (context, state) {
          if (state is ArticleLoadingState) {
            showOverlayLoader(context);
          } else if (state is OneArticleSuccessfulState) {
            hideOverlayLoader(context);
            setState(() {
              article = state.article;
            });
          } else if (state is ArticleErrorState) {
            hideOverlayLoader(context);
            showErrorSnackbar(context, state.error);
          } else if (state is LikeArticleByIdSuccessFullState) {
            hideOverlayLoader(context);
            context.read<ArticleBloc>().add(GetOneArticleEvent(widget.id));
          } else if (state is DislikeArticleByIdSuccessFullState) {
            hideOverlayLoader(context);
            context.read<ArticleBloc>().add(GetOneArticleEvent(widget.id));
          }
        },
        child: article == null
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Vspace(10),
                          CustomAppBar(
                            arrowColor: AppColors.black,
                            rightWidget: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppBarIcons(
                                  iconData: checkIfArticleLiked()
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 30,
                                  color: checkIfArticleLiked()
                                      ? AppColors.primary
                                      : null,
                                  onTap: () {
                                    if (checkIfArticleLiked()) {
                                      context.read<ArticleBloc>().add(
                                        DislikeArticleByIdEvent(id: widget.id),
                                      );
                                    } else {
                                      context.read<ArticleBloc>().add(
                                        LikeArticleByIdEvent(id: widget.id),
                                      );
                                    }
                                  },
                                ),
                                const Hspace(15),
                                AppBarIcons(
                                  iconData: Icons.share_outlined,
                                  onTap: () {
                                    showOverlayLoader(context);
                                    // BranchLinkProperties lp =
                                    //     BranchLinkProperties(
                                    //         channel: 'facebook',
                                    //         feature: 'sharing',
                                    //         stage: 'new share',
                                    //         campaign: 'campaign');
                                    // lp.addControlParam(
                                    //     '\$uri_redirect_mode', '1');
                                    return generateLink(
                                      context,
                                      BranchUniversalObject(
                                        canonicalIdentifier:
                                            'studenttribebranch/app',
                                        title: article?.title ?? "",
                                        imageUrl: article?.thumbnailImg ?? "",
                                        contentDescription:
                                            'Article Description',
                                        contentMetadata: BranchContentMetaData()
                                          ..addCustomMetadata(
                                            'title',
                                            article?.title ?? "",
                                          )
                                          ..addCustomMetadata(
                                            'articleId',
                                            article?.id ?? "",
                                          )
                                          ..addCustomMetadata(
                                            'routeName',
                                            'articles',
                                          ),
                                        keywords: [
                                          'Plugin',
                                          'Branch',
                                          'Flutter',
                                        ],
                                        publiclyIndex: true,
                                        locallyIndex: true,
                                        expirationDateInMilliSec: DateTime.now()
                                            .add(const Duration(days: 365))
                                            .millisecondsSinceEpoch,
                                      ),
                                      BranchLinkProperties(
                                        channel: 'facebook',
                                        feature: 'sharing',
                                        stage: 'new share',
                                        campaign: 'campaign',
                                      ),
                                      true,
                                    );
                                  },
                                ),
                                // Hspace(15),
                                // Icon(Icons.bookmark_outline),
                              ],
                            ),
                          ),
                          const Vspace(15),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 17.5,
                                  foregroundImage:
                                      article == null ||
                                          article!.thumbnailImg.isEmpty
                                      ? null
                                      : NetworkImage(
                                          article!.author.profileImg,
                                        ),
                                ),
                                const Hspace(8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article!.author.name,
                                        style: AppTheme.bodyText3.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      const Vspace(2),
                                      Text(
                                        DateFormat(
                                          'MMM d',
                                        ).format(article!.createdAt),
                                        style: AppTheme.bodyText3.copyWith(
                                          color: const Color(0xFF57423F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // PrimaryButton(
                                //   text: "Follow",
                                //   padding: EdgeInsets.zero,
                                //   innerPadding: MaterialStateProperty.all(
                                //       const EdgeInsets.symmetric(
                                //           vertical: 7, horizontal: 15)),
                                //   onTap: () {},
                                // )
                              ],
                            ),
                          ),
                          const Vspace(18),
                          article!.tag == null
                              ? Container()
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        width: 1,
                                        color: Color(0xFFCE202F),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    article!.tag!,
                                    style: AppTheme.bodyText3.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                          const Vspace(11),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              article!.title,
                              style: AppTheme.bodyText1.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const Vspace(20),
                          // Container(
                          //   margin: const EdgeInsets.symmetric(horizontal: 30),
                          //   child: Text(
                          //     article!.content,
                          //     style: AppTheme.bodyText1.copyWith(
                          //         fontSize: 18.sp,
                          //         fontWeight: FontWeight.w400,
                          //         color: const Color(0XFF515151)),
                          //   ),
                          // ),
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: article!.richContent.length,
                            itemBuilder: (context, index) =>
                                article!.richContent[index].type == 'txt'
                                ? HtmlWidget(
                                    article!.richContent[index].data,
                                    textStyle: AppTheme.bodyText3.copyWith(),
                                    onTapUrl: launchUrlString,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      showImageViewer(
                                        context,
                                        Image.network(
                                          "https://cdn.stumagz.com/images/${article!.richContent[index].data}stryimg",
                                        ).image,
                                        immersive: false,
                                        useSafeArea: true,
                                        swipeDismissible: true,
                                      );
                                    },
                                    child: Image.network(
                                      "https://cdn.stumagz.com/images/${article!.richContent[index].data}stryimg",
                                    ),
                                  ),
                            separatorBuilder: (_, __) => const Vspace(12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await context.router.push(
                              CommentRoute(articleId: widget.id),
                            );

                            // ignore: use_build_context_synchronously
                            context.read<ArticleBloc>().add(
                              GetOneArticleEvent(widget.id),
                            );
                          },
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: UnconstrainedBox(
                              child: Image.asset(
                                AppImages.comment2,
                                height: 18,
                                width: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const Hspace(7),
                        Text((article?.commentsCount ?? 0).toString()),
                        const Expanded(child: Hspace(0)),
                        CustomPopUpMenuItem(
                          items: [
                            PopupMenuItem<SampleItem>(
                              value: SampleItem.itemOne,
                              child: const Text('Report Article'),
                              onTap: () {
                                reportDialog(
                                  context: context,
                                  cancelTap: () {
                                    context.router.pop();
                                  },
                                  onChange: (p0) {
                                    setState(() {
                                      reportMessage = p0;
                                    });
                                  },
                                  reportTap: () async {
                                    if (reportMessage.isEmpty) {
                                      showErrorSnackbar(
                                        context,
                                        "please fill report field",
                                      );

                                      return;
                                    }
                                    showOverlayLoader(context);
                                    await Future.delayed(
                                      const Duration(seconds: 2),
                                      () {
                                        hideOverlayLoader(context);

                                        showSuccessMessage(
                                          context,
                                          message:
                                              "Article Reported SuccessFully",
                                        ).whenComplete(
                                          () => context.router.pop(),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CommentPostButton(
                        onTap: () async {
                          await context.router.push(
                            CommentRoute(articleId: widget.id),
                          );

                          // ignore: use_build_context_synchronously
                          context.read<ArticleBloc>().add(
                            GetOneArticleEvent(widget.id),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

extension on StackRouter {
  FutureOr<void> pop() {}
}
