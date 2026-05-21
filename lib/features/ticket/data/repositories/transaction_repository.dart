import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/transaction_model.dart';
import '../models/paginated_response.dart';

/// Repository for transaction-related API calls.
class TransactionRepository {
  final ApiClient _apiClient;

  TransactionRepository({required this._apiClient});

  /// Fetch all pending transactions for the authenticated user.
  Future<List<TransactionModel>> getPendingTransactions() async {
    try {
      final response = await _apiClient.dio.get('/transactions/pending');

      if (response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((json) => TransactionModel.fromJson(json)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch pending transactions');
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

  /// Fetch paginated transaction history with optional status filter.
  Future<PaginatedResponse<TransactionModel>> getTransactionHistory({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };
      if (status != null) queryParams['status'] = status;

      final response = await _apiClient.dio.get(
        '/transactions',
        queryParameters: queryParams,
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        final List txJson = data['transactions'] ?? [];
        final transactions = txJson.map((json) => TransactionModel.fromJson(json)).toList();
        final pagination = PaginationMeta.fromJson(data['pagination'] ?? {});

        return PaginatedResponse(items: transactions, pagination: pagination);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch transaction history');
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
