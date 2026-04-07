import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/categories_table.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';

class CategoriesViewBody extends StatefulWidget {
  const CategoriesViewBody({super.key});

  @override
  State<CategoriesViewBody> createState() => _CategoriesViewBodyState();
}

class _CategoriesViewBodyState extends State<CategoriesViewBody> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;

  final List<String> _filters = ['All', 'Active', 'Draft', 'Archived'];

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
          child: Column(
            children: [
              FilterChips(
                hintText: 'Search categories...',
                filters: _filters,
                selectedFilter: _selectedFilter,
                onFilterSelected: (filter) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
                searchController: _searchController,
                onSearchChanged: (_) {},
                onSortPressed: () {},
              ),
              Gap(16.h),
              const CategoriesTable(),
              Gap(16.h),
              Pagination(
                currentPage: _currentPage,
                totalItems: 24,
                itemsPerPage: 5,
                onPreviousPressed: () {
                  if (_currentPage > 1) {
                    setState(() {
                      _currentPage--;
                    });
                  }
                },
                onNextPressed: () {
                  if (_currentPage < 5) {
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
