import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/token_storage.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl({
    required this._apiClient,
    required TokenStorage tokenStorage,
  })  : _tokenStorage = tokenStorage;

  @override
  Future<UserModel> login(String phoneNumber, String pin) async {
    try {
      final response = await _apiClient.dio.post('/auth/login', data: {
        'phoneNumber': phoneNumber,
        'pin': pin,
      });

      if (response.statusCode == 200) {
        final token = response.data['data']['token'];
        if (token != null) {
          await _tokenStorage.saveToken(token);
        }
        return UserModel.fromJson(response.data['data']['user']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to login');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Login failed');
    }
  }

  @override
  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String pin,
  }) async {
    try {
      final response = await _apiClient.dio.post('/auth/register', data: {
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'pin': pin,
      });

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw Exception(response.data['message'] ?? 'Failed to register');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Registration failed');
    }
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await _apiClient.dio.get('/users/me');
      
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to get profile');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Failed to load profile');
    }
  }

  @override
  Future<UserModel> updateProfile(UserModel user) async {
    try {
      final response = await _apiClient.dio.put('/auth/profile', data: {
        'fullName': user.fullName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        if (user.age != null) 'age': user.age,
      });

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to update profile');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Update failed');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final response = await _apiClient.dio.delete('/auth/account');
      if (response.statusCode == 200) {
        await logout();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to delete account');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message ?? 'Deletion failed');
    }
  }

  @override
  Future<void> logout() async {
    await _tokenStorage.deleteToken();
  }
}
