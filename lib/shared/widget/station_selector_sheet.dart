import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_style.dart';
import '../models/mrt_station.dart';

/// Mode controls what each row shows and what is selectable.
enum StationSelectorMode {
  /// Plain departure list — no prices, any station selectable.
  departure,

  /// Destination list — shows price, departure station is locked.
  destination,

  /// Radio-button list (used by Schedule page).
  radio,
}

/// A bottom-sheet that lets the user pick an MRT station.
/// Returns the selected [MrtStation] via [Navigator.pop].
class StationSelectorSheet extends StatefulWidget {
  final StationSelectorMode mode;
  final MrtStation? departureStation; // required when mode == destination
  final MrtStation? currentSelection;

  const StationSelectorSheet({
    super.key,
    required this.mode,
    this.departureStation,
    this.currentSelection,
  });

  @override
  State<StationSelectorSheet> createState() => _StationSelectorSheetState();
}

class _StationSelectorSheetState extends State<StationSelectorSheet> {
  MrtStation? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.currentSelection;
  }

  String get _title => switch (widget.mode) {
        StationSelectorMode.departure => 'Select Departure Station',
        StationSelectorMode.destination => 'Select Destination Station',
        StationSelectorMode.radio => 'Select Station',
      };

  List<MrtStation> get _stations => widget.mode == StationSelectorMode.destination
      ? kMrtStations.where((s) => s != widget.departureStation).toList()
      : kMrtStations;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Text(_title, style: AppTextStyle.title.copyWith(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              // Departure context banner (destination mode only)
              if (widget.mode == StationSelectorMode.destination &&
                  widget.departureStation != null)
                _DepartureBanner(station: widget.departureStation!),
              const SizedBox(height: 8),
              // Station list
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: _stations.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, indent: 20, endIndent: 20),
                  itemBuilder: (_, i) {
                    final station = _stations[i];
                    return _StationRow(
                      station: station,
                      mode: widget.mode,
                      departureStation: widget.departureStation,
                      isSelected: _selected == station,
                      onTap: () {
                        if (widget.mode == StationSelectorMode.radio) {
                          setState(() => _selected = station);
                          Future.delayed(const Duration(milliseconds: 150), () {
                            if (context.mounted) Navigator.of(context).pop(station);
                          });
                        } else {
                          Navigator.of(context).pop(station);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _DepartureBanner extends StatelessWidget {
  final MrtStation station;
  const _DepartureBanner({required this.station});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Departure station',
                  style: AppTextStyle.bodySmall.copyWith(color: AppColors.primaryBlue)),
              const SizedBox(height: 2),
              Text(station.name,
                  style: AppTextStyle.body.copyWith(
                      color: AppColors.primaryBlue, fontWeight: FontWeight.w700)),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text('Change Station',
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.primaryGreen)),
          ),
        ],
      ),
    );
  }
}

class _StationRow extends StatelessWidget {
  final MrtStation station;
  final StationSelectorMode mode;
  final MrtStation? departureStation;
  final bool isSelected;
  final VoidCallback onTap;

  const _StationRow({
    required this.station,
    required this.mode,
    required this.isSelected,
    required this.onTap,
    this.departureStation,
  });

  @override
  Widget build(BuildContext context) {
    final price = (mode == StationSelectorMode.destination && departureStation != null)
        ? computePrice(departureStation!, station)
        : null;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            if (mode == StationSelectorMode.radio)
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? AppColors.primaryGreen : AppColors.border,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 14)
                    : null,
              ),
            Expanded(
              child: Text(station.name,
                  style: AppTextStyle.body.copyWith(color: AppColors.textPrimary)),
            ),
            if (price != null)
              Text(formatRp(price),
                  style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w700))
            else if (mode != StationSelectorMode.radio)
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
