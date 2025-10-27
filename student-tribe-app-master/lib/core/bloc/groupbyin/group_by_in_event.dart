part of 'group_by_in_bloc.dart';

sealed class GroupByInEvent extends Equatable {
  const GroupByInEvent();

  @override
  List<Object> get props => [];
}

class GetAllGroupByInEvent extends GroupByInEvent {}

class GetGroupByInByIdEvent extends GroupByInEvent {
  final String id;
  final bool handleSilently;
  GetGroupByInByIdEvent({required this.id, this.handleSilently = false});
}

class CreateGroupBuyInBookingEvent extends GroupByInEvent {
  final String id;
  final String paymentMethod;
  final int qty;
  final Map<String, dynamic> payment;
  final int? stCoins;

  const CreateGroupBuyInBookingEvent(
      {required this.id,
      required this.paymentMethod,
      required this.qty,
      required this.payment,
      this.stCoins
      });
}
