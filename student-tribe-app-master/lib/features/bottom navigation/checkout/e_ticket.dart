// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:architecture/core/bloc/event/events_bloc.dart';
import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:architecture/core/presentation/widgets/app_background.dart';
import 'package:architecture/core/presentation/widgets/app_divider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/data/models/event/booking_model.dart';
import '../export.dart';

@RoutePage()
class EticketScreen extends StatefulWidget {
  const EticketScreen(
      {Key? key,
      required this.bookingModel,
      required this.eventModel,
      required this.totalPrice})
      : super(key: key);
  final EventModel eventModel;
  final num totalPrice;
  final BookingModel bookingModel;

  @override
  State<EticketScreen> createState() => _EticketScreenState();
}

class _EticketScreenState extends State<EticketScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // context
    //     .read<EventBloc>()
    //     .add(GetMyBookingsEvent(id: widget.eventModel.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarN(text: "Your E-ticket"),
      body: AppBackGround(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: BlocConsumer<EventBloc, EventState>(
            listener: (context, state) {
              // if (state is EventLoadingState) {
              //   showOverlayLoader(context);
              // } else if (state is GetMyBookingSuccessFullState) {
              //   hideOverlayLoader(context);
              //   setState(() {
              //     bookingModelList = state.bookingModelList;
              //   });
              // } else if (state is EventErrorState) {
              //   hideOverlayLoader(context);
              //   showErrorSnackbar(context, state.error);
              // }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const Vspace(40),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 37, vertical: 28),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.eventModel.title ?? "",
                                style: AppTheme.bodyText1.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            widget.eventModel.coverImg == null ||
                                    widget.eventModel.coverImg!.isEmpty
                                ? const SizedBox()
                                : Container(
                                    width: 39,
                                    height: 39,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            widget.eventModel.coverImg!),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                        const Vspace(16),
                        Label(
                          text1: "Name",
                          fontsize: 16.sp,
                          labelColor: const Color(0xFF8E8E8E),
                        ),
                        const Vspace(2),
                        Label(
                          text1:
                              context.read<ProfileBloc>().userModel?.name ?? "",
                          fontsize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        const Vspace(16),
                        const Label(
                          text1: "Date",
                          fontsize: 16,
                          labelColor: Color(0xFF8E8E8E),
                        ),
                        const Vspace(2),
                        Label(
                          text1: DateFormat("dd MMMM yyyy").format(
                              DateTime.parse(widget.eventModel.startDate!).toLocal()),
                          fontsize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        const Vspace(16),
                        const Label(
                          text1: "Time",
                          fontsize: 16,
                          labelColor: Color(0xFF8E8E8E),
                        ),
                        const Vspace(2),
                        Label(
                          text1:
                              "${DateFormat("h:mm a").format(DateTime.parse(widget.bookingModel.event!.startDate!).toLocal())} - ${DateFormat("h:mm a").format(DateTime.parse(widget.bookingModel.event!.endDate!).toLocal())}",
                          fontsize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        const Vspace(16),
                        const Label(
                          text1: "Venue",
                          fontsize: 16,
                          labelColor: Color(0xFF8E8E8E),
                        ),
                        const Vspace(2),
                        Text(
                          "${widget.eventModel.location?.addressLine1 ?? ""} ${widget.eventModel.location?.addressLine2 ?? ""} ${widget.eventModel.location?.city ?? ""} ${widget.eventModel.location?.state ?? ""}",
                          style: AppTheme.bodyText1.copyWith(
                              fontSize: 20.sp, fontWeight: FontWeight.w700),
                        ),
                        const Vspace(17),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Label(
                              text1: "Tickets",
                              fontsize: 16,
                              labelColor: Color(0xFF8E8E8E),
                            ),
                            const Vspace(2),
                            ...List.generate(
                                widget.bookingModel.tickets!.length,
                                (index) => Label(
                                      text1:
                                          "${widget.bookingModel.tickets![index].qty} ${widget.eventModel.tickets!.firstWhere((element) => element.id == widget.bookingModel.tickets![index].ticket).title}",
                                      fontsize: 20,
                                      fontWeight: FontWeight.w700,
                                    )),
                            Vspace(17),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Label(
                                  text1: "Cost",
                                  fontsize: 16,
                                  labelColor: Color(0xFF8E8E8E),
                                ),
                                const Vspace(2),
                                Label(
                                  text1: formattedCurrency(widget.totalPrice),
                                  fontsize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Vspace(17),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Attendees",
                              style: AppTheme.bodyText3.copyWith(
                                  fontSize: 16,
                                  color: const Color(0xFF8E8E8E),
                                  fontWeight: FontWeight.w700),
                            ),
                            const Vspace(2),
                            if (widget.bookingModel.attendees != null) ...[
                              ...List.generate(
                                widget.bookingModel.attendees!.length,
                                (index) => Text(
                                  widget.bookingModel.attendees![index].name ??
                                      "",
                                  style: AppTheme.bodyText3.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                            Vspace(17),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Label(
                                  text1: "Mode",
                                  fontsize: 16,
                                  labelColor: Color(0xFF8E8E8E),
                                ),
                                const Vspace(2),
                                Label(
                                  text1: toBeginningOfSentenceCase(
                                          widget.eventModel.location?.type) ??
                                      "",
                                  fontsize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            )
                          ],
                        ),
                        const Vspace(17),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [

                        //   ],
                        // ),
                        // const Vspace(17),
                        const Label(
                          text1: "Order ID",
                          fontsize: 16,
                          labelColor: Color(0xFF8E8E8E),
                        ),
                        const Vspace(2),
                        Text(
                          widget.bookingModel.id!.substring(16).toUpperCase(),
                          style: AppTheme.bodyText1.copyWith(
                              fontSize: 20.sp, fontWeight: FontWeight.w700),
                        ),
                        const Vspace(20),
                        const AppDivider(
                          color: AppColors.black,
                        ),
                        const Vspace(20),
                        Visibility(
                          visible: false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image.network(
                              //   "https://cdn.pixabay.com/photo/2013/07/12/14/45/qr-code-148732_1280.png",
                              //   height: 135,
                              //   width: 144,
                              //   fit: BoxFit.cover,
                              // ),
                              QrImageView(
                                data: {
                                  "eventId": widget.eventModel.id,
                                  "tickets": widget.bookingModel.tickets!
                                      .map((e) => e.toJson()),
                                  "payment":
                                      widget.bookingModel.payment!.toJson()
                                }.toString(),
                                version: QrVersions.auto,
                                size: 140,
                                padding: EdgeInsets.zero,
                              ),
                              const Hspace(15),
                              const Expanded(
                                child: Text(
                                    "Scan this QR at the venue to attend the event."),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Vspace(30),
                  // PrimaryButton(
                  //   text: "Download your E-Ticket",
                  //   color: AppColors.white,
                  //   textColor: AppColors.primary,
                  //   fontsize: 16.sp,
                  //   fontWeight: FontWeight.w700,
                  //   onTap: () {},
                  // ),
                  // const Vspace(30)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
