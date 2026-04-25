import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesKPIsCards extends StatelessWidget {
  const CategoriesKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoaded) {
          final totalCategories = state.masterCategories.length;
          final totalCases = state.masterCategories.fold<int>(0, (sum, c) => sum + c.totalCases);
          final avgCases = totalCategories > 0 ? (totalCases / totalCategories).toStringAsFixed(1) : '0';
          
          String highestImpact = 'N/A';
          if (state.masterCategories.isNotEmpty) {
            final highest = state.masterCategories.reduce((a, b) => a.totalDonations > b.totalDonations ? a : b);
            highestImpact = highest.category.type;
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: KPICard(
                  title: 'Total Active Categories',
                  value: totalCategories.toString(),
                  logo: 'assets/icons/active cases.png',
                  icon: Icons.category_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: KPICard(
                  title: 'Avg. Cases per Category',
                  value: avgCases,
                  logo: 'assets/icons/Donors.png',
                  icon: Icons.bar_chart_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: KPICard(
                  title: 'Highest Impact',
                  value: highestImpact,
                  logo: 'assets/icons/funds distributed.png',
                  icon: Icons.volunteer_activism_outlined,
                ),
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: KPICard(
                title: 'Total Active Categories',
                value: '...',
                logo: 'assets/icons/active cases.png',
                icon: Icons.category_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: KPICard(
                title: 'Avg. Cases per Category',
                value: '...',
                logo: 'assets/icons/Donors.png',
                icon: Icons.bar_chart_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: KPICard(
                title: 'Highest Impact',
                value: '...',
                logo: 'assets/icons/funds distributed.png',
                icon: Icons.volunteer_activism_outlined,
              ),
            ),
          ],
        );
      },
    );
  }
}