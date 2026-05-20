import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/payment_models.dart';
import '../../../data/repositories/payment_repository.dart';
import 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository repository;

  PaymentCubit({required this.repository})
      : super(PaymentInitial());

  Future<void> createPayment({
    required String departureId,
    required String destinationId,
    required int passengers,
    required bool isRoundTrip,
    required bool addOnProteksi,
    String? voucherCode,
  }) async {
    emit(PaymentLoading());
    try {
      final request = PaymentRequest(
        departureId: departureId,
        destinationId: destinationId,
        passengers: passengers,
        isRoundTrip: isRoundTrip,
        addOnProteksi: addOnProteksi,
        voucherCode: voucherCode,
      );
      final response = await repository.createPayment(request);
      emit(PaymentSuccess(response: response));
    } catch (e) {
      emit(PaymentError(message: e.toString().replaceFirst('Exception: ', '')));
    }
  }

  void reset() {
    emit(PaymentInitial());
  }
}
