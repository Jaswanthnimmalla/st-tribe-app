// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';

class CommentPostButton extends StatelessWidget {
  const CommentPostButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 30),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFFEAEAEA),
            ),
            borderRadius: BorderRadius.circular(41),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 10,
              offset: Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add a Comment",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black.withOpacity(0.64),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              "Post",
              style: AppTheme.bodyText3.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
