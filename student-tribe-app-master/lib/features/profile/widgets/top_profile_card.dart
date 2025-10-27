import 'package:architecture/core/data/models/user.dart';
import 'package:architecture/core/utils/imagepicker_util.dart';
import 'package:architecture/features/bottom%20navigation/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TopProfileCard extends StatelessWidget {
  TopProfileCard({super.key, required this.userModel});

  final UserModel userModel;
  ImagePickerUtil imagePickerUtil = ImagePickerUtil();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: 75, color: AppColors.primary),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 25).r,
          height: 100,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 7),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  imagePickerUtil.showImagePicker(context, () {
                    imagePickerUtil.uploadImage(context, (p0) {
                      context.read<ProfileBloc>().add(
                        UpdateProfileEvent(formData: p0),
                      );
                    }, "profileImg");
                  });
                },
                child: Stack(
                  children: [
                    userModel.profileImg.isEmpty
                        ? CircleAvatar(
                            radius: 40,
                            backgroundColor: AppColors.primary,
                            child: Text(
                              userModel.name
                                  .split(" ")
                                  .map((e) => e[0].toUpperCase())
                                  .join(""),
                              style: AppTheme.bodyText1.copyWith(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 40,
                            foregroundImage: NetworkImage(userModel.profileImg),
                          ),
                    Positioned(
                      top: 5,
                      right: 0,
                      child: Image.asset(AppImages.camera1),
                    ),
                  ],
                ),
              ),
              const Hspace(7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userModel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.bodyText2.copyWith(
                        color: const Color(0xFF57423F),
                      ),
                    ),
                    Text(
                      userModel.email,
                      style: AppTheme.bodyText2.copyWith(
                        color: const Color(0xFF798897),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
