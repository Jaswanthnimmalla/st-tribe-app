import 'package:architecture/features/bottom%20navigation/interships/internship_loction_filter_screen.dart';

import '../../../core/bloc/intership/intership_bloc.dart';
import '../../../core/presentation/widgets/border_textfield.dart';
import '../export.dart';
import 'internship_filter_screen.dart';

@RoutePage()
class SkillFilter extends StatefulWidget {
  const SkillFilter({super.key});

  @override
  State<SkillFilter> createState() => _SkillFilterState();
}

class _SkillFilterState extends State<SkillFilter> {
  InternshipBloc? intershipBloc;

  List<RowHelper> skills = [
    RowHelper(jobTitle: "Python"),
    RowHelper(jobTitle: "React js"),
    RowHelper(jobTitle: "Node js"),
    RowHelper(jobTitle: "UI Design"),
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
              padding: const EdgeInsets.symmetric(vertical: 26),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    ),
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
                                      .skills
                                      .map(
                                        (e) => SelectedChip(
                                          text: e,
                                          removeTap: () {
                                            setState(() {
                                              intershipBloc!
                                                  .intershipFilter
                                                  .skills
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
                          text1: "Skills",
                          fontsize: 14,
                          labelColor: Color(0xff8D8D8D),
                        ),
                        const Vspace(13),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return buildRow(
                              skills[index].jobTitle,
                              skills[index].isSelected,
                              (p0) {
                                setState(() {
                                  skills[index].isSelected =
                                      !skills[index].isSelected;
                                  if (!intershipBloc!.intershipFilter.skills
                                      .contains(skills[index].jobTitle)) {
                                    intershipBloc!.intershipFilter.skills.add(
                                      skills[index].jobTitle,
                                    );
                                  }
                                });
                              },
                            );
                          },
                          itemCount: skills.length,
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

class RowHelper {
  String jobTitle;
  bool isSelected;
  RowHelper({required this.jobTitle, this.isSelected = false});
}
