import 'package:architecture/core/bloc/article/article_bloc.dart';
import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/bloc/event/events_bloc.dart';
import 'package:architecture/core/bloc/intership/intership_bloc.dart';
import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:architecture/core/data/models/intership/intership_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../core/data/models/article.dart';
import '../../../core/data/models/user.dart';
import '../export.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userModel;
  List<InternshipModel>? internshipList;
  List<ArticleModel>? articles;
  List<EventModel>? eventList;
  bool showTopCard = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<ProfileBloc>().add(const GetMyProfileEvent());
    context.read<InternshipBloc>().add(GetInternshipsEvent());
    context
        .read<EventBloc>()
        .add(GetAllEvents(sortBy: const {"sort": "-createdAt"}));
    context.read<ArticleBloc>().add(const GetAllArticlesEvent(
        query: {"sort": "-createdAt", "limit": "5", "page": 1}));

    context
        .read<EventBloc>()
        .add(GetAllEvents(sortBy: const {"sort": "-createdAt"}));
    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission(true);
    super.didChangeDependencies();
  }

  void oneSignalLogin() {
    var externalId = context
        .read<ProfileBloc>()
        .userModel!
        .id; // You will supply the external id to the OneSignal SDK
    OneSignal.login(externalId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 17).r,
        child: MultiBlocListener(
          listeners: [
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoadingState) {
                  showOverlayLoader(context);
                } else if (state is GetMyProfileSuccessFullState) {
                  hideOverlayLoader(context);
                  setState(() {
                    userModel = state.userModel;
                  });
                } else if (state is ProfileErrorState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                }
              },
            ),
            BlocListener<InternshipBloc, InternshipState>(
              listener: (context, state) {
                if (state is InternshipLoadingState) {
                  showOverlayLoader(context);
                } else if (state is GetInternshipsSuccessFullState) {
                  hideOverlayLoader(context);
                  setState(() {
                    internshipList = state.internships;
                  });
                } else if (state is InternshipErrorState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                } else if (state is ApplyInternShipSuccessState) {
                  hideOverlayLoader(context);
                  // showSnackbar(context, "InternShip Apply SuccessFully");
                }
              },
            ),
            BlocListener<ArticleBloc, ArticleState>(
              listener: (context, state) {
                if (state is ArticleLoadingState) {
                  showOverlayLoader(context);
                } else if (state is ArticlesSuccessfulState) {
                  hideOverlayLoader(context);
                  setState(() {
                    articles = state.list;
                  });
                } else if (state is ArticleErrorState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                }
              },
            ),
            BlocListener<EventBloc, EventState>(
              listener: (context, state) {
                if (state is EventLoadingState) {
                  showOverlayLoader(context);
                } else if (state is GetAllEventsSuccessFullState) {
                  hideOverlayLoader(context);
                  setState(() {
                    eventList = state.events;
                  });
                } else if (state is EventErrorState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                }
              },
            )
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Vspace(18),
              showTopCard
                  ? Visibility(
                      visible: userModel?.profileCompletionPercentage != 100,
                      child: TopCard(
                        updateState: () {},
                        onCancel: () {
                          showTopCard = false;
                          setState(() {});
                        },
                        userModel: userModel,
                      ),
                    )
                  : const SizedBox(),
              // const Vspace(50),
              // const RowLabel(
              //   text1: "Upcoming Events",
              //   text2: "See all",
              // ),
              // const Vspace(14),
              // const CommonEventCard(),

              if (eventList != null && eventList!.isNotEmpty) ...[
                const Vspace(27),
                RowLabel(
                  text1: "Upcoming Events",
                  text2: "See all",
                  onTap: () {
                    context
                        .read<AuthBloc>()
                        .add(const UpdateBottomNavigationIndex(1));
                  },
                ),
                const Vspace(14),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            if (isDateExpired(eventList![index].endDate)) {
                              return;
                            }
                            context.router.push(
                                EventDetailsRoute(id: eventList![index].id!));
                          },
                          child:
                              CommonEventCard(eventModel: eventList![index]));
                    },
                    separatorBuilder: (context, index) => const Vspace(10),
                    itemCount: eventList!.length >= 6 ? 5 : eventList!.length)
              ],

              if (internshipList != null && internshipList!.isNotEmpty) ...[
                const Vspace(27),
                RowLabel(
                  text1: "Latest Internships",
                  text2: "See all",
                  onTap: () {
                    context
                        .read<AuthBloc>()
                        .add(const UpdateBottomNavigationIndex(2));
                  },
                ),
                const Vspace(11),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            if (isDateExpired(
                                internshipList![index].expiryDate)) {
                              return;
                            }
                            context.router.push(IntershipDetailsRoute(
                                id: internshipList![index].id!));
                          },
                          child: IntershipCard(
                              internshipModel: internshipList![index]));
                    },
                    separatorBuilder: (context, index) => const Vspace(10),
                    itemCount: internshipList!.length >= 6
                        ? 5
                        : internshipList!.length),
                const Vspace(32),
              ],
              if (articles != null && articles!.isNotEmpty) ...[
                const Vspace(27),
                RowLabel(
                  text1: "Articles",
                  text2: "See all",
                  onTap: () {
                    context
                        .read<AuthBloc>()
                        .add(const UpdateBottomNavigationIndex(3));
                  },
                ),
                const Vspace(14),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            context.router
                                .push(MoreDetails(id: articles![index].id));
                          },
                          child: ArticleCard(article: articles![index]));
                    },
                    separatorBuilder: (context, index) => const Vspace(10),
                    itemCount: articles!.length >= 6 ? 5 : articles!.length)
              ],

              // const Vspace(42),
              // const RowLabel(
              //   text1: "Communities",
              //   text2: "See all",
              // ),
              // const Vspace(14),
              // const CommunityCard(),
              const Vspace(80)
            ],
          ),
        ),
      ),
    );
  }
}
