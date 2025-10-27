// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';

class CommonEventCard extends StatelessWidget {
  const CommonEventCard(
      {Key? key, required this.eventModel, this.isShowRegisterButton = false})
      : super(key: key);
  final EventModel eventModel;
  final bool isShowRegisterButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 11),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19484848),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          eventModel.coverImg == null || eventModel.coverImg!.isEmpty
              ? const SizedBox()
              : Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 185,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        image: DecorationImage(
                            image: NetworkImage(eventModel.coverImg ?? ""),
                            fit: BoxFit.fill),
                      ),
                    ),
                    eventModel.type == null || eventModel.type!.isEmpty
                        ? const SizedBox()
                        : Container(
                            margin: const EdgeInsets.only(left: 12, top: 11),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 23, vertical: 5),
                            decoration: BoxDecoration(
                              // color: isDateExpired(eventModel.endDate)
                              //     ? Colors.grey.shade400
                              //     : Colors.white,
                              color: Colors.white,
                              border: Border.all(
                                  color: isDateExpired(eventModel.endDate)
                                      ? AppColors.primary
                                      : Color(0x33000000),
                                  width: 1),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: isDateExpired(eventModel.endDate)
                                      ? Colors.transparent
                                      : Color(0x33000000),
                                  blurRadius: 30,
                                  offset: Offset(0, 3),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Text(
                              isDateExpired(eventModel.endDate)
                                  ? "Closed"
                                  : capitalizeFirstLetter(eventModel.type) ??
                                      "",
                              style: AppTheme.bodyText3.copyWith(
                                fontSize: 10.sp,
                                color: isDateExpired(eventModel.endDate)
                                    ? AppColors.primary
                                    : Colors.black,
                              ),
                            ),
                          ),
                  ],
                ),
          const Vspace(8),
          Text(eventModel.title ?? "",
              style: AppTheme.bodyText2.copyWith(fontWeight: FontWeight.w700)),
          const Vspace(6),
          IconTextRowWidget(
            // text: "24 Dec - 1 Jan | 2:00- 5:00 pm | Online",
            text:
                formatDateTimeRange(eventModel.startDate!, eventModel.endDate!),
            appImages: AppImages.calendra,
          ),
          const Vspace(5),
          IconTextRowWidget(
            text: eventModel.location?.city ?? "",
            appImages: AppImages.location2,
            hspace: 11,
          ),
          const Vspace(17),
          Row(
            children: [
              if (eventModel.entryType != null &&
                  eventModel.entryType == "free") ...[
                Text(
                  "Free ",
                  style: AppTheme.bodyText2.copyWith(
                      color: AppColors.primary, fontWeight: FontWeight.w700),
                ),
              ] else ...[
                if (eventModel.tickets != null &&
                    eventModel.tickets!.isNotEmpty) ...[
                  Text(
                    "Starting at ",
                    style: AppTheme.bodyText3
                        .copyWith(color: const Color(0xFF676767)),
                  ),
                  if (eventModel.tickets != null &&
                      eventModel.tickets!.isNotEmpty) ...[
                    Text(
                      formattedCurrency(num.tryParse(
                          eventModel.tickets![0].price!.toString())!),
                      style:
                          AppTheme.bodyText3.copyWith(color: AppColors.primary),
                    ),
                  ],
                ],
              ],
              const Expanded(child: Hspace(0)),
              isShowRegisterButton
                  ? PrimaryButton(
                      text: "Register",
                      padding: EdgeInsets.zero,
                      onTap: () {},
                      fontsize: 12.sp,
                      innerPadding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8)),
                    )
                  : const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}
