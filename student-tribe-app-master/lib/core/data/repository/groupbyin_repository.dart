import 'package:architecture/core/data/network/endpoints.dart';
import 'package:injectable/injectable.dart';

import '../network/api_client.dart';

@lazySingleton
class GroupByInRepository {
  final ApiClient _apiClient;
  GroupByInRepository(this._apiClient);

  Future<List<dynamic>> getAllGroupByIns() async {
    try {
      var res = await _apiClient.get(Endpoints.groupByIn);
      print(res["data"]["data"]);
      return res["data"]["data"];
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getGroupByInById(String id) async {
    try {
      return _apiClient.get("${Endpoints.groupByIn}/$id");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> createGroupBuyInBooking(String id, Map data) async {
    try {
      return _apiClient.post("${Endpoints.groupByIn}/$id/bookings/me",
          data: data);
    } catch (e) {
      rethrow;
    }
  }

//!new razorpayorder
  Future<dynamic> getRzpOrderEvents(String id, Map body) async {
    try {
      return _apiClient.put("groupbuyins/$id/bookings/me", data: body);
    } catch (e) {
      rethrow;
    }
  }
}
