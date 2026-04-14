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
  String _selectedFilter = 'All';

  final TextEditingController _searchController = TextEditingController();

  final int _currentPage = 1;

  final List<String> _filters = ["All", "Medical", "Shelter", "Education"];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CasesCubit, CasesState>(
      builder: (context, state) {
        if (state is CasesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CasesError) {
          return Center(child: Text(state.message));
        } else if (state is CasesLoaded) {
          final cases = state.casesResponse.items;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    FilterChips(
                      hintText: 'Search Case...',
                      filters: _filters,
                      selectedFilter: _selectedFilter,
                      onFilterSelected: (filter) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      searchController: _searchController,
                      onSearchChanged: (value) {},
                      onSortPressed: () {},
                    ),
                    Gap(16.h),
                    CasesTable(cases: cases),
                    Gap(16.h),
                    Pagination(
                      currentPage: state.casesResponse.page,
                      totalItems: state.casesResponse.totalCount,
                      itemsPerPage: state.casesResponse.pageSize,
                      onPreviousPressed: () {
                        // Handle pagination if needed
                      },
                      onNextPressed: () {
                        // Handle pagination if needed
                      },
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


