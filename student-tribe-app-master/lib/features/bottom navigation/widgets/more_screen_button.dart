// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';

class EndsInButton extends StatelessWidget {
  const EndsInButton({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 4).r,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(1.00, 0.09),
          end: Alignment(-1, -0.09),
          colors: [Color(0xFFCE202F), Color(0xFF84000B)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 30,
            offset: Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text('Ends At',
            style: AppTheme.bodyText3.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFC7C7))),
        const Hspace(5),
        Text(text,
            style: AppTheme.bodyText3.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.white))
      ]),
    );
  }
}
