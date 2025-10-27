// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/features/bottom%20navigation/export.dart';

import 'package:architecture/core/presentation/widgets/app_background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/validator.dart';

@RoutePage()
class AccountCreatedScreen extends StatefulWidget {
  const AccountCreatedScreen({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;

  @override
  State<AccountCreatedScreen> createState() => _AccountCreatedScreenState();
}

class _AccountCreatedScreenState extends State<AccountCreatedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackGround(
          child: Column(
        children: [
          const Spacer(),
          Image.asset(AppImages.studentTribe),
          const Spacer(),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(AppImages.whiteCircle),
              Image.asset(AppImages.redtick),
            ],
          ),
          const Vspace(27),
          Text(
            "Your account has been \nverified successfully!",
            textAlign: TextAlign.center,
            style: AppTheme.bodyText1.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white),
          ),
          const Expanded(child: Hspace(0)),
          PrimaryButton(
            text: "Done",
            color: AppColors.white,
            textColor: AppColors.black,
            onTap: () {
              // context.router.push(const UploadCollegeIdRoute());
              if (Validator.checkCommonEmail(widget.email)) {
                context.router.replaceAll([const UploadCollegeIdRoute()]);
                return;
              }

              context.router.replaceAll([const BottomNavigationRoute()]);
            },
          ),
          const Vspace(37)
        ],
      )),
    );
  }
}
