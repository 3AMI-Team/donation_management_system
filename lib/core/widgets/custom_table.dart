import 'package:donation_management_system/core/widgets/table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:donation_management_system/core/theme/colors.dart';

class CustomTable<T> extends StatelessWidget {
  final VoidCallback? onMenuPressed;
  final List<TableHeader> headerCells;
  final List<T> dataRow;
  final Widget Function(T item) itemBuilder;

  const CustomTable({
    super.key,
    this.onMenuPressed,
    required this.headerCells,
    required this.dataRow,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.divider,
              border: Border(bottom: BorderSide(color: AppColors.divider)),
            ),
            child: Row(children: headerCells),
          ),
          ...dataRow.map((item) => itemBuilder(item)),
        ],
      ),
    );
  }
}
