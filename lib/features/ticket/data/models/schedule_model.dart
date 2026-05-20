class ScheduleData {
  final StationData station;
  final String dayType;
  final String serverTime;
  final DirectionSchedule? northbound;
  final DirectionSchedule? southbound;

  ScheduleData({
    required this.station,
    required this.dayType,
    required this.serverTime,
    this.northbound,
    this.southbound,
  });

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    return ScheduleData(
      station: StationData.fromJson(json['station']),
      dayType: json['dayType'] ?? '',
      serverTime: json['serverTime'] ?? '',
      northbound: json['northbound'] != null
          ? DirectionSchedule.fromJson(json['northbound'])
          : null,
      southbound: json['southbound'] != null
          ? DirectionSchedule.fromJson(json['southbound'])
          : null,
    );
  }
}

class StationData {
  final String stationId;
  final String name;

  StationData({required this.stationId, required this.name});

  factory StationData.fromJson(Map<String, dynamic> json) {
    return StationData(
      stationId: json['stationId'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class DirectionSchedule {
  final String direction;
  final String nextDeparture;
  final List<String> upcoming;

  DirectionSchedule({
    required this.direction,
    required this.nextDeparture,
    required this.upcoming,
  });

  factory DirectionSchedule.fromJson(Map<String, dynamic> json) {
    return DirectionSchedule(
      direction: json['direction'] ?? '',
      nextDeparture: json['nextDeparture'] ?? '',
      upcoming: json['upcoming'] != null
          ? List<String>.from(json['upcoming'])
          : [],
    );
  }
}
