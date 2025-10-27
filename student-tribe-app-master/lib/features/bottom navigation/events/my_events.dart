import '../../../core/bloc/event/events_bloc.dart';
import '../../../core/data/models/event/booking_model.dart';
import '../export.dart';

@RoutePage()
class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  List<BookingModel>? bookingModelList;

  @override
  void didChangeDependencies() {
    context.read<EventBloc>().add(GetMyBookingsEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarN(text: "My Bookings"),
      body: BlocListener<EventBloc, EventState>(
          listener: (context, state) {
            if (state is EventLoadingState) {
              showOverlayLoader(context);
            } else if (state is GetMyBookingSuccessFullState) {
              hideOverlayLoader(context);
              setState(() {
                bookingModelList = state.bookingModelList;
              });
            } else if (state is EventErrorState) {
              hideOverlayLoader(context);
              showErrorSnackbar(context, state.error);
            }
          },
          child: bookingModelList != null && bookingModelList!.isEmpty
              ? const EmptyPageGraphic(
                  message: "No Bookings Found!\nPlease make a booking first")
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Vspace(19),
                        ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    //! Go to event E Ticket
                                    context.router.push(EticketRoute(
                                        bookingModel: bookingModelList![index],
                                        eventModel:
                                            bookingModelList![index].event!,
                                        totalPrice: bookingModelList![index]
                                            .payment!
                                            .ticketAmount!));
                                  },
                                  child: CommonEventCard(
                                    eventModel: bookingModelList![index].event!,
                                    isShowRegisterButton: false,
                                  ));
                            },
                            separatorBuilder: (context, index) {
                              return const Vspace(12);
                            },
                            itemCount: bookingModelList?.length ?? 0),
                        const Vspace(20)
                      ]),
                )),
    );
  }
}
