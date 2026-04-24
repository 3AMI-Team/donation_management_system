import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/add_new_distribution.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/dist_table.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/distributin_kpis_cards.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/add_distribution_cubit/add_distribution_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distribution_stats_cubit/distribution_stats_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distributions_cubit/distributions_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distributions_cubit/distributions_state.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistributionView extends StatelessWidget {
  const DistributionView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<DistributionStatsCubit>()..getDistributionKpis(),
        ),
        BlocProvider(
          create: (context) => sl<DistributionsCubit>()..getDistributions(),
        ),
        BlocProvider(
          create: (context) => sl<AddDistributionCubit>(),
        ),
      ],
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: ListView(
            children: [
              Text('Distributions Management', style: AppTypography.h1),
              Gap(5.h),
              Row(
                children: [
                  Text(
                    'Manage your donor database, track contributions, and maintain relationships with\nindividuals and corporate partners.',
                    style: AppTypography.bodyMedium,
                  ),
                  const Spacer(),
                  const AddNewDistribution(),
                ],
              ),
              Gap(20.h),
              const DistributionKPIsCards(),
              Gap(20.h),
              const DistribtionViewBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class DistribtionViewBody extends StatefulWidget {
  const DistribtionViewBody({super.key});

  @override
  State<DistribtionViewBody> createState() => _DistribtionViewBodyState();
}

class _DistribtionViewBodyState extends State<DistribtionViewBody> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _filters = ["All", "Delivered", "Pending"];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DistributionsCubit, DistributionsState>(
      builder: (context, state) {
        if (state is DistributionsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DistributionsError) {
          return Center(child: Text(state.message));
        }

        if (state is DistributionsLoaded) {
          return Column(
            children: [
              FilterChips(
                hintText: 'Search ...',
                filters: _filters,
                selectedFilter: state.selectedStatus,
                onFilterSelected: (filter) {
                  context
                      .read<DistributionsCubit>()
                      .filterDistributions(status: filter);
                },
                searchController: _searchController,
                onSearchChanged: (value) {
                  context
                      .read<DistributionsCubit>()
                      .filterDistributions(query: value);
                },
                onSortPressed: () {},
              ),
              Gap(16.h),
              DistributionTable(distributions: state.currentPageDistributions),
              Gap(16.h),
              Pagination(
                currentPage: state.currentPage,
                totalItems: state.totalCount,
                itemsPerPage: 10,
                onPreviousPressed: () {
                  context
                      .read<DistributionsCubit>()
                      .changePage(state.currentPage - 1);
                },
                onNextPressed: () {
                  context
                      .read<DistributionsCubit>()
                      .changePage(state.currentPage + 1);
                },
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
