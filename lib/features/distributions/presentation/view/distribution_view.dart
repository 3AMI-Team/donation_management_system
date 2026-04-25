import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/add_distribution_dialog.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/dist_table.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/distributin_kpis_cards.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/add_distribution_cubit/add_distribution_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distribution_stats_cubit/distribution_stats_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distributions_cubit/distributions_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distributions_cubit/distributions_state.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DistributionView extends StatelessWidget {
  const DistributionView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<DistributionStatsCubit>()..getDistributionKpis()),
        BlocProvider(create: (context) => sl<DistributionsCubit>()..getDistributions()),
        BlocProvider(create: (context) => sl<AddDistributionCubit>()),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: PageHeader(
                  title: 'Distributions Management',
                  subtitle: 'Track and manage the distribution of aid to cases efficiently.',
                  filledButtonText: 'Add Distribution',
                  onFilledPressed: () {
                    final addCubit = context.read<AddDistributionCubit>();
                    final distsCubit = context.read<DistributionsCubit>();
                    final statsCubit = context.read<DistributionStatsCubit>();
                    showDialog(
                      context: context,
                      builder: (dialogContext) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: addCubit),
                          BlocProvider.value(value: distsCubit),
                          BlocProvider.value(value: statsCubit),
                        ],
                        child: const AddDistributionDialog(),
                      ),
                    );
                  },
                ),
              ),
              Gap(20.h),
              const DistributionKPIsCards(),
              Gap(20.h),
              const DistributionViewBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class DistributionViewBody extends StatefulWidget {
  const DistributionViewBody({super.key});

  @override
  State<DistributionViewBody> createState() => _DistributionViewBodyState();
}

class _DistributionViewBodyState extends State<DistributionViewBody> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _filters = ["All", "Delivered", "Pending"];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DistributionsCubit, DistributionsState>(
      builder: (context, state) {
        if (state is DistributionsLoading) {
          return const ShimmerTable(rowCount: 8);
        }

        if (state is DistributionsError) {
          return Center(child: Text(state.message));
        }

        if (state is DistributionsLoaded) {
          return FadeInLeft(
            duration: const Duration(milliseconds: 500),
            child: Column(
              children: [
                FilterChips(
                  hintText: 'Search distributions...',
                  filters: _filters,
                  selectedFilter: state.selectedStatus,
                  onFilterSelected: (filter) {
                    context.read<DistributionsCubit>().filterDistributions(status: filter);
                  },
                  searchController: _searchController,
                  onSearchChanged: (value) {
                    context.read<DistributionsCubit>().filterDistributions(query: value);
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
                  onPreviousPressed: state.currentPage > 1
                      ? () => context.read<DistributionsCubit>().changePage(state.currentPage - 1)
                      : null,
                  onNextPressed: state.currentPage < state.totalPages
                      ? () => context.read<DistributionsCubit>().changePage(state.currentPage + 1)
                      : null,
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
