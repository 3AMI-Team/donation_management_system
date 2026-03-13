import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomAddButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const CustomAddButton({
    super.key,
    required this.onTap,
    this.text = 'Add Donor',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Icon(Icons.add, color: Colors.white, size: 20.sp),
            Gap(5.w),
            Text(
              text,
              style: AppTypography.button.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
