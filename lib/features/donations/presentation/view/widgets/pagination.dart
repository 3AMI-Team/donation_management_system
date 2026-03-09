import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:donation_management_system/core/theme/colors.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalItems;
  final int itemsPerPage;
  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalItems,
    this.itemsPerPage = 5,
    this.onPreviousPressed,
    this.onNextPressed,
  });

  int get totalPages => (totalItems / itemsPerPage).ceil();
  int get startItem => (currentPage - 1) * itemsPerPage + 1;
  int get endItem => (currentPage * itemsPerPage).clamp(1, totalItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$startItem-$endItem of $totalItems',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          Row(
            children: [
              _buildNavigationButton(
                icon: Icons.chevron_left,
                onPressed: currentPage > 1 ? onPreviousPressed : null,
              ),
              Gap(8.w),
              _buildNavigationButton(
                icon: Icons.chevron_right,
                onPressed: currentPage < totalPages ? onNextPressed : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    final bool isEnabled = onPressed != null;
    return Material(
      color: isEnabled ? AppColors.surface : AppColors.border.withOpacity(0.5),
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: isEnabled ? AppColors.border : AppColors.border.withOpacity(0.3),
            ),
          ),
          child: Icon(
            icon,
            size: 20.sp,
            color: isEnabled ? AppColors.textPrimary : AppColors.textSecondary.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
