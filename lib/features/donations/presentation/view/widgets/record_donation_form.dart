import 'package:donation_management_system/core/di/injection_container.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/record_donation_cubit/record_donation_cubit.dart';
import 'package:donation_management_system/features/donations/presentation/view_model/record_donation_cubit/record_donation_state.dart';
import 'package:donation_management_system/features/donors/domain/entity/donor_entity.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:donation_management_system/core/theme/colors.dart';

class RecordDonationForm extends StatefulWidget {
  final VoidCallback? onConfirmPressed;

  const RecordDonationForm({
    super.key,
    this.onConfirmPressed,
  });

  @override
  State<RecordDonationForm> createState() => _RecordDonationFormState();
}

class _RecordDonationFormState extends State<RecordDonationForm> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RecordDonationCubit>()..initForm(),
      child: BlocConsumer<RecordDonationCubit, RecordDonationState>(
        listener: (context, state) {
          if (state.status == RecordDonationStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Donation recorded successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            _amountController.clear();
            _descriptionController.clear();
            context.read<RecordDonationCubit>().initForm(); // Refresh for next donation
            if (widget.onConfirmPressed != null) widget.onConfirmPressed!();
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
            context.read<RecordDonationCubit>().resetStatus();
          }
        },
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Gap(20.h),
                _buildDonorField(context, state),
                Gap(16.h),
                _buildAmountField(),
                Gap(16.h),
                _buildDescriptionField(),
                Gap(16.h),
                _buildCategorySection(context, state),
                Gap(24.h),
                _buildSubmitButton(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      'Record Donation',
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildDonorField(BuildContext context, RecordDonationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Donor (Search by Name or ID)',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Gap(8.h),
        Autocomplete<DonorEntity>(
          displayStringForOption: (option) => '${option.name} (ID: ${option.id})',
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<DonorEntity>.empty();
            }
            return state.donors.where((donor) {
              final query = textEditingValue.text.toLowerCase();
              return donor.name.toLowerCase().contains(query) || donor.id.toString().contains(query);
            });
          },
          onSelected: (donor) {
            context.read<RecordDonationCubit>().selectDonor(donor);
          },
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
              decoration: _inputDecoration('Search donor ...', Icons.person_search),
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 280.w,
                  constraints: BoxConstraints(maxHeight: 250.h),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    separatorBuilder: (context, index) => Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, index) {
                      final donor = options.elementAt(index);
                      return ListTile(
                        title: Text(donor.name, style: TextStyle(fontSize: 14.sp)),
                        subtitle: Text('ID: ${donor.id}', style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary)),
                        onTap: () => onSelected(donor),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Gap(8.h),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 16.sp, color: AppColors.textPrimary),
          decoration: _inputDecoration('Enter amount', Icons.attach_money),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Gap(8.h),
        TextField(
          controller: _descriptionController,
          style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
          decoration: _inputDecoration('e.g. Monthly Contribution', Icons.description),
        ),
      ],
    );
  }

  Widget _buildCategorySection(BuildContext context, RecordDonationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Gap(8.h),
        if (state.status == RecordDonationStatus.loading)
          const Center(child: LinearProgressIndicator())
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: state.categories.map((category) {
                return _buildCategoryChip(context, category, state.selectedCategory?.id == category.id);
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryChip(BuildContext context, CategoryEntity category, bool isSelected) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: FilterChip(
        selected: isSelected,
        label: Text(category.type),
        onSelected: (_) => context.read<RecordDonationCubit>().selectCategory(category),
        selectedColor: AppColors.primary.withOpacity(0.2),
        checkmarkColor: AppColors.primary,
        labelStyle: TextStyle(
          fontSize: 12.sp,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: isSelected ? AppColors.primary : AppColors.border),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, RecordDonationState state) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: state.isSubmitting
            ? null
            : () {
                final amount = double.tryParse(_amountController.text) ?? 0;
                context.read<RecordDonationCubit>().submitDonation(
                      amount: amount,
                      description: _descriptionController.text,
                    );
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          elevation: 2,
        ),
        child: state.isSubmitting
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : Text(
                'Confirm Donation',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, size: 20.sp, color: AppColors.textSecondary),
      hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary.withOpacity(0.6)),
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
    );
  }
}
