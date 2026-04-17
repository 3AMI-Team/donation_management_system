import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/donations_table_header_actions.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/donations_stats_row.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/donations_main_content.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donation_stats_cubit.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donations_cubit.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DonationsView extends StatelessWidget {
  const DonationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<DonationsCubit>()..fetchDonations(),
        ),
        BlocProvider(
          create: (context) => sl<DonationStatsCubit>()..getDonationKpis(),
        ),
        BlocProvider(
          create: (context) => sl<CategoriesCubit>()..getCategories(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DonationsTableHeaderActions(),
                Gap(24.h),
                const DonationsStatsRow(),
                Gap(24.h),
                const DonationsMainContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
