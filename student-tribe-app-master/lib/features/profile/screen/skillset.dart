import 'package:architecture/core/bloc/profile/profile_bloc.dart';
import 'package:architecture/core/utils/common_methods.dart';
import 'package:auto_route/auto_route.dart';
import 'package:architecture/core/constants/images.dart';
import 'package:architecture/core/presentation/widgets/appbar.dart';
import 'package:architecture/core/presentation/widgets/common_border.dart';
import 'package:architecture/core/presentation/widgets/hspace.dart';
import 'package:architecture/core/theme/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/data/models/skill.dart';
import '../../../core/presentation/widgets/label.dart';
import '../../../core/presentation/widgets/primary_button.dart';
import '../../../core/presentation/widgets/vspace.dart';
import '../../../core/theme/app_color.dart';

@RoutePage()
class SkillSetDetailsScreen extends StatefulWidget {
  final List<SkillModel> selectedSkills;
  const SkillSetDetailsScreen(this.selectedSkills, {super.key});

  @override
  State<SkillSetDetailsScreen> createState() => _SkillSetDetailsScreenState();
}

class _SkillSetDetailsScreenState extends State<SkillSetDetailsScreen> {
  List<SkillModel> selectedSkills = [];

  List<SkillModel> skills = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(GetAllSkillsEvent());
    });

    selectedSkills = widget.selectedSkills;

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
              } else if (state is UpdateSkillSuccessFullState) {
                hideOverlayLoader(context);
                context.router.pop();
                context.read<ProfileBloc>().add(const GetMyProfileEvent());
              } else if (state is GetAllSkillsSuccessState) {
                hideOverlayLoader(context);
                setState(() {
                  skills = state.skills;
                  for (var skill in widget.selectedSkills) {
                    skills.removeWhere((element) => element.id == skill.id);
                  }
                });
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
                    middleText: "Skillsets",
                    arrowColor: AppColors.black,
                    padding: EdgeInsets.zero,
                  ),
                  const Vspace(27),
                  const Label(text1: "Skill"),
                  const Vspace(19),
                  Wrap(
                    spacing: 14,
                    runSpacing: 14,
                    children: selectedSkills
                        .map(
                          (e) => Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 7,
                              horizontal: 14,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: IntrinsicWidth(
                              child: Row(
                                children: [
                                  Text(
                                    e.name,
                                    style: AppTheme.bodyText3.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  const Hspace(8),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSkills.remove(e);
                                        skills.add(e);
                                      });
                                    },
                                    child: Image.asset(AppImages.cross),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const Vspace(30),
                  Label(
                    text1: "Suggested skill tags:",
                    fontsize: 14.sp,
                    labelColor: const Color(0xFF676767),
                    labelfontWeight: FontWeight.w400,
                  ),
                  const Vspace(30),
                  Wrap(
                    spacing: 13,
                    runSpacing: 14,
                    children: skills
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedSkills.indexWhere(
                                      (element) => element == e.id,
                                    ) ==
                                    -1) {
                                  selectedSkills.add(e);
                                }
                                skills.removeWhere(
                                  (element) => element.id == e.id,
                                );
                              });
                            },
                            child: AppShadowBorder(
                              child: Text(
                                e.name,
                                style: AppTheme.bodyText3.copyWith(
                                  color: const Color(0xFF333333),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
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
            context.read<ProfileBloc>().add(
              UpdateSkillEvent(selectedSkills.map((e) => e.id).toList()),
            );
          },
        ),
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}
