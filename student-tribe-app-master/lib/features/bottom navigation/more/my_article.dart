// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/bloc/article/article_bloc.dart';
import 'package:architecture/core/data/models/article.dart';
import 'package:architecture/core/presentation/widgets/app_dilogs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/presentation/widgets/popup_menu.dart';
import '../export.dart';

enum ReviewStatus { underReview, approved, notApproved }

@RoutePage()
class MyArticle extends StatefulWidget {
  const MyArticle({super.key});

  @override
  State<MyArticle> createState() => _MyArticleState();
}

class _MyArticleState extends State<MyArticle> {
  int selectedTab = 0;
  List<ArticleModel> list = [];

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  void getArticles() {
    context.read<ArticleBloc>().add(
      GetMyArticlesEvent(
        status: selectedTab == 0
            ? "approved"
            : selectedTab == 1
            ? "pending"
            : "draft",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarN(text: "My Articles"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(CreateArticle());
          // context.router.push(const MyArticle());
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ArticleBloc, ArticleState>(
        listener: (context, state) async {
          if (state is ArticleLoadingState) {
            showOverlayLoader(context);
            setState(() {
              list = [];
            });
          } else if (state is MyArticlesSuccessfulState) {
            hideOverlayLoader(context);
            setState(() {
              list = state.list;
            });
          } else if (state is ArticleCreatedSuccessfulState ||
              state is DeleteArticleByIdSuccessFullState) {
            getArticles();
          } else if (state is ArticleErrorState) {
            hideOverlayLoader(context);
            showErrorSnackbar(context, state.error);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CommonTabItem(
                      text: "Published Articles",
                      index: 0,
                      onTap: (p0) {
                        setState(() {
                          selectedTab = p0;
                        });
                        getArticles();
                      },
                      selectedIndex: selectedTab,
                    ),
                  ),
                  Expanded(
                    child: CommonTabItem(
                      text: "Under Review",
                      index: 1,
                      onTap: (p0) {
                        setState(() {
                          selectedTab = p0;
                        });
                        getArticles();
                      },
                      selectedIndex: selectedTab,
                    ),
                  ),
                  CommonTabItem(
                    text: "Draft",
                    index: 2,
                    onTap: (p0) {
                      setState(() {
                        selectedTab = p0;
                      });
                      getArticles();
                    },
                    selectedIndex: selectedTab,
                  ),
                ],
              ),
              const Vspace(20),
              selectedTab == 0
                  ? PublishedArticlesWidget(list)
                  : selectedTab == 1
                  ? UnderReviewWidget(list, status: ReviewStatus.approved)
                  : DraftWidget(list),
            ],
          ),
        ),
      ),
    );
  }
}

class DraftWidget extends StatelessWidget {
  final List<ArticleModel> list;
  const DraftWidget(this.list, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {},
        child: CommonArticleCard(
          items: [
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: const Text('Edit Article'),
              onTap: () {
                context.router.push(CreateArticle(articleModel: list[index]));
              },
            ),
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: const Text('Delete Article'),
              onTap: () {
                showConfirmDialog(
                  context: context,
                  message: 'Are you sure you want delete this article',
                  cancelTap: () {
                    context.router.pop();
                  },
                  confirmTap: () {
                    context.read<ArticleBloc>().add(
                      DeleteArticleByIdEvent(id: list[index].id),
                    );
                    context.router.pop();
                  },
                );
                // context.router.push(CreateArticle(articleModel: list[index]));
              },
            ),
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: const Text('Submit For Review'),
              onTap: () {
                context.read<ArticleBloc>().add(
                  UpdateArticleEvent({
                    "id": list[index].id,
                    "status": "pending",
                  }),
                );
              },
            ),
          ],
          list[index].id,
          list[index].title,
          list[index].content,
        ),
      ),
      separatorBuilder: (context, index) {
        return const Vspace(12);
      },
      itemCount: list.length,
    );
  }
}

