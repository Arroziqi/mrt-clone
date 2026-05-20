import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/profile/bloc/language_cubit.dart';
import 'core/network/api_client.dart';
import 'core/network/token_storage.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/ticket/data/repositories/schedule_repository.dart';
import 'features/ticket/presentation/bloc/schedule/schedule_bloc.dart';

void main() {
  final tokenStorage = TokenStorage();
  final apiClient = ApiClient(tokenStorage: tokenStorage);
  final authRepository = AuthRepositoryImpl(
    apiClient: apiClient,
    tokenStorage: tokenStorage,
  );
  final scheduleRepository = ScheduleRepository(
    apiClient: apiClient,
  );

  runApp(MyApp(
    authRepository: authRepository,
    tokenStorage: tokenStorage,
    scheduleRepository: scheduleRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final TokenStorage tokenStorage;
  final ScheduleRepository scheduleRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.tokenStorage,
    required this.scheduleRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: authRepository,
            tokenStorage: tokenStorage,
          )..add(AppStarted()),
        ),
        BlocProvider<LanguageCubit>(
          create: (_) => LanguageCubit(),
        ),
        BlocProvider<ScheduleBloc>(
          create: (_) => ScheduleBloc(repository: scheduleRepository),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
