// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/bloc/event/events_bloc.dart';
import 'package:architecture/core/data/entity/create_booking_entity.dart';
import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:architecture/core/data/models/groupbyin.dart';
import 'package:architecture/core/data/models/stcoin.dart';
import 'package:flutter/services.dart';

import '../../../core/data/models/event/ticket_model.dart';
import '../../../core/presentation/widgets/border_textfield.dart';
import '../../../core/utils/validator.dart';
import '../export.dart';
import '../interships/internship_details_screen.dart';
import '../widgets/proceed_tap_button.dart';

@RoutePage()
class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({
    Key? key,
    this.eventModel,
    this.groupByInModel,
    this.stcoinModel,
    this.stPointQuantity,
    required this.screenType,
    required this.totalPrice,
  }) : super(key: key);

  final EventModel? eventModel;
  final GroupByInModel? groupByInModel;
  final StcoinModel? stcoinModel;
  final int? stPointQuantity;
  final num totalPrice;
  final ScreenType screenType;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late List<TextEditingController> nameList;
  late List<TextEditingController> emailList;
  late List<TextEditingController> mobileList;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  num ticketQuantity = 0;

  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().createEventBookingEntity.attendees = [];
    if (widget.screenType == ScreenType.EVENT) {
      ticketQuantity = ticketsQty(widget.eventModel!.tickets!);
    }
  }

  num ticketsQty(List<TicketModel>? list) {
    num qty = 0;
    if (list != null && list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        if (list[i].qty! > 0) {
          qty += list[i].qty!;
        }
      }
    }

    nameList = List.generate(
      int.parse((qty).toString()),
      (index) => TextEditingController(),
    );
    emailList = List.generate(
      int.parse((qty).toString()),
      (index) => TextEditingController(),
    );
    mobileList = List.generate(
      int.parse((qty).toString()),
      (index) => TextEditingController(),
    );

    return qty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarN(text: "Checkout"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (widget.screenType == ScreenType.EVENT) ...[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Vspace(18),
                        Label(text1: "Ticket ${index + 1}"),
                        const Vspace(2),
                        Text(
                          "Please enter below details of the attendee",
                          style: AppTheme.bodyText2.copyWith(
                            color: const Color(0xFF8D8D8D),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Vspace(31),
                        const Label(text1: "Name", isStartRequired: true),
                        const Vspace(9),
                        BorderedTextFormField(
                          hintText: "Enter your name",
                          controller: nameList[index],
                          validator: (value) => Validator.validateName(value),
                        ),
                        const Vspace(18),
                        const Label(text1: "Email", isStartRequired: true),
                        const Vspace(9),
                        BorderedTextFormField(
                          hintText: "Enter your email",
                          controller: emailList[index],
                          validator: (value) => Validator.validateEmail(value),
                        ),
                        const Vspace(18),
                        const Label(text1: "Mobile", isStartRequired: true),
                        const Vspace(9),
                        BorderedTextFormField(
                          hintText: "Enter your mobile no",
                          controller: mobileList[index],
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          maxLength: 10,
                          validator: (value) =>
                              Validator.validateMobileNumber(value),
                        ),
                        const Vspace(18),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Vspace(20);
                  },
                  itemCount: int.parse(ticketQuantity.toString()),
                ),

                //! QUESTIONS AND ANSWERS
                if (widget.eventModel?.questions != null &&
                    widget.eventModel!.questions!.isNotEmpty) ...[
                  const Vspace(20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Questions',
                      style: AppTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Vspace(20),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: widget.eventModel?.questions?.length ?? 0,
                    separatorBuilder: (context, index) {
                      return const Vspace(15);
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CommonQuestionWidget(
                        onChange: (value) {
                          widget.eventModel?.questions![index].answer = value;
                        },
                        quesiton:
                            widget.eventModel?.questions?[index].question ?? "",
                      );
                    },
                  ),
                ],
              ],

              // else ...[
              //   Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Vspace(18),
              //       // Label(
              //       //   text1: "Ticket ${index + 1}",
              //       // ),
              //       // const Vspace(2),
              //       Text(
              //         "Please share details",
              //         style: AppTheme.bodyText2.copyWith(
              //             color: const Color(0xFF8D8D8D),
              //             fontWeight: FontWeight.w700),
              //       ),
              //       const Vspace(31),
              //       const Label(
              //         text1: "Name",
              //         isStartRequired: true,
              //       ),
              //       const Vspace(9),
              //       BorderedTextFormField(
              //         hintText: "Enter your name",
              //         controller: name,
              //         validator: (value) => Validator.validateName(value),
              //       ),
              //       const Vspace(18),
              //       const Label(
              //         text1: "Email",
              //         isStartRequired: true,
              //       ),
              //       const Vspace(9),
              //       BorderedTextFormField(
              //         hintText: "Enter your email",
              //         controller: email,
              //         validator: (value) => Validator.validateEmail(value),
              //       ),
              //       const Vspace(18),
              //       const Label(
              //         text1: "Mobile",
              //         isStartRequired: true,
              //       ),
              //       const Vspace(9),
              //       BorderedTextFormField(
              //         hintText: "Enter your mobile no",
              //         controller: mobile,
              //         keyboardType: TextInputType.phone,
              //         maxLength: 10,
              //         validator: (value) =>
              //             Validator.validateMobileNumber(value),
              //       ),
              //       const Vspace(18),
              //     ],
              //   )
              // ]
            ],
          ),
        ),
      ),
      bottomNavigationBar: ProceedTap(
        leftTitle: "Total Price",
        amountString: formattedCurrency(widget.totalPrice),
        onTap: () {
          buyTicketPress();
        },
        text: "Buy ticket",
      ),
    );
  }

  void buyTicketPress() {
    if (_formKey.currentState?.validate() ?? false) {
      for (int i = 0; i < nameList.length; i++) {
        context.read<EventBloc>().createEventBookingEntity.attendees!.add(
          AttendeesModel(
            name: nameList[i].text,
            email: emailList[i].text,
            phone: mobileList[i].text,
          ),
        );
      }

      context.router.push(
        BuyTicketRoute(
          eventModel: widget.eventModel,
          totalPrice: widget.totalPrice,
          screenType: widget.screenType,
          groupByInModel: widget.groupByInModel,
          stcoinModel: widget.stcoinModel,
          stPointQuantity: widget.stPointQuantity,
        ),
      );
    }
  }
}
