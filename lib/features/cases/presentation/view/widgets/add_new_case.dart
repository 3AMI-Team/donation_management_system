import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/domain/entity/add_case_params.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/add_case_cubit/add_case_cubit.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/add_case_cubit/add_case_state.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_state.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/cases_cubit.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCase extends StatelessWidget {
  final CaseEntity? caseEntity;
  
  const AddNewCase({super.key, this.caseEntity});

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      text: "Add Case",
      onTap: () {
        final addCaseCubit = context.read<AddCaseCubit>();
        final casesCubit = context.read<CasesCubit>();
        final categoriesBloc = context.read<CategoriesBloc>();

        showDialog(
          context: context,
          builder: (dialogContext) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: addCaseCubit),
                BlocProvider.value(value: casesCubit),
                BlocProvider.value(value: categoriesBloc),
              ],
              child: AddCaseDialog(caseEntity: caseEntity),
            );
          },
        );
      },
    );
  }
}

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
    return BlocListener<AddCaseCubit, AddCaseState>(
      listener: (context, state) {
        if (state is AddCaseSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Case added successfully!')),
          );
          context.read<CasesCubit>().refresh();
        } else if (state is AddCaseError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add New Case',
              style: AppTypography.h2.copyWith(fontSize: 20),
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.grey),
            ),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        "Full Name",
                        "Enter full name",
                        controller: _nameController,
                      ),
                    ),
                    Gap(20.w),
                    Expanded(
                      child: _buildInputField(
                        "Phone Number",
                        "+20 120 000 0000",
                        controller: _phoneController,
                      ),
                    ),
                  ],
                ),
                Gap(20.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        "Address",
                        "123 Street, City, State",
                        controller: _addressController,
                      ),
                    ),
                    Gap(20.w),
                    Expanded(
                      child: _buildStatusDropdown(),
                    ),
                  ],
                ),
                Gap(20.h),
                _buildCategoryDropdown(),
                Gap(20.h),
                _buildInputField(
                  "Description",
                  "Provide detailed information about the case...",
                  controller: _descriptionController,
                  maxLines: 4,
                ),
              ],
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
          BlocBuilder<AddCaseCubit, AddCaseState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D7D6D),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: state is AddCaseLoading
                    ? null
                    : () {
                        if (selectedCategoryId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select a category')),
                          );
                          return;
                        }
                        if (widget.caseEntity != null) {
                          context.read<AddCaseCubit>().updateCase(
                                widget.caseEntity!.id,
                                AddCaseParams(
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                  address: _addressController.text,
                                  registDate: widget.caseEntity!.registDate.toIso8601String(),
                                  status: selectedStatus,
                                  description: _descriptionController.text,
                                  categoryId: selectedCategoryId!,
                                  supervisorId: 1,
                                ),
                              );
                        } else {
                          context.read<AddCaseCubit>().addCase(
                                AddCaseParams(
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                  address: _addressController.text,
                                  registDate: DateTime.now().toIso8601String(),
                                  status: selectedStatus,
                                  description: _descriptionController.text,
                                  categoryId: selectedCategoryId!,
                                  supervisorId: 1,
                                ),
                              );
                        }
                      },
                child: state is AddCaseLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        widget.caseEntity != null ? "Update Case" : "Save Case",
                        style: const TextStyle(color: Colors.white),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, String hint,
      {required TextEditingController controller, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Gap(8.h),
        CustomTextField(hint: hint, controller: controller, maxLines: maxLines),
      ],
    );
  }

  Widget _buildStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Status",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Gap(8.h),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedStatus,
              isExpanded: true,
              items: ["Approved", "Pending", "Rejected"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedStatus = val!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Category",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Gap(8.h),
        BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return const LinearProgressIndicator();
            }
            if (state is CategoriesLoaded) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: selectedCategoryId,
                    hint: const Text("Select Category"),
                    isExpanded: true,
                    items: state.masterCategories.map((cat) {
                      return DropdownMenuItem<int>(
                        value: cat.id,
                        child: Text(cat.type),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => selectedCategoryId = val!),
                  ),
                ),
              );
            }
            return const Text("Failed to load categories");
          },
        ),
      ],
    );
  }
}
