import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesKPIsCards extends StatelessWidget {
  const CategoriesKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoaded) {
          final totalCategories = state.masterCategories.length;
          final totalCases = state.masterCategories
              .fold<int>(0, (sum, c) => sum + c.totalCases);
          final avgCases = totalCategories > 0
              ? (totalCases / totalCategories).toStringAsFixed(1)
              : '0';

          String highestImpact = 'N/A';
          if (state.masterCategories.isNotEmpty) {
            final highest = state.masterCategories
                .reduce((a, b) => a.totalDonations > b.totalDonations ? a : b);
            highestImpact = highest.type;
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildKPI(
                'Total Active Categories',
                totalCategories.toString(),
                'assets/icons/active cases.png',
                Icons.category_outlined,
              ),
              const SizedBox(width: 12),
              _buildKPI(
                'Avg. Cases per Category',
                avgCases,
                'assets/icons/Donors.png',
                Icons.bar_chart_rounded,
              ),
              const SizedBox(width: 12),
              _buildKPI(
                'Highest Impact',
                highestImpact,
                'assets/icons/funds distributed.png',
                Icons.volunteer_activism_outlined,
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildKPI('Total Active Categories', '...',
                'assets/icons/active cases.png', Icons.category_outlined),
            const SizedBox(width: 12),
            _buildKPI('Avg. Cases per Category', '...',
                'assets/icons/Donors.png', Icons.bar_chart_rounded),
            const SizedBox(width: 12),
            _buildKPI('Highest Impact', '...',
                'assets/icons/funds distributed.png', Icons.volunteer_activism_outlined),
          ],
        );
      },
    );
  }

  Widget _buildKPI(String title, String value, String logo, IconData icon) {
    return Expanded(
      child: KPICard(
        title: title,
        value: value,
        logo: logo,
        icon: icon,
      ),
    );
  }
}