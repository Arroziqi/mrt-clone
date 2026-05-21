import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/profile/bloc/language_cubit.dart';
import 'features/profile/bloc/activity_cubit.dart';
import 'core/network/api_client.dart';
import 'core/network/token_storage.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/ticket/data/repositories/schedule_repository.dart';
import 'features/ticket/presentation/bloc/schedule/schedule_bloc.dart';
import 'features/ticket/data/repositories/payment_repository.dart';
import 'features/ticket/presentation/bloc/payment/payment_cubit.dart';
import 'features/ticket/data/repositories/ticket_repository.dart';
import 'features/ticket/data/repositories/transaction_repository.dart';
import 'features/ticket/presentation/bloc/ticket/ticket_cubit.dart';

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
  final paymentRepository = PaymentRepository(
    apiClient: apiClient,
  );
  final ticketRepository = TicketRepository(apiClient: apiClient);
  final transactionRepository = TransactionRepository(apiClient: apiClient);

  runApp(MyApp(
    authRepository: authRepository,
    tokenStorage: tokenStorage,
    scheduleRepository: scheduleRepository,
    paymentRepository: paymentRepository,
    ticketRepository: ticketRepository,
    transactionRepository: transactionRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final TokenStorage tokenStorage;
  final ScheduleRepository scheduleRepository;
  final PaymentRepository paymentRepository;
  final TicketRepository ticketRepository;
  final TransactionRepository transactionRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.tokenStorage,
    required this.scheduleRepository,
    required this.paymentRepository,
    required this.ticketRepository,
    required this.transactionRepository,
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
        BlocProvider<PaymentCubit>(
          create: (_) => PaymentCubit(repository: paymentRepository),
        ),
        BlocProvider<TicketCubit>(
          create: (_) => TicketCubit(
            ticketRepository: ticketRepository,
            transactionRepository: transactionRepository,
          ),
        ),
        BlocProvider<ActivityCubit>(
          create: (_) => ActivityCubit(
            transactionRepository: transactionRepository,
          ),
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

