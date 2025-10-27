// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/bloc/event/events_bloc.dart';

import '../../../core/data/entity/create_booking_entity.dart';
import '../../../core/data/models/event/event_model.dart';
import '../../../core/data/models/event/payment_model.dart';
import '../export.dart';

@RoutePage()
class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool allEvents = true;
  bool date = false;
  bool eventType = false;
  List<EventModel>? eventsList;

  Map<String, dynamic> sortBy = {};

  @override
  void didChangeDependencies() {
    context.read<EventBloc>().add(
      GetAllEvents(sortBy: const {"sort": "-createdAt"}),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventLoadingState) {
              showOverlayLoader(context);
            } else if (state is GetAllEventsSuccessFullState) {
              hideOverlayLoader(context);
              setState(() {
                eventsList = state.events;
              });
            } else if (state is EventErrorState) {
              hideOverlayLoader(context);
              showErrorSnackbar(context, state.error);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Vspace(19),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          innerPadding: MaterialStatePropertyAll(
                            const EdgeInsets.symmetric(vertical: 14),
                          ),
                          text: "Sort",
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
                      //     onTap: () {
                      //       context.router.push(const EventFilterRoute());
                      //     },
                      //     frontIcon: Image.asset(AppImages.filter),
                      //     padding: EdgeInsets.zero,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                // const Vspace(30),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 14),
                //   child: Text(
                //     "Categories",
                //     style: AppTheme.bodyText3
                //         .copyWith(fontWeight: FontWeight.w700),
                //   ),
                // ),
                // const Vspace(19),
                // SizedBox(
                //   height: 80,
                //   width: double.infinity,
                //   child: ListView.separated(
                //       padding: const EdgeInsets.symmetric(horizontal: 14),
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (context, index) {
                //         return const CategoriesWidget();
                //       },
                //       separatorBuilder: (context, index) {
                //         return const Hspace(13);
                //       },
                //       itemCount: 10),
                // ),
                const Vspace(19),
                if (!(eventsList != null && eventsList!.isEmpty))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      "Explore",
                      style: AppTheme.bodyText3.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                const Vspace(19),
                eventsList != null && eventsList!.isEmpty
                    ? const EmptyPageGraphic(
                        message: "No Events Found!\nPlease check back later!",
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        physics: const NeverScrollableScrollPhysics(),
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
                              if (isDateExpired(eventsList![index].endDate)) {
                                return;
                              }
                              context.router.push(
                                EventDetailsRoute(id: eventsList![index].id!),
                              );
                            },
                            child: CommonEventCard(
                              eventModel: eventsList![index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Vspace(12);
                        },
                        itemCount: eventsList?.length ?? 0,
                      ),
                const Vspace(80),
              ],
            );
          },
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
                buildRow("Event Type", eventType, (p0) {
                  setState(() {
                    eventType = p0;
                    if (allEvents) {
                      sortBy["sort"] = "-eventType";
                    }
                  });
                }),
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
                context.read<EventBloc>().add(GetAllEvents(sortBy: sortBy));
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
