import 'package:flutter/material.dart';
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
  String? selectedDonor;
  String? selectedCategory;
  final TextEditingController _amountController = TextEditingController();

  final List<String> _donors = ['John Smith', 'Sarah Johnson', 'Michael Brown', 'Emily Davis'];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Text(
            'Record Donation',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Gap(20.h),
          Text(
            'Donor',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Gap(8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedDonor,
                hint: Text(
                  'Select donor',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary.withOpacity(0.6),
                  ),
                ),
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, size: 20.sp, color: AppColors.textSecondary),
                items: _donors.map((donor) {
                  return DropdownMenuItem<String>(
                    value: donor,
                    child: Text(
                      donor,
                      style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDonor = value;
                  });
                },
              ),
            ),
          ),
          Gap(16.h),
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
            decoration: InputDecoration(
              hintText: 'Enter amount',
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary.withOpacity(0.6),
              ),
              prefixText: '\$ ',
              prefixStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
          ),
          Gap(16.h),
          Text(
            'Category',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Gap(8.h),
          Row(
            children: [
              _buildCategoryButton('Food'),
              Gap(8.w),
              _buildCategoryButton('Health'),
              Gap(8.w),
              _buildCategoryButton('Edu'),
            ],
          ),
          Gap(24.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: widget.onConfirmPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
              ),
              child: Text(
                'Confirm Donation',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    final bool isSelected = selectedCategory == category;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedCategory = category;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
