import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import '../../../domain/entity/donation_trends_entity.dart';

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
            _ChartHeader(trends: trends),
            Gap(24.h),
            Expanded(child: _ChartViewSection(trends: trends)),
          ],
        ),
      ),
    );
  }
}

class _ChartHeader extends StatelessWidget {
  final DonationTrends trends;
  const _ChartHeader({required this.trends});

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
                  '\$ ${totalByMonth.toStringAsFixed(0)}',
                  style: AppTypography.h1.copyWith(fontSize: 28.sp),
                ),
                Gap(12.w),
                const _GrowthBadge(percentage: '12.5%'),
              ],
            ),
          ],
        ),
        const Spacer(),
        const _PeriodSelector(),
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

class _PeriodSelector extends StatelessWidget {
  const _PeriodSelector();

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
        labelStyle: AppTypography.bodySmall.copyWith(
          fontWeight: FontWeight.bold,
        ),
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

class _ChartViewSection extends StatelessWidget {
  final DonationTrends trends;
  const _ChartViewSection({required this.trends});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _BaseLineChart(items: trends.donationByMonth, type: ChartType.monthly),
        _BaseLineChart(items: trends.donationByWeek, type: ChartType.weekly),
        _BaseLineChart(items: trends.donationByDay, type: ChartType.daily),
      ],
    );
  }
}

enum ChartType { monthly, weekly, daily }

class _BaseLineChart extends StatelessWidget {
  final List<DonationTrendItem> items;
  final ChartType type;

  const _BaseLineChart({required this.items, required this.type});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    final spots = _generateSpots();
    
    // Calculate intelligent MaxY and Interval
    double rawMaxY = spots.isEmpty ? 10.0 : spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    double maxY = rawMaxY == 0 ? 1000 : (rawMaxY * 1.3);
    double interval = (maxY / 5).ceilToDouble();
    if (interval == 0) interval = 1000;
    maxY = interval * 5; // Normalize maxY to interval steps

    // Calculate X range
    double minX = 0;
    double maxX = 11;
    if (type == ChartType.monthly) {
       minX = 1;
       maxX = 12;
    } else if (type == ChartType.weekly) {
       minX = 1;
       maxX = 7;
    } else if (type == ChartType.daily) {
       // For daily, if we have limited points, we can either show full day or a balanced window
       // Let's show from the first hour minus 1 to last hour plus 5 to avoid gaps but feel natural
       minX = spots.first.x - 1;
       maxX = spots.last.x + 5; 
       if (minX < 0) minX = 0;
       if (maxX > 23) maxX = 23;
    }

    return Padding(
      padding: EdgeInsets.only(right: 20.w, left: 10.w), // Add padding to avoid edge cuts
      child: LineChart(
        duration: const Duration(milliseconds: 400),
        LineChartData(
          minX: minX,
          maxX: maxX,
          minY: 0,
          maxY: maxY,
          gridData: _buildGridData(interval),
          titlesData: _buildTitlesData(interval),
          borderData: FlBorderData(show: false),
          lineTouchData: _buildTouchData(),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.primary,
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) =>
                    FlDotCirclePainter(
                      radius: 4,
                      color: Colors.white,
                      strokeWidth: 2.5,
                      strokeColor: AppColors.primary,
                    ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withOpacity(0.2),
                    AppColors.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _generateSpots() {
    if (type == ChartType.monthly) {
      return items.map((e) => FlSpot(double.parse(e.label), e.amount)).toList();
    } else if (type == ChartType.daily) {
      return items.map((e) => FlSpot(double.parse(e.label), e.amount)).toList();
    } else if (type == ChartType.weekly) {
      const weekDays = {
        'Monday': 1.0, 'Tuesday': 2.0, 'Wednesday': 3.0, 'Thursday': 4.0, 'Friday': 5.0, 'Saturday': 6.0, 'Sunday': 7.0,
      };
      final sortedItems = List<DonationTrendItem>.from(items)
        ..sort((a, b) => (weekDays[a.label] ?? 0).compareTo(weekDays[b.label] ?? 0));
        
      return sortedItems.map((e) => FlSpot(weekDays[e.label] ?? 0, e.amount)).toList();
    }
    return [];
  }

  LineTouchData _buildTouchData() => LineTouchData(
    touchTooltipData: LineTouchTooltipData(
      getTooltipColor: (spot) => AppColors.primary,
      getTooltipItems: (spots) => spots
          .map(
            (s) => LineTooltipItem(
              '\$${s.y.toStringAsFixed(0)}',
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
          .toList(),
    ),
  );

  FlGridData _buildGridData(double interval) => FlGridData(
    show: true,
    drawVerticalLine: false,
    horizontalInterval: interval,
    getDrawingHorizontalLine: (value) =>
        FlLine(color: AppColors.border.withOpacity(0.2), strokeWidth: 1),
  );

  FlTitlesData _buildTitlesData(double interval) => FlTitlesData(
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: interval,
        reservedSize: 65.w,
        getTitlesWidget: (val, meta) => Text(
          '\$${val.toInt()}',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.grey, fontSize: 11.sp),
        ),
      ),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 1,
        reservedSize: 40.h,
        getTitlesWidget: (val, meta) {
          final label = _getLabel(val);
          if (label.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Text(
              label,
              style: TextStyle(color: Colors.grey, fontSize: 11.sp),
            ),
          );
        },
      ),
    ),
  );

  String _getLabel(double value) {
    if (type == ChartType.monthly) {
      const labels = {
        1: 'Jan', 2: 'Feb', 3: 'Mar', 4: 'Apr', 5: 'May', 6: 'Jun',
        7: 'Jul', 8: 'Aug', 9: 'Sep', 10: 'Oct', 11: 'Nov', 12: 'Dec',
      };
      return labels[value.toInt()] ?? '';
    } else if (type == ChartType.weekly) {
      const labels = {
        1: 'Mon', 2: 'Tue', 3: 'Wed', 4: 'Thu', 5: 'Fri', 6: 'Sat', 7: 'Sun',
      };
      return labels[value.toInt()] ?? '';
    } else {
      // For daily, only show labels for the points we have to avoid clutter if range is wide
      // or show specific intervals
      return '${value.toInt()}:00';
    }
  }
}
