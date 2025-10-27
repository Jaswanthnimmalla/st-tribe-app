// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/presentation/widgets/common_border.dart';
import '../export.dart';

class ProceedTap extends StatelessWidget {
  const ProceedTap(
      {Key? key,
      required this.onTap,
      this.padding,
      this.isShowSubtitleText = false,
      this.text,
      this.amountString,
      required this.leftTitle,
      this.isBoxShadowRequired = true})
      : super(key: key);
  final Function() onTap;
  final EdgeInsets? padding;
  final bool isShowSubtitleText;
  final String? text;
  final String? amountString;
  final String leftTitle;
  final bool isBoxShadowRequired;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color:
              isBoxShadowRequired == false ? Colors.transparent : Colors.white,
          boxShadow: isBoxShadowRequired == false
              ? []
              : [
                  const BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 8,
                    offset: Offset(-0.50, 0),
                    spreadRadius: 0,
                  )
                ],
        ),
        child: Column(
          children: [
            Padding(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15).r,
              child: Row(children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(leftTitle),
                    const Vspace(2),
                    Row(
                      children: [
                        Text(
                          amountString ?? "",
                          style: AppTheme.bodyText2.copyWith(
                              fontSize: 20.sp, color: AppColors.primary),
                        ),
                        if (isShowSubtitleText) ...[
                          Text(
                            "/person",
                            style: AppTheme.bodyText2.copyWith(
                                color: const Color(0xFF676767),
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ],
                    )
                  ],
                )),
                PrimaryButton(
                  text: text ?? "Proceed",
                  padding: EdgeInsets.zero,
                  innerPadding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 14)
                          .r),
                  onTap: () {
                    onTap();
                  },
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonQuantitySelector extends StatelessWidget {
  const CommonQuantitySelector({
    Key? key,
    required this.amount,
    required this.quantity,
    required this.decrease,
    required this.increase,
  }) : super(key: key);
  final double amount;
  final int quantity;
  final Function() decrease;
  final Function() increase;
  @override
  Widget build(BuildContext context) {
    return AppCommonBorder(
      borderColor: const Color(0xFFD1D1D1),
      child: Row(
        children: [
          Text(
            formattedCurrency(amount),
            style: AppTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w700, color: AppColors.primary),
          ),
          const Expanded(child: Hspace(0)),
          GestureDetector(
            onTap: () {
              if (quantity < 0) return;
              decrease();
            },
            child: Text(
              "-",
              style: AppTheme.bodyText3.copyWith(
                  color: const Color(0xFF676767),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const Hspace(17),
          Text(
            quantity.toString(),
            style: AppTheme.bodyText2.copyWith(fontWeight: FontWeight.w700),
          ),
          const Hspace(17),
          GestureDetector(
            onTap: () {
              increase();
            },
            child: Text(
              "+",
              style: AppTheme.bodyText3.copyWith(
                  color: const Color(0xFF676767),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
