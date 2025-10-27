import 'package:architecture/core/data/models/intership/application_model.dart';

import '../../../core/bloc/intership/intership_bloc.dart';
import '../export.dart';

@RoutePage()
class appliedInternship extends StatefulWidget {
  const appliedInternship({super.key});

  @override
  State<appliedInternship> createState() => _appliedInternshipState();
}

class _appliedInternshipState extends State<appliedInternship> {
  List<ApplicationModel>? applicationsList;
  Map<String, dynamic> sortBy = {};

  @override
  void didChangeDependencies() {
    context.read<InternshipBloc>().add(GetMyApplicationsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarN(text: "Applied Internships"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: BlocListener<InternshipBloc, InternshipState>(
            listener: (context, state) {
              if (state is InternshipLoadingState) {
                showOverlayLoader(context);
              } else if (state is GetMyApplicationSuccessFullState) {
                hideOverlayLoader(context);
                setState(() {
                  applicationsList = state.applications;
                });
              } else if (state is InternshipErrorState) {
                hideOverlayLoader(context);
                showErrorSnackbar(context, state.error);
              } else if (state is ApplyInternShipSuccessState) {
                hideOverlayLoader(context);
                // showSnackbar(context, "InternShip Apply SuccessFully");
                context.read<InternshipBloc>().add(GetInternshipsEvent());
              }
            },
            child: applicationsList != null && applicationsList!.isEmpty
                ? const EmptyPageGraphic(
                    message:
                        "No Internships Found!\nPlease apply on an internship")
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            context.router.push(IntershipDetailsRoute(
                                id: applicationsList![index].internship!.id!));
                          },
                          child: IntershipCard(
                            internshipModel: applicationsList![index].internship!,
                            applicationModel: applicationsList![index],
                          ));
                    },
                    separatorBuilder: (context, index) {
                      return const Vspace(12);
                    },
                    itemCount: applicationsList?.length ?? 0)),
      ),
    );
  }
}
