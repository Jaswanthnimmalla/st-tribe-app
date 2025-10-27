// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';

class UnselectedChip extends StatelessWidget {
  const UnselectedChip(
      {Key? key,
      required this.text,
      this.color,
      this.padding,
      this.fontSize,
      this.fontWeight,
      this.borderColor,
      this.textColor,
      this.isShadowRequired = true})
      : super(key: key);
  final String? text;
  final Color? color;
  final EdgeInsets? padding;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final bool isShadowRequired;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 3).r,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: color ?? Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: isShadowRequired == false
            ? []
            : [
                BoxShadow(
                  color: borderColor ?? const Color(0x19000000),
                  blurRadius: 30,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
      ),
      child: Text(
        text ?? "",
        style: AppTheme.bodyText3.copyWith(
            fontSize:ScreenUtil().setSp(fontSize ?? 10)  ,
            color:textColor?? color ?? const Color(0xFF007528),
            fontWeight: fontWeight),
      ),
    );
  }
}
