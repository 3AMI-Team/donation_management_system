import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/theme/typography.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/add_new_donor.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donors_view_body.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donors_kpi_cards.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donor_stats_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DonorsView extends StatelessWidget {
  const DonorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<DonorsCubit>()..getDonors(),
        ),
        BlocProvider(
          create: (context) => sl<DonorStatsCubit>()..getDonorKpis(),
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: ListView(
            children: [
              Text('Donors Management', style: AppTypography.h1),
              Gap(5.h),
              Row(
                children: [
                  Text(
                    'Manage your donor database, track contributions, and maintain relationships with\nindividuals and corporate partners.',
                    style: AppTypography.bodyMedium,
                  ),
                  const Spacer(),
                  const AddNewDonor(),
                ],
              ),
              Gap(20.h),
              const DonorsKPIsCards(),
              Gap(20.h),
              const DonorsViewBody(),
            ],
          ),
        ),
      ),
    );
  }
}
