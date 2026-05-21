import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/ticket_model.dart';
import '../models/paginated_response.dart';

/// Repository for ticket-related API calls.
class TicketRepository {
  final ApiClient _apiClient;

  TicketRepository({required this._apiClient});

  /// Fetch all active tickets for the authenticated user.
  Future<List<TicketModel>> getActiveTickets() async {
    try {
      final response = await _apiClient.dio.get('/tickets/active');

      if (response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((json) => TicketModel.fromJson(json)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch active tickets');
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

  /// Fetch paginated used/expired ticket history.
  Future<PaginatedResponse<TicketModel>> getUsedTicketHistory({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/tickets/history',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        final List ticketsJson = data['tickets'] ?? [];
        final tickets = ticketsJson.map((json) => TicketModel.fromJson(json)).toList();
        final pagination = PaginationMeta.fromJson(data['pagination'] ?? {});

        return PaginatedResponse(items: tickets, pagination: pagination);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch ticket history');
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
