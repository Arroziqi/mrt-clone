import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/models/mrt_station.dart';
import '../../../../shared/widget/station_selector_sheet.dart';
import '../widgets/schedule_column.dart';
import '../bloc/schedule/schedule_bloc.dart';
import '../bloc/schedule/schedule_event.dart';
import '../bloc/schedule/schedule_state.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  MrtStation _station = kMrtStations.firstWhere((s) => s.name.contains('ASEAN'));

  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(LoadSchedule(_station));
  }

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
    if (result != null) {
      setState(() => _station = result);
      if (mounted) {
        context.read<ScheduleBloc>().add(LoadSchedule(_station));
      }
    }
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
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state is ScheduleLoading || state is ScheduleInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ScheduleError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: AppTextStyle.bodySmall.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (state is ScheduleLoaded) {
                  final data = state.scheduleData;
                  final north = data.northbound;
                  final south = data.southbound;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (north != null)
                          Expanded(
                            child: ScheduleColumn(
                              direction: north.direction,
                              nextTime: north.nextDeparture,
                              upcoming: north.upcoming,
                              headerColor: AppColors.primaryBlue,
                              headerColorEnd: const Color(0xFF1A73E8),
                            ),
                          )
                        else
                          Expanded(
                            child: _buildTerminusPlaceholder('Terminus\nNo Northbound'),
                          ),
                        const SizedBox(width: 12),
                        if (south != null)
                          Expanded(
                            child: ScheduleColumn(
                              direction: south.direction,
                              nextTime: south.nextDeparture,
                              upcoming: south.upcoming,
                              headerColor: AppColors.primaryGreen,
                              headerColorEnd: const Color(0xFF2E7D32),
                            ),
                          )
                        else
                          Expanded(
                            child: _buildTerminusPlaceholder('Terminus\nNo Southbound'),
                          ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTerminusPlaceholder(String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Center(
        child: Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
