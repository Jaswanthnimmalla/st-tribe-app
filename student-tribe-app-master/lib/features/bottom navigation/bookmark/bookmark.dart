import 'package:architecture/core/bloc/event/events_bloc.dart';
import 'package:architecture/core/data/entity/create_booking_entity.dart';
import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:architecture/core/data/models/event/payment_model.dart';
import 'package:architecture/core/data/models/intership/intership_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';

@RoutePage()
class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  List<InternshipModel> internships = [];
  List<EventModel> events = [];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      if (controller.index == 0) {
        context.read<ProfileBloc>().add(
          const GetMyBookmarksEvent("bookmarkedInternships"),
        );
      } else {
        context.read<ProfileBloc>().add(
          const GetMyBookmarksEvent("bookmarkedEvents"),
        );
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileBloc>().add(
        const GetMyBookmarksEvent("bookmarkedInternships"),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            leading: GestureDetector(
              onTap: () {
                context.router.pop();
              },
              child: const Icon(Icons.arrow_back_ios),
            ),
            bottom: TabBar(
              controller: controller,
              tabs: const [
                Tab(
                  // icon: Icon(Icons.flight),
                  text: "Internships",
                ),
                Tab(text: "Events"),
              ],
            ),
            title: Text(
              'Bookmarks',
              style: AppTheme.bodyText3.copyWith(
                fontSize: 16.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is GetBookmarkedInternshipsSuccessState) {
                hideOverlayLoader(context);
                setState(() {
                  internships = state.internships;
                });
              } else if (state is GetBookmarkedEventsSuccessState) {
                hideOverlayLoader(context);
                setState(() {
                  events = state.events;
                });
              }
            },
            child: TabBarView(
              controller: controller,
              children: [
                internships.isEmpty
                    ? const EmptyPageGraphic(
                        message:
                            "No Bookmarks Found!\nPlease check back later!",
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.router.push(
                                IntershipDetailsRoute(
                                  id: internships[index].id!,
                                ),
                              );
                            },
                            child: IntershipCard(
                              internshipModel: internships[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Vspace(12);
                        },
                        itemCount: internships.length,
                      ),
                events.isEmpty
                    ? const EmptyPageGraphic(
                        message:
                            "No Bookmarks Found!\nPlease check back later!",
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 14,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              //!Resetting entity whenever event details click
                              context
                                      .read<EventBloc>()
                                      .createEventBookingEntity =
                                  CreateEventBookingEntity(
                                    payment: PaymentModel(),
                                    paymentMethod: "",
                                    tickets: [],
                                  );
                              //! Go to event details
                              context.router.push(
                                EventDetailsRoute(id: events[index].id!),
                              );
                            },
                            child: CommonEventCard(eventModel: events[index]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Vspace(12);
                        },
                        itemCount: events.length,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}
