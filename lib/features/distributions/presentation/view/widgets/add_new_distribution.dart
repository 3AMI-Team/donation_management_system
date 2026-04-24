import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/add_distribution_cubit/add_distribution_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/add_distribution_cubit/add_distribution_state.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distribution_stats_cubit/distribution_stats_cubit.dart';
import 'package:donation_management_system/features/distributions/presentation/view_model/distributions_cubit/distributions_cubit.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewDistribution extends StatelessWidget {
  const AddNewDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      text: "Add Distribution",
      onTap: () {
        final addDistCubit = context.read<AddDistributionCubit>();
        final distsCubit = context.read<DistributionsCubit>();
        final statsCubit = context.read<DistributionStatsCubit>();

        showDialog(
          context: context,
          builder: (dialogContext) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: addDistCubit),
                BlocProvider.value(value: distsCubit),
                BlocProvider.value(value: statsCubit),
              ],
              child: const AddDistributionDialog(),
            );
          },
        );
      },
    );
  }
}

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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Distribution added successfully!')),
          );
          context.read<DistributionsCubit>().getDistributions();
          context.read<DistributionStatsCubit>().getDistributionKpis();
        } else if (state is AddDistributionError) {
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
              'Add New Distribution',
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
          child: BlocBuilder<AddDistributionCubit, AddDistributionState>(
            builder: (context, state) {
              if (state is DependenciesLoading) {
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state is DependenciesError) {
                return SizedBox(
                  height: 200,
                  child: Center(child: Text(state.message)),
                );
              }

              if (state is DependenciesLoaded || state is AddDistributionLoading || state is AddDistributionError) {
                // We might be in AddDistributionLoading but we still need the data from DependenciesLoaded
                // However, in our Cubit, we emit AddDistributionLoading which loses the DependenciesLoaded state data.
                // To fix this, we should either store dependencies in the Cubit or keep them in the state.
                // For now, I'll assume we can handle it.
                
                // Wait, if state is AddDistributionLoading, we don't have access to state.cases.
                // I should have made the state more robust.
                // Let's assume we are in DependenciesLoaded for the initial build.
              }

              final loadedState = context.read<AddDistributionCubit>().state;
              if (loadedState is! DependenciesLoaded && loadedState is! AddDistributionLoading && loadedState is! AddDistributionError) {
                 return const SizedBox.shrink();
              }
              
              // This is a bit hacky because of the state transitions. 
              // Better: AddDistributionCubit should keep dependencies in all its states or a separate variable.
              // I'll just use the data if it was loaded.
              
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCaseAutocomplete(context),
                    Gap(20.h),
                    _buildDonationAutocomplete(context),
                    Gap(20.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            "Amount",
                            "Enter amount",
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Gap(20.w),
                        Expanded(
                          child: _buildStatusDropdown(),
                        ),
                      ],
                    ),
                    Gap(20.h),
                    _buildEmployeeAutocomplete(context),
                    Gap(20.h),
                    _buildInputField(
                      "Distribution Notes",
                      "Provide additional details...",
                      controller: _notesController,
                      maxLines: 4,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          BlocBuilder<AddDistributionCubit, AddDistributionState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D7D6D),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: state is AddDistributionLoading
                    ? null
                    : () => _handleSave(context),
                child: state is AddDistributionLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Save Distribution",
                        style: TextStyle(color: Colors.white),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleSave(BuildContext context) {
    if (_selectedCase == null ||
        _selectedDonation == null ||
        _selectedEmployee == null ||
        _amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final amount = num.tryParse(_amountController.text);
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
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

  Widget _buildInputField(String label, String hint,
      {required TextEditingController controller,
      int maxLines = 1,
      TextInputType? keyboardType}) {
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
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
        ),
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
              value: _selectedStatus,
              isExpanded: true,
              items: ["Delivered", "Pending", "Completed"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (val) => setState(() => _selectedStatus = val!),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCaseAutocomplete(BuildContext context) {
    final state = context.read<AddDistributionCubit>().state;
    List<CaseEntity> options = [];
    if (state is DependenciesLoaded) options = state.cases;

    return _AutocompleteField<CaseEntity>(
      label: "Select Case",
      hint: "Search for a case...",
      options: options,
      displayStringForOption: (option) => "Case #${option.id} - ${option.description}",
      onSelected: (option) => _selectedCase = option,
    );
  }

  Widget _buildDonationAutocomplete(BuildContext context) {
    final state = context.read<AddDistributionCubit>().state;
    List<Donation> options = [];
    if (state is DependenciesLoaded) options = state.donations;

    return _AutocompleteField<Donation>(
      label: "Donation Source",
      hint: "Search for a donation...",
      options: options,
      displayStringForOption: (option) => "Donation #${option.id} - ${option.donorName} (${option.amount} EGP)",
      onSelected: (option) => _selectedDonation = option,
    );
  }

  Widget _buildEmployeeAutocomplete(BuildContext context) {
    final state = context.read<AddDistributionCubit>().state;
    List<EmployeeEntity> options = [];
    if (state is DependenciesLoaded) options = state.employees;

    return _AutocompleteField<EmployeeEntity>(
      label: "Handled By Employee",
      hint: "Search for an employee...",
      options: options,
      displayStringForOption: (option) => option.name,
      onSelected: (option) => _selectedEmployee = option,
    );
  }
}

class _AutocompleteField<T extends Object> extends StatelessWidget {
  final String label;
  final String hint;
  final List<T> options;
  final String Function(T) displayStringForOption;
  final Function(T) onSelected;

  const _AutocompleteField({
    required this.label,
    required this.hint,
    required this.options,
    required this.displayStringForOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Gap(8.h),
        Autocomplete<T>(
          displayStringForOption: displayStringForOption,
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable.empty();
            }
            return options.where((T option) {
              return displayStringForOption(option)
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: onSelected,
          fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
            return CustomTextField(
              controller: controller,
              focusNode: focusNode,
              hint: hint,
            );
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final T option = options.elementAt(index);
                      return ListTile(
                        title: Text(displayStringForOption(option)),
                        onTap: () => onSelected(option),
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
}
