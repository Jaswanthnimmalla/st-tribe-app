// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:architecture/core/bloc/event/events_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:architecture/core/data/models/event/event_model.dart';
import 'package:architecture/core/presentation/widgets/app_dilogs.dart';
import 'package:architecture/core/presentation/widgets/border_textfield.dart';
import 'package:architecture/core/utils/validator.dart';

import '../export.dart';
import '../widgets/proceed_tap_button.dart';

@RoutePage()
class DebitCreditCardScreen extends StatefulWidget {
  const DebitCreditCardScreen({
    Key? key,
    required this.totalPrice,
    required this.eventModel,
  }) : super(key: key);
  final num totalPrice;
  final EventModel eventModel;
  @override
  State<DebitCreditCardScreen> createState() => _DebitCreditCardScreenState();
}

class _DebitCreditCardScreenState extends State<DebitCreditCardScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController expiryDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showConfirmDialog(
          context: context,
          message: 'Are you sure you want to cancel the transaction',
          cancelTap: () {
            context.router.pop();
          },
          confirmTap: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
        );
        return Future.value(true);
      },
      child: Scaffold(
        appBar: const AppBarN(text: "Debit and Credit Card"),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: BlocConsumer<EventBloc, EventState>(
              listener: (context, state) {
                if (state is EventLoadingState) {
                  showOverlayLoader(context);
                } else if (state is CreateEventBookingSuccessFullState) {
                  hideOverlayLoader(context);
                  context.router.replaceAll([
                    const BottomNavigationRoute(),
                    const MyEvents(),
                  ]);
                } else if (state is EventErrorState) {
                  hideOverlayLoader(context);
                  showErrorSnackbar(context, state.error);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    const Vspace(24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Label(text1: "Enter your card details"),
                          const Vspace(25),
                          const Label(text1: "Card Holder Name*"),
                          const Vspace(8),
                          BorderedTextFormField(
                            controller: cardHolderName,
                            hintText: "Enter card holder's name",
                            validator: (value) => Validator.validateName(value),
                          ),
                          const Vspace(25),
                          const Label(text1: "Card Number*"),
                          const Vspace(8),
                          BorderedTextFormField(
                            hintText: "",
                            controller: cardNumber,
                            keyboardType: TextInputType.number,
                            onChange: (value) {},
                            validator: (value) =>
                                Validator.validateCreditCardNumber(value),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                              CardNumberInputFormatter(),
                            ],
                          ),
                          const Vspace(25),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Label(text1: "CVV*"),
                                    const Vspace(8),
                                    BorderedTextFormField(
                                      hintText: "",
                                      controller: cvv,
                                      validator: (value) =>
                                          Validator.validateCVV(value),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        CreditCardCvcInputFormatter(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Hspace(12),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Label(text1: "Expiry Date*"),
                                    const Vspace(8),
                                    BorderedTextFormField(
                                      hintText: "",
                                      controller: expiryDate,
                                      keyboardType: TextInputType.number,
                                      validator: (value) =>
                                          Validator.validateExpiryDate(value),
                                      inputFormatters: [
                                        CreditCardExpirationDateFormatter(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: ProceedTap(
          onTap: () {
            buyTicketPress();
          },
          leftTitle: "Total Price",
          text: "Buy Ticket",
          amountString: formattedCurrency(widget.totalPrice),
        ),
      ),
    );
  }

  void buyTicketPress() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<EventBloc>().add(
        CreateEventBookingEvent(id: widget.eventModel.id!),
      );
    }
  }
}

extension on StackRouter {
  void pop() {}
}
