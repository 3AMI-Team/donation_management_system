import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/dashboard/domain/entity/donation_trends_entity.dart';
import 'package:fl_chart/fl_chart.dart';

enum ChartType { monthly, weekly, daily }

class BaseLineChart extends StatelessWidget {
  final List<DonationTrendItem> items;
  final ChartType type;

  const BaseLineChart({super.key, required this.items, required this.type});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    final spots = _generateSpots();
    double rawMaxY = spots.isEmpty ? 10.0 : spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    double maxY = rawMaxY == 0 ? 1000 : (rawMaxY * 1.3);
    double interval = (maxY / 5).ceilToDouble();
    if (interval == 0) interval = 1000;
    maxY = interval * 5;

    double minX = 0;
    double maxX = 11;
    if (type == ChartType.monthly) {
      minX = 1; maxX = 12;
    } else if (type == ChartType.weekly) {
      minX = 1; maxX = 7;
    } else if (type == ChartType.daily) {
      minX = spots.first.x - 1;
      maxX = spots.last.x + 5;
      if (minX < 0) minX = 0;
      if (maxX > 23) maxX = 23;
    }

    return Padding(
      padding: EdgeInsets.only(right: 20.w, left: 10.w),
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
                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
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
    if (type == ChartType.monthly || type == ChartType.daily) {
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
          .map((s) => LineTooltipItem('${s.y.toStringAsFixed(0)} EGP', const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))
          .toList(),
    ),
  );

  FlGridData _buildGridData(double interval) => FlGridData(
    show: true,
    drawVerticalLine: false,
    horizontalInterval: interval,
    getDrawingHorizontalLine: (value) => FlLine(color: AppColors.border.withOpacity(0.2), strokeWidth: 1),
  );

  FlTitlesData _buildTitlesData(double interval) => FlTitlesData(
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: interval,
        reservedSize: 65.w,
        getTitlesWidget: (val, meta) => Text('${val.toInt()}', style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
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
          return Padding(padding: EdgeInsets.only(top: 12.h), child: Text(label, style: TextStyle(color: Colors.grey, fontSize: 11.sp)));
        },
      ),
    ),
  );

  String _getLabel(double value) {
    if (type == ChartType.monthly) {
      const labels = {1: 'Jan', 2: 'Feb', 3: 'Mar', 4: 'Apr', 5: 'May', 6: 'Jun', 7: 'Jul', 8: 'Aug', 9: 'Sep', 10: 'Oct', 11: 'Nov', 12: 'Dec'};
      return labels[value.toInt()] ?? '';
    } else if (type == ChartType.weekly) {
      const labels = {1: 'Mon', 2: 'Tue', 3: 'Wed', 4: 'Thu', 5: 'Fri', 6: 'Sat', 7: 'Sun'};
      return labels[value.toInt()] ?? '';
    }
    return '${value.toInt()}:00';
  }
}
