// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:architecture/core/bloc/profile/profile_bloc.dart';
import 'package:architecture/core/utils/common_methods.dart';
import 'package:architecture/core/utils/validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/data/models/education.dart';
import '../../../core/presentation/widgets/appbar.dart';
import '../../../core/presentation/widgets/border_textfield.dart';
import '../../../core/presentation/widgets/label.dart';
import '../../../core/presentation/widgets/primary_button.dart';
import '../../../core/presentation/widgets/vspace.dart';
import '../../../core/theme/app_color.dart';
import '../widgets/date_picker.dart';

@RoutePage()
class EducationalDetailsScreen extends StatefulWidget {
  const EducationalDetailsScreen({
    Key? key,
    this.educationModel,
    required this.isUpdate,
  }) : super(key: key);
  final EducationModel? educationModel;
  final bool isUpdate;
  @override
  State<EducationalDetailsScreen> createState() =>
      _EducationalDetailsScreenState();
}

class _EducationalDetailsScreenState extends State<EducationalDetailsScreen> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController schoolCtrl = TextEditingController();
  TextEditingController degreeCtrl = TextEditingController();
  TextEditingController courseCtrl = TextEditingController();
  TextEditingController gradeCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool present = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.educationModel != null) {
        if (widget.educationModel?.startDate != null) {
          startDate.text = DateFormat(
            "d MMM yyyy",
          ).format(widget.educationModel!.startDate);
        }
        if (widget.educationModel?.endDate != null) {
          endDate.text = DateFormat(
            "d MMM yyyy",
          ).format(widget.educationModel!.endDate!);
        } else {
          present = true;
        }

        schoolCtrl.text = widget.educationModel?.instituteName ?? "";
        degreeCtrl.text = widget.educationModel?.degree ?? "";
        courseCtrl.text = widget.educationModel?.course ?? "";
        gradeCtrl.text = widget.educationModel?.grade.toString() ?? "";
        // descriptionCtrl.text = widget.educationModel?.description ?? "";
      }
      setState(() {});
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
                } else if (state
                    is AddOrUpdateEducationalDetailsSuccessFullState) {
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
                    const Vspace(20),
                    const CustomAppBar(
                      middleText: "Educational Details",
                      arrowColor: AppColors.black,
                      padding: EdgeInsets.zero,
                    ),
                    const Vspace(27),
                    const Label(
                      text1: "School/College Name",
                      isStartRequired: true,
                    ),
                    const Vspace(10),
                    BorderedTextFormField(
                      underlinedBorder: true,
                      controller: schoolCtrl,
                      hintText: "Enter your college or school name",
                      validator: (value) =>
                          Validator.isEmptyCheckValidator(value),
                    ),
                    const Vspace(18),
                    const Label(text1: "Degree", isStartRequired: true),
                    const Vspace(10),
                    BorderedTextFormField(
                      underlinedBorder: true,
                      controller: degreeCtrl,
                      hintText: "Ex- Master's",
                      validator: (value) =>
                          Validator.isEmptyCheckValidator(value),
                    ),
                    const Vspace(18),
                    const Label(text1: "Course", isStartRequired: true),
                    const Vspace(10),
                    BorderedTextFormField(
                      underlinedBorder: true,
                      controller: courseCtrl,
                      hintText: "Ex- MBA",
                      maxLength: 200,
                      validator: (value) =>
                          Validator.isEmptyCheckValidator(value),
                    ),
                    const Vspace(18),
                    const Label(text1: "Start Date", isStartRequired: true),
                    const Vspace(10),
                    ProfileDatePicker(
                      controller: startDate,
                      hint: "Start Date",
                      maxDate: endDate.text.isNotEmpty
                          ? DateFormat("d MMM yyyy").parse(endDate.text)
                          : null,
                      selectedDate: widget.educationModel?.startDate,
                      updateState: () {
                        setState(() {});
                      },
                    ),
                    const Vspace(18),
                    if (!present) const Label(text1: "End Date"),
                    if (!present) const Vspace(10),
                    if (!present)
                      ProfileDatePicker(
                        controller: endDate,
                        hint: "End Date",
                        minDate: startDate.text.isNotEmpty
                            ? DateFormat("d MMM yyyy").parse(startDate.text)
                            : null,
                        selectedDate: widget.educationModel?.endDate,
                        updateState: () {
                          setState(() {});
                        },
                      ),
                    const Vspace(9),
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(unselectedWidgetColor: AppColors.primary),
                      child: CheckboxListTile(
                        activeColor: AppColors.primary,
                        value: present,
                        title: const Text("Currently Studying Here"),
                        onChanged: (val) {
                          setState(() {
                            present = val!;
                            if (val) {
                              endDate.text = "";
                            }
                          });
                        },
                      ),
                    ),
                    const Vspace(18),
                    const Label(text1: "Grade", isStartRequired: true),
                    const Vspace(10),
                    BorderedTextFormField(
                      underlinedBorder: true,
                      controller: gradeCtrl,
                      hintText: "Your grade out of 10",
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          Validator.isEmptyCheckValidator(value),
                    ),
                    const Vspace(18),
                    // const Label(
                    //   text1: "Description",
                    //   isStartRequired: true,
                    // ),
                    // const Vspace(20),
                    // BorderedTextFormField(
                    //   controller: descriptionCtrl,
                    //   hintText: "",
                    //   maxLength: 200,
                    //   validator: (value) =>
                    //       Validator.isEmptyCheckValidator(value),
                    // ),
                    // const Divider(
                    //   color: Color(0xFFBEBEBE),
                    //   thickness: 1,
                    // ),
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
    if (_formKey.currentState?.validate() ?? false) {
      if (widget.isUpdate) {
        context.read<ProfileBloc>().add(
          AddOrUpdateEducationalDetailsEvent(
            course: courseCtrl.text,
            degree: degreeCtrl.text,
            grade: double.tryParse(gradeCtrl.text) ?? 0.0,
            instituteName: schoolCtrl.text,
            startDate: startDate.text,
            endDate: endDate.text,
            isUpdate: true,
            id: widget.educationModel!.id,
          ),
        );
      } else {
        context.read<ProfileBloc>().add(
          AddOrUpdateEducationalDetailsEvent(
            course: courseCtrl.text,
            degree: degreeCtrl.text,
            grade: double.tryParse(gradeCtrl.text) ?? 0.0,
            instituteName: schoolCtrl.text,
            startDate: startDate.text,
            endDate: endDate.text,
          ),
        );
      }
    }
  }
}

extension on StackRouter {
  void pop() {}
}
