import 'package:donation_management_system/features/categories/presentation/view_model/categories_cubit/categories_cubit.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donations_cubit.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/donations_cubit/donations_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'donations_table.dart';
import 'widgets.dart' as common;

class DonationsMainContent extends StatefulWidget {
  const DonationsMainContent({super.key});

  @override
  State<DonationsMainContent> createState() => _DonationsMainContentState();
}

class _DonationsMainContentState extends State<DonationsMainContent> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildTableSection(),
        ),
        Gap(24.w),
        Expanded(
          flex: 1,
          child: _buildSidebar(),
        ),
      ],
    );
  }

  Widget _buildTableSection() {
    return BlocBuilder<DonationsCubit, DonationsState>(
      builder: (context, state) {
        if (state is DonationsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DonationsLoaded) {
          // Sync text controller if needed (rarely needed for one-way search)
          return Column(
            children: [
              _buildFilters(context, state),
              Gap(24.h),
              DonationsTable(donations: state.currentPageDonations),
              Gap(16.h),
              _buildPagination(context, state),
            ],
          );
        } else if (state is DonationsError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildFilters(BuildContext context, DonationsLoaded state) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, categoriesState) {
        List<String> categories = ['All'];
        if (categoriesState is CategoriesLoaded) {
          categories.addAll(categoriesState.masterCategories.map((e) => e.category.type));
        }

        return common.FilterChips(
          hintText: 'Search donations ...',
          filters: categories,
          selectedFilter: state.selectedCategory ?? 'All',
          onFilterSelected: (filter) {
            context.read<DonationsCubit>().filterDonations(
                  category: filter,
                );
          },
          searchController: _searchController,
          onSearchChanged: (value) {
            context.read<DonationsCubit>().filterDonations(
                  query: value,
                );
          },
          onSortPressed: () {},
        );
      },
    );
  }

  Widget _buildPagination(BuildContext context, DonationsLoaded state) {
    return common.Pagination(
      currentPage: state.currentPage,
      totalItems: state.totalCount,
      itemsPerPage: 10,
      onPreviousPressed: state.currentPage > 1
          ? () => context.read<DonationsCubit>().changePage(state.currentPage - 1)
          : null,
      onNextPressed: state.currentPage < state.totalPages
          ? () => context.read<DonationsCubit>().changePage(state.currentPage + 1)
          : null,
    );
  }

  Widget _buildSidebar() {
    return Column(
      children: [
        common.RecordDonationForm(onConfirmPressed: () {}),
        Gap(20.h),
        common.CampaignGoalCard(
          goalAmount: '\$100k',
          currentAmount: '\$45,200',
          description: 'Help us reach our goal to support more families in need.',
          progress: 0.452,
        ),
      ],
    );
  }
}
