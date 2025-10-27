// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/bloc/intership/intership_bloc.dart';
import 'package:architecture/core/data/models/intership/intership_model.dart';
import 'package:architecture/core/presentation/widgets/app_dilogs.dart';
import 'package:architecture/core/presentation/widgets/app_divider.dart';
import 'package:architecture/core/presentation/widgets/border_textfield.dart';
import 'package:architecture/core/utils/validator.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';
import '../widgets/intership_detail_widget.dart';

@RoutePage()
class IntershipDetailsScreen extends StatefulWidget {
  const IntershipDetailsScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<IntershipDetailsScreen> createState() => _IntershipDetailsScreenState();
}

class _IntershipDetailsScreenState extends State<IntershipDetailsScreen> {
  int selectedButton = 0;
  InternshipModel? internshipModel;
  bool isApplied = false;
  bool bookmarked = false;
  bool showQuestions = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<InternshipBloc>().add(GetIntershipByIdEvent(id: widget.id));
    super.didChangeDependencies();
  }

  Future<dynamic> createLink() async {
    showOverlayLoader(context);
    await generateLink(
      context,
      BranchUniversalObject(
        canonicalIdentifier: 'studenttribebranch/app',
        title: internshipModel?.title ?? "",
        contentDescription: '',
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata('internshipId', widget.id),
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
      ),
      BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        stage: 'new share',
        campaign: 'campaign',
      ),
      true,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarN(
        text: "Internships",
        action: [
          IconButton(
            onPressed: () {
              createLink();
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Vspace(42),
              MultiBlocListener(
                listeners: [
                  BlocListener<InternshipBloc, InternshipState>(
                    listener: (context, state) {
                      if (state is InternshipLoadingState) {
                        showOverlayLoader(context);
                      } else if (state is GetInternshipByIdSuccessFullState) {
                        hideOverlayLoader(context);
                        setState(() {
                          internshipModel = state.interships;
                        });
                        context.read<InternshipBloc>().add(
                          CheckInternShipEvent(id: widget.id),
                        );
                      } else if (state is InternshipErrorState) {
                        hideOverlayLoader(context);
                        showErrorSnackbar(context, state.error);
                      } else if (state is ApplyInternShipSuccessState) {
                        hideOverlayLoader(context);
                        context.read<InternshipBloc>().add(
                          GetIntershipByIdEvent(id: widget.id),
                        );
                        showSuccessMessage(
                          context,
                          message: "Application Successfully Submitted!",
                        );
                      } else if (state is CheckInternShipSuccessState) {
                        hideOverlayLoader(context);
                        setState(() {
                          isApplied = state.applied;
                          bookmarked = state.bookmarked;
                        });
                      }
                    },
                  ),
                  BlocListener<ProfileBloc, ProfileState>(
                    listener: (context, state) {
                      if (state is BookmarkAddedSuccessState) {
                        context.read<InternshipBloc>().add(
                          GetIntershipByIdEvent(id: widget.id),
                        );

                        if (bookmarked == false) {
                          showSuccessSnackbar(
                            context,
                            "Bookmarked Added SuccessFully",
                          );
                        }
                      }
                    },
                  ),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: (internshipModel?.companyLogo?.isEmpty ?? true)
                              ? Container(
                                  width: 50,
                                  height: 50,
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const CircleAvatar(
                                    maxRadius: 20,
                                    backgroundColor: AppColors.primary,
                                    foregroundImage: AssetImage(
                                      AppImages.studentTribe,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor: Colors.transparent,
                                  foregroundImage: NetworkImage(
                                    internshipModel!.companyLogo ?? "",
                                  ),
                                ),
                        ),
                        const Hspace(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      internshipModel?.title ?? "",
                                      style: AppTheme.bodyText2.copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<ProfileBloc>().add(
                                        AddToBookmarksEvent(
                                          "internship",
                                          widget.id,
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      bookmarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_outline,
                                      size: 22,
                                    ),
                                  ),
                                ],
                              ),
                              const Vspace(2),
                              Text(
                                internshipModel?.companyName ?? "",
                                style: AppTheme.bodyText2.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Vspace(6),
                              Text(
                                "No of openings - ${internshipModel?.numberOfOpenings ?? 0}",
                                style: AppTheme.bodyText2.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF676767),
                                ),
                              ),
                              const Vspace(26),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: DualImageWithTextRow(
                                      text: internshipModel?.location ?? "",
                                      imagePath: AppImages.home,
                                    ),
                                  ),
                                  Expanded(
                                    child: DualImageWithTextRow(
                                      text:
                                          "${internshipModel?.duration?.years ?? ""} year ${internshipModel?.duration?.months ?? ""} months",
                                      imagePath: AppImages.calendra1,
                                    ),
                                  ),
                                ],
                              ),
                              const Vspace(28),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: DualImageWithTextRow(
                                      text:
                                          internshipModel
                                                  ?.compensation
                                                  ?.method ==
                                              "fixed"
                                          ? "INR ${internshipModel?.compensation?.amount ?? ""}/month"
                                          : "INR ${internshipModel?.compensation?.minimum ?? ""}-${internshipModel?.compensation?.maximum ?? ""}/month",
                                      imagePath: AppImages.money1,
                                    ),
                                  ),
                                  Expanded(
                                    child: DualImageWithTextRow(
                                      text: internshipModel?.type ?? "",
                                      imagePath: AppImages.stopwatch,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Vspace(30),
                    const AppDivider(),
                    const Vspace(20),
                    if (showQuestions) ...[
                      Text(
                        'Questions from the employer',
                        style: AppTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const Vspace(8),
                      Text(
                        'Recruiters use this information to find the best talent for the role.',
                        style: AppTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                          fontSize: 15,
                        ),
                      ),
                      const Vspace(20),
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => Vspace(16),
                        itemCount: internshipModel?.questions?.length ?? 0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CommonQuestionWidget(
                            onChange: (value) {
                              internshipModel?.questions![index].answer = value;
                            },
                            quesiton:
                                internshipModel?.questions?[index].question ??
                                "",
                          );
                        },
                      ),
                    ] else ...[
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              padding: EdgeInsets.zero,
                              text: "Job description",
                              onTap: () {
                                setState(() {
                                  selectedButton = 0;
                                });
                              },
                              borderColor: selectedButton == 0
                                  ? AppColors.primary
                                  : Colors.transparent,
                              textColor: selectedButton == 0
                                  ? AppColors.white
                                  : Colors.black,
                              fontsize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: selectedButton == 0
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: PrimaryButton(
                              padding: EdgeInsets.zero,
                              text: "About company",
                              onTap: () {
                                setState(() {
                                  selectedButton = 1;
                                });
                              },
                              borderColor: selectedButton == 1
                                  ? AppColors.primary
                                  : Colors.transparent,
                              textColor: selectedButton == 1
                                  ? AppColors.white
                                  : Colors.black,
                              fontsize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: selectedButton == 1
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                      const Vspace(29),
                      selectedButton == 0
                          ? JobDescription(internshipModel: internshipModel)
                          : AboutCompany(
                              companyDescription:
                                  internshipModel?.companyDescription ?? "",
                            ),
                      const Vspace(20),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: internshipModel == null
          ? Container()
          : PrimaryButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              text: isApplied ? "Applied" : "Apply Now",
              onTap: isApplied
                  ? null
                  : () {
                      if (checkIfProfileCompleted(
                            context.read<ProfileBloc>().userModel,
                          ) ==
                          false) {
                        showErrorSnackbar(context, commonProfileError);
                        return;
                      }

                      if (internshipModel!.questions!.isNotEmpty &&
                          !showQuestions) {
                        setState(() {
                          showQuestions = true;
                        });
                        return;
                      }
                      showConfirmDialog(
                        context: context,
                        message:
                            'Are you sure you want apply on this internship?',
                        cancelTap: () {
                          context.router.pop();
                        },
                        confirmTap: () {
                          context.router.pop();

                          setState(() {
                            showQuestions = false;
                          });

                          if (internshipModel?.questions != null &&
                              internshipModel!.questions!.isNotEmpty) {
                            if (_formKey.currentState?.validate() ?? false) {
                              List<Map> list = [];
                              for (
                                var i = 0;
                                i < internshipModel!.questions!.length;
                                i++
                              ) {
                                list.add({
                                  "questionId":
                                      internshipModel!.questions![i].id!,
                                  "answer":
                                      internshipModel!.questions![i].answer,
                                });
                              }
                              context.read<InternshipBloc>().add(
                                ApplyInternShipEvent(
                                  id: internshipModel!.id!,
                                  data: {"answers": list},
                                ),
                              );
                            }
                          } else {
                            context.read<InternshipBloc>().add(
                              ApplyInternShipEvent(
                                id: internshipModel!.id!,
                                data: const {},
                              ),
                            );
                          }
                        },
                      );
                    },
            ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}

class CommonQuestionWidget extends StatelessWidget {
  const CommonQuestionWidget({
    super.key,
    required this.quesiton,
    required this.onChange,
  });
  final String quesiton;
  final Function(dynamic value) onChange;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          quesiton,
          style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w700),
        ),
        const Vspace(5),
        BorderedTextFormField(
          hintText: 'Please type in your reply...',
          underlinedBorder: true,
          minLines: 1,
          maxline: null,
          onChange: onChange,
          validator: (value) => Validator.validateQuestions(value),
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ],
    );
  }
}
