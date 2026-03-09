import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:donation_management_system/core/theme/colors.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String outlinedButtonText;
  final String filledButtonText;
  final VoidCallback? onOutlinedPressed;
  final VoidCallback? onFilledPressed;

  const PageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.outlinedButtonText,
    required this.filledButtonText,
    this.onOutlinedPressed,
    this.onFilledPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Gap(4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: onOutlinedPressed,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                ),
                child: Text(
                  outlinedButtonText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              Gap(12.w),
              ElevatedButton(
                onPressed: onFilledPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 20.sp),
                    Gap(4.w),
                    Text(
                      filledButtonText,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
