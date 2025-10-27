import 'package:architecture/core/bloc/article/article_bloc.dart';
import 'package:architecture/core/bloc/groupbyin/group_by_in_bloc.dart';
import 'package:architecture/core/data/models/article.dart';
import 'package:architecture/core/data/models/groupbyin.dart';

import '../export.dart';

@RoutePage()
class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  int selectedTab = 0;
  int pageSize = 1;
  List<ArticleModel> articles = [];
  List<GroupByInModel> groupByInList = [];
  bool allEvents = true;
  bool date = false;
  bool eventType = false;
  Map<String, dynamic> sortBy = {};
  String selectedArticleIndex = "";

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchMore() async {
    pageSize = pageSize + 1;
    callArticleApi();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    callArticleApi();
  }

  void callArticleApi() {
    int? tempPageSize;

    if (selectedArticleIndex.isNotEmpty) {
      int articleIndex = articles.indexWhere(
        (element) => element.id == selectedArticleIndex,
      );
      tempPageSize = (articleIndex ~/ 15) + 1;
    }

    context.read<ArticleBloc>().add(
      GetAllArticlesEvent(
        query: {
          "sort": "-createdAt",
          "limit": "15",
          "page": tempPageSize ?? pageSize.toString(),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ArticleBloc, ArticleState>(
            listener: (context, state) {
              if (state is ArticleLoadingState) {
                showOverlayLoader(context);
              } else if (state is ArticlesSuccessfulState) {
                hideOverlayLoader(context);
                setState(() {
                  if (state.list.isEmpty && pageSize > 1) {
                    return;
                  }

                  if (selectedArticleIndex.isNotEmpty) {
                    int articleIndex = articles.indexWhere(
                      (element) => element.id == selectedArticleIndex,
                    );
                    int articleIndexFromUpdatedList = state.list.indexWhere(
                      (element) => element.id == selectedArticleIndex,
                    );

                    articles[articleIndex] =
                        state.list[articleIndexFromUpdatedList];
                    selectedArticleIndex = "";
                    return;
                  }

                  articles.addAll(state.list);
                });
              } else if (state is ArticleErrorState) {
                hideOverlayLoader(context);
                showErrorSnackbar(context, state.error);
              }
            },
          ),
          BlocListener<GroupByInBloc, GroupByInState>(
            listener: (context, state) {
              if (state is GroupByInLoadingState) {
                showOverlayLoader(context);
              } else if (state is GetAllGroupByInSuccessFullState) {
                hideOverlayLoader(context);
                setState(() {
                  groupByInList = state.groupByInList;
                });
              } else if (state is GroupByInFailureState) {
                hideOverlayLoader(context);
                showErrorSnackbar(context, state.error);
              }
            },
          ),
        ],
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.extentAfter == 0) {
              if (notification.metrics.atEdge) {
                bool isTop = notification.metrics.pixels == 0;
                if (isTop) {
                  print('At the top');
                } else {
                  print('At the bottom');
                  if (selectedTab == 0) {
                    _fetchMore();
                  }
                }
              }
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Vspace(19),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          text: "Sort",
                          innerPadding: MaterialStatePropertyAll(
                            const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onTap: () {
                            showSortWidget(context);
                          },
                          frontIcon: Image.asset(AppImages.sort),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      // const Hspace(14),
                      // Expanded(
                      //   child: PrimaryButton(
                      //     text: "Filter",
                      //     onTap: () {},
                      //     frontIcon: Image.asset(AppImages.filter),
                      //     padding: EdgeInsets.zero,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const Vspace(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = 0;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Articles",
                              style: AppTheme.bodyText3.copyWith(
                                fontWeight: FontWeight.w700,
                                color: selectedTab == 0
                                    ? AppColors.primary
                                    : Colors.black,
                              ),
                            ),
                            const Vspace(7),
                            Visibility(
                              visible: selectedTab == 0,
                              child: Container(
                                height: 3,
                                color: AppColors.primary,
                                child: Text(
                                  "  Articles  ",
                                  style: AppTheme.bodyText3.copyWith(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Hspace(16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = 1;
                            context.read<GroupByInBloc>().add(
                              GetAllGroupByInEvent(),
                            );
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              "Group buy-ins",
                              style: AppTheme.bodyText3.copyWith(
                                fontWeight: FontWeight.w700,
                                color: selectedTab == 1
                                    ? AppColors.primary
                                    : Colors.black,
                              ),
                            ),
                            const Vspace(7),
                            Visibility(
                              visible: selectedTab == 1,
                              child: Container(
                                height: 3,
                                color: AppColors.primary,
                                child: Text(
                                  "Group buy-ins",
                                  style: AppTheme.bodyText3.copyWith(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Vspace(20),
                selectedTab == 0
                    ? articles.isEmpty
                          ? const EmptyPageGraphic(
                              message: "No Articles present",
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    selectedArticleIndex = articles[index].id;
                                    await context.router.push(
                                      MoreDetails(id: articles[index].id),
                                    );
                                    // articles=[];
                                    callArticleApi();
                                  },
                                  child: ArticleCard(article: articles[index]),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Vspace(12);
                              },
                              itemCount: articles.length,
                            )
                    : groupByInList.isEmpty
                    ? const EmptyPageGraphic(
                        message: "No Group Buy-Ins present",
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (groupByInList[index].status != "available" ||
                                  DateTime.parse(
                                    groupByInList[index].offerEndDate!,
                                  ).toLocal().isBefore(
                                    DateTime.now().toLocal(),
                                  ) ||
                                  groupByInList[index].sold >=
                                      groupByInList[index].target) {
                                return;
                              }
                              context.router.push(
                                GroupInDetailsRoute(
                                  id: groupByInList[index].id!,
                                ),
                              );
                            },
                            child: GroupBuyInCard(
                              groupByInModel: groupByInList[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Vspace(12);
                        },
                        itemCount: groupByInList.length,
                      ),
                Vspace(80),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // context.router.push(CreateArticle());
      //     context.router.push(const MyArticle());
      //   },
      //   backgroundColor: AppColors.primary,
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  void showSortWidget(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SortWidget(
              sortRowsList: [
                buildRow("All Events", allEvents, (p0) {
                  setState(() {
                    allEvents = p0;
                    if (allEvents) {
                      sortBy["sort"] = "-createdAt";
                    }
                  });
                }),
                buildRow("Date (Recent-old)", date, (p0) {
                  setState(() {
                    date = p0;
                    if (date) {
                      sortBy["sort"] = "-createdAt";
                    }
                  });
                }),
                // buildRow("Event Type", eventType, (p0) {
                //   setState(
                //     () {
                //       eventType = p0;
                //       if (allEvents) {
                //         sortBy["sort"] = "-eventType";
                //       }
                //     },
                //   );
                // }),
              ],
              clearAll: () {
                setState(() {
                  allEvents = false;
                  date = false;
                  eventType = false;
                  context.router.pop();
                });
              },
              done: () {
                context.read<ArticleBloc>().add(
                  const GetAllArticlesEvent(query: {"sort": "-createdAt"}),
                );
                context.router.pop();
              },
            );
          },
        );
      },
    );
  }
}

extension on StackRouter {
  void pop() {}
}
