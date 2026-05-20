import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';

class _PaymentMethod {
  final String name;
  final IconData icon;
  final Color iconColor;
  bool connected;
  _PaymentMethod({required this.name, required this.icon, required this.iconColor, required this.connected});
}

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _ewallets = [
    _PaymentMethod(name: 'AstraPay', icon: Icons.account_balance_wallet, iconColor: const Color(0xFF1565C0), connected: false),
    _PaymentMethod(name: 'i.saku', icon: Icons.wallet, iconColor: const Color(0xFF5C6BC0), connected: false),
    _PaymentMethod(name: 'Kredivo', icon: Icons.credit_card, iconColor: const Color(0xFF00897B), connected: false),
    _PaymentMethod(name: 'GoPay', icon: Icons.payments_outlined, iconColor: const Color(0xFF00BCD4), connected: false),
    _PaymentMethod(name: 'Yup', icon: Icons.account_balance_wallet_outlined, iconColor: Colors.red, connected: false),
  ];

  final _banks = [
    _PaymentMethod(name: 'BCA Virtual Account', icon: Icons.account_balance, iconColor: const Color(0xFF1565C0), connected: false),
    _PaymentMethod(name: 'Mandiri Virtual Account', icon: Icons.account_balance, iconColor: const Color(0xFFF57F17), connected: false),
    _PaymentMethod(name: 'BNI Virtual Account', icon: Icons.account_balance, iconColor: const Color(0xFF6A1B9A), connected: false),
    _PaymentMethod(name: 'BRI Virtual Account', icon: Icons.account_balance, iconColor: const Color(0xFF1565C0), connected: false),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text('Payment',
            style: AppTextStyle.title.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Tab bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 4)],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: AppColors.primaryBlue,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: AppTextStyle.body.copyWith(fontWeight: FontWeight.w600),
                tabs: const [
                  Tab(text: 'E-wallet/Paylater'),
                  Tab(text: 'Bank/Credit Card'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Method lists
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _MethodList(methods: _ewallets, onToggle: (i, v) => setState(() => _ewallets[i].connected = v)),
                _MethodList(methods: _banks, onToggle: (i, v) => setState(() => _banks[i].connected = v)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _MethodList extends StatelessWidget {
  final List<_PaymentMethod> methods;
  final void Function(int, bool) onToggle;

  const _MethodList({required this.methods, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: methods.length,
      separatorBuilder: (_, _) => const SizedBox(height: 1),
      itemBuilder: (_, i) {
        final m = methods[i];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: m.iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(m.icon, color: m.iconColor, size: 22),
            ),
            title: Text(m.name, style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w600)),
            subtitle: Text(
              m.connected ? 'Connected' : 'Not connected',
              style: AppTextStyle.bodySmall,
            ),
            trailing: Switch(
              value: m.connected,
              onChanged: (v) => onToggle(i, v),
              activeTrackColor: AppColors.primaryBlue,
            ),
          ),
        );
      },
    );
  }
}
