import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NavItem extends StatelessWidget {
  final String title;
  final String path;
  final String currentRoute;

  const NavItem(this.title, this.path, this.currentRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool isActive = currentRoute == path;

    return InkWell(
      onTap: () => context.go(path),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: isActive
              ? Border(
                  bottom: BorderSide(color: AppColors.primary, width: 2.w),
                )
              : null,
        ),
        child: Text(
          title,
          style: AppTypography.bodyMedium.copyWith(
            color: isActive ? AppColors.primary : null,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
