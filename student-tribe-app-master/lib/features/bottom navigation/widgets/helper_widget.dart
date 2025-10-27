// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../export.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTextRowWidget extends StatelessWidget {
  const IconTextRowWidget({
    Key? key,
    required this.text,
    this.appImages,
    this.fontSize,
    this.color,
    this.hspace,
    this.imageColor,
  }) : super(key: key);
  final String text;
  final String? appImages;
  final double? fontSize;
  final Color? color;
  final double? hspace;
  final Color? imageColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        appImages == null
            ? const Hspace(15)
            : appImages!.contains("svg")
                ? SvgPicture.asset(
                    appImages!,
                    color: imageColor ?? AppColors.primary,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    appImages!,
                    color: imageColor ?? AppColors.primary,
                    fit: BoxFit.cover,
                  ),
        Hspace(hspace ?? 5),
        Expanded(
          child: Text(
            text,
            style:
                AppTheme.bodyText3.copyWith(fontSize: fontSize, color: color),
          ),
        )
      ],
    );
  }
}

class RowLabel extends StatelessWidget {
  const RowLabel(
      {super.key, required this.text1, required this.text2, this.onTap});

  final String text1;
  final String text2;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: AppTheme.bodyText2.copyWith(fontWeight: FontWeight.w700),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: AppTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w700, color: AppColors.primary),
          ),
        )
      ],
    );
  }
}
