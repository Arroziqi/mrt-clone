import 'package:flutter/material.dart';
import '../../../../shared/widget/policy_sheet_content.dart';
import '../../data/policy_data.dart';

/// Privacy Policy — presented as a modal bottom sheet.
/// Call via: showModalBottomSheet(context: ctx, builder: (_) => const PrivacyPolicyPage())
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => PolicySheetContent(
        title: 'Privacy Policy',
        sections: privacyPolicySections,
      ),
    );
  }
}
