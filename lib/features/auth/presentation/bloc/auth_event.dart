import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String phoneNumber;
  final String password; // Or whatever mock data

  const LoggedIn({required this.phoneNumber, required this.password});

  @override
  List<Object> get props => [phoneNumber, password];
}

class LoggedOut extends AuthEvent {}
