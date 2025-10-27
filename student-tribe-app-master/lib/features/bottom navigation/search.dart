// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/data/models/article.dart';
import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:architecture/core/data/models/intership/intership_model.dart';

import 'package:architecture/core/presentation/widgets/border_textfield.dart';

import '../../core/bloc/event/events_bloc.dart';
import '../../core/bloc/home/home_bloc.dart';
import '../../core/data/entity/create_booking_entity.dart';
import '../../core/data/models/event/payment_model.dart';
import './export.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
    required this.screenType,
  }) : super(key: key);

  final String screenType;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<EventModel>? eventsList;
  List<InternshipModel>? internshipsList;
  List<ArticleModel>? articles;

  bool showText = false;

  @override
  void initState() {
    super.initState();
  }

  // void callSearchApi() {
  //   switch (widget.screenType) {
  //     case "Home":
  //       break;
  //     case "Events":
  //       break;
  //     case "Internships":
  //       break;
  //     case "More":
  //       break;
  //     default:
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 10,
        backgroundColor: AppColors.primary,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(6)),
          child: BorderedTextFormField(
            controller: _searchController,
            hintText: "search...",
            noBorder: true,
            onFieldSubmitted: (p0) {
              context.read<HomeBloc>().add(
                  SearchByQueryEvent(query: {"query": _searchController.text}));
            },
            suffix: GestureDetector(
                onTap: () {
                  context.read<HomeBloc>().add(SearchByQueryEvent(
                      query: {"query": _searchController.text}));
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: const Icon(Icons.search)),
          ),
        ),
        actions: const [Hspace(40)],
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is SearchLoadingState) {
            showOverlayLoader(context);
          } else if (state is SearchByQuerySuccessFullState) {
            hideOverlayLoader(context);
            setState(() {
              showText = true;
              eventsList = state.eventsList;
              internshipsList = state.internshipList;
              articles = state.articleList;
            });
          } else if (state is SearchFailureState) {
            hideOverlayLoader(context);
            showErrorSnackbar(context, state.error);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 26),
              //   color: AppColors.primary,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Expanded(
              //         child: CustomAppBar(
              //           middleWidget: Container(
              //               decoration: BoxDecoration(
              //                   color: AppColors.white,
              //                   borderRadius: BorderRadius.circular(6)),
              //               child: BorderedTextFormField(
              //                 hintText: "search...",
              //                 noBorder: true,
              //                 suffix: Icon(Icons.search),
              //               )),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const Vspace(24),
              showText
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Showing results for ${_searchController.text}",
                        style: AppTheme.bodyText2.copyWith(fontSize: 18),
                      ),
                    )
                  : const EmptyPageGraphic(message: "Search your query"),

              const Vspace(8),
              ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          context.router.push(IntershipDetailsRoute(
                              id: internshipsList![index].id!));
                        },
                        child: IntershipCard(
                          internshipModel: internshipsList![index],
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return const Vspace(12);
                  },
                  itemCount: internshipsList?.length ?? 0),

              const Vspace(8),

              ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          //!Resetting entity whenever event details click
                          context.read<EventBloc>().createEventBookingEntity =
                              CreateEventBookingEntity(
                                  payment: PaymentModel(),
                                  paymentMethod: "",
                                  tickets: []);
                          //! Go to event details
                          context.router.push(
                              EventDetailsRoute(id: eventsList![index].id!));
                        },
                        child: CommonEventCard(
                          eventModel: eventsList![index],
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return const Vspace(12);
                  },
                  itemCount: eventsList?.length ?? 0),

              const Vspace(8),

              ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          context.router
                              .push(MoreDetails(id: articles![index].id));
                        },
                        child: ArticleCard(article: articles![index]));
                  },
                  separatorBuilder: (context, index) {
                    return const Vspace(12);
                  },
                  itemCount: articles?.length ?? 0)
            ],
          ),
        ),
      ),
    );
  }
}
