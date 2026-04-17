import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/add_donor_cubit/add_donor_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/add_donor_cubit/add_donor_state.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donor_stats_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewDonor extends StatelessWidget {
  const AddNewDonor({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return const AddDonorDialog();
          },
        );
      },
    );
  }
}

class AddDonorDialog extends StatefulWidget {
  final DonorEntity? donor; // If null, it's Add mode. If not null, it's Edit mode.
  const AddDonorDialog({super.key, this.donor});

  @override
  State<AddDonorDialog> createState() => _AddDonorDialogState();
}

class _AddDonorDialogState extends State<AddDonorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  String? selectedDonorType;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.donor?.name);
    _emailController = TextEditingController(text: widget.donor?.email);
    _phoneController = TextEditingController(text: widget.donor?.phone);
    _addressController = TextEditingController(text: widget.donor?.address);
    selectedDonorType = widget.donor?.type ?? "Individual";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = widget.donor != null;

    return BlocProvider(
      create: (context) => sl<AddDonorCubit>(),
      child: BlocConsumer<AddDonorCubit, AddDonorState>(
        listener: (context, state) {
          if (state is AddDonorSuccess || state is UpdateDonorSuccess) {
            final isEdit = state is UpdateDonorSuccess;
            context.showSuccessSnackBar(
                isEdit ? "Donor updated successfully!" : "Donor added successfully!");
            
            // Local update for better UX (no full-page spinner)
            if (isEdit && widget.donor != null) {
              final updatedDonor = DonorEntity(
                id: widget.donor!.id,
                name: _nameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
                address: _addressController.text,
                type: selectedDonorType ?? "Individual",
                registerDate: widget.donor!.registerDate,
              );
              BlocProvider.of<DonorsCubit>(context).onDonorUpdated(updatedDonor);
            } else if (state is AddDonorSuccess) {
              // For Add, we don't have the ID from response easily without model update, 
              // so we might still need a quick refresh or use a mock ID.
              // For now, full refresh is safest for NEW items to get the real ID.
              BlocProvider.of<DonorsCubit>(context).getDonors();
            }
            
            BlocProvider.of<DonorStatsCubit>(context).getDonorKpis();
            Navigator.pop(context);
          } else if (state is AddDonorError) {
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
                  isEdit ? 'Edit Donor' : 'Add New Donor',
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
                child: Form(
                  key: _formKey,
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
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter full name';
                                }
                                return null;
                              },
                            ),
                          ),
                          Gap(20.w),
                          Expanded(
                            child: _buildInputField(
                              "Email Address",
                              "example@email.com",
                              controller: _emailController,
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter email';
                                }
                                if (!val.isValidEmail) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInputField(
                              "Phone Number",
                              "+20 120 000 0000",
                              controller: _phoneController,
                              validator: (val) {
                                if (val == null || val.trim().isEmpty) {
                                  return 'Please enter phone number';
                                }
                                if (!val.isValidPhone) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                          Gap(20.w),
                          Expanded(child: _buildDropdownField("Donor Type")),
                        ],
                      ),
                      Gap(20.h),
                      _buildInputField(
                        "Address",
                        "Enter full mailing address",
                        controller: _addressController,
                        maxLines: 3,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return 'Please enter address';
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
                onPressed: state is AddDonorLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          if (isEdit) {
                            context.read<AddDonorCubit>().updateDonor(
                                  id: widget.donor!.id,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  address: _addressController.text,
                                  type: selectedDonorType ?? "Individual",
                                );
                          } else {
                            context.read<AddDonorCubit>().registerDonor(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  address: _addressController.text,
                                  type: selectedDonorType ?? "Individual",
                                );
                          }
                        }
                      },
                child: state is AddDonorLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        isEdit ? "Save Changes" : "Add Donor",
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

  Widget _buildDropdownField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
              value: selectedDonorType,
              isExpanded: true,
              items: ["Individual", "Organization"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedDonorType = val),
            ),
          ),
        ),
      ],
    );
  }
}
