import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/add_donor_dialog.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donors_view_body.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donors_kpi_cards.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donor_stats_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonorsView extends StatelessWidget {
  const DonorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<DonorsCubit>()..getDonors()),
        BlocProvider(create: (context) => sl<DonorStatsCubit>()..getDonorKpis()),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: PageHeader(
                  title: 'Donors Management',
                  subtitle: 'Manage your donor database, track contributions, and maintain relationships.',
                  filledButtonText: 'Add Donor',
                  onFilledPressed: () {
                    final donorsCubit = context.read<DonorsCubit>();
                    final statsCubit = context.read<DonorStatsCubit>();
                    showDialog(
                      context: context,
                      builder: (dialogContext) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: donorsCubit),
                          BlocProvider.value(value: statsCubit),
                        ],
                        child: const AddDonorDialog(),
                      ),
                    );
                  },
                ),
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
