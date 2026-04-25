import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddDonorFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final String? selectedDonorType;
  final ValueChanged<String?> onTypeChanged;

  const AddDonorFormFields({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.addressController,
    required this.selectedDonorType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: LabeledField(
                  label: "Full Name",
                  child: CustomTextField(
                    hint: "Enter full name",
                    controller: nameController,
                    validator: (val) => (val == null || val.trim().isEmpty) ? 'Please enter full name' : null,
                  ),
                ),
              ),
              Gap(20.w),
              Expanded(
                child: LabeledField(
                  label: "Email Address",
                  child: CustomTextField(
                    hint: "example@email.com",
                    controller: emailController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) return 'Please enter email';
                      if (!val.isValidEmail) return 'Please enter a valid email';
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
          Gap(20.h),
          Row(
            children: [
              Expanded(
                child: LabeledField(
                  label: "Phone Number",
                  child: CustomTextField(
                    hint: "+20 120 000 0000",
                    controller: phoneController,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) return 'Please enter phone number';
                      if (!val.isValidPhone) return 'Please enter a valid phone number';
                      return null;
                    },
                  ),
                ),
              ),
              Gap(20.w),
              Expanded(
                child: LabeledField(
                  label: "Donor Type",
                  child: _buildTypeDropdown(),
                ),
              ),
            ],
          ),
          Gap(20.h),
          LabeledField(
            label: "Address",
            child: CustomTextField(
              hint: "Enter full mailing address",
              controller: addressController,
              maxLines: 3,
              validator: (val) => (val == null || val.trim().isEmpty) ? 'Please enter address' : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return Container(
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
          onChanged: onTypeChanged,
        ),
      ),
    );
  }
}
