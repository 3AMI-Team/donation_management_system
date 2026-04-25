import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/dashboard/domain/entity/donation_trends_entity.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/base_line_chart.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/widgets/chart_header.dart';
import 'package:flutter/material.dart';

class DashboardChart extends StatelessWidget {
  final DonationTrends trends;
  const DashboardChart({super.key, required this.trends});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        width: 800.w,
        height: 500.h,
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            ChartHeader(trends: trends),
            Gap(24.h),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  BaseLineChart(items: trends.donationByMonth, type: ChartType.monthly),
                  BaseLineChart(items: trends.donationByWeek, type: ChartType.weekly),
                  BaseLineChart(items: trends.donationByDay, type: ChartType.daily),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
