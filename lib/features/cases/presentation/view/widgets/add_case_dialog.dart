import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/domain/entity/add_case_params.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/add_case_form_fields.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/add_case_cubit/add_case_cubit.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/add_case_cubit/add_case_state.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/cases_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AddCaseDialog extends StatefulWidget {
  final CaseEntity? caseEntity;
  const AddCaseDialog({super.key, this.caseEntity});

  @override
  State<AddCaseDialog> createState() => _AddCaseDialogState();
}

class _AddCaseDialogState extends State<AddCaseDialog> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();

  String selectedStatus = "Approved";
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    if (widget.caseEntity != null) {
      _nameController.text = widget.caseEntity!.name;
      _phoneController.text = widget.caseEntity!.phone;
      _addressController.text = widget.caseEntity!.address;
      _descriptionController.text = widget.caseEntity!.description;
      selectedStatus = ["Approved", "Pending", "Rejected"].contains(widget.caseEntity!.status)
          ? widget.caseEntity!.status
          : "Approved";
      // Note: CaseEntity currently doesn't have categoryId, 
      // user will need to re-select or we can enhance Entity later.
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.caseEntity != null;

    return BlocListener<AddCaseCubit, AddCaseState>(
      listener: (context, state) {
        if (state is AddCaseSuccess) {
          Navigator.pop(context);
          context.showSuccessSnackBar(isEdit ? 'Case updated successfully!' : 'Case added successfully!');
          context.read<CasesCubit>().refresh();
        } else if (state is AddCaseError) {
          context.showErrorSnackBar(state.message);
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        title: _buildTitle(context, isEdit),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: SingleChildScrollView(
            child: AddCaseFormFields(
              nameController: _nameController,
              phoneController: _phoneController,
              addressController: _addressController,
              descriptionController: _descriptionController,
              selectedStatus: selectedStatus,
              selectedCategoryId: selectedCategoryId,
              onStatusChanged: (val) => setState(() => selectedStatus = val),
              onCategoryChanged: (val) => setState(() => selectedCategoryId = val),
            ),
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        actions: _buildActions(context, isEdit),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isEdit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(isEdit ? 'Edit Case' : 'Add New Case', style: AppTypography.h2.copyWith(fontSize: 20.sp)),
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.grey)),
      ],
    );
  }

  List<Widget> _buildActions(BuildContext context, bool isEdit) {
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
      ),
      BlocBuilder<AddCaseCubit, AddCaseState>(
        builder: (context, state) {
          final bool isLoading = state is AddCaseLoading;
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            onPressed: isLoading ? null : () => _submit(context),
            child: isLoading
                ? SizedBox(width: 20.sp, height: 20.sp, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : Text(isEdit ? "Update Case" : "Save Case", style: const TextStyle(color: Colors.white)),
          );
        },
      ),
    ];
  }

  void _submit(BuildContext context) {
    if (selectedCategoryId == null) {
      context.showErrorSnackBar('Please select a category');
      return;
    }

    final params = AddCaseParams(
      name: _nameController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      registDate: widget.caseEntity?.registDate.toIso8601String() ?? DateTime.now().toIso8601String(),
      status: selectedStatus,
      description: _descriptionController.text,
      categoryId: selectedCategoryId!,
      supervisorId: 1,
    );

    if (widget.caseEntity != null) {
      context.read<AddCaseCubit>().updateCase(widget.caseEntity!.id, params);
    } else {
      context.read<AddCaseCubit>().addCase(params);
    }
  }
}
