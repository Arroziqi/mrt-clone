import '../../../data/models/schedule_model.dart';

abstract class ScheduleState {}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final ScheduleData scheduleData;

  ScheduleLoaded(this.scheduleData);
}

class ScheduleError extends ScheduleState {
  final String message;

  ScheduleError(this.message);
}
