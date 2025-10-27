import 'package:architecture/core/bloc/auth/auth_bloc.dart';
import 'package:architecture/core/presentation/widgets/app_background.dart';
import 'package:architecture/core/presentation/widgets/border_textfield.dart';
import 'package:architecture/core/utils/validator.dart';
import 'package:architecture/features/auth/screens/widgets/white_continer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/presentation/widgets/app_dilogs.dart';
import '../../bottom navigation/export.dart';

@RoutePage()
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

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
              } else if (state is ForgotPasswordSuccessState) {
                hideOverlayLoader(context);
                context.router.push(ConfirmNewPassword(email: email.text));
              } else if (state is AuthErrorState) {
                hideOverlayLoader(context);
                // showErrorSnackbar(context, state.error);
                showErrorPopUp(
                  context: context,
                  cancelTap: () {
                    context.router.pop();
                  },
                  confirmTap: () {
                    context.router.pop();
                  },
                  message: "Error",
                  confirmButtonText: "Ok",
                  smallText: state.error,
                );
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
                              "Forgot Password",
                              style: AppTheme.bodyText1.copyWith(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w900,
                                color: AppColors.black,
                              ),
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
                            validator: (value) =>
                                Validator.validateEmail(value),
                          ),
                          const Vspace(15),
                          Center(
                            child: PrimaryButton(
                              text: "Get Verification Code",
                              onTap: () {
                                btnPress();
                              },
                              padding: EdgeInsets.zero,
                            ),
                          ),
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
    );
  }

  void btnPress() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(ForgotPasswordEvent(email: email.text));
    }
  }
}

extension on StackRouter {
  void pop() {}
}
