import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repository/auth_repository.dart';
import '../../../../core/network/token_storage.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final TokenStorage _tokenStorage;

  AuthBloc({
    required this._authRepository,
    required this._tokenStorage,
  })  : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<Registered>(_onRegistered);
    on<ProfileUpdated>(_onProfileUpdated);
    on<AccountDeleted>(_onAccountDeleted);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await _tokenStorage.getToken();
      if (token != null) {
        final user = await _authRepository.getProfile();
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      // If token is invalid or request fails, clear token and unauthenticate
      await _tokenStorage.deleteToken();
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(event.phoneNumber, event.password);
      emit(Authenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onRegistered(Registered event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.register(
        fullName: event.fullName,
        email: event.email,
        phoneNumber: event.phoneNumber,
        pin: event.pin,
      );
      // Auto-login after successful registration
      final user = await _authRepository.login(event.phoneNumber, event.pin);
      emit(Authenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onProfileUpdated(ProfileUpdated event, Emitter<AuthState> emit) async {
    try {
      final updatedUser = await _authRepository.updateProfile(event.user);
      emit(Authenticated(user: updatedUser));
    } catch (e) {
      emit(AuthError(message: e.toString()));
      // Re-emit previous authenticated state to preserve UI if we have it
      if (state is Authenticated) {
        emit(state);
      }
    }
  }

  Future<void> _onAccountDeleted(AccountDeleted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.deleteAccount();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
      // Stay authenticated if delete fails
      if (state is Authenticated) {
        emit(state);
      }
    }
  }

  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.logout();
    } catch (_) {}
    emit(Unauthenticated());
  }
}
