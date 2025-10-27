// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:circular_progress_stack/circular_progress_stack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:architecture/core/data/models/user.dart';

import '../export.dart';

class TopCard extends StatelessWidget {
  const TopCard({
    Key? key,
    required this.updateState,
    required this.onCancel,
    this.userModel,
  }) : super(key: key);
  final Function() updateState;
  final Function() onCancel;

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24).r,
          decoration: ShapeDecoration(
            color: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userModel?.name ?? "",
                      style: AppTheme.bodyText2.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp),
                    ),
                    const Vspace(1),
                    Text(
                      "Profile completion",
                      style: AppTheme.bodyText2.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp),
                    ),
                    const Vspace(7),
                    Text(
                      "Please complete your profile to get access to all the events, internships, communities and more.",
                      style: AppTheme.bodyText2.copyWith(
                          color: AppColors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    const Vspace(11),
                    PrimaryButton(
                      text: "Complete Your Profile",
                      onTap: () async {
                        await context.router.push(const ProfileRoute());
                        updateState();
                      },
                      color: AppColors.white,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w700,
                      fontsize: 10.sp,
                      padding: EdgeInsets.zero.w,
                      innerPadding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 12).r),
                    )
                  ],
                ),
              ),
              Hspace(40.w),
              Column(
                children: [
                  const Vspace(24),
                  context
                              .read<ProfileBloc>()
                              .userModel
                              ?.profileCompletionPercentage ==
                          null
                      ? const SizedBox(
                          width: 50,
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            SingleSimpleStackCircularProgressBar(
                              size: 110,
                              progressStrokeWidth: 15,
                              backStrokeWidth: 15,
                              startAngle: 0,
                              backColor: Colors.white,
                              barColor: Colors.red,
                              barValue: double.tryParse(
                                      "${context.read<ProfileBloc>().userModel?.profileCompletionPercentage}") ??
                                  0,
                              textStyle: AppTheme.bodyText1.copyWith(
                                  fontSize: 20.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900),
                              isTextShow: false,
                            ),
                            Text(
                              "${context.read<ProfileBloc>().userModel?.profileCompletionPercentage ?? 0}%",
                              style: AppTheme.bodyText1.copyWith(
                                  fontSize: 20.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900),
                            )
                          ],
                        )

                  // SimpleCircularProgressBar(
                  //     backColor: AppColors.white,
                  //     progressColors: const [Color(0xFFFF4646)],
                  //     mergeMode: true,
                  //     maxValue: 100,
                  //     valueNotifier: ValueNotifier(double.tryParse(
                  //             "${context.read<ProfileBloc>().userModel?.profileCompletionPercentage}") ??
                  //         0),
                  //     animationDuration: 2,
                  //     onGetText: (p0) {
                  //       return Text(
                  //         "${context.read<ProfileBloc>().userModel?.profileCompletionPercentage ?? 0}%",
                  //         style: AppTheme.bodyText1.copyWith(
                  //             fontSize: 20.sp,
                  //             color: AppColors.white,
                  //             fontWeight: FontWeight.w900),
                  //       );
                  //     },
                  //   ),
                  // Text(
                  //   "85%",
                  //   style: AppTheme.bodyText1.copyWith(
                  //       fontSize: 24,
                  //       color: AppColors.white,
                  //       fontWeight: FontWeight.w900),
                  // )
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 15,
          child: GestureDetector(
            onTap: () {
              onCancel();
            },
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
