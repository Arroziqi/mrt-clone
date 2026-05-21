import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/schedule_model.dart';

class ScheduleRepository {
  final ApiClient _apiClient;

  ScheduleRepository({required this._apiClient});

  Future<ScheduleData> getStationSchedule(String stationId) async {
    try {
      final response = await _apiClient.dio.get('/schedules/$stationId');
      
      if (response.data['success'] == true) {
        return ScheduleData.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load schedule');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        throw Exception(e.response?.data['message'] ?? e.message);
      }
      throw Exception(e.message ?? 'Network error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
