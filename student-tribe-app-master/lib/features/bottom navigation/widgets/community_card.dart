import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
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
      child: Column(
        children: [
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // AvatarImageWithName(),
                UnselectedChip(
                  text: "Design Tribe",
                  color: AppColors.primary,
                )
              ]),
          const Vspace(7),
          Text(
            "Have you recently observed a change in parenting style?",
            style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w700),
          ),
          const Vspace(10),
          Row(
            children: [
              Image.asset(
                AppImages.heart,
                height: 14,
                width: 15,
              ),
              const Hspace(3),
              Text(
                "2k",
                style: AppTheme.bodyText3
                    .copyWith(fontSize: 14.sp, color: const Color(0xFF676767)),
              ),
              const Hspace(13),
              Image.asset(
                AppImages.comment,
                height: 14,
                width: 15,
              ),
              const Hspace(3),
              Text(
                "200",
                style: AppTheme.bodyText3
                    .copyWith(fontSize: 14.sp, color: const Color(0xFF676767)),
              ),
              const Expanded(child: Hspace(0)),
              Image.asset(AppImages.share)
            ],
          )
        ],
      ),
    );
  }
}
