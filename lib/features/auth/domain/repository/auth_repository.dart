import '../models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String phoneNumber, String pin);
  Future<void> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String pin,
  });
  Future<UserModel> getProfile();
  Future<UserModel> updateProfile(UserModel user);
  Future<void> deleteAccount();
  Future<void> logout();
}
