import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/domain/entity/add_employee_params.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/add_employee_cubit/add_employee_cubit.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/add_employee_cubit/add_employee_state.dart';
import 'package:donation_management_system/features/employees/presentation/view_model/employees_cubit/employees_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewEmployee extends StatelessWidget {
  const AddNewEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAddButton(
      text: "Add New Employee",
      onTap: () {
        final addEmployeeCubit = context.read<AddEmployeeCubit>();
        final employeesCubit = context.read<EmployeesCubit>();

        showDialog(
          context: context,
          builder: (dialogContext) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: addEmployeeCubit),
                BlocProvider.value(value: employeesCubit),
              ],
              child: const AddEmployeeDialog(),
            );
          },
        );
      },
    );
  }
}

class AddEmployeeDialog extends StatefulWidget {
  final EmployeeEntity? employee;

  const AddEmployeeDialog({super.key, this.employee});

  @override
  State<AddEmployeeDialog> createState() => _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends State<AddEmployeeDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _emailController;

  late String selectedRole;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee?.name);
    _usernameController = TextEditingController(text: widget.employee?.username);
    _passwordController = TextEditingController();
    _phoneController = TextEditingController(text: widget.employee?.phone);
    _addressController = TextEditingController(text: widget.employee?.address);
    _emailController = TextEditingController(text: widget.employee?.email);
    selectedRole = widget.employee?.role ?? "Supervisor";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.employee != null;

    return BlocListener<AddEmployeeCubit, AddEmployeeState>(
      listener: (context, state) {
        if (state is AddEmployeeSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditing
                    ? 'Employee updated successfully!'
                    : 'Employee added successfully!',
              ),
            ),
          );
          context.read<EmployeesCubit>().getEmployees();
        } else if (state is AddEmployeeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isEditing ? 'Edit Employee' : 'Add New Employee',
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
                        "Username",
                        "e.g. sameh.r",
                        controller: _usernameController,
                      ),
                    ),
                  ],
                ),
                Gap(20.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        "Email",
                        "employee@example.com",
                        controller: _emailController,
                      ),
                    ),
                    Gap(20.w),
                    Expanded(
                      child: _buildInputField(
                        "Password",
                        isEditing ? "Leave blank to keep current" : "Enter password",
                        controller: _passwordController,
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
                        "01066665555",
                        controller: _phoneController,
                      ),
                    ),
                    Gap(20.w),
                    Expanded(
                      child: _buildRoleDropdown(),
                    ),
                  ],
                ),
                Gap(20.h),
                _buildInputField(
                  "Address",
                  "123 Street, City, State",
                  controller: _addressController,
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
          BlocBuilder<AddEmployeeCubit, AddEmployeeState>(
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
                onPressed: state is AddEmployeeLoading
                    ? null
                    : () {
                        final params = AddEmployeeParams(
                          name: _nameController.text,
                          username: _usernameController.text,
                          password: _passwordController.text,
                          role: selectedRole,
                          phone: _phoneController.text,
                          address: _addressController.text,
                          email: _emailController.text,
                        );

                        if (isEditing) {
                          context
                              .read<AddEmployeeCubit>()
                              .updateEmployee(widget.employee!.id, params);
                        } else {
                          context.read<AddEmployeeCubit>().addEmployee(params);
                        }
                      },
                child: state is AddEmployeeLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        isEditing ? "Update Employee" : "Save Employee",
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
      {required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Gap(8.h),
        CustomTextField(hint: hint, controller: controller),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Role",
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
              value: selectedRole,
              isExpanded: true,
              items: ["Supervisor", "Admin", "Staff", "Field Worker"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedRole = val!),
            ),
          ),
        ),
      ],
    );
  }
}
