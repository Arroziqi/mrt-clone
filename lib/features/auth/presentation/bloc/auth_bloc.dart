import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Mock check if user is already logged in
    await Future.delayed(const Duration(seconds: 1));
    emit(Unauthenticated()); // Default to unauthenticated for now
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Mock API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Accept any login for mock
    emit(const Authenticated(userId: "mock_user_id_123"));
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Mock API call
    await Future.delayed(const Duration(milliseconds: 500));
    emit(Unauthenticated());
  }
}
