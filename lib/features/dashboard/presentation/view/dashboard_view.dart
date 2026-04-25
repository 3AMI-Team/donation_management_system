import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/sections/distributions_section.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/sections/kpis_section.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/sections/recent_activity_section.dart';
import 'package:donation_management_system/features/dashboard/presentation/view/sections/trends_section.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/kpis_cubit/kpis_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/last_distributions_cubit/last_distributions_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/recent_activity_cubit/recent_activity_cubit.dart';
import 'package:donation_management_system/features/dashboard/presentation/view_model/trends_cubit/trends_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<KpisCubit>()..getKpis()),
        BlocProvider(create: (context) => sl<TrendsCubit>()..getTrends()),
        BlocProvider(
          create: (context) => sl<RecentActivityCubit>()..getLastDonations(),
        ),
        BlocProvider(
          create: (context) =>
              sl<LastDistributionsCubit>()..getLastDistributions(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
          child: const _DashboardBody(),
        ),
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const KpisSection(),
        Gap(32.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  const TrendsSection(),
                  Gap(32.h),
                  const RecentActivitySection(),
                ],
              ),
            ),
            Gap(32.w),
            const DistributionsSection(),
          ],
        ),
      ],
    );
  }
}
