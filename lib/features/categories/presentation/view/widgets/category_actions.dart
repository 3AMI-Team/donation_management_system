import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_event.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/add_new_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryActions extends StatelessWidget {
  final CategoryEntity category;
  const CategoryActions({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categoriesBloc = context.read<CategoriesBloc>();
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
            showDialog(
              context: context,
              builder: (dialogContext) => BlocProvider.value(
                value: categoriesBloc,
                child: AddCategoryDialog(category: category),
              ),
            );
          } else if (value == 'delete') {
            showDialog(
              context: context,
              builder: (dialogContext) => BlocProvider.value(
                value: categoriesBloc,
                child: DeleteConfirmationDialog(
                  title: 'Delete Category',
                  content:
                      'Are you sure you want to delete "${category.type}"? This action cannot be undone.',
                  onDeletePressed: () {
                    categoriesBloc.add(DeleteCategoryEvent(category.id));
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
                Icon(Icons.edit_outlined, size: 20),
                Gap(8),
                Text('Edit'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete_outline, size: 20, color: Colors.red),
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
