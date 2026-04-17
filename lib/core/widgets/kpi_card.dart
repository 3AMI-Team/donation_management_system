import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class KPICard extends StatelessWidget {
  final String title;
  final String value;
  final String logo;
  final IconData icon;
  final double vsLastMonth;

  const KPICard({
    super.key,
    required this.title,
    required this.value,
    required this.logo,
    required this.icon,
    this.vsLastMonth = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary.withOpacity(0.7),
                  ),
                ),
                Row(
                  children: [
                    Icon(icon, color: AppColors.textPrimary, size: 28.sp),
                    Gap(8.w),
                    Flexible(
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.h2.copyWith(fontSize: 22.sp),
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Row(
                    children: [
                      Icon(
                        vsLastMonth >= 0
                            ? Icons.trending_up_outlined
                            : Icons.trending_down_outlined,
                        color: vsLastMonth >= 0 ? AppColors.primary : Colors.red,
                        size: 20.sp,
                      ),
                      Gap(4.w),
                      Text(
                        vsLastMonth.toCompactPercentage(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              vsLastMonth >= 0 ? AppColors.primary : Colors.red,
                        ),
                      ),
                      Gap(4.w),
                      Expanded(
                        child: Text(
                          'vs last month',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(12.w),
          Image.asset(logo, width: 60.w, height: 60.h, fit: BoxFit.contain),
        ],
      ),
    );
  }
}
