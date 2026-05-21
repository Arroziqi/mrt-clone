import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/payment_models.dart';

class PaymentRepository {
  final ApiClient _apiClient;

  PaymentRepository({required this._apiClient});

  Future<PaymentResponse> createPayment(PaymentRequest request) async {
    try {
      final response = await _apiClient.dio.post(
        '/payments/create',
        data: request.toJson(),
      );

      if (response.data['success'] == true) {
        return PaymentResponse.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to create checkout payment');
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

  Future<TransactionStatusResponse> getTransactionStatus(String orderId) async {
    try {
      final response = await _apiClient.dio.get('/transactions/$orderId');

      if (response.data['success'] == true) {
        return TransactionStatusResponse.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to get transaction status');
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
