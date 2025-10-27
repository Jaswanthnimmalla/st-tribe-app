// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/presentation/widgets/app_background.dart';
import 'package:architecture/core/presentation/widgets/border_textfield.dart';
import 'package:architecture/core/utils/validator.dart';
import 'package:architecture/features/auth/screens/widgets/white_continer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../bottom navigation/export.dart';

@RoutePage()
class ConfirmNewPassword extends StatefulWidget {
  const ConfirmNewPassword({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;
  @override
  State<ConfirmNewPassword> createState() => _ConfirmNewPasswordState();
}

class _ConfirmNewPasswordState extends State<ConfirmNewPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: AppBackGround(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                showOverlayLoader(context);
              } else if (state is ConfirmPasswordSuccessState) {
                hideOverlayLoader(context);
                showSuccessMessage(context,
                        message: "Password Reset SuccessFully")
                    .whenComplete(
                        () => context.router.replaceAll([const LoginRoute()]));
              } else if (state is AuthErrorState) {
                hideOverlayLoader(context);
                showErrorSnackbar(context, state.error);
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
                          "New Password",
                          style: AppTheme.bodyText1.copyWith(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColors.black),
                        ),
                      ),
                      const Vspace(35),
                      const Label(text1: "Password", isStartRequired: true),
                      const Vspace(5),
                      BorderedTextFormField(
                        hintText: "Please enter your password",
                        controller: password,
                        validator: (value) => Validator.validatePassword(value),
                      ),
                      const Vspace(18),
                      const Label(
                          text1: "Confirm password", isStartRequired: true),
                      const Vspace(5),
                      BorderedTextFormField(
                        hintText: "Please confirm your password",
                        controller: confirmPassword,
                        validator: (value) =>
                            Validator.validatePasswordAndConfirmPassword(
                                value, password.text),
                      ),
                      const Vspace(15),
                      const Label(
                        text1: "Enter OTP",
                        isStartRequired: true,
                      ),
                      const Vspace(5),
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
                        onCompleted: (v) {},
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
                      const Vspace(15),
                      Center(
                        child: PrimaryButton(
                          text: "Confirm",
                          onTap: () {
                            btnPress();
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                )))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void btnPress() {
    if (otp.isEmpty) {
      showErrorSnackbar(context, "Please enter OTP");
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(ConfirmPasswordEvent(
          email: widget.email, password: password.text, code: otp));
    }
  }
}
