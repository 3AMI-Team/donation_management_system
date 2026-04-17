import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donors_table.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DonorsViewBody extends StatefulWidget {
  const DonorsViewBody({super.key});

  @override
  State<DonorsViewBody> createState() => _DonorsViewBodyState();
}

class _DonorsViewBodyState extends State<DonorsViewBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonorsCubit, DonorsState>(
      builder: (context, state) {
        if (state is DonorsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DonorsError) {
          return Center(child: Text(state.message));
        } else if (state is DonorsLoaded) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    FilterChips(
                      hintText: 'Search donors...',
                      filters: const [], // Removed filtration as requested
                      selectedFilter: 'All',
                      onFilterSelected: (filter) {},
                      searchController: _searchController,
                      onSearchChanged: (value) {
                        context.read<DonorsCubit>().searchDonors(value);
                      },
                      onSortPressed: () {},
                    ),
                    Gap(16.h),
                    DonorsTable(donors: state.currentPageDonors),
                    Gap(16.h),
                    Pagination(
                      currentPage: state.currentPage,
                      totalItems: state.totalCount,
                      itemsPerPage: 10,
                      onPreviousPressed: state.currentPage > 1
                          ? () => context
                              .read<DonorsCubit>()
                              .changePage(state.currentPage - 1)
                          : null,
                      onNextPressed: state.currentPage < state.totalPages
                          ? () => context
                              .read<DonorsCubit>()
                              .changePage(state.currentPage + 1)
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
