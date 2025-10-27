// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:architecture/core/presentation/widgets/hspace.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/presentation/widgets/primary_button.dart';
import 'package:architecture/core/presentation/widgets/vspace.dart';
import 'package:architecture/core/routes/router.gr.dart';
import 'package:architecture/core/theme/app_color.dart';
import 'package:architecture/core/utils/common_methods.dart';
import 'package:architecture/features/auth/screens/widgets/white_continer.dart';

import '../../../core/bloc/profile/profile_bloc.dart';
import '../../../core/presentation/widgets/app_background.dart';
import '../../../core/presentation/widgets/label.dart';
import '../../../core/theme/apptheme.dart';

@RoutePage()
class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen(
      {Key? key, required this.email, this.isFromForgotPassword = false})
      : super(key: key);
  final String email;
  final bool isFromForgotPassword;
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String otp = "";
  bool isErrorOtp = false;
  int _remainingSeconds = 30;
  Timer? _timer;
  bool resendOtp = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(GetReferIdEvent());
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel(); // Stop the timer when it reaches 0
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AppBackGround(
            child: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showOverlayLoader(context);
        } else if (state is OtpSuccessState) {
          hideOverlayLoader(context);
          String? referId = context.read<AuthBloc>().referId;

          if (referId != null && referId.isNotEmpty) {
            context
                .read<ProfileBloc>()
                .add(AddReferalEvent(referralUserId: referId));
          }
          context.router.replaceAll([AccountCreatedRoute(email: widget.email)]);
        } else if (state is AuthErrorState) {
          hideOverlayLoader(context);
          showErrorSnackbar(context, state.error);
        } else {
          hideOverlayLoader(context);
        }

        if (state is ResendOtpSuccessState) {
          hideOverlayLoader(context);
        }
      },
      child: Column(
        children: [
          const Vspace(50),
          // Image.asset(AppImages.studentTribe),
          SvgPicture.asset(
            'assets/svg/stlogo_transparent.svg',
            height: 100.h,
            width: 100.w,
          ),
          const Vspace(82),
          Expanded(
            child: AuthWhiteContainer(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Vspace(29),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "OTP Verification",
                        style: AppTheme.bodyText1.copyWith(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w900,
                            color: AppColors.black),
                      ),
                    ),
                    const Vspace(35),
                    const Label(
                      text1: "Enter OTP",
                    ),
                    const Vspace(3),
                    // Text(
                    //   "Please enter OTP that we have sent you ${context.read<AuthBloc>().email != null ? "on ${context.read<AuthBloc>().email}" : ""}",
                    //   style: AppTheme.bodyText3.copyWith(
                    //       fontSize: 12.sp, color: const Color(0xFF9B9B9B)),
                    // ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Please enter OTP that we have sent you on ',
                            style: AppTheme.bodyText3.copyWith(
                                fontSize: 12.sp,
                                color: const Color(0xFF9B9B9B)),
                          ),
                          context.read<AuthBloc>().email != null
                              ? TextSpan(
                                  text: '${context.read<AuthBloc>().email}',
                                  style: AppTheme.bodyText3.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.primary),
                                )
                              : TextSpan(text: ''),
                        ],
                      ),
                    ),
                    const Vspace(16),
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderWidth: 0.2,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.transparent,
                        activeColor: const Color(0x3F000000),
                        inactiveColor: const Color(0x3F000000),
                        selectedColor: AppColors.primary,
                        selectedFillColor: Colors.transparent,
                        inactiveFillColor: Colors.transparent,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      onCompleted: (v) {
                        context.read<AuthBloc>().add(VerifyOtpEvent(otp: otp));
                      },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          otp = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    const Vspace(5),
                    if (isErrorOtp) ...[
                      Text(
                        "Verification failed,Please try again",
                        style: AppTheme.bodyText3.copyWith(
                            fontSize: 12.sp, color: AppColors.primary),
                      ),
                    ],
                    const Vspace(137),
                    if (resendOtp) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Resend code in 0:${_remainingSeconds}",
                            style: AppTheme.bodyText3.copyWith(
                                fontSize: 14.sp, color: Color(0xff9B9B9B)),
                          ),
                          Hspace(10),
                          GestureDetector(
                            onTap: () {
                              if (_remainingSeconds == 0) {
                                _remainingSeconds = 30;
                                startTimer();
                                context.read<AuthBloc>().add(ResendOtpEvent());
                              }
                            },
                            child: Text(
                              "Resend OTP",
                              style: AppTheme.bodyText3.copyWith(
                                  fontSize: 12.sp, color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      Vspace(10),
                    ],
                    Center(
                      child: PrimaryButton(
                        text: "Verify",
                        onTap: () {
                          context
                              .read<AuthBloc>()
                              .add(VerifyOtpEvent(otp: otp));
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const Vspace(6),
                    if (resendOtp == false) ...[
                      GestureDetector(
                        onTap: () {
                          startTimer();
                          resendOtp = true;
                          context.read<AuthBloc>().add(ResendOtpEvent());
                        },
                        child: Center(
                            child: Text(
                          "Resend OTP",
                          style: AppTheme.bodyText3.copyWith(
                              fontSize: 12.sp, color: AppColors.primary),
                        )),
                      ),
                    ],
                    const Vspace(22),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          context.router.push(const LoginRoute());
                        },
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Already have an account? ',
                                  style: AppTheme.bodyText3.copyWith(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF585858))),
                              TextSpan(
                                  text: 'Login',
                                  style: AppTheme.bodyText3.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    )));
  }
}
