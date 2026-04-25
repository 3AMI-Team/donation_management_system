import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/add_case_dialog.dart';
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
        BlocProvider(create: (context) => sl<CasesCubit>()..getCases()),
        BlocProvider(create: (context) => sl<CaseStatsCubit>()..getCaseKpis()),
        BlocProvider(create: (context) => sl<CategoriesBloc>()..add(GetCategoriesEvent())),
        BlocProvider(create: (context) => sl<AddCaseCubit>()),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: PageHeader(
                  title: 'Cases Management',
                  subtitle: 'Manage your cases database, track contributions, and maintain relationships.',
                  filledButtonText: 'Add Case',
                  onFilledPressed: () {
                    final addCaseCubit = context.read<AddCaseCubit>();
                    final casesCubit = context.read<CasesCubit>();
                    final categoriesBloc = context.read<CategoriesBloc>();
                    showDialog(
                      context: context,
                      builder: (dialogContext) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: addCaseCubit),
                          BlocProvider.value(value: casesCubit),
                          BlocProvider.value(value: categoriesBloc),
                        ],
                        child: const AddCaseDialog(),
                      ),
                    );
                  },
                ),
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
          return const ShimmerStatsRow(count: 4, cardHeight: 110);
        }
        if (state is CaseStatsError) {
          return Center(child: Text(state.message));
        }
        if (state is CaseStatsLoaded) {
          final kpis = [
            (title: 'Total Cases', value: state.kpis.totalCases.toString(), icon: Icons.people_alt_outlined),
            (title: 'Pending Review', value: state.kpis.pendingReview.toString(), icon: Icons.people_alt_outlined),
            (title: 'Active Cases', value: state.kpis.activeCases.toString(), icon: Icons.people_outline_outlined),
            (title: 'Funded Cases', value: state.kpis.fundedCases.toString(), icon: Icons.av_timer),
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
                      percentageChange: 0, // Default value for now
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
