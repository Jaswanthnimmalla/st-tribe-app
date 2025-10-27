// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:architecture/core/bloc/event/events_bloc.dart';
import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/data/entity/create_booking_entity.dart';
import '../../../core/data/models/event/payment_model.dart';
import '../../../core/data/models/event/ticket_model.dart';
import '../export.dart';
import '../widgets/proceed_tap_button.dart';

@RoutePage()
class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  EventModel? eventModel;

  @override
  void initState() {
    super.initState();

    //! Resetting this entity for every new event
    context
        .read<EventBloc>()
        .createEventBookingEntity = CreateEventBookingEntity(
      payment: PaymentModel(),
      paymentMethod: "",
      tickets: [],
      attendees: [],
    );
  }

  @override
  void didChangeDependencies() {
    context.read<EventBloc>().add(GetEventByIdEvent(id: widget.id));
    super.didChangeDependencies();
  }

  Future<dynamic> createLink() async {
    showOverlayLoader(context);
    await generateLink(
      context,
      BranchUniversalObject(
        canonicalIdentifier: 'studenttribebranch/app',
        title: eventModel?.title ?? "",
        contentDescription: '',
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata('eventId', widget.id),
        keywords: ['Plugin', 'Branch', 'Flutter'],
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

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarN(
        text: "",
        action: [
          IconButton(
            onPressed: () {
              createLink();
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocListener<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventLoadingState) {
              showOverlayLoader(context);
            } else if (state is GetEventByIdSuccessFullState) {
              hideOverlayLoader(context);
              setState(() {
                eventModel = state.event;
                if (eventModel!.tickets != null &&
                    eventModel!.tickets!.isNotEmpty) {
                  eventModel!.tickets![0].qty =
                      eventModel!.tickets![0].qty! + 1;
                  eventModel!.tickets![0].showPrice =
                      eventModel!.tickets![0].price!;
                }
              });
            } else if (state is EventErrorState) {
              hideOverlayLoader(context);
              showErrorSnackbar(context, state.error);
            }
          },
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoadingState) {
                showOverlayLoader(context);
              } else if (state is BookmarkAddedSuccessState) {
                hideOverlayLoader(context);
                if (eventModel?.bookmarked == false) {
                  showSuccessSnackbar(context, "Bookmark Added Successfully");
                }
                context.read<EventBloc>().add(GetEventByIdEvent(id: widget.id));
              } else if (state is ProfileErrorState) {
                hideOverlayLoader(context);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                eventModel?.coverImg == null || eventModel!.coverImg!.isEmpty
                    ? const SizedBox()
                    : SafeArea(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 25,
                          ),
                          height: 216,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(eventModel!.coverImg!),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // GestureDetector(
                                //   onTap: () {
                                //     context.router.pop();
                                //   },
                                //   child: const Icon(
                                //     Icons.arrow_back_ios,
                                //     color: Colors.white,
                                //   ),
                                // ),
                                // Icon(
                                //   Icons.share,
                                //   color: Colors.white,
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Vspace(21),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Featured",
                            style: AppTheme.bodyText3.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<ProfileBloc>().add(
                                AddToBookmarksEvent("event", widget.id),
                              );
                            },
                            child: Icon(
                              (eventModel?.bookmarked ?? false)
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                      const Vspace(3),
                      Text(
                        eventModel?.title ?? "",
                        style: AppTheme.bodyText2.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Vspace(28),
                      Text(
                        "Details",
                        style: AppTheme.bodyText3.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Vspace(8),
                      if (eventModel?.startDate != null) ...[
                        IconTextRowWidget(
                          text: DateFormat("MMMM d").format(
                            DateTime.parse(eventModel!.startDate!).toLocal(),
                          ),
                          appImages: AppImages.calendra,
                          hspace: 12,
                        ),
                        IconTextRowWidget(
                          text: DateFormat("h:mm a").format(
                            DateTime.parse(eventModel!.startDate!).toLocal(),
                          ),
                          hspace: 12,
                        ),
                        const Vspace(8),
                      ],
                      eventModel?.location?.addressLine1 == null ||
                              eventModel!.location!.addressLine1!.isEmpty
                          ? const SizedBox()
                          : IconTextRowWidget(
                              // text:
                              //     "Manipal University, Dehmi Kalan, Jaipur, Rajasthan",
                              text:
                                  "${eventModel?.location?.addressLine1 ?? ""} ${eventModel?.location?.addressLine2 ?? ""} ${eventModel?.location?.city ?? ""} ${eventModel?.location?.state ?? ""}",
                              appImages: AppImages.location,
                              hspace: 15,
                            ),
                      eventModel?.location?.addressLine1 == null ||
                              eventModel!.location!.addressLine1!.isEmpty
                          ? const SizedBox(height: 20)
                          : const Vspace(41),
                      Text(
                        "Description",
                        style: AppTheme.bodyText3.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Vspace(11),
                      Text(
                        eventModel?.description ?? "",
                        style: AppTheme.bodyText3.copyWith(fontSize: 16.sp),
                      ),
                      const Vspace(21),
                      ImageAvatarWithName(
                        radius: 20,
                        imageUrl: eventModel?.coverImg,
                        text: eventModel?.hostName,
                      ),
                      const Vspace(32),
                      // Text(
                      //   "Comments(1)",
                      //   style: AppTheme.bodyText3.copyWith(
                      //       fontSize: 16, fontWeight: FontWeight.w700),
                      // ),
                      // const Vspace(17),
                      // CommentPostButton(
                      //   onTap: () {
                      //     // context.router.push(const CommentRoute());
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          eventModel?.previousBookingId != null &&
              eventModel!.previousBookingId!.isNotEmpty
          ? PrimaryButton(
              text: "View Booking",
              onTap: () {
                context.router.push(const MyEvents());
              },
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            )
          : ProceedTap(
              // isShowDivider: true,
              leftTitle: "Ticket Price",
              isShowSubtitleText: true,
              amountString:
                  eventModel == null ||
                      eventModel?.tickets == null ||
                      eventModel!.tickets!.isEmpty
                  ? ""
                  : formattedCurrency(
                      num.tryParse(eventModel!.tickets![0].price!.toString())!,
                    ),
              onTap: () {
                if (eventModel!.previousBookingId == null &&
                    eventModel!.pendingOrderId != null) {
                  showErrorSnackbar(
                    context,
                    "Payment Pending: Your transaction is currently being processed. Please wait a moment while we finalize your payment and kindly don’t initiate any new request. Thank you for your patience.",
                  );
                  return;
                }
                showQuantityPicker(context);
              },
            ),
    );
  }

  void showQuantityPicker(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
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
            return Padding(
              padding: const EdgeInsets.only(
                left: 26,
                right: 26,
                top: 38,
                bottom: 0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      const Text("Select Quantity"),
                      // GestureDetector(
                      //     onTap: () {
                      //       context.router.pop();
                      //     },
                      //     child: const Icon(Icons.close))
                      GestureDetector(
                        onTap: () {
                          context.router.pop();
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/backgroundcrosssvg.svg",
                            ),
                            SvgPicture.asset("assets/svg/scrossvg.svg"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Vspace(28),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // if (eventModel!.tickets![index].showPrice == 0) {
                      //   eventModel!.tickets![index].showPrice =
                      //       eventModel!.tickets![index].price ?? 0;
                      // }
                      return Column(
                        children: [
                          Text(
                            eventModel?.tickets?[index].title ?? "",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Vspace(7),
                          CommonQuantitySelector(
                            amount: double.tryParse(
                              eventModel!.tickets![index].price.toString(),
                            )!,
                            decrease: () {
                              setState(() {
                                if (eventModel!.tickets![index].qty! > 0) {
                                  eventModel!.tickets![index].qty =
                                      eventModel!.tickets![index].qty! - 1;
                                  eventModel!.tickets![index].showPrice =
                                      eventModel!.tickets![index].showPrice -
                                      eventModel!.tickets![index].price!;
                                }
                              });
                            },
                            increase: () {
                              setState(() {
                                eventModel!.tickets![index].qty =
                                    eventModel!.tickets![index].qty! + 1;
                                eventModel!.tickets![index].showPrice =
                                    eventModel!.tickets![index].qty! *
                                    eventModel!.tickets![index].price!;
                              });
                            },
                            quantity: eventModel!.tickets![index].qty!,
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const Vspace(10),
                    itemCount: eventModel?.tickets?.length ?? 0,
                  ),
                  const Vspace(20),
                  ProceedTap(
                    leftTitle: "Total Price",
                    padding: EdgeInsets.zero,
                    isBoxShadowRequired: false,
                    amountString:
                        eventModel?.tickets == null ||
                            eventModel!.tickets!.isEmpty
                        ? ""
                        : formattedCurrency(
                            calulateTotalPrice(eventModel?.tickets),
                          ),
                    onTap: () {
                      if (eventModel?.tickets != null) {
                        for (int i = 0; i < eventModel!.tickets!.length; i++) {
                          if (eventModel!.tickets![i].qty! > 0) {
                            context.read<EventBloc>().createEventBookingEntity =
                                CreateEventBookingEntity(
                                  payment: PaymentModel(),
                                  paymentMethod: "",
                                  tickets: [],
                                  attendees: [],
                                );

                            context
                                .read<EventBloc>()
                                .createEventBookingEntity
                                .tickets!
                                .add(
                                  TicketModel(
                                    qty: eventModel!.tickets![i].qty!,
                                    ticket: eventModel!.tickets![i].id,
                                  ),
                                );
                          }
                        }
                      }

                      if (checkIfNotAnyTicketSelected(eventModel?.tickets) ==
                          false) {
                        showErrorSnackbar(
                          context,
                          "please select atleast 1 quantity for a ticket",
                        );
                        return;
                      }
                      // if (totalTicketsQty == 1) {
                      //   context.router.push(BuyTicketRoute(
                      //     totalPrice:
                      //         1, // calulateTotalPrice(eventModel!.tickets),
                      //     eventModel: eventModel!,
                      //     screenType: ScreenType.EVENT,
                      //   ));
                      // } else {

                      context.router.push(
                        CheckOutRoute(
                          totalPrice: calulateTotalPrice(eventModel!.tickets),
                          screenType: ScreenType.EVENT,
                          eventModel: eventModel!,
                        ),
                      );
                      // }
                    },
                  ),
                  const Vspace(20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  bool checkIfNotAnyTicketSelected(List<TicketModel>? list) {
    if (list != null && list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        if (list[i].qty! > 0) {
          return true;
        }
      }
    }
    return false;
  }

  int calulateTotalPrice(List<TicketModel>? list) {
    int totalPrice = 0;

    if (list != null && list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        totalPrice += list[i].showPrice;
      }
    }

    // if (list != null && list.isNotEmpty) {
    //   if (totalPrice == 0) {
    //     totalPrice = list[0].price!;
    //   }
    // }

    return totalPrice;
  }
}

extension on StackRouter {
  void pop() {}
}
