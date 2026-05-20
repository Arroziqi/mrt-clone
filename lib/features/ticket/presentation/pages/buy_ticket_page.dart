import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/models/mrt_station.dart';
import '../../../../shared/widget/app_button.dart';
import '../../../../shared/widget/station_selector_sheet.dart';
import '../widgets/ticket_route_card.dart';
import '../widgets/passenger_selector.dart';
import '../widgets/voucher_card.dart';
import '../widgets/purchase_summary.dart';

class BuyTicketPage extends StatefulWidget {
  const BuyTicketPage({super.key});

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  MrtStation? _departure;
  MrtStation? _destination;
  bool _isRoundTrip = false;
  int _passengers = 1;
  bool _addOnEnabled = false;
  final _voucherController = TextEditingController();

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

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
    if (result != null) setState(() => _destination = result);
  }

  void _swap() {
    setState(() {
      final tmp = _departure;
      _departure = _destination;
      _destination = tmp;
    });
  }

  int get _unitPrice =>
      (_departure != null && _destination != null) ? computePrice(_departure!, _destination!) : 3000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Buy Ticket',
            style: AppTextStyle.title.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Route card
            TicketRouteCard(
              departure: _departure,
              destination: _destination,
              isRoundTrip: _isRoundTrip,
              onToggleRoundTrip: () => setState(() => _isRoundTrip = !_isRoundTrip),
              onTapDeparture: _pickDeparture,
              onTapDestination: _pickDestination,
              onSwap: _swap,
            ),
            const SizedBox(height: 24),
            // Passengers
            PassengerSelector(
              count: _passengers,
              onChanged: (n) => setState(() => _passengers = n),
            ),
            const SizedBox(height: 20),
            // Voucher
            VoucherCard(controller: _voucherController),
            const SizedBox(height: 20),
            // Add-On
            _AddOnSection(
              enabled: _addOnEnabled,
              onToggle: (v) => setState(() => _addOnEnabled = v),
            ),
            const SizedBox(height: 20),
            // Purchase summary
            PurchaseSummary(
              departure: _departure,
              destination: _destination,
              passengers: _passengers,
            ),
            const SizedBox(height: 20),
            // Promo mini-banners
            _PromoBanners(),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: const Center(
                child: Text('Read Term and Conditions',
                    style: TextStyle(color: AppColors.primaryBlue)),
              ),
            ),
            const SizedBox(height: 80), // space for FAB
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppButton(
            text: 'Pay ${formatRp(_unitPrice * _passengers)}',
            onPressed: (_departure != null && _destination != null) ? () {} : null,
            variant: AppButtonVariant.primaryGreen,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _AddOnSection extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onToggle;

  const _AddOnSection({required this.enabled, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add-On', style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.shield_outlined, color: AppColors.primaryBlue, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Proteksi Perjalanan',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Text('Rp 1.000  ',
                            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                        Text('Rp 10.000',
                            style: TextStyle(
                                color: Colors.red[300],
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text('Learn more',
                        style: TextStyle(color: AppColors.primaryBlue, fontSize: 12)),
                  ],
                ),
              ),
              Switch(
                value: enabled,
                onChanged: onToggle,
                activeTrackColor: AppColors.primaryBlue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PromoBanners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Cashback Points', style: TextStyle(color: Colors.white, fontSize: 10)),
                const Text('50%',
                    style: TextStyle(color: AppColors.accentYellow, fontWeight: FontWeight.w900, fontSize: 26)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFF00838F),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Cashback blu', style: TextStyle(color: Colors.white, fontSize: 10)),
                const Text('100%',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 26)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
