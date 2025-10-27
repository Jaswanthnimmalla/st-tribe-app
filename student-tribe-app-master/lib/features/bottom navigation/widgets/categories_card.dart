import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';



class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: ShapeDecoration(
            color: const Color(0xFFD9D9D9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        ),
        const Vspace(6),
        Text(
          "Workshops",
          style: AppTheme.bodyText3.copyWith(fontSize: 10.sp),
        ),
      ],
    );
  }
}
