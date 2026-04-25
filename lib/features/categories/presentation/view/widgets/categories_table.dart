import 'package:animate_do/animate_do.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_state.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/category_data_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoriesTable extends StatelessWidget {
  const CategoriesTable({super.key});

  static const List<TableHeader> _headers = [
    TableHeader(text: 'Category Name', flex: 2),
    TableHeader(text: 'Description', flex: 3),
    TableHeader(text: 'Total Cases', flex: 1),
    TableHeader(text: 'Total Donations', flex: 1),
    TableHeader(text: 'Actions', flex: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is CategoriesError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (state is CategoriesLoaded) {
          if (state.masterCategories.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No categories found.'),
              ),
            );
          }

          final categories = state.currentPageCategories;
          return CustomTable<CategoryEntity>(
            headerCells: _headers,
            dataRow: categories,
            sortKeyExtractors: {
              0: (cat) => cat.type,
              2: (cat) => cat.totalCases,
              3: (cat) => cat.totalDonations,
            },
            itemBuilder: (item) {
              final i = categories.indexOf(item);
              return FadeInUp(
                delay: Duration(milliseconds: i * 40),
                duration: const Duration(milliseconds: 400),
                child: CategoryDataRow(category: item),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
