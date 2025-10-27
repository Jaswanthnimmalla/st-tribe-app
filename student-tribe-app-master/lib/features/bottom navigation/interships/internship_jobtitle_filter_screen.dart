// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/features/bottom%20navigation/interships/internship_loction_filter_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/bloc/intership/intership_bloc.dart';
import '../../../core/presentation/widgets/border_textfield.dart';
import '../export.dart';
import 'internship_filter_screen.dart';

@RoutePage()
class JobTitleFilter extends StatefulWidget {
  const JobTitleFilter({super.key});

  @override
  State<JobTitleFilter> createState() => _JobTitleFilterState();
}

class _JobTitleFilterState extends State<JobTitleFilter> {
  InternshipBloc? intershipBloc;

  List<JobTitleHelper> financeJob = [
    JobTitleHelper(jobTitle: "Accounts"),
    JobTitleHelper(jobTitle: "Finance"),
  ];
  List<JobTitleHelper> designing = [
    JobTitleHelper(jobTitle: "Interior Designer"),
    JobTitleHelper(jobTitle: "Fashion Designer"),
    JobTitleHelper(jobTitle: "Motion Designer"),
  ];
  List<JobTitleHelper> engineering = [
    JobTitleHelper(jobTitle: "Frontend Developer"),
    JobTitleHelper(jobTitle: "Backend Developer"),
    JobTitleHelper(jobTitle: "Full Stack Developer"),
  ];

  @override
  void initState() {
    intershipBloc = context.read<InternshipBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 26).r,
              color: AppColors.primary,
              child: CustomAppBar(
                middleText: "Job Title",
                middleColor: AppColors.white,
                rightText: "Clear all",
                rightTextOnTap: () {},
              ),
            ),
            const Vspace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Label(
                    text1: "Job Title",
                    labelColor: AppColors.primary,
                  ),
                  const Vspace(10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 18,
                    ).r,
                    decoration: customShapeDecoration(),
                    child: Row(
                      children: [
                        Expanded(
                          child:
                              intershipBloc!.intershipFilter.jobTitle.isNotEmpty
                              ? Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: intershipBloc!
                                      .intershipFilter
                                      .jobTitle
                                      .map(
                                        (e) => SelectedChip(
                                          text: e,
                                          removeTap: () {
                                            setState(() {
                                              intershipBloc!
                                                  .intershipFilter
                                                  .jobTitle
                                                  .remove(e);
                                            });
                                          },
                                          label: "",
                                          selectedStipendIndex: -1,
                                          selectedDurationIndex: -1,
                                          index: -1,
                                        ),
                                      )
                                      .toList(),
                                )
                              : const BorderedTextFormField(
                                  hintText: "Search job title",
                                ),
                        ),
                        const Icon(Icons.search),
                      ],
                    ),
                  ),
                  const Vspace(10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 17,
                    ),
                    decoration: customShapeDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Label(
                          text1: "ACCOUNTING AND FINANCE",
                          fontsize: 14,
                          labelColor: Color(0xff8D8D8D),
                        ),
                        const Vspace(13),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildRow(
                              financeJob[index].jobTitle,
                              financeJob[index].isSelected,
                              (p0) {
                                setState(() {
                                  financeJob[index].isSelected =
                                      !financeJob[index].isSelected;
                                  if (!intershipBloc!.intershipFilter.jobTitle
                                      .contains(financeJob[index].jobTitle)) {
                                    intershipBloc!.intershipFilter.jobTitle.add(
                                      financeJob[index].jobTitle,
                                    );
                                  }
                                });
                              },
                            );
                          },
                          itemCount: financeJob.length,
                        ),
                        const Vspace(20),
                        const Label(
                          text1: "DESIGNING",
                          fontsize: 14,
                          labelColor: Color(0xff8D8D8D),
                        ),
                        const Vspace(13),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildRow(
                              designing[index].jobTitle,
                              designing[index].isSelected,
                              (p0) {
                                setState(() {
                                  designing[index].isSelected =
                                      !designing[index].isSelected;
                                  if (!intershipBloc!.intershipFilter.jobTitle
                                      .contains(designing[index].jobTitle)) {
                                    intershipBloc!.intershipFilter.jobTitle.add(
                                      designing[index].jobTitle,
                                    );
                                  }
                                });
                              },
                            );
                          },
                          itemCount: designing.length,
                        ),
                        const Vspace(20),
                        const Label(
                          text1: "ENGINEERING",
                          fontsize: 14,
                          labelColor: Color(0xff8D8D8D),
                        ),
                        const Vspace(13),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildRow(
                              engineering[index].jobTitle,
                              engineering[index].isSelected,
                              (p0) {
                                setState(() {
                                  engineering[index].isSelected =
                                      !engineering[index].isSelected;
                                  if (!intershipBloc!.intershipFilter.jobTitle
                                      .contains(engineering[index].jobTitle)) {
                                    intershipBloc!.intershipFilter.jobTitle.add(
                                      engineering[index].jobTitle,
                                    );
                                  }
                                });
                              },
                            );
                          },
                          itemCount: engineering.length,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PrimaryButton(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        text: "Add",
        onTap: () {
          context.router.pop();
        },
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}

class JobTitleHelper {
  String jobTitle;
  bool isSelected;
  JobTitleHelper({required this.jobTitle, this.isSelected = false});
}
