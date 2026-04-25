import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_event.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: _onStateChanged,
      builder: (context, state) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: _buildTitle(context, isEdit),
          content: _buildContent(context),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          actions: _buildActions(context, state, isEdit),
        );
      },
    );
  }

  void _onStateChanged(BuildContext context, CategoriesState state) {
    if (state is CategoryActionSuccess) {
      context.showSuccessSnackBar(state.message);
      Navigator.pop(context);
    } else if (state is CategoryActionError) {
      context.showErrorSnackBar(state.message);
    }
  }

  Widget _buildTitle(BuildContext context, bool isEdit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(isEdit ? 'Edit Category' : 'Add New Category',
            style: AppTypography.h2.copyWith(fontSize: 20)),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInputField("Category Type", "e.g. Health Support",
                  controller: _typeController),
              Gap(20.h),
              _buildInputField("Description", "Enter category description",
                  controller: _descriptionController, maxLines: 3),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions(
      BuildContext context, CategoriesState state, bool isEdit) {
    final bool isLoading = state is CategoryActionLoading;
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D7D6D),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: isLoading ? null : () => _submit(context),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white))
            : Text(isEdit ? "Update Category" : "Add Category",
                style: const TextStyle(color: Colors.white)),
      ),
    ];
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final bloc = context.read<CategoriesBloc>();
      if (widget.category != null) {
        bloc.add(UpdateCategoryEvent(
          id: widget.category!.id,
          type: _typeController.text,
          description: _descriptionController.text,
        ));
      } else {
        bloc.add(AddCategoryEvent(
          type: _typeController.text,
          description: _descriptionController.text,
        ));
      }
    }
  }

  Widget _buildInputField(String label, String hint,
      {int maxLines = 1, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        Gap(8.h),
        CustomTextField(
          hint: hint,
          maxLines: maxLines,
          controller: controller,
          validator: (val) => (val == null || val.trim().isEmpty)
              ? 'Field cannot be empty'
              : null,
        ),
      ],
    );
  }
}
