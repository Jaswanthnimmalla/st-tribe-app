// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/data/models/skill.dart';
import 'package:architecture/core/data/models/user.dart';
import 'package:architecture/core/utils/common_methods.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:architecture/core/bloc/profile/profile_bloc.dart';
import 'package:architecture/core/constants/images.dart';
import 'package:architecture/core/presentation/widgets/hspace.dart';
import 'package:architecture/core/presentation/widgets/label.dart';
import 'package:architecture/core/presentation/widgets/primary_button.dart';
import 'package:architecture/core/presentation/widgets/vspace.dart';
import 'package:architecture/core/routes/router.gr.dart';
import 'package:architecture/core/theme/app_color.dart';
import 'package:architecture/core/theme/apptheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/bloc/auth/auth_bloc.dart';
import '../../../core/data/models/education.dart';
import '../../../core/data/models/experience.dart';
import '../../../core/presentation/widgets/app_dilogs.dart';
import '../widgets/add_cards.dart';
import '../widgets/top_profile_card.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    callProfileApi();
    super.didChangeDependencies();
  }

  callProfileApi() {
    context.read<ProfileBloc>().add(const GetMyProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
      ),
      body: SizedBox(
        child: MultiBlocListener(
          listeners: [
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileLoadingState) {
                  showOverlayLoader(context);
                } else if (state is GetMyProfileSuccessFullState) {
                  hideOverlayLoader(context);
                  setState(() {
                    userModel = state.userModel;
                  });
                } else if (state is ProfileErrorState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                } else if (state is UpdateProfileSuccessState) {
                  hideOverlayLoader(context);
                  callProfileApi();
                } else if (state is DeleteUserProfileSuccessFullState) {
                  hideOverlayLoader(context);
                  context.read<AuthBloc>().add(LogOutAuthEvent());
                }
              },
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoadingState) {
                  showOverlayLoader(context);
                } else {
                  hideOverlayLoader(context);
                }
                if (state is UnAuthenticatedAuthState) {
                  context.router.replaceAll([LoginRoute()]);
                }
              },
            ),
          ],
          child: userModel == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      TopProfileCard(userModel: userModel!),
                      Container(
                        width: double.infinity,
                        color: AppColors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Vspace(10),
                            Label(
                              fontWeight: FontWeight.w900,
                              text1:
                                  "Profile Completion ${userModel?.profileCompletionPercentage ?? 0}%",
                              labelColor: const Color(0xFFCE202F),
                            ),
                            const Vspace(13),
                            Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    minHeight: 8,
                                    borderRadius: BorderRadius.circular(8),
                                    backgroundColor: const Color(0xffCBCBCB),
                                    value:
                                        (double.tryParse(
                                              '${userModel?.profileCompletionPercentage}',
                                            ) ??
                                            0) /
                                        100,
                                  ),
                                ),
                                const Hspace(3),
                                Text(
                                  "${(((userModel?.profileCompletionPercentage ?? 0) / 100) * 5).toInt()}/5",
                                  style: AppTheme.bodyText3.copyWith(
                                    color: const Color(0xFF6C6C6C),
                                  ),
                                ),
                              ],
                            ),
                            const Vspace(4),
                            Text(
                              "Complete your profile to earn more st coins",
                              style: AppTheme.bodyText3.copyWith(
                                color: const Color(0xFF818181),
                              ),
                            ),
                            const Vspace(27),
                            const Label(
                              text1: "Personal Details",
                              labelColor: Color(0xFFCE202F),
                            ),
                            const Vspace(7),
                            userModel?.name != null
                                ? PersonalDetailsCard(userModel: userModel)
                                : AddCard(
                                    text: 'Add Personal Details',
                                    onTap: () async {
                                      await context.router.push(
                                        PersonalDetailsRoute(
                                          userModel: userModel,
                                        ),
                                      );
                                      callProfileApi();
                                    },
                                  ),
                            const Vspace(20),
                            const Label(
                              text1: "Educational Details",
                              labelColor: Color(0xFFCE202F),
                            ),
                            const Vspace(7),
                            userModel?.education != null &&
                                    userModel!.education.isNotEmpty
                                ? EducationalDetailsCard(
                                    educationModel: userModel?.education,
                                  )
                                : AddCard(
                                    text: 'Add Educational Details',
                                    onTap: () async {
                                      await context.router.push(
                                        EducationalDetailsRoute(
                                          educationModel: null,
                                          isUpdate: false,
                                        ),
                                      );
                                      callProfileApi();
                                    },
                                  ),
                            const Vspace(20),
                            const Label(
                              text1: "Skillsets",
                              labelColor: Color(0xFFCE202F),
                            ),
                            const Vspace(7),
                            context
                                    .read<ProfileBloc>()
                                    .userModel!
                                    .skills
                                    .isNotEmpty
                                ? SkillSetEducationCard(
                                    context
                                        .read<ProfileBloc>()
                                        .userModel!
                                        .skills,
                                  )
                                : AddCard(
                                    text: 'Add Skillsets',
                                    onTap: () async {
                                      await context.router.push(
                                        SkillSetDetailsRoute(
                                          selectedSkills: context
                                              .read<ProfileBloc>()
                                              .userModel!
                                              .skills,
                                        ),
                                      );
                                    },
                                  ),
                            const Vspace(20),
                            const Label(
                              text1: "Experience",
                              labelColor: Color(0xFFCE202F),
                            ),
                            const Vspace(7),
                            userModel?.experience != null &&
                                    userModel!.experience.isNotEmpty
                                ? ExperienceEducationCard(
                                    experienceModel: userModel!.experience,
                                  )
                                : AddCard(
                                    text: 'Add Experience',
                                    onTap: () async {
                                      await context.router.push(
                                        ExperienceDetailsRoute(
                                          experienceModel: null,
                                          isUpdate: false,
                                        ),
                                      );
                                      callProfileApi();
                                    },
                                  ),
                            const Vspace(20),
                            Row(
                              children: [
                                Expanded(
                                  child: PrimaryButton(
                                    padding: EdgeInsets.zero,
                                    text: "Delete Profile",
                                    onTap: () {
                                      showDeleteProfileDialog(
                                        context: context,
                                        message: "",
                                        smallText: "",
                                        cancelButtonText: "Cancel",
                                        cancelTap: () {
                                          Navigator.pop(context);
                                        },
                                        confirmTap: () {
                                          context.read<ProfileBloc>().add(
                                            DeleteUserProfileEvent(),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Hspace(10),
                                Expanded(
                                  child: PrimaryButton(
                                    text: "Save Profile",
                                    onTap: () {
                                      showSuccessMessage(
                                        context,
                                        message:
                                            "Successfully saved your profile",
                                      ).then((value) {
                                        context.router.pop();
                                      });
                                    },
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                            const Vspace(20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}

class ExperienceEducationCard extends StatelessWidget {
  const ExperienceEducationCard({super.key, required this.experienceModel});

  final List<ExperienceModel>? experienceModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonCards(
          child: Column(
            children: [
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.grey, height: 25),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: experienceModel?.length ?? 0,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CommonEditTitle(
                        text: experienceModel?[index].orgName ?? "",
                        onTap: () {
                          debugPrint("tapping");
                          context.router.push(
                            ExperienceDetailsRoute(
                              experienceModel: experienceModel?[index],
                              isUpdate: true,
                            ),
                          );
                        },
                      ),
                      const Vspace(6),
                      InfoRow(
                        text:
                            "${experienceModel![index].role} (${capitalizeFirstLetter(experienceModel?[index].employmentType)})",
                        imagePath: AppImages.work,
                      ),
                      const Vspace(3),
                      InfoRow(
                        text:
                            "${formatDateTimeToMonthYear(experienceModel?[index].startDate)} - ${formatDateTimeToMonthYear(experienceModel?[index].endDate)}",
                        imagePath: AppImages.work,
                      ),
                    ],
                  );
                },
              ),
              const Vspace(20),
              GestureDetector(
                onTap: () async {
                  await context.router.push(
                    ExperienceDetailsRoute(
                      experienceModel: null,
                      isUpdate: false,
                    ),
                  );
                  context.read<ProfileBloc>().add(const GetMyProfileEvent());
                },
                child: Text(
                  "+ Add More Experience",
                  style: AppTheme.bodyText3.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SkillSetEducationCard extends StatelessWidget {
  final List<SkillModel> skills;
  const SkillSetEducationCard(this.skills, {super.key});

  @override
  Widget build(BuildContext context) {
    return CommonCards(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Wrap(
              spacing: 14,
              runSpacing: 14,
              children: skills
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
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                context.router.push(
                  SkillSetDetailsRoute(
                    selectedSkills: context
                        .read<ProfileBloc>()
                        .userModel!
                        .skills,
                  ),
                );
              },
              child: Image.asset(AppImages.pencil),
            ),
          ),
        ],
      ),
    );
  }
}

class EducationalDetailsCard extends StatelessWidget {
  const EducationalDetailsCard({super.key, required this.educationModel});

  final List<EducationModel>? educationModel;

  @override
  Widget build(BuildContext context) {
    return CommonCards(
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) =>
                const Divider(color: Colors.grey, height: 25),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: educationModel?.length ?? 0,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CommonEditTitle(
                    text: educationModel?[index].instituteName ?? "",
                    onTap: () {
                      debugPrint("tapping");
                      context.router.push(
                        EducationalDetailsRoute(
                          educationModel: educationModel?[index],
                          isUpdate: true,
                        ),
                      );
                    },
                  ),
                  const Vspace(6),
                  InfoRow(
                    text: educationModel?[index].course,
                    imagePath: AppImages.schoolhat,
                  ),
                  const Vspace(3),
                  InfoRow(
                    text:
                        "${formatDateTimeToMonthYear(educationModel?[index].startDate)} - ${formatDateTimeToMonthYear(educationModel?[index].endDate)}",
                  ),
                ],
              );
            },
          ),
          const Vspace(25),
          GestureDetector(
            onTap: () async {
              await context.router.push(
                EducationalDetailsRoute(educationModel: null, isUpdate: false),
              );
              context.read<ProfileBloc>().add(const GetMyProfileEvent());
            },
            child: Text(
              "+ Add More Education Details",
              style: AppTheme.bodyText3.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PersonalDetailsCard extends StatelessWidget {
  const PersonalDetailsCard({super.key, required this.userModel});

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return CommonCards(
      child: Column(
        children: [
          CommonEditTitle(
            text: userModel?.name ?? "",
            onTap: () {
              debugPrint("tapping");
              context.router.push(PersonalDetailsRoute(userModel: userModel));
            },
          ),
          const Vspace(6),
          InfoRow(text: userModel?.email, imagePath: AppImages.mail),
          const Vspace(7),
          if (userModel?.number == null ||
              (userModel != null && userModel!.number!.isEmpty)) ...[
            // const Vspace(7),
            InfoRow(
              text: "No mobile number added",
              imagePath: AppImages.phone,
              color: Colors.grey,
            ),
          ],
          InfoRow(text: userModel?.number, imagePath: AppImages.phone),
          const Vspace(7),
          InfoRow(text: userModel?.location, imagePath: AppImages.location),
          if (userModel?.dateOfBirth != null) ...[
            const Vspace(7),
            InfoRow(
              text: DateFormat("d MMM yyyy").format(userModel!.dateOfBirth!),
              imagePath: AppImages.cake,
            ),
          ],
        ],
      ),
    );
  }
}

class CommonEditTitle extends StatelessWidget {
  const CommonEditTitle({super.key, required this.text, this.onTap});

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(text)),
        InkWell(
          onTap: () {
            if (onTap != null) onTap!();
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            color: Colors.transparent,
            child: Image.asset(AppImages.pencil),
          ),
        ),
      ],
    );
  }
}

class CommonCards extends StatelessWidget {
  const CommonCards({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20).r,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        shadows: const [
          BoxShadow(
            color: Color(0x19484848),
            blurRadius: 10,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({
    Key? key,
    this.text,
    this.imagePath,
    this.hideImg = false,
    this.color,
  }) : super(key: key);

  final String? text;
  final String? imagePath;
  final bool hideImg;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return text == null || text!.isEmpty
        ? const SizedBox()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imagePath != null
                  ? Image.asset(imagePath!)
                  : Container(width: 16),
              const Hspace(7),
              Expanded(
                child: Text(
                  text ?? "",
                  style: AppTheme.bodyText3.copyWith(
                    fontSize: 14.sp,
                    color: color ?? AppColors.black,
                  ),
                ),
              ),
            ],
          );
  }
}
