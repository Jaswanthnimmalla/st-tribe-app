// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:architecture/core/data/models/intership/application_model.dart';
import 'package:architecture/core/data/models/intership/intership_model.dart';

import '../../../core/constants/svg.dart';
import '../export.dart';

class IntershipCard extends StatelessWidget {
  const IntershipCard({
    Key? key,
    required this.internshipModel,
    this.applicationModel,
  }) : super(key: key);
  final InternshipModel internshipModel;
  final ApplicationModel? applicationModel;

  Color getColorForStatus(String status) {
//   Pending => Yellow
// Accepted => Green
// Rejected => Red
// Shortlisted => Blue
// Scheduled Interview => Orange
    switch (status) {
      case "pending":
        //Color code for a dark yellow
        return Color(0XFFf5a623);
      case "accepted":
        return Colors.green;
      case "rejected":
        return Colors.red;
      case "shortlisted":
        return Colors.blue;
      case "scheduleInterview":
        return Colors.orange;
      default:
        return AppColors.primary;
    }
  }

  //Method to capitalize first letter of the string
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  //Method to convert camel case to space separated string with first letters capitalized
  String camelCaseToTitle(String s) {
    String newString = "";
    for (int i = 0; i < s.length; i++) {
      if (s[i] == s[i].toUpperCase()) {
        newString += " ";
      }
      newString += s[i];
    }
    return capitalize(newString);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14).r,
      width: double.infinity,
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
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (internshipModel.companyLogo?.isEmpty ?? true)
                ? Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: AppColors.primary,
                      foregroundImage: AssetImage(
                        AppImages.studentTribe,
                      ),
                    ))
                : CircleAvatar(
                    maxRadius: 20,
                    backgroundColor: Colors.transparent,
                    foregroundImage: NetworkImage(
                      internshipModel.companyLogo ?? "",
                    ),
                  ),
            const Hspace(6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   applicationModel != null &&
                  //           applicationModel!.status != null &&
                  //           applicationModel!.status!.isNotEmpty
                  //       ? applicationModel!.status!
                  //       : internshipModel.status ?? "",
                  //   style: AppTheme.bodyText3.copyWith(fontSize: 12),
                  // ),
                  Text(internshipModel.title ?? "",
                      style: AppTheme.bodyText2
                          .copyWith(fontWeight: FontWeight.w700)),
                  const Vspace(7),
                  // if (internshipModel.skills != null ||
                  //     internshipModel.skills!.isNotEmpty) ...[
                  //   Wrap(
                  //     runSpacing: 8,
                  //     spacing: 5,
                  //     children: internshipModel.skills!
                  //         .map(
                  //           (e) => UnselectedChip(
                  //             text: e,
                  //           ),
                  //         )
                  //         .toList(),
                  //   ),
                  //   const Vspace(10),
                  // ],

                  if (isDateExpired(internshipModel.expiryDate))
                    UnselectedChip(
                      fontWeight: FontWeight.bold,
                      text: "Closed",
                      isShadowRequired: false,
                      color: AppColors.primary,
                    )
                  else
                    Wrap(
                      runSpacing: 8,
                      spacing: 5,
                      children: [
                        internshipModel.expectedStartDate != null &&
                                internshipModel.expectedStartDate!.isNotEmpty
                            ? UnselectedChip(
                                fontWeight: FontWeight.bold,
                                text:
                                    "Start Date - ${formatDateTimeToDayMonthYear(DateTime.parse(internshipModel.expectedStartDate!).toLocal())}",
                                isShadowRequired: false,
                              )
                            : const SizedBox.shrink(),
                        internshipModel.numberOfOpenings != null
                            ? UnselectedChip(
                                fontWeight: FontWeight.bold,
                                text:
                                    "${internshipModel.numberOfOpenings} Openings",
                                isShadowRequired: false,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  if (internshipModel.expectedStartDate != null &&
                          internshipModel.expectedStartDate!.isNotEmpty ||
                      internshipModel.numberOfOpenings != null) ...[
                    const Vspace(5),
                  ],

                  if (applicationModel?.status == null ||
                      applicationModel!.status!.isEmpty) ...[
                    const SizedBox.shrink()
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: getColorForStatus(
                          applicationModel?.status ?? "",
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                          camelCaseToTitle(applicationModel?.status ?? ""),
                          style: AppTheme.bodyText3
                              .copyWith(fontSize: 12, color: Colors.white)),
                    ),
                    const Vspace(6)
                  ],

                  IconTextRowWidget(
                    text: internshipModel.location ?? "",
                    appImages: AppSvg.calendra,
                    fontSize: 12.sp,
                  ),
                  const Vspace(4),
                  if (internshipModel.type != null &&
                      internshipModel.type!.isNotEmpty &&
                      internshipModel.type == "internship") ...[
                    IconTextRowWidget(
                      text:
                          "${internshipModel.duration?.years ?? ""} year ${internshipModel.duration?.months ?? ""} months",
                      appImages: AppImages.calendra1,
                      fontSize: 12.sp,
                    ),
                    const Vspace(4),
                  ],

                  IconTextRowWidget(
                    text: internshipModel.compensation?.method == "fixed"
                        ? "INR ${internshipModel.compensation?.amount ?? ""}/month"
                        : "INR ${internshipModel.compensation?.minimum ?? ""}-${internshipModel.compensation?.maximum ?? ""}/month",
                    appImages: AppImages.money1,
                    fontSize: 12.sp,
                  ),
                  if (internshipModel.type != null &&
                      internshipModel.type!.isNotEmpty) ...[
                    const Vspace(4),
                    IconTextRowWidget(
                      text: convertInternshpTypeInCamelCase(
                          internshipModel.type ?? ""),
                      appImages: AppImages.svgStopwatch,
                      fontSize: 12.sp,
                      hspace: 8,
                    ),
                  ],
                ],
              ),
            ),
            // const Icon(
            //   Icons.bookmark_outline,
            //   size: 22,
            // )
          ],
        ),
        const Vspace(10),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "View Details",
        //       style: AppTheme.bodyText3.copyWith(color: AppColors.primary),
        //     ),
        //     PrimaryButton(
        //       text: "Apply Now",
        //       padding: EdgeInsets.zero,
        //       onTap: () {
        //         context
        //             .read<InternshipBloc>()
        //             .add(ApplyInternShipEvent(id: internshipModel.id!));
        //       },
        //       fontsize: 12,
        //       innerPadding: MaterialStateProperty.all(
        //           const EdgeInsets.symmetric(vertical: 4, horizontal: 16)),
        //     )
        //   ],
        // )
      ]),
    );
  }

  String convertInternshpTypeInCamelCase(String type) {
    switch (type) {
      case "full-time":
        return "Full Time";
      case "internship":
        return "Internship";

      default:
        return "";
    }
  }
}
