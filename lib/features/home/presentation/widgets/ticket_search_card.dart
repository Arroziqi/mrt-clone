import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/models/mrt_station.dart';
import '../../../../shared/widget/app_button.dart';
import '../../../../shared/widget/station_selector_sheet.dart';

/// The floating ticket search card that overlaps the blue header.
class TicketSearchCard extends StatefulWidget {
  const TicketSearchCard({super.key});

  @override
  State<TicketSearchCard> createState() => _TicketSearchCardState();
}

class _TicketSearchCardState extends State<TicketSearchCard> {
  MrtStation? _departure;
  MrtStation? _destination;

  Future<void> _pickDeparture() async {
    final result = await showModalBottomSheet<MrtStation>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StationSelectorSheet(
        mode: StationSelectorMode.departure,
        currentSelection: _departure,
      ),
    );
    if (result != null) {
      setState(() {
        _departure = result;
        if (_destination == result) _destination = null;
      });
    }
  }

  Future<void> _pickDestination() async {
    if (_departure == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a departure station first.')),
      );
      return;
    }
    final result = await showModalBottomSheet<MrtStation>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StationSelectorSheet(
        mode: StationSelectorMode.destination,
        departureStation: _departure,
        currentSelection: _destination,
      ),
    );
    if (result != null) {
      setState(() {
        _destination = result;
      });
    }
  }

  void _swap() {
    setState(() {
      final tmp = _departure;
      _departure = _destination;
      _destination = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Location chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              const Icon(
                Icons.near_me_outlined,
                color: AppColors.surface,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                'You are 1 km from ASEAN station',
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.surface.withValues(alpha: 0.85),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(height: 28, width: 2, color: AppColors.border),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        _StationField(
                          hint: 'Select Departure Station',
                          label: 'From the Station',
                          value: _departure?.name,
                          onTap: _pickDeparture,
                        ),
                        const SizedBox(height: 10),
                        _StationField(
                          hint: 'Select Destination Station',
                          label: 'To Station',
                          value: _destination?.name,
                          onTap: _pickDestination,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _swap,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(
                        Icons.swap_vert,
                        color: AppColors.primaryBlue,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              AppButton(
                text: 'Buy Ticket',
                onPressed: () {
                  context.push(
                    '/buy-ticket',
                    extra: {
                      'departure': _departure,
                      'destination': _destination,
                    },
                  );
                },
                variant: AppButtonVariant.primaryGreen,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Single station selector field.
class _StationField extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final VoidCallback onTap;

  const _StationField({
    required this.label,
    required this.hint,
    required this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyle.bodySmall.copyWith(
                fontSize: 10,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value ?? hint,
              style: AppTextStyle.bodySmall.copyWith(
                fontSize: 12,
                color: value != null ? AppColors.textPrimary : AppColors.disabled,
                fontWeight: value != null ? FontWeight.w600 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
