import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/features/dashboard/domain/entity/last_donations_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ActivityTableRow extends StatelessWidget {
  final LastDonation donation;
  const ActivityTableRow({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          _dataCell(donation.donorName, width: 190.w, isBold: true),
          _dataCell('\$ ${donation.amount.toStringAsFixed(0)}', width: 150.w, isNumber: true),
          _categoryCell(donation.category, width: 150.w),
          _dataCell(DateFormat('yyyy-MM-dd').format(donation.date), width: 150.w, isSecondary: true),
          Expanded(child: _statusCell()),
        ],
      ),
    );
  }

  Widget _dataCell(String text, {required double width, bool isBold = false, bool isNumber = false, bool isSecondary = false}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        style: AppTypography.bodyMedium.copyWith(
          color: isSecondary ? AppColors.textSecondary : AppColors.textPrimary,
          fontWeight: isBold || isNumber ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _categoryCell(String text, {required double width}) {
    return SizedBox(
      width: width,
      child: UnconstrainedBox(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            text,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusCell() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            'Completed',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
