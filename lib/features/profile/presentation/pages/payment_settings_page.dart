import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widget/segment_tab_bar.dart';
import '../widgets/payment/payment_provider_list.dart';

/// Payment Settings page.
/// Shows E-wallet/Paylater and Bank/Credit Card tabs with provider toggles.
class PaymentSettingsPage extends StatefulWidget {
  const PaymentSettingsPage({super.key});

  @override
  State<PaymentSettingsPage> createState() => _PaymentSettingsPageState();
}

class _PaymentSettingsPageState extends State<PaymentSettingsPage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: false,
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: SegmentTabBar(
              labels: const ['E-wallet/Paylater', 'Bank/Credit Card'],
              selectedIndex: _tabIndex,
              onTabChanged: (i) => setState(() => _tabIndex = i),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: PaymentProviderList(tabIndex: _tabIndex),
            ),
          ),
        ],
      ),
    );
  }
}
