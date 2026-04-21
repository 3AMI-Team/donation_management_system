import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/cases_table.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/cases_cubit.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/cases_state.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CasesViewBody extends StatefulWidget {
  const CasesViewBody({super.key});

  @override
  State<CasesViewBody> createState() => _CasesViewBodyState();
}

class _CasesViewBodyState extends State<CasesViewBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CasesCubit, CasesState>(
      builder: (context, state) {
        if (state is CasesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CasesError) {
          return Center(child: Text(state.message));
        } else if (state is CasesLoaded) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    FilterChips(
                      hintText: 'Search Cases...',
                      filters: const [], // Filters can be added later if needed
                      selectedFilter: 'All',
                      onFilterSelected: (filter) {},
                      searchController: _searchController,
                      onSearchChanged: (value) {
                        context.read<CasesCubit>().searchCases(value);
                      },
                      onSortPressed: () {},
                    ),
                    Gap(16.h),
                    CasesTable(cases: state.currentPageCases),
                    Gap(16.h),
                    Pagination(
                      currentPage: state.currentPage,
                      totalItems: state.totalCount,
                      itemsPerPage: 10,
                      onPreviousPressed: state.currentPage > 1
                          ? () => context
                              .read<CasesCubit>()
                              .changePage(state.currentPage - 1)
                          : null,
                      onNextPressed: state.currentPage < state.totalPages
                          ? () => context
                              .read<CasesCubit>()
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


