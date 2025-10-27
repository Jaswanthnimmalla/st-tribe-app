// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/bloc/intership/intership_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../export.dart';

@RoutePage()
class IntershipFilterScreen extends StatefulWidget {
  const IntershipFilterScreen({super.key});

  @override
  State<IntershipFilterScreen> createState() => _IntershipFilterScreenState();
}

class _IntershipFilterScreenState extends State<IntershipFilterScreen> {
  InternshipBloc? intershipBloc;
  int selectedStipendIndex = -1;
  int selectedDurationIndex = -1;

  @override
  void initState() {
    intershipBloc = context.read<InternshipBloc>();
    super.initState();
  }

  updateState() {
    setState(() {});
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
                middleText: "Filters",
                middleColor: AppColors.white,
                rightText: "Clear all",
                rightTextOnTap: () {},
              ),
            ),
            const Vspace(34),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FilterCommonWidget(
                  //   text: "Location",
                  //   updateState: updateState,
                  //   data: intershipBloc!.intershipFilter.location,
                  //   goToFilter: () async {
                  //     await context.router.push(const LocationFilter());
                  //     setState(() {});
                  //   },
                  // ),
                  // const Vspace(37),
                  // FilterCommonWidget(
                  //     text: "Job Title",
                  //     updateState: updateState,
                  //     data: intershipBloc!.intershipFilter.jobTitle,
                  //     goToFilter: () async {
                  //       await context.router.push(const JobTitleFilter());
                  //       setState(() {});
                  //     }),
                  // const Vspace(37),
                  // FilterCommonWidget(
                  //     text: "Skills",
                  //     updateState: updateState,
                  //     data: intershipBloc!.intershipFilter.skills,
                  //     goToFilter: () async {
                  //       await context.router.push(const SkillFilter());
                  //       setState(() {});
                  //     }),
                  // const Vspace(37),
                  FilterCommonWidget(
                    text: "Stipend",
                    updateState: updateState,
                    data: intershipBloc!.intershipFilter.stipend,
                    isAddWidgetRequired: false,
                    selectedStipendIndex: selectedStipendIndex,
                    updateStipendandDuration: (p0) {
                      setState(() {
                        selectedStipendIndex = p0;
                      });
                    },
                  ),
                  const Vspace(37),
                  FilterCommonWidget(
                    text: "Duration",
                    updateState: updateState,
                    data: intershipBloc!.intershipFilter.duration,
                    isAddWidgetRequired: false,
                    selectedDurationIndex: selectedDurationIndex,
                    updateStipendandDuration: (p0) {
                      setState(() {
                        selectedDurationIndex = p0;
                      });
                    },
                  ),
                  const Vspace(37),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PrimaryButton(
        text: "Apply Filter",
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        onTap: () {
          Map<String, dynamic> filter = {};
          if (selectedStipendIndex != -1) {
            filter["compensation.amount[gte]"] = intershipBloc!
                .intershipFilter
                .stipend[selectedStipendIndex]
                .replaceAll(RegExp(r"\D"), "");
          }
          if (selectedDurationIndex != -1) {
            filter["duration.months[gte]"] = intershipBloc!
                .intershipFilter
                .duration[selectedDurationIndex]
                .replaceAll(RegExp(r"\D"), "");
          }
          context.read<InternshipBloc>().add(
            GetInternshipsEvent(sortBy: filter),
          );
          context.router.pop();
        },
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}

class FilterCommonWidget extends StatelessWidget {
  const FilterCommonWidget({
    Key? key,
    required this.text,
    required this.data,
    required this.updateState,
    this.updateStipendandDuration,
    this.selectedStipendIndex = -1,
    this.selectedDurationIndex = -1,
    this.goToFilter,
    this.isAddWidgetRequired = true,
  }) : super(key: key);
  final String text;
  final List<String> data;
  final bool isAddWidgetRequired;
  final Function() updateState;
  final int selectedStipendIndex;
  final int selectedDurationIndex;
  final Function(int)? updateStipendandDuration;
  final Function()? goToFilter;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Label(
              text1: text,
              labelColor: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontsize: 16.sp,
            ),
            if (isAddWidgetRequired) ...[
              GestureDetector(
                onTap: () {
                  if (goToFilter != null) {
                    goToFilter!();
                  }
                },
                child: const Icon(Icons.add, color: AppColors.primary),
              ),
            ],
          ],
        ),
        const Vspace(14),
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: data.map((e) {
            int index = data.indexOf(e);
            return GestureDetector(
              onTap: () {
                if (updateStipendandDuration != null) {
                  updateStipendandDuration!(index);
                }
              },
              child: SelectedChip(
                text: e,
                removeTap: () {
                  data.remove(e);
                  updateState();
                },
                label: text,
                selectedDurationIndex: selectedDurationIndex,
                selectedStipendIndex: selectedStipendIndex,
                index: index,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SelectedChip extends StatelessWidget {
  const SelectedChip({
    Key? key,
    required this.text,
    required this.removeTap,
    required this.label,
    required this.selectedStipendIndex,
    required this.selectedDurationIndex,
    required this.index,
  }) : super(key: key);
  final String text;
  final Function() removeTap;
  final String label;
  final int selectedStipendIndex;
  final int selectedDurationIndex;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
      decoration: BoxDecoration(
        color: label.contains("Stipend") || label.contains("Duration")
            ? (label.contains("Stipend") && selectedStipendIndex == index) ||
                      (label.contains("Duration") &&
                          selectedDurationIndex == index)
                  ? AppColors.primary
                  : const Color(0xffF5F5F5)
            : AppColors.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: IntrinsicWidth(
        child: Row(
          children: [
            Text(
              text,
              style: AppTheme.bodyText3.copyWith(
                color: label.contains("Stipend") || label.contains("Duration")
                    ? (label.contains("Stipend") &&
                                  selectedStipendIndex == index) ||
                              (label.contains("Duration") &&
                                  selectedDurationIndex == index)
                          ? AppColors.white
                          : AppColors.black
                    : AppColors.white,
              ),
            ),
            if (label.contains("Stipend") || label.contains("Duration"))
              ...[]
            else ...[
              const Hspace(8),
              GestureDetector(
                onTap: () {
                  removeTap();
                },
                child: Image.asset(AppImages.cross),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
