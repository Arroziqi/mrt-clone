import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/ticket_repository.dart';
import '../../../data/repositories/transaction_repository.dart';
import 'ticket_state.dart';

/// Cubit managing the Ticket page state.
/// Fetches both active tickets and pending transactions in parallel.
class TicketCubit extends Cubit<TicketState> {
  final TicketRepository _ticketRepository;
  final TransactionRepository _transactionRepository;

  TicketCubit({
    required TicketRepository ticketRepository,
    required TransactionRepository transactionRepository,
  })  : _ticketRepository = ticketRepository,
        _transactionRepository = transactionRepository,
        super(TicketInitial());

  /// Load active tickets and pending transactions.
  Future<void> loadTickets() async {
    emit(TicketLoading());
    try {
      final results = await Future.wait([
        _ticketRepository.getActiveTickets(),
        _transactionRepository.getPendingTransactions(),
      ]);

      emit(TicketLoaded(
        activeTickets: results[0] as dynamic,
        pendingTransactions: results[1] as dynamic,
      ));
    } catch (e) {
      emit(TicketError(
        message: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  /// Refresh tickets — same as loadTickets but can be called on pull-to-refresh.
  Future<void> refresh() => loadTickets();
}
