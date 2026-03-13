import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/cases_table.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';

class CasesViewBody extends StatefulWidget {
  const CasesViewBody({super.key});

  @override
  State<CasesViewBody> createState() => _CasesViewBodyState();
}

class _CasesViewBodyState extends State<CasesViewBody> {
  String _selectedFilter = 'All';

  final TextEditingController _searchController = TextEditingController();

  int _currentPage = 1;

  final List<String> _filters = ["All", "Medical", "Shelter", "Education"];

  @override
  Widget build(BuildContext context) {
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
              const CasesTable(),
              Gap(16.h),
              Pagination(
                currentPage: _currentPage,
                totalItems: 45,
                itemsPerPage: 5,
                onPreviousPressed: () {
                  if (_currentPage > 1) {
                    setState(() {
                      _currentPage--;
                    });
                  }
                },
                onNextPressed: () {
                  if (_currentPage < 9) {
                    setState(() {
                      _currentPage++;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}


