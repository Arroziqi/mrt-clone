import '../../../../../shared/models/mrt_station.dart';

abstract class ScheduleEvent {}

class LoadSchedule extends ScheduleEvent {
  final MrtStation station;

  LoadSchedule(this.station);
}
