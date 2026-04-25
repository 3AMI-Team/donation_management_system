import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/categories_table.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_cubit/categories_cubit.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesViewBody extends StatefulWidget {
  const CategoriesViewBody({super.key});

  @override
  State<CategoriesViewBody> createState() => _CategoriesViewBodyState();
}

class _CategoriesViewBodyState extends State<CategoriesViewBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        int totalItems = 0;
        int totalPages = 1;
        int currentPage = 1;

        if (state is CategoriesLoaded) {
          totalItems = state.totalCount;
          totalPages = state.totalPages;
          currentPage = state.currentPage;
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  FilterChips(
                    hintText: 'Search categories...',
                    searchController: _searchController,
                    onSearchChanged: (val) {
                      context.read<CategoriesCubit>().filterCategories(query: val);
                    },
                    onSortPressed: () {},
                  ),
                  Gap(16.h),
                  const CategoriesTable(),
                  Gap(16.h),
                  Pagination(
                    currentPage: currentPage,
                    totalItems: totalItems,
                    itemsPerPage: 5,
                    onPreviousPressed: currentPage > 1
                        ? () => context.read<CategoriesCubit>().changePage(currentPage - 1)
                        : null,
                    onNextPressed: currentPage < totalPages
                        ? () => context.read<CategoriesCubit>().changePage(currentPage + 1)
                        : null,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
