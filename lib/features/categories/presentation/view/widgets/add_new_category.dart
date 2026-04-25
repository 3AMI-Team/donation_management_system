import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/add_category_dialog.dart';
export 'package:donation_management_system/features/categories/presentation/view/widgets/add_category_dialog.dart';

class AddNewCategory extends StatelessWidget {
  const AddNewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return const AddCategoryDialog();
          },
        );
      },
    );
  }
}
