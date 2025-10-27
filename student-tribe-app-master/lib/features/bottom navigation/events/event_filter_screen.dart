
import '../export.dart';

@RoutePage()
class EventFilterScreen extends StatefulWidget {
  const EventFilterScreen({super.key});

  @override
  State<EventFilterScreen> createState() => _EventFilterScreenState();
}

class _EventFilterScreenState extends State<EventFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 26),
          color: AppColors.primary,
          child: const CustomAppBar(
            middleText: "Filters",
            middleColor: AppColors.white,
            rightText: "Clear all",
          ),
        ),
        const Expanded(child: Vspace(0)),
        PrimaryButton(
          text: "Apply Filter",
          onTap: () {},
        )
      ]),
    );
  }
}
