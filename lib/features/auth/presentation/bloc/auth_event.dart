import 'package:equatable/equatable.dart';
import '../../domain/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String phoneNumber;
  final String password; // used as pin

  const LoggedIn({required this.phoneNumber, required this.password});

  @override
  List<Object?> get props => [phoneNumber, password];
}

class Registered extends AuthEvent {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String pin;

  const Registered({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.pin,
  });

  @override
  List<Object?> get props => [fullName, email, phoneNumber, pin];
}

class ProfileUpdated extends AuthEvent {
  final UserModel user;

  const ProfileUpdated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AccountDeleted extends AuthEvent {}

class LoggedOut extends AuthEvent {}
