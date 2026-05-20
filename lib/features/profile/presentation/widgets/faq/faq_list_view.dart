import 'package:flutter/material.dart';
import '../../../data/faq_data.dart';
import 'faq_item_tile.dart';

/// Renders the list of FAQ items for the currently selected category.
class FaqListView extends StatelessWidget {
  final int categoryIndex;

  const FaqListView({super.key, required this.categoryIndex});

  @override
  Widget build(BuildContext context) {
    final items = faqCategories[categoryIndex].items;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (_, i) => FaqItemTile(item: items[i]),
    );
  }
}
