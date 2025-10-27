import 'package:architecture/core/data/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';

class AvatarImageWithName extends StatelessWidget {
  final UserModel author;

  const AvatarImageWithName({super.key, this.radius, required this.author});
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          foregroundImage: author.profileImg.isEmpty
              ? null
              : NetworkImage(author.profileImg),
          radius: radius ?? 8.5,
        ),
        const Hspace(4),
        Text(
          author.name,
          style: AppTheme.bodyText3.copyWith(fontSize: 12.sp),
        )
      ],
    );
  }
}

class ImageAvatarWithName extends StatelessWidget {
  final String? imageUrl;
  final String? text;
  final double? radius;
  const ImageAvatarWithName({super.key, this.imageUrl, this.text, this.radius});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          foregroundImage: imageUrl == null || imageUrl!.isEmpty
              ? null
              : NetworkImage(imageUrl!),
          radius: radius ?? 8.5,
        ),
        const Hspace(4),
        Expanded(
          child: Text(
            text ?? "",
            style: AppTheme.bodyText3.copyWith(fontSize: 12.sp),
          ),
        )
      ],
    );
  }
}
