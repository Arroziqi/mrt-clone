import 'package:equatable/equatable.dart';
import '../../../../../features/ticket/data/models/transaction_model.dart';
import '../../../../../features/ticket/data/models/paginated_response.dart';

/// States for the Activity (transaction history) page.
abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object?> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final List<TransactionModel> transactions;
  final PaginationMeta pagination;
  final bool isLoadingMore;

  const ActivityLoaded({
    required this.transactions,
    required this.pagination,
    this.isLoadingMore = false,
  });

  bool get isEmpty => transactions.isEmpty;
  bool get hasMore => pagination.hasNextPage;

  ActivityLoaded copyWith({
    List<TransactionModel>? transactions,
    PaginationMeta? pagination,
    bool? isLoadingMore,
  }) {
    return ActivityLoaded(
      transactions: transactions ?? this.transactions,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [transactions, pagination, isLoadingMore];
}

class ActivityError extends ActivityState {
  final String message;

  const ActivityError({required this.message});

  @override
  List<Object?> get props => [message];
}
