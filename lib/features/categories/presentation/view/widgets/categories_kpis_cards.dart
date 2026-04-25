import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesKPIsCards extends StatelessWidget {
  const CategoriesKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const ShimmerStatsRow(count: 3, cardHeight: 110);
        }

        if (state is CategoriesLoaded) {
          final totalCategories = state.masterCategories.length;
          final totalCases = state.masterCategories.fold<int>(0, (sum, c) => sum + c.totalCases);
          final avgCases = totalCategories > 0 ? (totalCases / totalCategories).toStringAsFixed(1) : '0';

          String highestImpact = 'N/A';
          if (state.masterCategories.isNotEmpty) {
            final highest = state.masterCategories.reduce((a, b) => a.totalDonations > b.totalDonations ? a : b);
            highestImpact = highest.type;
          }

          final kpis = [
            (
              title: 'Total Active Categories',
              value: totalCategories.toString(),
              icon: Icons.category_outlined,
              color: const Color(0xFF6366F1)
            ),
            (
              title: 'Avg. Cases per Category',
              value: avgCases,
              icon: Icons.bar_chart_rounded,
              color: const Color(0xFF3B82F6)
            ),
            (
              title: 'Highest Impact',
              value: highestImpact,
              icon: Icons.volunteer_activism_outlined,
              color: const Color(0xFFF59E0B)
            ),
          ];

          return Row(
            children: List.generate(kpis.length, (index) {
              final kpi = kpis[index];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: index < kpis.length - 1 ? 16.w : 0),
                  child: FadeInUp(
                    delay: Duration(milliseconds: index * 100),
                    duration: const Duration(milliseconds: 500),
                    child: StatCard(
                      title: kpi.title,
                      value: kpi.value,
                      icon: kpi.icon,
                      iconColor: kpi.color,
                      percentageChange: 0,
                    ),
                  ),
                ),
              );
            }),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}