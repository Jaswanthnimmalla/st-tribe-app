import 'package:architecture/core/presentation/widgets/border_textfield.dart';
import 'package:architecture/features/bottom%20navigation/interships/internship_filter_screen.dart';

import '../../../core/bloc/intership/intership_bloc.dart';
import '../export.dart';

@RoutePage()
class LocationFilter extends StatefulWidget {
  const LocationFilter({super.key});

  @override
  State<LocationFilter> createState() => _LocationFilterState();
}

class _LocationFilterState extends State<LocationFilter> {
  InternshipBloc? intershipBloc;
  List<String> locationList = [
    "Delhi",
    "Mumbai",
    "Banglore",
    "Ahmedabad",
    "Jaipur",
  ];

  @override
  void initState() {
    intershipBloc = context.read<InternshipBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 26),
            color: AppColors.primary,
            child: CustomAppBar(
              middleText: "Location",
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
                const Label(text1: "Location", labelColor: AppColors.primary),
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
                            intershipBloc!.intershipFilter.location.isNotEmpty
                            ? Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: intershipBloc!
                                    .intershipFilter
                                    .location
                                    .map(
                                      (e) => SelectedChip(
                                        text: e,
                                        removeTap: () {
                                          setState(() {
                                            intershipBloc!
                                                .intershipFilter
                                                .location
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
                                hintText: "Search Preferred location",
                              ),
                      ),
                      const Icon(Icons.search),
                    ],
                  ),
                ),
                const Vspace(13),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 18,
                  ),
                  decoration: customShapeDecoration(),
                  child: Wrap(
                    // alignment: WrapAlignment.center,
                    runSpacing: 10,
                    spacing: 10,
                    children: locationList
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!intershipBloc!.intershipFilter.location
                                    .contains((e))) {
                                  intershipBloc!.intershipFilter.location.add(
                                    e,
                                  );
                                }
                              });
                            },
                            child: UnselectedChip(
                              text: e,
                              color: AppColors.black,
                              borderColor: Colors.grey,
                              isShadowRequired: false,
                              fontSize: 14,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 7,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
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

ShapeDecoration customShapeDecoration() {
  return ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    shadows: const [
      BoxShadow(
        color: Color(0x19000000),
        blurRadius: 30,
        offset: Offset(0, 3),
        spreadRadius: 0,
      ),
    ],
  );
}
