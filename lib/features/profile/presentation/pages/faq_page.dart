import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_style.dart';
import '../widgets/faq/faq_category_tabs.dart';
import '../widgets/faq/faq_list_view.dart';

/// FAQ page with search, category tabs, and expandable Q&A items.
class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  int _categoryIndex = 0;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        leading: const BackButton(),
        title: _SearchBar(controller: _searchController),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          FaqCategoryTabs(
            selectedIndex: _categoryIndex,
            onTabChanged: (i) => setState(() => _categoryIndex = i),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FaqListView(categoryIndex: _categoryIndex),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: AppTextStyle.body.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: AppTextStyle.body.copyWith(color: AppColors.textSecondary),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}
