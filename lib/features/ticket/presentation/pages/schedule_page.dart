import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/models/mrt_station.dart';
import '../../../../shared/widget/station_selector_sheet.dart';
import '../widgets/schedule_column.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  MrtStation _station = kMrtStations.firstWhere((s) => s.name.contains('ASEAN'));

  // Mock timetable — in a real app this comes from an API
  final _northTimes = ['05:58', '06:10', '06:22', '06:33', '06:43', '06:52'];
  final _southTimes = ['06:01', '06:10', '06:18', '06:25', '06:32', '06:39'];

  String get _nextNorth => '05:46';
  String get _nextSouth => '05:51';

  Future<void> _changeStation() async {
    final result = await showModalBottomSheet<MrtStation>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StationSelectorSheet(
        mode: StationSelectorMode.radio,
        currentSelection: _station,
      ),
    );
    if (result != null) setState(() => _station = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('Schedule',
            style: AppTextStyle.title.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Location banner
          Container(
            color: const Color(0xFFE8F4FD),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.near_me, color: AppColors.primaryBlue, size: 16),
                const SizedBox(width: 6),
                Text('You are 1 km from ASEAN station',
                    style: AppTextStyle.bodySmall.copyWith(color: AppColors.primaryBlue)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Station selector card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: _changeStation,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ratangga departure schedule from',
                            style: AppTextStyle.bodySmall),
                        const SizedBox(height: 2),
                        Text(_station.name,
                            style: AppTextStyle.title.copyWith(
                                fontWeight: FontWeight.w900, fontSize: 20)),
                      ],
                    ),
                    Text('Change',
                        style: AppTextStyle.bodySmall.copyWith(
                            color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Two-column schedule
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ScheduleColumn(
                      direction: 'To Lebak Bulus',
                      nextTime: _nextNorth,
                      upcoming: _northTimes,
                      headerColor: AppColors.primaryBlue,
                      headerColorEnd: const Color(0xFF1A73E8),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ScheduleColumn(
                      direction: 'To Bundaran HI',
                      nextTime: _nextSouth,
                      upcoming: _southTimes,
                      headerColor: AppColors.primaryGreen,
                      headerColorEnd: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
