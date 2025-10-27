import 'dart:developer';

import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/presentation/widgets/border_textfield.dart';
import 'package:architecture/core/utils/validator.dart';
import 'package:architecture/features/auth/screens/widgets/white_continer.dart';
import 'package:architecture/features/bottom%20navigation/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool googleLogin = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoadingState) {
              showOverlayLoader(context);
            } else if (state is RegistrationSuccessState) {
              hideOverlayLoader(context);
              context.router.push(VerifyOtpRoute(email: email.text));
            } else if (state is AuthSuccessState) {
              hideOverlayLoader(context);
              setState(() {
                googleLogin = state.googleLogin;
              });
              context.read<ProfileBloc>().add(const GetMyProfileEvent());
            } else if (state is AuthErrorState) {
              hideOverlayLoader(context);
              showErrorSnackbar(context, state.error);
            }
          },
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoadingState) {
                showOverlayLoader(context);
              } else if (state is GetMyProfileSuccessFullState) {
                hideOverlayLoader(context);
                log("googleLogin: $googleLogin");
                if (googleLogin) {
                  String? referId = context.read<AuthBloc>().referId;
                  context.read<AuthBloc>().referId = "";
                  if (referId != null && referId.isNotEmpty) {
                    context.read<ProfileBloc>().add(
                      AddReferalEvent(referralUserId: referId),
                    );
                  }
                }
                if (state.userModel.studentIdImg == null ||
                    state.userModel.studentIdImg!.isEmpty) {
                  context.router.replaceAll([const UploadCollegeIdRoute()]);
                  return;
                }
                context.router.replaceAll([const BottomNavigationRoute()]);
              } else if (state is ProfileErrorState) {
                hideOverlayLoader(context);
                showErrorSnackbar(context, state.error);
              }
            },
            child: SafeArea(
              child: Column(
                children: [
                  // const Vspace(50),
                  // Image.asset(AppImages.studentTribe),
                  // const Vspace(15),
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
                                "Create an account",
                                style: AppTheme.bodyText1.copyWith(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            const Vspace(35),
                            const Label(
                              text1: "Full name",
                              isStartRequired: true,
                            ),
                            const Vspace(5),
                            BorderedTextFormField(
                              hintText: "Please enter your full name",
                              controller: fullName,
                              validator: (value) =>
                                  Validator.validateName(value),
                            ),
                            const Vspace(18),
                            const Label(
                              text1: "Email",
                              isStartRequired: true,
                              subtitle: "Enter your college email address",
                            ),
                            const Vspace(5),
                            BorderedTextFormField(
                              hintText:
                                  "Please enter your college email address",
                              controller: email,
                              validator: (value) =>
                                  Validator.validateEmail(value),
                            ),
                            const Vspace(18),
                            const Label(
                              text1: "Mobile no",
                              isStartRequired: true,
                            ),
                            const Vspace(5),
                            BorderedTextFormField(
                              hintText: "Please enter your mobile number",
                              controller: mobileNumber,
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              validator: (value) =>
                                  Validator.validateMobileNumber(value),
                            ),
                            const Vspace(18),
                            const Label(
                              text1: "Password",
                              isStartRequired: true,
                            ),
                            const Vspace(5),
                            BorderedTextFormField(
                              hintText: "Please enter your password",
                              controller: password,
                              obscureText: hidePassword,
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                child: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              validator: (value) =>
                                  Validator.validatePassword(value),
                            ),
                            const Vspace(18),
                            const Label(
                              text1: "Confirm password",
                              isStartRequired: true,
                            ),
                            const Vspace(5),
                            BorderedTextFormField(
                              hintText: "Please confirm your password",
                              controller: confirmPassword,
                              obscureText: hideConfirmPassword,
                              suffix: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hideConfirmPassword = !hideConfirmPassword;
                                  });
                                },
                                child: Icon(
                                  hideConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              validator: (value) =>
                                  Validator.validatePasswordAndConfirmPassword(
                                    value,
                                    password.text,
                                  ),
                            ),
                            const Vspace(30),
                            Center(
                              child: PrimaryButton(
                                text: "Get OTP",
                                onTap: () {
                                  getOtpPress();
                                },
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            const Vspace(18),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Or",
                                style: AppTheme.bodyText3.copyWith(
                                  color: const Color(0xFF393939),
                                ),
                              ),
                            ),
                            const Vspace(18),
                            const SocialLoginContainer(),
                            const Vspace(15),
                            SafeArea(
                              top: false,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    context.router.replace(const LoginRoute());
                                  },
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Already have an account?',
                                          style: AppTheme.bodyText3.copyWith(
                                            color: const Color(0xFF676767),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' Login',
                                          style: AppTheme.bodyText3.copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //         child: GestureDetector(
                            //             onTap: () {
                            //               context
                            //                   .read<AuthBloc>()
                            //                   .add(SignInWithGoogleEvent());
                            //             },
                            //             child: Image.asset(AppImages.google))),
                            //     Expanded(child: Image.asset(AppImages.facebook)),
                            //     Expanded(child: Image.asset(AppImages.twitter)),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getOtpPress() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SignUpEvent(
          name: fullName.text,
          email: email.text,
          mobileNumber: mobileNumber.text,
          password: password.text,
        ),
      );
    }
  }
}
