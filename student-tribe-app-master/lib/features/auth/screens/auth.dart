import 'package:architecture/core/presentation/widgets/app_background.dart';
import 'package:architecture/core/presentation/widgets/hspace.dart';
import 'package:architecture/core/presentation/widgets/primary_button.dart';
import 'package:architecture/core/presentation/widgets/vspace.dart';
import 'package:architecture/core/routes/router.gr.dart';
import 'package:architecture/core/theme/app_color.dart';
import 'package:architecture/core/theme/apptheme.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/presentation/widgets/app_divider.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackGround(
        child: Column(
          children: [
            const Spacer(),
            // Image.asset(AppImages.studentTribe),
            SvgPicture.asset(
              'assets/svg/stlogo_transparent.svg',
              height: 100.h,
              width: 100.w,
            ),
            const Expanded(child: Vspace(0)),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                "Welcome to \n Student Tribe",
                textAlign: TextAlign.center,
                style: AppTheme.bodyText1.copyWith(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
            const Vspace(5),
            Text(
              "Explore exciting articles,\ninternships, events, join\ncommunities and group buy-ins",
              textAlign: TextAlign.center,
              style: AppTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFFFF9797),
              ),
            ),
            const Vspace(55),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: "Register",
                color: AppColors.white,
                textColor: AppColors.black,
                onTap: () {
                  context.router.push(const RegisterRoute());
                },
              ),
            ),
            const Vspace(13),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  const Expanded(child: AppDivider()),
                  const Hspace(10),
                  Text(
                    "or",
                    style: AppTheme.bodyText3.copyWith(color: AppColors.white),
                  ),
                  const Hspace(10),
                  const Expanded(child: AppDivider()),
                ],
              ),
            ),
            const Vspace(13),
            PrimaryOutlineButton(
              text: "Sign In",
              textColor: AppColors.white,
              onTap: () {
                context.router.push(const LoginRoute());
                // context.router.push(const BottomNavigationRoute());
                // context.router.push(const ProfileRoute());
              },
            ),
            const Vspace(20),
          ],
        ),
      ),
    );
  }
}
