import 'package:flutter_bloc/flutter_bloc.dart';
import 'schedule_event.dart';
import 'schedule_state.dart';
import '../../../data/repositories/schedule_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _repository;

  ScheduleBloc({required this._repository})
      : super(ScheduleInitial()) {
    on<LoadSchedule>(_onLoadSchedule);
  }

  Future<void> _onLoadSchedule(
    LoadSchedule event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(ScheduleLoading());
    try {
      final scheduleData = await _repository.getStationSchedule(event.station.id);
      emit(ScheduleLoaded(scheduleData));
    } catch (e) {
      // Remove generic Exception prefix if present
      final errorMsg = e.toString().replaceAll('Exception: ', '');
      emit(ScheduleError(errorMsg));
    }
  }
}
