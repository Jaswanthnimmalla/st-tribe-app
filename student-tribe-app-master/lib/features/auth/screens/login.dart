import 'dart:developer';

import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/data/models/user.dart';
import 'package:architecture/core/presentation/widgets/app_divider.dart';
import 'package:architecture/core/utils/validator.dart';
import 'package:architecture/features/auth/screens/widgets/white_continer.dart';
import 'package:architecture/features/bottom%20navigation/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/presentation/widgets/app_background.dart';
import '../../../core/presentation/widgets/border_textfield.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool googleLogin = false;
  UserModel? userModel;
  bool hidePassword = true;

  @override
  void initState() {
    context.read<AuthBloc>().add(GetReferIdEvent());
    super.initState();
  }

  void callProfileApi() {
    context.read<ProfileBloc>().add(const GetMyProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AppBackGround(
            child: Form(
      key: _formKey,
      child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoadingState) {
                  showOverlayLoader(context);
                } else if (state is AuthSuccessState) {
                  hideOverlayLoader(context);
                  setState(() {
                    googleLogin = state.googleLogin;
                  });
                  callProfileApi();
                } else if (state is RegistrationSuccessState) {
                  hideOverlayLoader(context);
                  context.router.push(VerifyOtpRoute(email: email.text));
                } else if (state is AuthErrorState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                }
              },
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoadingState) {
                  showOverlayLoader(context);
                } else if (state is GetMyProfileSuccessFullState) {
                  hideOverlayLoader(context);
                  log("googleLogin: $googleLogin");
                  if (googleLogin) {
                    String? referId = context.read<AuthBloc>().referId;
                    context.read<AuthBloc>().referId = "";
                    log("referId: $referId");
                    if (referId != null && referId.isNotEmpty) {
                      log("Going for referral");
                      context
                          .read<ProfileBloc>()
                          .add(AddReferalEvent(referralUserId: referId));
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
            )
          ],
          child: Column(
            children: [
              const Vspace(50),
              SvgPicture.asset(
                'assets/svg/stlogo_transparent.svg',
                height: 100.h,
                width: 100.w,
              ),
              const Vspace(40),
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
                            "Welcome Back",
                            style: AppTheme.bodyText1.copyWith(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w900,
                                color: AppColors.black),
                          ),
                        ),
                        const Vspace(35),
                        const Label(
                          text1: "Email",
                          // isStartRequired: true,
                        ),
                        const Vspace(5),
                        BorderedTextFormField(
                          controller: email,
                          hintText: "Please enter your email",
                          validator: (value) => Validator.validateEmail(value),
                        ),
                        const Vspace(18),
                        const Label(
                          text1: "Password",
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
                              child: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          validator: (value) =>
                              Validator.validatePassword(value),
                        ),
                        const Vspace(8),
                        Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                context.router.push(const ForgotPassword());
                              },
                              child: Text(
                                "Forgot Password?",
                                style: AppTheme.bodyText3.copyWith(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF9B9B9B)),
                              ),
                            )),
                        const Vspace(30),
                        Center(
                          child: PrimaryButton(
                            text: "Log In",
                            onTap: () {
                              loginPress();
                            },
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        const Vspace(20),
                        Row(
                          children: [
                            const Expanded(
                                child: AppDivider(
                              color: AppColors.grey,
                            )),
                            const Hspace(10),
                            Text(
                              "Or",
                              style: AppTheme.bodyText3
                                  .copyWith(color: const Color(0xFF393939)),
                            ),
                            const Hspace(10),
                            const Expanded(
                                child: AppDivider(
                              color: AppColors.grey,
                            )),
                          ],
                        ),
                        const Vspace(18),
                        // Center(
                        //   child: GestureDetector(
                        //       onTap: () {
                        //         context
                        //             .read<AuthBloc>()
                        //             .add(SignInWithAppleEvent());
                        //       },
                        //       child: const SignInWithGoogleButton()),
                        // ),
                        const SocialLoginContainer(),
                        const Vspace(15),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              context.router.replace(const RegisterRoute());
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Don’t have an account?',
                                      style: AppTheme.bodyText3.copyWith(
                                          color: const Color(0xFF676767),
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                      text: ' sign up',
                                      style: AppTheme.bodyText3.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w500)),
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
          )),
    )));
  }

  void loginPress() {
    if (_formKey.currentState?.validate() ?? false) {
      // context.router.push(const VerifyOtpRoute());
      context
          .read<AuthBloc>()
          .add(SignInEvent(email: email.text, password: password.text));
    }
  }
}
