import 'package:equatable/equatable.dart';
import '../../../data/models/ticket_model.dart';
import '../../../data/models/transaction_model.dart';

/// States for the Ticket page.
abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object?> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  final List<TicketModel> activeTickets;
  final List<TransactionModel> pendingTransactions;

  const TicketLoaded({
    required this.activeTickets,
    required this.pendingTransactions,
  });

  /// Whether both lists are empty — triggers the empty state illustration.
  bool get isEmpty => activeTickets.isEmpty && pendingTransactions.isEmpty;

  @override
  List<Object?> get props => [activeTickets, pendingTransactions];
}

class TicketError extends TicketState {
  final String message;

  const TicketError({required this.message});

  @override
  List<Object?> get props => [message];
}