class UnderReviewWidget extends StatelessWidget {
  final List<ArticleModel> list;
  const UnderReviewWidget(this.list, {Key? key, required this.status})
    : super(key: key);

  final ReviewStatus status;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => CommonArticleCard(
        items: [
          PopupMenuItem<SampleItem>(
            value: SampleItem.itemOne,
            child: const Text('Edit Article'),
            onTap: () {
              context.router.push(CreateArticle(articleModel: list[index]));
            },
          ),
          PopupMenuItem<SampleItem>(
            value: SampleItem.itemOne,
            child: const Text('Delete Article'),
            onTap: () {
              showConfirmDialog(
                context: context,
                message: 'Are you sure you want delete this article',
                cancelTap: () {
                  context.router.pop();
                },
                confirmTap: () {
                  context.read<ArticleBloc>().add(
                    DeleteArticleByIdEvent(id: list[index].id),
                  );
                },
              );
            },
          ),
        ],
        list[index].id,
        list[index].title,
        list[index].content,
        status: status,
      ),
      separatorBuilder: (context, index) {
        return const Vspace(12);
      },
      itemCount: list.length,
    );
  }
}

extension on StackRouter {
  void pop() {}
}

class CommonArticleCard extends StatelessWidget {
  final String title;
  final String content;
  final String id;
  final List<PopupMenuItem<SampleItem>> items;
  final ReviewStatus? status;

  const CommonArticleCard(
    this.id,
    this.title,
    this.content, {
    required this.items,
    super.key,
    this.status,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const Hspace(5),
            CustomPopUpMenuItem(items: items),
          ],
        ),
        const Vspace(1),
        Text(content, style: AppTheme.bodyText3.copyWith(fontSize: 12.sp)),
        // const Vspace(10),
        // if (status != null) ...[
        //   Text(
        //     status == ReviewStatus.underReview
        //         ? "Under Review"
        //         : status == ReviewStatus.notApproved
        //             ? "Not Approved"
        //             : "Approved",
        //     style: AppTheme.bodyText3.copyWith(
        //         fontSize: 12,
        //         color: status == ReviewStatus.underReview
        //             ? const Color(0xff818181)
        //             : status == ReviewStatus.notApproved
        //                 ? AppColors.primary
        //                 : Colors.green,
        //         fontWeight: FontWeight.w700),
        //   ),
        // ],
      ],
    );
  }
}

class PublishedArticlesWidget extends StatelessWidget {
  final List<ArticleModel> list;
  const PublishedArticlesWidget(this.list, {super.key});

  int returnTotalViews() {
    int views = 0;
    for (var element in list) {
      views += element.viewsCount;
    }
    return views;
  }

  int returnTotalComments() {
    int views = 0;
    for (var element in list) {
      views += element.commentsCount;
    }
    return views;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 22),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text("Total Views"),
                    Text(returnTotalViews().toString()),
                  ],
                ),
                Column(
                  children: [
                    const Text("Comments"),
                    Text(returnTotalComments().toString()),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Vspace(20),
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.router.push(MoreDetails(id: list[index].id));
              },
              child: PublishedArticleCard(list[index]),
            );
          },
          separatorBuilder: (context, index) {
            return const Vspace(12);
          },
          itemCount: list.length,
        ),
        // const ArticleCard(),
      ],
    );
  }
}

class CommonTabItem extends StatelessWidget {
  const CommonTabItem({
    Key? key,
    required this.text,
    required this.onTap,
    required this.index,
    required this.selectedIndex,
  }) : super(key: key);
  final String text;
  final Function(int) onTap;
  final int index;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: text,
      onTap: () {
        onTap(index);
      },
      color: index == selectedIndex ? AppColors.primary : AppColors.white,
      borderColor: index == selectedIndex ? AppColors.primary : AppColors.white,
      textColor: index == selectedIndex ? AppColors.white : AppColors.black,
      fontsize: 14.sp,
      padding: EdgeInsets.zero,
      innerPadding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(vertical: 4, horizontal: 13),
      ),
    );
  }
}
