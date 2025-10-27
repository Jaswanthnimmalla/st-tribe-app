// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:architecture/features/bottom%20navigation/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:architecture/core/presentation/widgets/app_divider.dart';
import 'package:architecture/core/utils/imagepicker_util.dart';
import 'package:architecture/features/auth/screens/widgets/white_continer.dart';

import '../../../core/presentation/widgets/app_background.dart';

@RoutePage()
class UploadCollegeIdScreen extends StatefulWidget {
  const UploadCollegeIdScreen({super.key});

  @override
  State<UploadCollegeIdScreen> createState() => _UploadCollegeIdScreenState();
}

class _UploadCollegeIdScreenState extends State<UploadCollegeIdScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ImagePickerUtil imagePickerUtil = ImagePickerUtil();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackGround(
        child: Form(
          key: _formKey,
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoadingState) {
                showOverlayLoader(context);
              } else if (state is UpdateProfileSuccessState) {
                hideOverlayLoader(context);
                showSuccessMessage(context,
                        message: "College ID SuccessFully Uploaded.")
                    .then((value) {
                  context.router.replaceAll([const BottomNavigationRoute()]);
                });
              } else if (state is ProfileErrorState) {
                hideOverlayLoader(context);
                showErrorSnackbar(context, state.error);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Platform.isAndroid ? const Vspace(40) : const Vspace(0),
                  CustomAppBar(
                    rightText: "Skip",
                    rightTextOnTap: () {
                      context.router
                          .replaceAll([const BottomNavigationRoute()]);
                    },
                  ),
                  const Vspace(50),
                  // Image.asset(AppImages.studentTribe),
                  SvgPicture.asset(
                    'assets/svg/stlogo_transparent.svg',
                    height: 100.h,
                    width: 100.w,
                  ),
                  const Vspace(40),
                  Expanded(
                    child: AuthWhiteContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Vspace(29),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Upload College ID Card",
                              style: AppTheme.bodyText1.copyWith(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.black),
                            ),
                          ),
                          const Vspace(39),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text('Upload ID card',
                                style: AppTheme.bodyText3.copyWith(
                                    color: const Color(0xFF585858),
                                    fontWeight: FontWeight.w700)),
                          ),
                          const Vspace(15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                                'By uploading your ID Card you will be able to login to our application',
                                style: AppTheme.bodyText3.copyWith(
                                  color: const Color(0xFF585858),
                                )),
                          ),
                          const Vspace(20),
                          imagePickerUtil.pickedImage().path.isNotEmpty
                              ? Image.file(
                                  imagePickerUtil.pickedImage(),
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                )
                              : const SizedBox(),
                          const Expanded(child: Vspace(0)),
                          const AppDivider(
                            color: Color(0x33000000),
                          ),
                          const Vspace(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    imagePickerUtil.getImage(
                                      ImageSource.camera,
                                      context,
                                      () {
                                        setState(() {});
                                        imagePickerUtil.uploadImage(context,
                                            (p0) {
                                          context.read<ProfileBloc>().add(
                                              UpdateProfileEvent(formData: p0));
                                        }, "studentIdImg");
                                      },
                                    );
                                  },
                                  child: Image.asset(AppImages.camera)),
                              const VerticalDivider(),
                              GestureDetector(
                                  onTap: () {
                                    // ImagePicker()
                                    //     .pickImage(source: ImageSource.gallery);
                                    imagePickerUtil.getImage(
                                      ImageSource.gallery,
                                      context,
                                      () {
                                        setState(() {});

                                        imagePickerUtil.uploadImage(context,
                                            (p0) {
                                          context.read<ProfileBloc>().add(
                                              UpdateProfileEvent(formData: p0));
                                        }, "studentIdImg");
                                      },
                                    );
                                  },
                                  child: Image.asset(AppImages.gallery)),
                            ],
                          ),
                          const Vspace(20)
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
