import 'package:flutter/material.dart';
import 'package:repouch/widgets/toggle_button_wd.dart';

class ToggleOption extends StatelessWidget {
  final String selectedOption;
  final ValueChanged<String> onOptionSelected;

  ToggleOption({required this.selectedOption, required this.onOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButton(
          label: 'Deposit',
          isSelected: selectedOption == 'Deposit',
          onTap: () => onOptionSelected('Deposit'),
        ),
        SizedBox(width: 10),
        ToggleButton(
          label: 'Withdraw',
          isSelected: selectedOption == 'Withdraw',
          onTap: () => onOptionSelected('Withdraw'),
        ),
      ],
    );
  }
}
