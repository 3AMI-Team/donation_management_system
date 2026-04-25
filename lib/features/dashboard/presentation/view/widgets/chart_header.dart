import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/dashboard/domain/entity/donation_trends_entity.dart';

class ChartHeader extends StatelessWidget {
  final DonationTrends trends;
  const ChartHeader({super.key, required this.trends});

  @override
  Widget build(BuildContext context) {
    double totalByMonth = trends.donationByMonth.fold(0, (sum, item) => sum + item.amount);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Donation Trends', style: AppTypography.h2),
            Text(
              'Overview of your fundraising performance',
              style: AppTypography.bodyMedium.copyWith(color: Colors.grey[500]),
            ),
            Gap(12.h),
            Row(
              children: [
                Text(
                  '${totalByMonth.toStringAsFixed(0)} EGP',
                  style: AppTypography.h1.copyWith(fontSize: 28.sp),
                ),
                Gap(12.w),
                const _GrowthBadge(percentage: '12.5%'),
              ],
            ),
          ],
        ),
        const Spacer(),
        const PeriodSelector(),
      ],
    );
  }
}

class _GrowthBadge extends StatelessWidget {
  final String percentage;
  const _GrowthBadge({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_upward, size: 14.sp, color: Colors.green[700]),
          Gap(4.w),
          Text(
            percentage,
            style: TextStyle(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class PeriodSelector extends StatelessWidget {
  const PeriodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 240.w,
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        labelStyle: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.bold),
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        tabs: const [
          Tab(text: "Monthly"),
          Tab(text: "Weekly"),
          Tab(text: "Daily"),
        ],
      ),
    );
  }
}
