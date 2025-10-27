import 'package:architecture/core/data/repository/event_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EventUseCase {
  final EventRepository _eventRepository;

  EventUseCase(this._eventRepository);

  Future<dynamic> handleGetEvents(Map<String, dynamic> data) async {
    try {
      return await _eventRepository.getAllEvents(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> handleGetEventsById(String id) async {
    try {
      return await _eventRepository.getEventsById(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> handleGetMyBookings() async {
    try {
      return await _eventRepository.getMyBookings();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> handleCreateEventBooking(String id, Map data) async {
    try {
      return await _eventRepository.createEventBooking(id, data);
    } catch (e) {
      rethrow;
    }
  }

  //!old
  Future<dynamic> handleGetRzpDetails(String id, num amount) async {
    try {
      return await _eventRepository.getRzpDetails(id, amount);
    } catch (e) {
      rethrow;
    }
  }

  //!Get razorpayorder Events
  Future<dynamic> handleGetRzpOrderEvents(String id, Map body,bool isFromGroupBuyIn) async {
    try {
      return await _eventRepository.getRzpOrderEvents(id, body, isFromGroupBuyIn);
    } catch (e) {
      rethrow;
    }
  }


}
