// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/bloc/groupbyin/group_by_in_bloc.dart';
import 'package:architecture/core/data/models/groupbyin.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../export.dart';
import '../widgets/more_screen_button.dart';
import '../widgets/proceed_tap_button.dart';

@RoutePage()
class GroupInDetailsScreen extends StatefulWidget {
  const GroupInDetailsScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<GroupInDetailsScreen> createState() => _GroupInDetailsScreenState();
}

class _GroupInDetailsScreenState extends State<GroupInDetailsScreen> {
  // double couple = 100;
  // double vip = 100;

  // double coupleDisplayText = 100;
  // double vipDisplayText = 100;

  num generalQty = 1;

  num totalPrice = 0;

  GroupByInModel? groupByInModel;

  @override
  void initState() {
    context.read<GroupByInBloc>().add(GetGroupByInByIdEvent(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarN(text: ""),
      body: SingleChildScrollView(
        child: BlocListener<GroupByInBloc, GroupByInState>(
          listener: (context, state) {
            if (state is GroupByInLoadingState) {
              showOverlayLoader(context);
            } else if (state is GetGroupByInByIdSuccessFullState) {
              hideOverlayLoader(context);
              setState(() {
                groupByInModel = state.groupByIn;
                totalPrice = groupByInModel!.discountedPrice!;
              });
            } else if (state is GroupByInFailureState) {
              hideOverlayLoader(context);
              showErrorSnackbar(context, state.error);
            }
          },
          child: groupByInModel == null
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    groupByInModel?.coverImg == null
                        ? SizedBox.fromSize()
                        : Container(
                            width: double.infinity,
                            height: 216,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(groupByInModel!.coverImg!),
                                fit: BoxFit.fill,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(top: 36, left: 12),
                            // child: GestureDetector(
                            //   onTap: () {
                            //     context.router.pop();
                            //   },
                            //   child: IconButton(
                            //       onPressed: () {
                            //         context.router.pop();
                            //       },
                            //       icon: const Icon(
                            //         Icons.arrow_back_ios,
                            //         color: Colors.white,
                            //       )),
                            // ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Vspace(21),
                          groupByInModel!.featured == false
                              ? SizedBox.fromSize()
                              : Text(
                                  "Featured",
                                  style: AppTheme.bodyText3.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                          const Vspace(3),
                          Text(
                            groupByInModel!.title ?? "",
                            style: AppTheme.bodyText2.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Vspace(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          '${(groupByInModel!.target - (groupByInModel!.sold))} left',
                                      style: AppTheme.bodyText3.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' out of ${groupByInModel!.target}',
                                      style: AppTheme.bodyText3.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              groupByInModel?.discountedPrice == null
                                  ? const SizedBox.shrink()
                                  : Text(
                                      formattedCurrency(
                                        groupByInModel!.discountedPrice!,
                                      ),
                                      style: AppTheme.bodyText2.copyWith(
                                        color: AppColors.primary,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                            ],
                          ),
                          const Vspace(28),
                          groupByInModel?.offerEndDate == null
                              ? SizedBox.fromSize()
                              : EndsInButton(
                                  text: DateFormat('dd MMM, hh:mm a').format(
                                    DateTime.parse(
                                      groupByInModel!.offerEndDate!,
                                    ).toLocal(),
                                  ),
                                ),
                          const Vspace(8),
                          groupByInModel?.offerEndDate == null
                              ? SizedBox.fromSize()
                              : IconTextRowWidget(
                                  text: DateFormat('MMMM d | h:mm a').format(
                                    DateTime.parse(
                                      groupByInModel!.startDate!,
                                    ).toLocal(),
                                  ),
                                  appImages: AppImages.calendra,
                                  hspace: 12,
                                ),
                          const Vspace(8),
                          IconTextRowWidget(
                            text: groupByInModel?.location ?? "",
                            appImages: AppImages.location,
                            hspace: 12,
                          ),
                          const Vspace(41),
                          Text(
                            "About",
                            style: AppTheme.bodyText3.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Vspace(11),
                          Text(
                            groupByInModel?.about ?? '',
                            style: AppTheme.bodyText3.copyWith(fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          groupByInModel?.purchased ?? false
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "We've received your booking. Our team will contact you with further details shortly",
                    textAlign: TextAlign.center,
                    style: AppTheme.bodyText3.copyWith(
                      fontSize: 10.sp,
                      color: AppColors.primary,
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              text: "Buy Now",
              onTap: groupByInModel?.purchased == true
                  ? null
                  : () {
                      if (checkIfProfileCompleted(
                            context.read<ProfileBloc>().userModel,
                          ) ==
                          false) {
                        showErrorSnackbar(context, commonProfileError);
                        return;
                      }

                      if (groupByInModel!.purchased == false &&
                          groupByInModel!.pendingBookingId != null) {
                        showErrorSnackbar(
                          context,
                          "Payment Pending: Your transaction is currently being processed. Please wait a moment while we finalize your payment and kindly don’t initiate any new request. Thank you for your patience.",
                        );
                        return;
                      }

                      showQuantityPicker(context);
                    },
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            ),
          ),
        ],
      ),
    );
  }

  void showQuantityPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
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
                  CommonQuantitySelector(
                    amount: double.parse(
                      groupByInModel!.discountedPrice.toString(),
                    ),
                    decrease: () {
                      setState(() {
                        if (generalQty > 1) {
                          generalQty--;
                          totalPrice -= groupByInModel!.discountedPrice!;
                        }
                      });
                    },
                    increase: () {
                      setState(() {
                        if (generalQty >=
                            groupByInModel!.target - groupByInModel!.sold) {
                          // showErrorSnackbar(context,
                          //     "You can't buy more than ${groupByInModel!.target! - groupByInModel!.sold!} tickets");
                          return;
                        }

                        generalQty++;
                        totalPrice =
                            groupByInModel!.discountedPrice! * generalQty;
                      });
                    },
                    quantity: int.parse(generalQty.toString()),
                  ),
                  const Vspace(20),
                  ProceedTap(
                    isBoxShadowRequired: false,
                    padding: EdgeInsets.zero,
                    leftTitle: "Ticket Price",
                    amountString: totalPrice.toString(),
                    onTap: () {
                      if (generalQty <= 0) {
                        showErrorSnackbar(
                          context,
                          "Please enter atleast 1 quantity",
                        );

                        return;
                      }
                      context.router.push(
                        BuyTicketRoute(
                          totalPrice: totalPrice,
                          groupBuyInQty: generalQty.toInt(),
                          screenType: ScreenType.GROUPBYIN,
                          groupByInModel: groupByInModel,
                        ),
                      );
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
}

extension on StackRouter {
  void pop() {}
}
