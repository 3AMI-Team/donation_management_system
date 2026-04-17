import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NavDropdown extends StatelessWidget {
  final String title;
  final List<DropdownNavItem> items;
  final String currentRoute;

  const NavDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAnyChildActive =
        items.any((item) => currentRoute == item.path);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: PopupMenuButton<String>(
        offset: Offset(0, 45.h),
        tooltip: 'Show $title',
        surfaceTintColor: Colors.white,
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            border: isAnyChildActive
                ? Border(
                    bottom: BorderSide(color: AppColors.primary, width: 2.w),
                  )
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTypography.bodyMedium.copyWith(
                  color: isAnyChildActive ? AppColors.primary : null,
                  fontWeight: isAnyChildActive ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 20.sp,
                color: isAnyChildActive ? AppColors.primary : AppColors.textSecondary,
              ),
            ],
          ),
        ),
        onSelected: (path) => context.go(path),
        itemBuilder: (context) => items.map((item) {
          final bool isItemActive = currentRoute == item.path;
          return PopupMenuItem<String>(
            value: item.path,
            child: Row(
              children: [
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    size: 18.sp,
                    color: isItemActive ? AppColors.primary : AppColors.textSecondary,
                  ),
                  SizedBox(width: 12.w),
                ],
                Text(
                  item.title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: isItemActive ? AppColors.primary : null,
                    fontWeight: isItemActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DropdownNavItem {
  final String title;
  final String path;
  final IconData? icon;

  const DropdownNavItem({
    required this.title,
    required this.path,
    this.icon,
  });
}
