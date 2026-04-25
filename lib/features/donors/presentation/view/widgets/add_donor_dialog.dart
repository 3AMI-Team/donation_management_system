import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/add_donor_form_fields.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/add_donor_cubit/add_donor_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/add_donor_cubit/add_donor_state.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donor_stats_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDonorDialog extends StatefulWidget {
  final DonorEntity? donor;
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
            final isEditSuccess = state is UpdateDonorSuccess;
            context.showSuccessSnackBar(isEditSuccess ? "Donor updated successfully!" : "Donor added successfully!");

            if (isEditSuccess && widget.donor != null) {
              final updatedDonor = DonorEntity(
                id: widget.donor!.id,
                name: _nameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
                address: _addressController.text,
                type: selectedDonorType ?? "Individual",
                registerDate: widget.donor!.registerDate,
              );
              context.read<DonorsCubit>().onDonorUpdated(updatedDonor);
            } else {
              context.read<DonorsCubit>().getDonors();
            }

            context.read<DonorStatsCubit>().getDonorKpis();
            Navigator.pop(context);
          } else if (state is AddDonorError) {
            context.showErrorSnackBar(state.message);
          }
        },
        builder: (context, state) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            title: _buildTitle(context, isEdit),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: SingleChildScrollView(
                child: AddDonorFormFields(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  phoneController: _phoneController,
                  addressController: _addressController,
                  selectedDonorType: selectedDonorType,
                  onTypeChanged: (val) => setState(() => selectedDonorType = val),
                ),
              ),
            ),
            actionsPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            actions: _buildActions(context, state, isEdit),
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context, bool isEdit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(isEdit ? 'Edit Donor' : 'Add New Donor', style: AppTypography.h2.copyWith(fontSize: 20.sp)),
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.grey)),
      ],
    );
  }

  List<Widget> _buildActions(BuildContext context, AddDonorState state, bool isEdit) {
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        onPressed: state is AddDonorLoading ? null : () => _submit(context, isEdit),
        child: state is AddDonorLoading
            ? SizedBox(width: 20.sp, height: 20.sp, child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text(isEdit ? "Save Changes" : "Add Donor", style: const TextStyle(color: Colors.white)),
      ),
    ];
  }

  void _submit(BuildContext context, bool isEdit) {
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
  }
}
