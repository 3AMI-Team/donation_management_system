import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/categories_table.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_event.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_state.dart';
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const ShimmerTable(rowCount: 6);
        }

        if (state is CategoriesError) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
        }

        if (state is CategoriesLoaded) {
          return _buildLoadedBody(context, state);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadedBody(BuildContext context, CategoriesLoaded state) {
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
                  context
                      .read<CategoriesBloc>()
                      .add(FilterCategoriesEvent(query: val));
                },
                onSortPressed: () {},
              ),
              Gap(16.h),
              const CategoriesTable(),
              Gap(16.h),
              Pagination(
                currentPage: state.currentPage,
                totalItems: state.totalCount,
                itemsPerPage: 5,
                onPreviousPressed: state.currentPage > 1
                    ? () => context
                        .read<CategoriesBloc>()
                        .add(ChangePageEvent(state.currentPage - 1))
                    : null,
                onNextPressed: state.currentPage < state.totalPages
                    ? () => context
                        .read<CategoriesBloc>()
                        .add(ChangePageEvent(state.currentPage + 1))
                    : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
