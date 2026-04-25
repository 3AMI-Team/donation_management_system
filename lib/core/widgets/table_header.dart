import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({
    super.key,
    required this.text,
    this.flex = 1,
    this.width,
    this.textAlign,
    this.onSort,
    this.isSorted = false,
    this.isAscending = true,
  });

  final String text;
  final int flex;
  final double? width;
  final TextAlign? textAlign;
  final VoidCallback? onSort;
  final bool isSorted;
  final bool isAscending;

  @override
  Widget build(BuildContext context) {
    Widget content = InkWell(
      onTap: onSort,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: textAlign == TextAlign.right
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              text,
              textAlign: textAlign,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: isSorted ? AppColors.primary : AppColors.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onSort != null) ...[
            const Gap(4),
            Icon(
              isSorted
                  ? (isAscending ? Icons.arrow_upward : Icons.arrow_downward)
                  : Icons.unfold_more,
              size: 14.sp,
              color: isSorted ? AppColors.primary : AppColors.textSecondary.withOpacity(0.5),
            ),
          ],
        ],
      ),
    );

    if (width != null) {
      return SizedBox(width: width, child: content);
    }

    return Expanded(flex: flex, child: content);
  }
}
