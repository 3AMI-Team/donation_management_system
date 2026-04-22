import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({
    super.key,
    required this.text,
    required this.flex,
    this.textAlign,
  });

  final String text;
  final int flex;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: textAlign,
        style: AppTypography.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
