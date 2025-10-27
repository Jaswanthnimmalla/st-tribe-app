// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/bloc/groupbyin/group_by_in_bloc.dart';
import 'package:architecture/core/presentation/widgets/app_divider.dart';
import 'package:architecture/core/presentation/widgets/border_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:architecture/core/bloc/event/events_bloc.dart';
import 'package:architecture/core/data/models/event/payment_model.dart';
import 'package:architecture/core/data/models/groupbyin.dart';
import 'package:architecture/core/data/models/stcoin.dart';

import '../../../core/data/models/event/event_model.dart';
import '../../../core/data/models/payment/payment_options_model.dart';
import '../export.dart';

@RoutePage()
class BuyTicketScreen extends StatefulWidget {
  const BuyTicketScreen({
    Key? key,
    this.eventModel,
    required this.totalPrice,
    required this.screenType,
    this.groupByInModel,
    this.stcoinModel,
    this.stPointQuantity,
    this.groupBuyInQty,
  }) : super(key: key);
  final EventModel? eventModel;
  final num totalPrice;
  final ScreenType screenType;
  final GroupByInModel? groupByInModel;
  final StcoinModel? stcoinModel;
  final int? stPointQuantity;
  final int? groupBuyInQty;
  @override
  State<BuyTicketScreen> createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  List<PaymentOptions> paymentOptions = [];
  int selectedIndex = -1;
  bool isStCoinCheckBoxSelected = true;
  TextEditingController stCoinController = TextEditingController();
  var razorpay = Razorpay();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.screenType == ScreenType.STCOINS) {
      isStCoinCheckBoxSelected = false;
    }
    stCoinController.text = min(
      num.parse(
        context.read<ProfileBloc>().userModel?.stCoins.toString() ?? '0',
      ),
      calulateTotalPrice() * 10,
    ).toString();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    if (widget.screenType == ScreenType.STCOINS) {
      paymentOptions = [
        PaymentOptions(
          image: AppImages.razorpayicon,
          paymentMethod: "RazorPay",
        ),
      ];
    } else {
      paymentOptions = [
        PaymentOptions(
          image: AppImages.razorpayicon,
          paymentMethod: "RazorPay",
        ),
        PaymentOptions(image: AppImages.stcoins, paymentMethod: "St Coins"),
      ];
    }
  }

  num calculateBookingPrice() {
    if (widget.screenType == ScreenType.EVENT) {
      num bookingPrice = widget.eventModel!.bookingPrice!;
      var calulateBookingPrice = widget.totalPrice * bookingPrice / 100;
      return calulateBookingPrice;
    }
    return 0;
  }

  num calulateTotalPrice() {
    if (widget.screenType == ScreenType.EVENT) {
      return widget.totalPrice + calculateBookingPrice();
    }

    return widget.totalPrice;
  }

  num handleTotalPayableBalance() {
    if (isStCoinCheckBoxSelected) {
      // return calulateTotalPrice() - (num.tryParse(stCoinController.text ?? "0") ?? 0);
      return calulateTotalPrice() -
          (num.tryParse(stCoinController.text) ?? 0) / 10;
    }
    return calulateTotalPrice();
  }

  int calculateTicketQuantity() {
    int quantity = 0;
    if (widget.eventModel!.tickets != null) {
      for (var i = 0; i < widget.eventModel!.tickets!.length; i++) {
        quantity += widget.eventModel!.tickets![i].qty!;
      }
    }
    return quantity;
  }

  void handleFreeEvent() {
    if (widget.screenType == ScreenType.EVENT) {
      setQuestionAndAnswersToEventEntity();
      context.read<EventBloc>().createEventBookingEntity.paymentMethod =
          "gateway";
      context.read<EventBloc>().createEventBookingEntity.payment = PaymentModel(
        bookingAmount: 0,
        ticketAmount: int.tryParse(widget.totalPrice.toString()),
        transactionId: "",
      );
      context.read<EventBloc>().add(
        CreateEventBookingEvent(id: widget.eventModel!.id!),
      );
    } else if (widget.screenType == ScreenType.GROUPBYIN) {
      context.read<GroupByInBloc>().add(
        CreateGroupBuyInBookingEvent(
          id: widget.groupByInModel!.id!,
          qty: widget.groupBuyInQty!,
          paymentMethod: "gateway",
          payment: {
            "buyInAmount": widget.totalPrice,
            "bookingAmount": 0,
            "transactionId": "",
          },
        ),
      );
    }
  }

  void setQuestionAndAnswersToEventEntity() {
    if (widget.eventModel?.questions != null &&
        widget.eventModel!.questions!.isNotEmpty) {
      context.read<EventBloc>().createEventBookingEntity.answers = widget
          .eventModel
          ?.questions
          ?.map((e) => {"questionId": e.id, "answer": e.answer})
          .toList();
    }
  }

  void callGetEventDetailsApi() {
    context.read<EventBloc>().add(
      GetEventByIdEvent(id: widget.eventModel!.id!, handleSilently: true),
    );
  }

  void callGetGroupByInDetailsApi() {
    context.read<GroupByInBloc>().add(
      GetGroupByInByIdEvent(
        id: widget.groupByInModel!.id!,
        handleSilently: true,
      ),
    );
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    if (widget.screenType == ScreenType.EVENT) {
      showOverlayLoader(context);
      _timer = Timer.periodic(
        Duration(seconds: 2),
        (Timer t) => callGetEventDetailsApi(),
      );
    } else if (widget.screenType == ScreenType.GROUPBYIN) {
      showOverlayLoader(context);
      _timer = Timer.periodic(
        Duration(seconds: 2),
        (Timer t) => callGetGroupByInDetailsApi(),
      );
    } else {
      context.read<ProfileBloc>().add(
        BuyStCoinEvent(transactionId: response.paymentId!),
      );
    }
  }

  void handlePaymentByStCoins() {
    if (widget.screenType == ScreenType.EVENT) {
      context.read<EventBloc>().createEventBookingEntity.paymentMethod =
          "stCoins";
      if (widget.eventModel?.questions != null &&
          widget.eventModel!.questions!.isNotEmpty) {
        context.read<EventBloc>().createEventBookingEntity.answers = widget
            .eventModel
            ?.questions
            ?.map((e) => {"questionId": e.id, "answer": e.answer})
            .toList();
      }
      context.read<EventBloc>().createEventBookingEntity.payment = PaymentModel(
        bookingAmount: calculateBookingPrice().toInt(),
        ticketAmount: int.tryParse(widget.totalPrice.toString()),
        transactionId: "",
      );

      context.read<EventBloc>().add(
        CreateEventBookingEvent(id: widget.eventModel!.id!),
      );
    } else if (widget.screenType == ScreenType.GROUPBYIN) {
      context.read<GroupByInBloc>().add(
        CreateGroupBuyInBookingEvent(
          id: widget.groupByInModel!.id!,
          qty: widget.groupBuyInQty!,
          paymentMethod: "stCoins",
          payment: {
            "buyInAmount": widget.totalPrice,
            "bookingAmount": 0,
            "transactionId": "",
          },
        ),
      );
    } else {
      // context
      //     .read<ProfileBloc>()
      //     .add(BuyStCoinEvent(transactionId: ""));
    }
  }

  void callMyProfileApi() {
    if (selectedIndex == 1) {
      context.read<ProfileBloc>().add(const GetMyProfileEvent());
    }
  }

  void handlePaymentError(PaymentFailureResponse response) {
    showErrorSnackbar(
      context,
      response.message ?? "Some error occurred! Please try again later!",
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {}

  @override
  void dispose() {
    razorpay.clear();
    _timer?.cancel();
    super.dispose();
  }

  void initiatePayment(String orderId, String key) {
    ProfileBloc profileBloc = context.read<ProfileBloc>();

    String title = "";
    if (widget.screenType == ScreenType.EVENT) {
      title = widget.eventModel!.title!;
    } else if (widget.screenType == ScreenType.GROUPBYIN) {
      title = widget.groupByInModel!.title!;
    } else {
      title = "St Coins";
    }

    razorpay.open({
      'key': "rzp_live_j0Zz5kUu2T38Ii",
      'amount': widget.totalPrice * 100,
      'name': "Student Tribe - $title",
      'order_id': orderId,
      'prefill': {
        'name': profileBloc.userModel?.name,
        'contact': profileBloc.userModel?.number,
        'email': profileBloc.userModel?.email,
      },
      'theme': {'color': '#CC202E'},
      'send_sms_hash': true,
    });
  }

  String location(EventModel? eventModel) {
    switch (eventModel?.location?.type) {
      case "virtual":
        return "";
      case "venue":
        return "${eventModel?.location?.addressLine1 ?? ""} ${eventModel?.location?.addressLine2 ?? ""} ${eventModel?.location?.city ?? ""} ${eventModel?.location?.state ?? ""}";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarN(text: "Payment Review"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MultiBlocListener(
          listeners: [
            BlocListener<EventBloc, EventState>(
              listener: (context, state) {
                if (state is EventLoadingState) {
                  showOverlayLoader(context);
                } else if (state is GetRzpSuccessState) {
                  hideOverlayLoader(context);
                  initiatePayment(state.orderId, state.rzpKey);
                } else if (state is CreateEventBookingSuccessFullState) {
                  hideOverlayLoader(context);
                  if (selectedIndex == 1) {
                    context.read<ProfileBloc>().add(
                      const GetMyProfileEvent(handleSilently: true),
                    );
                  }
                  showSuccessMessage(
                    context,
                    message: "Event Successfully Booked!",
                  ).then((value) {
                    context.router.replaceAll([
                      const BottomNavigationRoute(),
                      const MyEvents(),
                    ]);
                  });
                } else if (state is EventErrorState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                } else if (state is GetEventByIdSuccessFullState) {
                  if (state.event.previousBookingId != null) {
                    stopTimer();
                    hideOverlayLoader(context);
                    showSuccessMessage(
                      context,
                      message: "Event Successfully Booked!",
                    ).then((value) {
                      context.router.replaceAll([
                        const BottomNavigationRoute(),
                        const MyEvents(),
                      ]);
                    });
                    // handlePaymentSuccessForEvents(
                    //     state.event.previousBookingId!);
                  }
                }
              },
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoadingState) {
                  showOverlayLoader(context);
                } else if (state is BuyStCoinSuccessFullState) {
                  hideOverlayLoader(context);
                  showSuccessMessage(
                    context,
                    message: "ST Coin Purchase was successful!",
                  ).then((value) {
                    context.read<AuthBloc>().add(
                      const UpdateBottomNavigationIndex(0),
                    );
                    context.router.popUntilRoot();
                    context.read<ProfileBloc>().add(const GetMyProfileEvent());
                  });
                } else if (state is ProfileErrorState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                }
              },
            ),
            BlocListener<GroupByInBloc, GroupByInState>(
              listener: (context, state) {
                if (state is GroupByInLoadingState) {
                  showOverlayLoader(context);
                } else if (state is GroupByInPurchaseSuccessState) {
                  hideOverlayLoader(context);
                  if (selectedIndex == 1) {
                    context.read<ProfileBloc>().add(
                      const GetMyProfileEvent(handleSilently: true),
                    );
                  }
                  showSuccessMessage(
                    context,
                    message: "Group Buy In bought successfully!",
                  ).then((value) {
                    context.router.popUntilRoot();
                  });
                } else if (state is GroupByInFailureState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                } else if (state is GetGroupByInByIdSuccessFullState) {
                  if (state.groupByIn.purchased == true) {
                    stopTimer();
                    hideOverlayLoader(context);
                    showSuccessMessage(
                      context,
                      message: "Group Buy In bought successfully!",
                    ).then((value) {
                      context.router.popUntilRoot();
                    });
                  }
                }
              },
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Vspace(24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: shapeDecoration(),
                child: Column(
                  children: [
                    const Label(text1: "Payment Details"),
                    const Vspace(29),
                    if (widget.screenType == ScreenType.EVENT) ...[
                      Label(
                        text1: "${calculateTicketQuantity()} Ticket",
                        labelfontWeight: FontWeight.w400,
                        fontsize: 12.sp,
                      ),
                      const Vspace(7),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.screenType == ScreenType.EVENT
                                ? widget.eventModel!.title ?? ""
                                : widget.screenType == ScreenType.GROUPBYIN
                                ? widget.groupByInModel?.title ?? ''
                                : "St. coins",
                          ),
                        ),
                        CommonTextWidget(
                          text1: formattedCurrency(widget.totalPrice),
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    const Vspace(8),
                    if (widget.screenType == ScreenType.STCOINS) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // const Label(
                          //   text1: "Quantity",
                          // ),
                          Text(
                            "Quantity",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          CommonTextWidget(
                            text1: "${widget.stPointQuantity} St. coins",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ],
                    if (widget.screenType == ScreenType.EVENT ||
                        widget.screenType == ScreenType.GROUPBYIN) ...[
                      IconTextRowWidget(
                        text: DateFormat("MMMM dd").format(
                          DateTime.parse(
                            widget.screenType == ScreenType.EVENT
                                ? widget.eventModel!.startDate!
                                : widget.groupByInModel!.startDate!,
                          ).toLocal(),
                        ),
                        hspace: 12,
                        appImages: AppImages.calendra1,
                      ),
                      IconTextRowWidget(
                        text: DateFormat("h:mm a").format(
                          DateTime.parse(
                            widget.screenType == ScreenType.EVENT
                                ? widget.eventModel!.startDate!
                                : widget.groupByInModel!.startDate!,
                          ).toLocal(),
                        ),
                        hspace: 12,
                        appImages: AppImages.calendra1,
                        imageColor: Colors.transparent,
                      ),
                      const Vspace(8),
                      if (widget.screenType == ScreenType.EVENT) ...[
                        location(widget.eventModel).isEmpty
                            ? SizedBox()
                            : IconTextRowWidget(
                                text: location(widget.eventModel),
                                hspace: 12,
                                appImages: AppImages.location2,
                              ),
                        const Vspace(10),
                      ],
                      if (widget.screenType == ScreenType.GROUPBYIN) ...[
                        IconTextRowWidget(
                          text: widget.groupByInModel?.location ?? '',
                          hspace: 12,
                          appImages: AppImages.location2,
                        ),
                        const Vspace(10),
                      ],
                    ],
                  ],
                ),
              ),
              const Vspace(20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Label(text1: "Payment Details"),
              ),
              const Vspace(11),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: shapeDecoration(),
                child: Column(
                  children: [
                    const Vspace(22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Amount",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        CommonTextWidget(
                          text1: formattedCurrency(widget.totalPrice),
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    const Vspace(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Platform Fee",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          formattedCurrency(calculateBookingPrice()),
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    if (isStCoinCheckBoxSelected &&
                        widget.screenType != ScreenType.STCOINS) ...[
                      Vspace(8),
                      AppDivider(color: Color(0xFFF5F5F5)),
                      Vspace(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Utilized ST Coins"),
                          Flexible(
                            child: CommonTextWidget(
                              text1:
                                  "-${formattedCurrency((num.tryParse(stCoinController.text) ?? 0) / 10)}",
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      Vspace(8),
                      AppDivider(color: Color(0xFFF5F5F5)),
                    ],
                    const Vspace(21),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total payable amount",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        Flexible(
                          child: CommonTextWidget(
                            text1: formattedCurrency(
                              handleTotalPayableBalance(),
                            ),
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const Vspace(19),
                  ],
                ),
              ),
              const Vspace(31),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Label(text1: "Choose Payment Option"),
              ),
              const Vspace(13),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: shapeDecoration(),
                child: Column(
                  children: [
                    if (widget.screenType != ScreenType.STCOINS) ...[
                      Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(AppImages.rupeeBackground),
                              Image.asset(AppImages.rupeeSymbol),
                            ],
                          ),
                          Hspace(10),
                          Expanded(
                            child: Text(
                              "Your st. coins balance:",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            child: BorderedTextFormField(
                              hintText: "",
                              controller: stCoinController,
                              keyboardType: TextInputType.number,
                              borderColor: AppColors.primary,
                              onChange: (val) {
                                // check if stCoinController.text is greater than user's st coins
                                int? stCoins = int.tryParse(val);
                                num userStCoins =
                                    context
                                        .read<ProfileBloc>()
                                        .userModel
                                        ?.stCoins ??
                                    0;

                                if (val != null &&
                                    val.isNotEmpty &&
                                    stCoins != null) {
                                  if (stCoins > userStCoins) {
                                    showErrorSnackbar(
                                      context,
                                      "You don't have ${stCoinController.text} st. coins!",
                                    );
                                    stCoinController.text = userStCoins
                                        .toString();
                                  }
                                  if (stCoins > calulateTotalPrice() * 10) {
                                    showErrorSnackbar(
                                      context,
                                      "You can't use more than ${calulateTotalPrice() * 10} st. coins!",
                                    );
                                    stCoinController.text =
                                        (calulateTotalPrice() * 10).toString();
                                  }
                                }

                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Vspace(16),
                      Row(
                        children: [
                          SizedBox(
                            height: 34,
                            width: 34,
                            child: Checkbox(
                              value: isStCoinCheckBoxSelected,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              side: const BorderSide(
                                color: Colors.grey,
                                width: 1.5,
                              ),
                              activeColor: AppColors.primary,
                              focusColor: AppColors.grey,
                              onChanged: (dynamic value) {
                                setState(() {
                                  isStCoinCheckBoxSelected = value;
                                  if (isStCoinCheckBoxSelected) {
                                    selectedIndex = 0;
                                  }
                                });
                              },
                            ),
                          ),
                          Hspace(10),
                          Expanded(
                            child: Text(
                              "Utilize your saved st. coins. (1 st. coin = 10 Paisa)",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Vspace(16),
                    ],
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(left: 5),
                      itemBuilder: (context, index) {
                        if (isStCoinCheckBoxSelected && index == 1) {
                          return const SizedBox();
                        }

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: ColoredBox(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Image.asset(
                                  paymentOptions[index].image,
                                  height: 16,
                                ),
                                const Hspace(14),
                                Text(paymentOptions[index].paymentMethod),
                                const Expanded(child: Hspace(0)),
                                selectedIndex == index
                                    ? const CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Color(0xff007405),
                                        child: CircleAvatar(
                                          radius: 6,
                                          backgroundColor: AppColors.white,
                                        ),
                                      )
                                    : const CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Color(0xffD9D9D9),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Vspace(19),
                      itemCount: paymentOptions.length,
                    ),
                  ],
                ),
              ),
              const Vspace(40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: PrimaryButton(
          text: "Proceed to Pay",
          onTap: () {
            if (widget.totalPrice == 0) {
              handleFreeEvent();
              return;
            }

            if (selectedIndex == 0) {
              if (widget.screenType == ScreenType.EVENT) {
                context
                    .read<EventBloc>()
                    .createEventBookingEntity
                    .paymentMethod = isStCoinCheckBoxSelected
                    ? "both"
                    : "gateway";
                context
                    .read<EventBloc>()
                    .createEventBookingEntity
                    .payment = PaymentModel(
                  bookingAmount: calculateBookingPrice(),
                  ticketAmount: num.tryParse(widget.totalPrice.toString()),
                  transactionId: "",
                );
                context
                    .read<EventBloc>()
                    .createEventBookingEntity
                    .stCoins = isStCoinCheckBoxSelected
                    ? num.tryParse(stCoinController.text) ?? 0
                    : 0;
              }

              if (isStCoinCheckBoxSelected == true &&
                  (((num.tryParse(stCoinController.text)) ?? 0) ==
                      (calulateTotalPrice() * 10))) {
                handlePaymentByStCoins();
                return;
              }

              //! HANDLING ID EARLIER ID WAS TESTING ID
              String id = "";

              if (widget.screenType == ScreenType.EVENT) {
                id = widget.eventModel!.id!;
              } else if (widget.screenType == ScreenType.GROUPBYIN) {
                id = widget.groupByInModel!.id!;
              } else if (widget.screenType == ScreenType.STCOINS) {
                id = "stcoins";
              }

              //! OLD CODE FOR RAZORPAY
              // context.read<EventBloc>().add(GetRzpDetailsEvent(
              //     id: id, amount: handleTotalPayableBalance()));

              //! NEW CODE FOR RAZORPAY
              if (widget.screenType == ScreenType.EVENT) {
                setQuestionAndAnswersToEventEntity();
                context.read<EventBloc>().createEventBookingEntity.amount =
                    handleTotalPayableBalance();
                context.read<EventBloc>().add(
                  GetRzpOrderEventsEvent(
                    id: id,
                    body: context
                        .read<EventBloc>()
                        .createEventBookingEntity
                        .toJson(),
                    isFromGroupBuyIn: false,
                  ),
                );
              } else if (widget.screenType == ScreenType.GROUPBYIN) {
                context.read<EventBloc>().add(
                  GetRzpOrderEventsEvent(
                    id: widget.groupByInModel!.id!,
                    body: {
                      "qty": widget.groupBuyInQty!,
                      "paymentMethod": isStCoinCheckBoxSelected
                          ? "both"
                          : "gateway",
                      "payment": {
                        "buyInAmount": widget.totalPrice,
                        "bookingAmount": 0,
                        "transactionId": "",
                      },
                      "stCoins": isStCoinCheckBoxSelected
                          ? int.tryParse(stCoinController.text) ?? 0
                          : null,
                      "amount": handleTotalPayableBalance(),
                    },
                    isFromGroupBuyIn: true,
                  ),
                );
              }
            } else if (selectedIndex == 1) //!for ST COINS
            {
              handlePaymentByStCoins();
            }

            // context.router.push(DebitCreditCardRoute(
            //     totalPrice: widget.totalPrice, eventModel: widget.eventModel));
            // showPaymentSuccessDialog(
            //   context: context,
            //   doneTap: () {},
            //   emailTap: () {},
            // );
            // showPaymentFailedDialog(
            //   context: context,
            //   cancelTap: () {},
            //   tryAgain: () {},
            // );
          },
        ),
      ),
    );
  }

  ShapeDecoration shapeDecoration() {
    return ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadows: const [
        BoxShadow(
          color: Color(0x19484848),
          blurRadius: 10,
          offset: Offset(0, 1),
          spreadRadius: 0,
        ),
      ],
    );
  }
}
