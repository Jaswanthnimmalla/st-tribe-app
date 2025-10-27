// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/utils/validator.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:architecture/core/bloc/profile/profile_bloc.dart';
import 'package:architecture/core/presentation/widgets/app_dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/data/models/experience.dart';
import '../../../core/presentation/widgets/appbar.dart';
import '../../../core/presentation/widgets/border_textfield.dart';
import '../../../core/presentation/widgets/label.dart';
import '../../../core/presentation/widgets/primary_button.dart';
import '../../../core/presentation/widgets/vspace.dart';
import '../../../core/theme/app_color.dart';
import '../../../core/utils/common_methods.dart';
import '../widgets/date_picker.dart';

@RoutePage()
class ExperienceDetailsScreen extends StatefulWidget {
  const ExperienceDetailsScreen({
    Key? key,
    this.experienceModel,
    required this.isUpdate,
  }) : super(key: key);
  final ExperienceModel? experienceModel;
  final bool isUpdate;

  @override
  State<ExperienceDetailsScreen> createState() =>
      _ExperienceDetailsScreenState();
}

class _ExperienceDetailsScreenState extends State<ExperienceDetailsScreen> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController organisation = TextEditingController();
  String? employmentType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool present = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.experienceModel != null) {
        if (widget.experienceModel?.startDate != null) {
          startDate.text = DateFormat(
            "d MMM yyyy",
          ).format(widget.experienceModel!.startDate);
        }
        if (widget.experienceModel?.endDate != null) {
          endDate.text = DateFormat(
            "d MMM yyyy",
          ).format(widget.experienceModel!.endDate!);
        } else {
          present = true;
        }

        role.text = widget.experienceModel?.role ?? "";
        location.text = widget.experienceModel?.location ?? "";
        organisation.text = widget.experienceModel?.orgName ?? "";
        employmentType = capitalizeFirstLetter(
          widget.experienceModel?.employmentType,
        );
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
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoadingState) {
                showOverlayLoader(context);
              } else if (state
                  is AddOrUpdateExperienceDetailsSuccessFullState) {
                hideOverlayLoader(context);
                context.router.pop();
                context.read<ProfileBloc>().add(const GetMyProfileEvent());
              } else if (state is ProfileErrorState) {
                hideOverlayLoader(context);
                showErrorSnackbar(context, state.error);
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Vspace(20),
                    const CustomAppBar(
                      middleText: "Experience",
                      arrowColor: AppColors.black,
                      padding: EdgeInsets.zero,
                    ),
                    const Vspace(27),
                    const Label(text1: "Organisation", isStartRequired: true),
                    const Vspace(8),
                    BorderedTextFormField(
                      controller: organisation,
                      hintText: "Ex- Organisation Name",
                      underlinedBorder: true,
                      validator: (value) =>
                          Validator.isEmptyCheckValidator(value),
                    ),
                    const Vspace(18),
                    const Label(text1: "Role", isStartRequired: true),
                    const Vspace(8),
                    BorderedTextFormField(
                      controller: role,
                      hintText: "Ex- Front End Developer",
                      underlinedBorder: true,
                      validator: (value) =>
                          Validator.isEmptyCheckValidator(value),
                    ),
                    const Vspace(18),
                    const Label(
                      text1: "Employment Type",
                      isStartRequired: true,
                    ),
                    const Vspace(8),
                    AppCommonDropDown(
                      items: const ["Internship", "Full-time"],
                      selectedValue: employmentType,
                      updateState: (p0) {
                        setState(() {
                          employmentType = p0;
                        });
                      },
                      hint: "Please select",
                    ),
                    const Vspace(18),
                    const Label(text1: "Location"),
                    const Vspace(8),
                    BorderedTextFormField(
                      controller: location,
                      hintText: "Ex- Banglore, India",
                      underlinedBorder: true,
                    ),
                    const Vspace(18),
                    const Label(text1: "Start Date", isStartRequired: true),
                    const Vspace(8),
                    ProfileDatePicker(
                      controller: startDate,
                      hint: "Start Date",
                      maxDate: endDate.text.isNotEmpty
                          ? DateFormat("d MMM yyyy").parse(endDate.text)
                          : null,
                      updateState: () {
                        setState(() {});
                      },
                    ),
                    const Vspace(18),
                    if (!present) const Label(text1: "End Date"),
                    if (!present) const Vspace(8),
                    if (!present)
                      ProfileDatePicker(
                        controller: endDate,
                        minDate: startDate.text.isNotEmpty
                            ? DateFormat("d MMM yyyy").parse(startDate.text)
                            : null,
                        hint: "End Date",
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
                        title: const Text("Currently Working Here"),
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
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 20).r,
        child: PrimaryButton(
          text: "Save",
          onTap: () {
            // startDate: startDate.text,
            // endDate: endDate.text,
            // role: role.text,
            // location: location.text,
            // employmentType: employementType,
            if (!(_formKey.currentState?.validate() ?? true)) {
              return;
            }
            if (widget.isUpdate) {
              context.read<ProfileBloc>().add(
                AddOrUpdateExperienceDetailsEvent(
                  role.text,
                  lowercaseFirstLetter(employmentType) ?? "",
                  startDate.text,
                  endDate.text,
                  location.text,
                  true,
                  widget.experienceModel!.id,
                  organisation.text,
                ),
              );
            } else {
              context.read<ProfileBloc>().add(
                AddOrUpdateExperienceDetailsEvent(
                  role.text,
                  lowercaseFirstLetter(employmentType) ?? "",
                  startDate.text,
                  endDate.text,
                  location.text,
                  false,
                  widget.experienceModel?.id ?? "",
                  organisation.text,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}
