import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class KPICard extends StatelessWidget {
  final String title;
  final String value;
  final String logo;
  final IconData icon;
  const KPICard({
    super.key,
    required this.title,
    required this.value,
    required this.logo,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290.w,
      height: 200.h,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: BoxBorder.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary.withOpacity(0.7),
                ),
              ),

              Row(
                children: [
                  Icon(icon, color: AppColors.textPrimary, size: 32.sp),
                  Gap(5.w),
                  Text(value, style: AppTypography.h2),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.trending_up_outlined,
                    color: AppColors.primary,
                    size: 25.sp,
                  ),
                  Gap(5.w),
                  Text(
                    '12%',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary.withOpacity(0.7),
                    ),
                  ),
                  Gap(5.w),
                  Text('vs last month', style: AppTypography.bodyMedium),
                ],
              ),
            ],
          ),
          Spacer(),
          Image.asset(logo, width: 70.w, height: 70.h),
        ],
      ),
    );
  }
}
