import 'package:donation_management_system/core/utils/validators.dart';
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/donations/domain/entity/donation_entity.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';

class AddDistributionFormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController amountController;
  final TextEditingController notesController;
  final List<CaseEntity> cases;
  final List<Donation> donations;
  final List<EmployeeEntity> employees;
  final String selectedStatus;
  final Function(CaseEntity) onCaseSelected;
  final Function(Donation) onDonationSelected;
  final Function(EmployeeEntity) onEmployeeSelected;
  final ValueChanged<String> onStatusChanged;

  const AddDistributionFormFields({
    super.key,
    required this.formKey,
    required this.amountController,
    required this.notesController,
    required this.cases,
    required this.donations,
    required this.employees,
    required this.selectedStatus,
    required this.onCaseSelected,
    required this.onDonationSelected,
    required this.onEmployeeSelected,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AutocompleteField<CaseEntity>(
            label: "Select Case",
            hint: "Search for a case...",
            options: cases,
            displayStringForOption: (option) =>
                "Case #${option.id} - ${option.description}",
            onSelected: onCaseSelected,
          ),
          Gap(20.h),
          _AutocompleteField<Donation>(
            label: "Donation Source",
            hint: "Search for a donation...",
            options: donations,
            displayStringForOption: (option) =>
                "Donation #${option.id} - ${option.donorName} (${option.amount} EGP)",
            onSelected: onDonationSelected,
          ),
          Gap(20.h),
          Row(
            children: [
              Expanded(
                child: LabeledField(
                  label: "Amount",
                  child: CustomTextField(
                    hint: "Enter amount",
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    validator: (val) => Validators.amount(val),
                  ),
                ),
              ),
              Gap(20.w),
              Expanded(
                child: LabeledField(
                  label: "Status",
                  child: _buildStatusDropdown(),
                ),
              ),
            ],
          ),
          Gap(20.h),
          _AutocompleteField<EmployeeEntity>(
            label: "Handled By Employee",
            hint: "Search for an employee...",
            options: employees,
            displayStringForOption: (option) => option.name,
            onSelected: onEmployeeSelected,
          ),
          Gap(20.h),
          LabeledField(
            label: "Distribution Notes",
            child: CustomTextField(
              hint: "Provide additional details...",
              controller: notesController,
              maxLines: 4,
              validator: (val) =>
                  Validators.minLength(val, 5, fieldName: 'Notes'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedStatus,
          isExpanded: true,
          items: ["Delivered", "Pending", "Completed"].map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (val) => onStatusChanged(val!),
        ),
      ),
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
    return LabeledField(
      label: label,
      child: Autocomplete<T>(
        displayStringForOption: displayStringForOption,
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') return const Iterable.empty();
          return options.where((T option) {
            return displayStringForOption(
              option,
            ).toLowerCase().contains(textEditingValue.text.toLowerCase());
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
              borderRadius: BorderRadius.circular(8.r),
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
    );
  }
}
