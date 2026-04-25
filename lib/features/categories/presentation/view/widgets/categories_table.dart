import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_cubit/categories_cubit.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_cubit/category_ui_model.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/add_new_category.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/add_category_cubit/add_category_cubit.dart';
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
    return BlocBuilder<CategoriesCubit, CategoriesState>(
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

          return CustomTable(
            headerCells: _headers,
            dataRow: state.currentPageCategories,
            itemBuilder: (item) => CategoryDataRow(category: item),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class CategoryDataRow extends StatelessWidget {
  final CategoryUIModel category;

  const CategoryDataRow({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    category.category.type.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    category.category.type,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              category.category.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
                height: 1.35,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              category.totalCases.toString(),
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "${category.totalDonations.toStringAsFixed(0)} EGP",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          CategoryActions(category: category),
        ],
      ),
    );
  }
}

class CategoryActions extends StatelessWidget {
  final CategoryUIModel category;
  const CategoryActions({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categoriesCubit = context.read<CategoriesCubit>();
    return SizedBox(
      width: 40.w,
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          size: 20.sp,
          color: AppColors.textSecondary,
        ),
        onSelected: (value) {
          if (value == 'edit') {
            final addCategoryCubit = context.read<AddCategoryCubit>();
            showDialog(
              context: context,
              builder: (dialogContext) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: categoriesCubit),
                  BlocProvider.value(value: addCategoryCubit),
                ],
                child: AddCategoryDialog(category: category.category),
              ),
            );
          } else if (value == 'delete') {
            showDialog(
              context: context,
              builder: (dialogContext) => BlocProvider.value(
                value: categoriesCubit,
                child: DeleteConfirmationDialog(
                  title: 'Delete Category',
                  content: 'Are you sure you want to delete "${category.category.type}"? This action cannot be undone.',
                  onDeletePressed: () {
                    categoriesCubit.deleteCategory(category.category.id);
                  },
                ),
              ),
            );
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit_outlined, size: 18),
                Gap(8),
                Text('Edit'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete_outline, size: 18, color: Colors.red),
                Gap(8),
                Text('Delete', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
