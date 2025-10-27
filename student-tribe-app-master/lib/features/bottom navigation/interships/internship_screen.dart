import 'package:architecture/core/data/models/intership/intership_model.dart';

import '../../../core/bloc/intership/intership_bloc.dart';
import '../export.dart';

@RoutePage()
class IntershipScreen extends StatefulWidget {
  const IntershipScreen({super.key});

  @override
  State<IntershipScreen> createState() => _IntershipScreenState();
}

class _IntershipScreenState extends State<IntershipScreen> {
  bool allInterships = true;
  bool mostRecent = false;
  bool highToLowStipend = false;
  bool fullTime = false;
  bool recommended = false;
  List<InternshipModel> internshipsList = [];
  Map<String, dynamic> sortBy = {};
  bool loaded = false;
  int pageSize = 1;
  bool fetchMore = false;
  @override
  void didChangeDependencies() {
    callInternshipApi();
    super.didChangeDependencies();
  }

  Future<void> _fetchMore() async {
    pageSize = pageSize + 1;
    fetchMore = true;
    callInternshipApi();
  }

  void callInternshipApi() {
    context.read<InternshipBloc>().add(
      GetInternshipsEvent(sortBy: {"page": pageSize, "limit": 20}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0) {
            if (notification.metrics.atEdge) {
              bool isTop = notification.metrics.pixels == 0;
              if (isTop) {
                print('At the top');
              } else {
                print('At the bottom');

                _fetchMore();
              }
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          child: BlocConsumer<InternshipBloc, InternshipState>(
            listener: (context, state) {
              if (state is InternshipLoadingState) {
                showOverlayLoader(context);
              } else if (state is GetInternshipsSuccessFullState) {
                loaded = true;
                hideOverlayLoader(context);
                setState(() {
                  if (fetchMore) {
                    internshipsList.addAll(state.internships);
                    fetchMore = false;
                  } else {
                    internshipsList = state.internships;
                  }
                });
              } else if (state is InternshipErrorState) {
                hideOverlayLoader(context);
                showErrorSnackbar(context, state.error);
              } else if (state is ApplyInternShipSuccessState) {
                hideOverlayLoader(context);
                // showSnackbar(context, "InternShip Apply SuccessFully");
                context.read<InternshipBloc>().add(GetInternshipsEvent());
              }
            },
            builder: (context, state) {
              return Column(
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
                        const Hspace(14),
                        Expanded(
                          child: PrimaryButton(
                            innerPadding: MaterialStatePropertyAll(
                              const EdgeInsets.symmetric(vertical: 14),
                            ),
                            text: "Filter",
                            onTap: () {
                              context.router.push(const IntershipFilterRoute());
                            },
                            frontIcon: Image.asset(AppImages.filter),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Vspace(30),
                  internshipsList.isEmpty && loaded
                      ? const EmptyPageGraphic(
                          message:
                              "No Internships Found!\nPlease check back later!",
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (isDateExpired(
                                  internshipsList[index].expiryDate,
                                )) {
                                  return;
                                }

                                context.router.push(
                                  IntershipDetailsRoute(
                                    id: internshipsList[index].id!,
                                  ),
                                );
                              },
                              child: IntershipCard(
                                internshipModel: internshipsList[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Vspace(12);
                          },
                          itemCount: internshipsList.length,
                        ),
                  Vspace(80),
                ],
              );
            },
          ),
        ),
      ),
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
                buildRow("All Internships", allInterships, (p0) {
                  setState(() {
                    allInterships = p0;
                    if (allInterships) {
                      sortBy["sort"] = "";
                    }
                  });
                }),
                buildRow("Most Recent", mostRecent, (p0) {
                  setState(() {
                    mostRecent = p0;
                    if (mostRecent) {
                      sortBy["sort"] = "-createdAt";
                    }
                  });
                }),
                buildRow("High to low stipend", highToLowStipend, (p0) {
                  setState(() {
                    highToLowStipend = p0;
                    if (highToLowStipend) {
                      sortBy["sort"] = "-compensation.amount";
                    }
                  });
                }),
                buildRow("Full Time", fullTime, (p0) {
                  setState(() {
                    fullTime = p0;
                    if (fullTime) {
                      sortBy["type"] = "full-time";
                    }
                  });
                }),
                // buildRow("Recommended", recommended, (p0) {
                //   setState(
                //     () {
                //       recommended = p0;
                //       if (recommended) {
                //         sortBy["sort"] = "sort";
                //       }
                //     },
                //   );
                // }),
              ],
              clearAll: () {
                setState(() {
                  allInterships = false;
                  mostRecent = false;
                  highToLowStipend = false;
                  recommended = false;
                  fullTime = false;
                  context.router.pop();
                });
              },
              done: () {
                context.read<InternshipBloc>().add(
                  GetInternshipsEvent(sortBy: sortBy),
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
