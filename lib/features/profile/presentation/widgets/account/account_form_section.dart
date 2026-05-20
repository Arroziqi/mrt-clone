import 'package:flutter/material.dart';
import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../shared/widget/app_textfield.dart';

/// Form fields section: Full Name, Phone, Email (disabled), Age dropdown.
class AccountFormSection extends StatefulWidget {
  const AccountFormSection({super.key});

  @override
  State<AccountFormSection> createState() => _AccountFormSectionState();
}

class _AccountFormSectionState extends State<AccountFormSection> {
  final _nameController = TextEditingController(text: 'Ahmad Arroziqi');
  final _phoneController = TextEditingController(text: '85179876206');
  final _emailController = TextEditingController(text: 'ahmadarroziqi@gmail.com');
  String? _selectedAge;

  static const _ages = ['< 17', '17–25', '26–35', '36–45', '> 45'];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(label: 'Full Name', controller: _nameController),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Phone Number',
            prefixText: '+62',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Email',
            hint: 'ahmadarroziqi@gmail.com',
            controller: _emailController,
          ),
          const SizedBox(height: 20),
          _AgeDropdown(
            selectedAge: _selectedAge,
            ages: _ages,
            onChanged: (val) => setState(() => _selectedAge = val),
          ),
        ],
      ),
    );
  }
}

class _AgeDropdown extends StatelessWidget {
  final String? selectedAge;
  final List<String> ages;
  final ValueChanged<String?> onChanged;

  const _AgeDropdown({
    required this.selectedAge,
    required this.ages,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age',
          style: AppTextStyle.bodySmall.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedAge,
              hint: const Text(''),
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary),
              onChanged: onChanged,
              items: ages
                  .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
