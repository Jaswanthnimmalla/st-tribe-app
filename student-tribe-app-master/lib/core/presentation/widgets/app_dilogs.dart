import 'package:architecture/core/presentation/widgets/border_textfield.dart';
import 'package:architecture/features/bottom%20navigation/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future showConfirmDialog({
  required BuildContext context,
  required Function() cancelTap,
  required Function() confirmTap,
  required String message,
  String smallText = "",
  String confirmButtonText = "Yes",
  String cancelButtonText = "No",
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          message,
          textAlign: smallText.isNotEmpty ? TextAlign.start : TextAlign.center,
          style: AppTheme.bodyText2.copyWith(fontWeight: FontWeight.w500),
        ),
        content: IntrinsicHeight(
          child: Column(
            children: [
              if (smallText.isNotEmpty) ...[
                Text(
                  smallText,
                  textAlign: smallText.isNotEmpty
                      ? TextAlign.start
                      : TextAlign.center,
                  style: AppTheme.bodyText3.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Vspace(15),
              ],
              Row(
                children: [
                  Expanded(
                    child: PrimaryOutlineButton(
                      text: cancelButtonText,
                      onTap: () {
                        cancelTap();
                      },
                      textColor: AppColors.black,
                      outlineColor: const Color(0xffD9D9D9),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const Hspace(8),
                  Expanded(
                    child: PrimaryButton(
                      text: confirmButtonText,
                      onTap: () {
                        confirmTap();
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

showPaymentFailedDialog({
  required BuildContext context,
  required Function() cancelTap,
  required Function() tryAgain,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.paymentfail),
            const Vspace(19),
            Text(
              'Payment Failed',
              textAlign: TextAlign.center,
              style: AppTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            const Vspace(6),
            Text(
              'Payment did not complete',
              textAlign: TextAlign.center,
              style: AppTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            const Vspace(35),
            Row(
              children: [
                Expanded(
                  child: PrimaryOutlineButton(
                    text: "No",
                    onTap: () {
                      cancelTap();
                    },
                    textColor: AppColors.black,
                    outlineColor: const Color(0xffD9D9D9),
                    padding: EdgeInsets.zero,
                  ),
                ),
                const Hspace(8),
                Expanded(
                  child: PrimaryButton(
                    text: "Yes",
                    onTap: () {
                      tryAgain();
                    },
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

showPaymentSuccessDialog({
  required BuildContext context,
  required Function() doneTap,
  required Function() emailTap,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppImages.paymentsuccess),
            const Vspace(19),
            Text(
              'Successfully Paid',
              textAlign: TextAlign.center,
              style: AppTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            const Vspace(6),
            Text(
              'Your payment for event has been processed successfully.',
              textAlign: TextAlign.center,
              style: AppTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
            const Vspace(13),
            Text(
              'A ticket has been sent to your email',
              textAlign: TextAlign.center,
              style: AppTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: const Color(0xff007628),
              ),
            ),
            const Vspace(35),
            Row(
              children: [
                Expanded(
                  child: PrimaryOutlineButton(
                    text: "Done",
                    onTap: () {
                      doneTap();
                    },
                    textColor: AppColors.black,
                    outlineColor: const Color(0xffD9D9D9),
                    padding: EdgeInsets.zero,
                  ),
                ),
                const Hspace(8),
                Expanded(
                  child: PrimaryButton(
                    text: "Go to email",
                    onTap: () {
                      emailTap();
                    },
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

reportDialog({
  required BuildContext context,
  required Function() cancelTap,
  required Function() reportTap,
  required Function(dynamic) onChange,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        content: IntrinsicHeight(
          child: Column(
            children: [
              Text(
                'Report Article',
                textAlign: TextAlign.center,
                style: AppTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const Vspace(10),
              Text(
                'Send a complaint to us about what you disliked about the article',
                textAlign: TextAlign.center,
                style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500),
              ),
              const Vspace(10),
              BorderedTextFormField(
                hintText: "",
                underlinedBorder: false,
                maxline: 8,
                onChange: onChange,
              ),
              const Vspace(10),
              Row(
                children: [
                  Expanded(
                    child: PrimaryOutlineButton(
                      text: "Cancel",
                      fontsize: 16.sp,
                      onTap: () {
                        cancelTap();
                      },
                      textColor: AppColors.primary,
                      outlineColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const Hspace(8),
                  Expanded(
                    child: PrimaryButton(
                      text: "Report",
                      fontsize: 16.sp,
                      fontWeight: FontWeight.w700,
                      onTap: () {
                        reportTap();
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

showStCoinDilog({
  required BuildContext context,
  required Function() cancelTap,
  required Function()? purchaseTap,
  required Function(dynamic) onChange,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        content: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    context.router.pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ),
              SizedBox(
                height: 104,
                child: Stack(
                  fit: StackFit.passthrough,
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AppImages.bigcoinbg),
                    Image.asset(AppImages.bigrupee),
                  ],
                ),
              ),
              const Vspace(10),
              Text(
                'Get St. Coins Now!',
                textAlign: TextAlign.center,
                style: AppTheme.bodyText3.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              const Vspace(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Text(
                      "Quantity:",
                      style: AppTheme.bodyText3.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const Hspace(8),
                    Expanded(
                      child: BorderedTextFormField(
                        hintText: "",
                        maxLength: 8,
                        underlinedBorder: false,
                        borderColor: const Color(0xffE24653),
                        keyboardType: TextInputType.number,
                        maxline: 1,
                        onChange: onChange,
                      ),
                    ),
                  ],
                ),
              ),
              const Vspace(32),
              Row(
                children: [
                  Expanded(
                    child: PrimaryOutlineButton(
                      text: "Cancel",
                      fontsize: 15.sp,
                      onTap: cancelTap,
                      textColor: const Color(0xFF676767),
                      outlineColor: const Color(0xFFCCCCCC),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  const Hspace(8),
                  Expanded(
                    child: PrimaryButton(
                      text: "Purchase",
                      fontsize: 15.sp,
                      fontWeight: FontWeight.w700,
                      onTap: purchaseTap,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

extension on StackRouter {
  void pop() {}
}

Future showDeleteProfileDialog({
  required BuildContext context,
  required Function() cancelTap,
  required Function() confirmTap,
  required String message,
  String smallText = "",
  String confirmButtonText = "Yes",
  String cancelButtonText = "No",
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "By deleting the profile, your",
                style: AppTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 14.sp,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              TextSpan(
                text: " ST.Coins",
                style: AppTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
              ),
              TextSpan(
                text:
                    " would be depleted to zero and this is irreversible. Are you sure you want to delete your profile?",
                style: AppTheme.bodyText2.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        // Text(
        //   message,
        //   textAlign: smallText.isNotEmpty ? TextAlign.start : TextAlign.center,
        //   style:
        //       AppTheme.bodyText2.copyWith(color: Colors.black.withOpacity(0.5)),
        // ),
        content: IntrinsicHeight(
          child: Column(
            children: [
              if (smallText.isNotEmpty) ...[
                Text(
                  smallText,
                  textAlign: smallText.isNotEmpty
                      ? TextAlign.start
                      : TextAlign.center,
                  style: AppTheme.bodyText3.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Vspace(15),
              ],
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        cancelTap();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffD9D9D9)),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: AppTheme.bodyText2.copyWith(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: PrimaryOutlineButton(
                  //     innerPadding: EdgeInsets.zero,
                  //     text: cancelButtonText,
                  //     onTap: () {
                  //       cancelTap();
                  //     },
                  //     textColor: AppColors.black,
                  //     outlineColor: const Color(0xffD9D9D9),
                  //     padding: EdgeInsets.zero,
                  //   ),
                  // ),
                  const Hspace(8),

                  // Expanded(
                  //   child: PrimaryButton(
                  //     innerPadding: MaterialStatePropertyAll(EdgeInsets.zero),
                  //     text: confirmButtonText,
                  //     onTap: () {
                  //       confirmTap();
                  //     },
                  //     padding: EdgeInsets.zero,
                  //   ),
                  // )
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        confirmTap();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: AppTheme.bodyText2.copyWith(
                              color: AppColors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future showErrorPopUp({
  required BuildContext context,
  required Function() cancelTap,
  required Function() confirmTap,
  required String message,
  String smallText = "",
  String confirmButtonText = "Yes",
  String cancelButtonText = "No",
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          message,
          textAlign: smallText.isNotEmpty ? TextAlign.start : TextAlign.center,
          style: AppTheme.bodyText2.copyWith(fontWeight: FontWeight.w500),
        ),
        content: IntrinsicHeight(
          child: Column(
            children: [
              if (smallText.isNotEmpty) ...[
                Text(
                  smallText,
                  textAlign: smallText.isNotEmpty
                      ? TextAlign.start
                      : TextAlign.center,
                  style: AppTheme.bodyText3.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Vspace(15),
              ],
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: confirmButtonText,
                      onTap: () {
                        confirmTap();
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
