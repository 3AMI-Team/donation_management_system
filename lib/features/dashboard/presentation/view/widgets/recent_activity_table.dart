import 'package:donation_management_system/core/routes/routes.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/features/dashboard/domain/entity/last_donations_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'activity_table_row.dart';

class RecentActivityTable extends StatelessWidget {
  final List<LastDonation> donations;
  const RecentActivityTable({super.key, required this.donations});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const _ActivityTableHeader(),
          if (donations.isEmpty)
            _buildEmptyState()
          else
            ...donations.map((d) => ActivityTableRow(donation: d)).toList(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Text('Recent Activity', style: AppTypography.h2),
          const Spacer(),
          TextButton(
            onPressed: () => context.go(Routes.donations),
            child: Text(
              'View All',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.all(32.r),
      child: const Text('No recent donations found'),
    );
  }
}

class _ActivityTableHeader extends StatelessWidget {
  const _ActivityTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      color: AppColors.divider.withOpacity(0.3),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            _headerCell('Donor', width: 190.w),
            _headerCell('Amount', width: 150.w),
            _headerCell('Category', width: 150.w),
            _headerCell('Date', width: 150.w),
            Expanded(child: _headerCell('Status', textAlign: TextAlign.end)),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String text, {double? width, TextAlign? textAlign}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        textAlign: textAlign,
        style: AppTypography.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
