import 'package:donation_management_system/core/utils/extensions.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/distributions/presentation/view/widgets/add_distribution_form_fields.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/add_distribution_cubit/add_distribution_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/add_distribution_cubit/add_distribution_state.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distribution_stats_cubit/distribution_stats_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distributions_cubit/distributions_cubit.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDistributionDialog extends StatefulWidget {
  const AddDistributionDialog({super.key});

  @override
  State<AddDistributionDialog> createState() => _AddDistributionDialogState();
}

class _AddDistributionDialogState extends State<AddDistributionDialog> {
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  CaseEntity? _selectedCase;
  Donation? _selectedDonation;
  EmployeeEntity? _selectedEmployee;
  String _selectedStatus = "Delivered";

  @override
  void initState() {
    super.initState();
    context.read<AddDistributionCubit>().fetchDependencies();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddDistributionCubit, AddDistributionState>(
      listener: (context, state) {
        if (state is AddDistributionSuccess) {
          Navigator.pop(context);
          context.showSuccessSnackBar('Distribution added successfully!');
          context.read<DistributionsCubit>().getDistributions();
          context.read<DistributionStatsCubit>().getDistributionKpis();
        } else if (state is AddDistributionError) {
          context.showErrorSnackBar(state.message);
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        title: _buildTitle(context),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: BlocBuilder<AddDistributionCubit, AddDistributionState>(
            builder: (context, state) {
              if (state is DependenciesLoading) {
                return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
              }
              if (state is DependenciesError) {
                return SizedBox(height: 200, child: Center(child: Text(state.message)));
              }

              List<CaseEntity> cases = [];
              List<Donation> donations = [];
              List<EmployeeEntity> employees = [];
              
              if (state is DependenciesLoaded) {
                cases = state.cases;
                donations = state.donations;
                employees = state.employees;
              }

              return SingleChildScrollView(
                child: AddDistributionFormFields(
                  amountController: _amountController,
                  notesController: _notesController,
                  cases: cases,
                  donations: donations,
                  employees: employees,
                  selectedStatus: _selectedStatus,
                  onCaseSelected: (val) => _selectedCase = val,
                  onDonationSelected: (val) => _selectedDonation = val,
                  onEmployeeSelected: (val) => _selectedEmployee = val,
                  onStatusChanged: (val) => setState(() => _selectedStatus = val),
                ),
              );
            },
          ),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        actions: _buildActions(context),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Add New Distribution', style: AppTypography.h2.copyWith(fontSize: 20.sp)),
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.grey)),
      ],
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
      ),
      BlocBuilder<AddDistributionCubit, AddDistributionState>(
        builder: (context, state) {
          final bool isLoading = state is AddDistributionLoading;
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            onPressed: isLoading ? null : () => _submit(context),
            child: isLoading
                ? SizedBox(width: 20.sp, height: 20.sp, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text("Save Distribution", style: TextStyle(color: Colors.white)),
          );
        },
      ),
    ];
  }

  void _submit(BuildContext context) {
    if (_selectedCase == null || _selectedDonation == null || _selectedEmployee == null || _amountController.text.isEmpty) {
      context.showErrorSnackBar('Please fill all required fields');
      return;
    }

    final amount = num.tryParse(_amountController.text);
    if (amount == null) {
      context.showErrorSnackBar('Please enter a valid amount');
      return;
    }

    final distributionData = {
      "amount": amount,
      "distributionDate": DateTime.now().toUtc().toIso8601String(),
      "status": _selectedStatus,
      "notes": _notesController.text,
      "caseId": _selectedCase!.id,
      "donationId": _selectedDonation!.id,
      "handledByEmployeeId": _selectedEmployee!.id,
    };

    context.read<AddDistributionCubit>().addDistribution(distributionData);
  }
}
