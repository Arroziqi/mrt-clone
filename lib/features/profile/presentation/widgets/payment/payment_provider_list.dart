import 'package:flutter/material.dart';
import 'payment_provider_tile.dart';

/// Static list of e-wallet providers.
const _eWalletProviders = [
  PaymentProvider(name: 'AstraPay', iconColor: Color(0xFF1565C0), iconLetter: 'A'),
  PaymentProvider(name: 'i.saku', iconColor: Color(0xFF0077B6), iconLetter: 'i'),
  PaymentProvider(name: 'Kredivo', iconColor: Color(0xFF00897B), iconLetter: 'K'),
  PaymentProvider(name: 'GoPay', iconColor: Color(0xFF00ACC1), iconLetter: 'G'),
  PaymentProvider(name: 'Yup', iconColor: Color(0xFFE53935), iconLetter: 'Y'),
];

/// Static list of bank / credit card providers.
const _bankProviders = [
  PaymentProvider(name: 'BCA Virtual Account', iconColor: Color(0xFF0055B8), iconLetter: 'B'),
  PaymentProvider(name: 'Mandiri Virtual Account', iconColor: Color(0xFF00796B), iconLetter: 'M'),
  PaymentProvider(name: 'BNI Virtual Account', iconColor: Color(0xFFFF8F00), iconLetter: 'N'),
];

/// Renders the correct list of payment providers based on [tabIndex].
/// 0 = E-wallet/Paylater, 1 = Bank/Credit Card
class PaymentProviderList extends StatelessWidget {
  final int tabIndex;

  const PaymentProviderList({super.key, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    final providers = tabIndex == 0 ? _eWalletProviders : _bankProviders;
    return Column(
      children: providers
          .map((p) => PaymentProviderTile(provider: p))
          .toList(),
    );
  }
}
