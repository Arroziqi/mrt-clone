import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../shared/widget/app_button.dart';

class TicketEmptyPage extends StatelessWidget {
  const TicketEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Ticket'),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.history, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'History',
                      style: AppTextStyle.bodySmall.copyWith(color: AppColors.surface),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Placeholder for illustration
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.image, size: 80, color: Colors.grey),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'To use tickets, you need to purchase them first.',
                        style: AppTextStyle.title.copyWith(fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'To be able to use tickets you need to buy it first.',
                        style: AppTextStyle.body,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      AppButton(
                        text: 'Buy Ticket',
                        onPressed: () {},
                        variant: AppButtonVariant.primaryGreen,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom cityscape placeholder
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
