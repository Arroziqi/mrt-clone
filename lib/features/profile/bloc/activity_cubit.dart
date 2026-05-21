import 'package:flutter_bloc/flutter_bloc.dart';
import '../../ticket/data/repositories/transaction_repository.dart';
import 'activity_state.dart';

/// Cubit managing the Activity History page state.
/// Supports initial load, pagination (load more), and filter by status.
class ActivityCubit extends Cubit<ActivityState> {
  final TransactionRepository _transactionRepository;

  ActivityCubit({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository, // ignore: prefer_initializing_formals
        super(ActivityInitial());

  int _currentPage = 1;
  String? _statusFilter;

  /// Load the first page of transaction history.
  Future<void> loadActivity({String? status}) async {
    _currentPage = 1;
    _statusFilter = status;
    emit(ActivityLoading());
    try {
      final result = await _transactionRepository.getTransactionHistory(
        page: 1,
        limit: 10,
        status: _statusFilter,
      );
      emit(ActivityLoaded(
        transactions: result.items,
        pagination: result.pagination,
      ));
    } catch (e) {
      emit(ActivityError(
        message: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  /// Load the next page and append to current list.
  Future<void> loadMore() async {
    final current = state;
    if (current is! ActivityLoaded) return;
    if (!current.hasMore || current.isLoadingMore) return;

    emit(current.copyWith(isLoadingMore: true));
    try {
      _currentPage++;
      final result = await _transactionRepository.getTransactionHistory(
        page: _currentPage,
        limit: 10,
        status: _statusFilter,
      );
      emit(ActivityLoaded(
        transactions: [...current.transactions, ...result.items],
        pagination: result.pagination,
      ));
    } catch (e) {
      // Revert page increment on failure
      _currentPage--;
      emit(current.copyWith(isLoadingMore: false));
    }
  }

  /// Refresh from page 1 with current filter.
  Future<void> refresh() => loadActivity(status: _statusFilter);
}
