import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/add_category_cubit/add_category_cubit.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_cubit/categories_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class AddCategoryDialog extends StatefulWidget {
  final CategoryEntity? category;
  const AddCategoryDialog({super.key, this.category});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _typeController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _typeController = TextEditingController(text: widget.category?.type);
    _descriptionController =
        TextEditingController(text: widget.category?.description);
  }

  @override
  void dispose() {
    _typeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.category != null;

    return BlocProvider(
      create: (context) => sl<AddCategoryCubit>(),
      child: BlocConsumer<AddCategoryCubit, AddCategoryState>(
        listener: (context, state) {
          if (state is AddCategorySuccess || state is UpdateCategorySuccess) {
            context.showSuccessSnackBar(isEdit
                ? "Category updated successfully!"
                : "Category added successfully!");
            context.read<CategoriesCubit>().getCategories();
            Navigator.pop(context);
          } else if (state is AddCategoryError) {
            context.showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isEdit ? 'Edit Category' : 'Add New Category',
                  style: AppTypography.h2.copyWith(fontSize: 20),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInputField(
                        "Category Type",
                        "e.g. Health Support",
                        controller: _typeController,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter category type';
                          }
                          return null;
                        },
                      ),
                      Gap(20.h),
                      _buildInputField(
                        "Description",
                        "Enter category description",
                        controller: _descriptionController,
                        maxLines: 3,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actionsPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D7D6D),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: state is AddCategoryLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          if (isEdit) {
                            context.read<AddCategoryCubit>().updateCategory(
                                  id: widget.category!.id,
                                  type: _typeController.text,
                                  description: _descriptionController.text,
                                );
                          } else {
                            context.read<AddCategoryCubit>().addCategory(
                                  type: _typeController.text,
                                  description: _descriptionController.text,
                                );
                          }
                        }
                      },
                child: state is AddCategoryLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        isEdit ? "Update Category" : "Add Category",
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String hint, {
    int maxLines = 1,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Gap(8.h),
        CustomTextField(
          hint: hint,
          maxLines: maxLines,
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}
