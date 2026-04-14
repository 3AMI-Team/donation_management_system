import 'package:donation_management_system/core/routes/routes.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/features/dashboard/domain/entity/last_distribution_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';

class LastDistributionsList extends StatelessWidget {
  final List<LastDistribution> distributions;
  const LastDistributionsList({super.key, required this.distributions});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 385.w,
      height: 620.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const Divider(),
          if (distributions.isEmpty)
            const Expanded(child: Center(child: Text('No distributions found')))
          else
            Expanded(child: _buildList()),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: [
          Text('Last Distributions', style: AppTypography.h2),
          const Spacer(),
          const Icon(Icons.more_vert, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemCount: distributions.length,
      separatorBuilder: (context, index) => Gap(16.h),
      itemBuilder: (context, index) {
        final dist = distributions[index];
        return Row(
          children: [
            _buildIcon(),
            Gap(12.w),
            Expanded(child: _buildInfo(dist)),
            Gap(8.w),
            _buildAmount(dist),
          ],
        );
      },
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 48.r,
      height: 48.r,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(Icons.outbox_rounded, color: AppColors.primary, size: 24.r),
    );
  }

  Widget _buildInfo(LastDistribution dist) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dist.caseName,
          style: AppTypography.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Gap(4.h),
        Text(
          DateFormat('MMM dd, yyyy').format(dist.date),
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAmount(LastDistribution dist) {
    return Text(
      '\$${dist.amount.toStringAsFixed(0)}',
      style: AppTypography.bodyMedium.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.green[700],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => context.go(Routes.distributions),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary.withOpacity(0.05),
            foregroundColor: AppColors.primary,
            elevation: 0,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: const Text('View Detailed Report'),
        ),
      ),
    );
  }
}
