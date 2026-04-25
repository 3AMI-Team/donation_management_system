import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/widgets/kpi_card.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/add_new_case.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/case_view_body.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/case_stats_cubit.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/cases_cubit.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/add_case_cubit/add_case_cubit.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasesView extends StatelessWidget {
  const CasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CasesCubit>()..getCases(),
        ),
        BlocProvider(
          create: (context) => sl<CaseStatsCubit>()..getCaseKpis(),
        ),
        BlocProvider(
          create: (context) => sl<CategoriesBloc>()..add(GetCategoriesEvent()),
        ),
        BlocProvider(
          create: (context) => sl<AddCaseCubit>(),
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: ListView(
            children: [
              Text('Cases Management', style: AppTypography.h1),
              Gap(5.h),
              Row(
                children: [
                  Text(
                    'Manage your donor database, track contributions, and maintain relationships with\nindividuals and corporate partners.',
                    style: AppTypography.bodyMedium,
                  ),
                  const Spacer(),
                  const AddNewCase(),
                ],
              ),
              Gap(20.h),
              const CasesKPIsCards(),
              Gap(20.h),
              const CasesViewBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class CasesKPIsCards extends StatelessWidget {
  const CasesKPIsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CaseStatsCubit, CaseStatsState>(
      builder: (context, state) {
        if (state is CaseStatsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CaseStatsError) {
          return Center(child: Text(state.message));
        }
        if (state is CaseStatsLoaded) {
          final kpis = state.kpis;
          return Row(
            children: [
              Expanded(
                child: KPICard(
                  title: 'Total Cases',
                  value: kpis.totalCases.toString(),
                  logo: 'assets/icons/active cases.png',
                  icon: Icons.people_alt_outlined,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: KPICard(
                  title: 'Pending Review',
                  value: kpis.pendingReview.toString(),
                  logo: 'assets/icons/funds distributed.png',
                  icon: Icons.people_alt_outlined,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: KPICard(
                  title: 'Active Cases',
                  value: kpis.activeCases.toString(),
                  logo: 'assets/icons/Donors.png',
                  icon: Icons.people_outline_outlined,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: KPICard(
                  title: 'Funded Cases',
                  value: kpis.fundedCases.toString(),
                  logo: 'assets/icons/funds distributed.png',
                  icon: Icons.av_timer,
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
