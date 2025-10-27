// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:architecture/core/bloc/profile/profile_bloc.dart';
import 'package:architecture/core/data/models/user.dart';
import 'package:architecture/core/presentation/widgets/appbar.dart';
import 'package:architecture/core/presentation/widgets/border_textfield.dart';
import 'package:architecture/core/presentation/widgets/label.dart';
import 'package:architecture/core/presentation/widgets/primary_button.dart';
import 'package:architecture/core/presentation/widgets/vspace.dart';
import 'package:architecture/core/theme/app_color.dart';
import 'package:architecture/core/utils/common_methods.dart';
import 'package:architecture/core/utils/validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/presentation/widgets/app_dropdown.dart';
import '../widgets/date_picker.dart';

@RoutePage()
class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({Key? key, this.userModel}) : super(key: key);
  final UserModel? userModel;

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  String? selectedGender;
  TextEditingController birthdayController = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController mobile = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ProfileBloc? profileBloc;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.userModel != null) {
        birthdayController.text = widget.userModel?.dateOfBirth != null
            ? DateFormat("d MMM yyyy").format(widget.userModel!.dateOfBirth!)
            : "";
        fullName.text = widget.userModel?.name ?? "";
        email.text = widget.userModel?.email ?? "";
        about.text = widget.userModel?.aboutMe ?? "";
        location.text = widget.userModel?.location ?? "";
        mobile.text = widget.userModel?.number ?? "";

        selectedGender = capitalizeFirstLetter(widget.userModel?.gender);
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: AppColors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: Form(
            key: _formKey,
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoadingState) {
                  showOverlayLoader(context);
                } else if (state is UpdateProfileSuccessState) {
                  hideOverlayLoader(context);
                  context.router.pop();
                  context.read<ProfileBloc>().add(const GetMyProfileEvent());
                } else if (state is ProfileErrorState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    const Vspace(30),
                    const CustomAppBar(
                      middleText: "Personal Details",
                      arrowColor: AppColors.black,
                      padding: EdgeInsets.zero,
                    ),
                    const Vspace(27),
                    const Label(text1: "Full Name", isStartRequired: true),
                    const Vspace(30),
                    BorderedTextFormField(
                      underlinedBorder: true,
                      controller: fullName,
                      hintText: "Your Name",
                      validator: (value) => Validator.validateName(value),
                    ),
                    const Vspace(18),
                    const Label(text1: "Email", isStartRequired: true),
                    const Vspace(30),
                    BorderedTextFormField(
                      underlinedBorder: true,
                      controller: email,
                      enabled: false,
                      hintText: "xyz@gmail.com",
                    ),
                    const Vspace(18),
                    const Label(text1: "About me", isStartRequired: true),
                    const Vspace(30),
                    BorderedTextFormField(
                      underlinedBorder: true,
                      controller: about,
                      hintText: "Write about yourself",
                      maxLength: 200,
                      validator: (value) =>
                          Validator.isEmptyCheckValidator(value),
                    ),
                    const Vspace(18),
                    const Label(text1: "Location", isStartRequired: true),
                    const Vspace(30),
                    BorderedTextFormField(
                      underlinedBorder: true,
                      controller: location,
                      hintText: "Ex: Indore (M.P)",
                      validator: (value) =>
                          Validator.isEmptyCheckValidator(value),
                    ),
                    const Vspace(18),
                    const Label(text1: "Birthday"),
                    const Vspace(30),
                    ProfileDatePicker(
                      controller: birthdayController,
                      hint: "Please select your Date of Birth",
                      selectedDate: widget.userModel?.dateOfBirth,
                      updateState: () {
                        setState(() {});
                      },
                    ),
                    const Vspace(18),
                    const Label(text1: "Gender", isStartRequired: true),
                    const Vspace(30),
                    AppCommonDropDown(
                      items: const ["Male", "Female", "Other"],
                      selectedValue: selectedGender,
                      hint: 'Please Select',
                      updateState: (p0) {
                        setState(() {
                          selectedGender = p0;
                        });
                      },
                    ),
                    const Vspace(18),
                    const Label(text1: "Mobile", isStartRequired: true),
                    const Vspace(30),
                    BorderedTextFormField(
                      underlinedBorder: true,
                      controller: mobile,
                      hintText: "Enter your Mobile Number",
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      validator: (value) =>
                          Validator.validateMobileNumber(value),
                    ),
                    const Vspace(18),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 20).r,
        child: PrimaryButton(
          text: "Save",
          onTap: () {
            savePress();
          },
        ),
      ),
    );
  }

  void savePress() {
    if (selectedGender == null) {
      showErrorSnackbar(context, "Please Select Gender");
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      // fullName: fullName.text,
      // email: email.text,
      // aboutMe: about.text,
      // location: location.text,
      // birthday: birthdayController.text,
      // gender: selectedGender,
      // mobileNo: mobile.text,
      FormData formData = FormData.fromMap({
        "name": fullName.text,
        "aboutMe": about.text,
        "location": location.text,
        "dateOfBirth": birthdayController.text,
        "gender": lowercaseFirstLetter(selectedGender!),
        "number": mobile.text,
      });
      context.read<ProfileBloc>().add(UpdateProfileEvent(formData: formData));
    }
  }
}

extension on StackRouter {
  void pop() {}
}
