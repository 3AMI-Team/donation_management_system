import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/domain/entity/employee_entity.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/employee_actions_buttons.dart';

class EmployeeDataRow extends StatelessWidget {
  final EmployeeEntity employee;

  const EmployeeDataRow({super.key, required this.employee});

  String get _initials {
    final parts = employee.name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return employee.name.isNotEmpty ? employee.name.substring(0, 1).toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.12),
                  child: Text(
                    _initials,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.primary),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    employee.name,
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              employee.email,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              employee.username,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
            ),
          ),
          Expanded(flex: 1, child: _RoleBadge(role: employee.role)),
          Expanded(
            flex: 1,
            child: Text(
              employee.phone,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.textPrimary),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              employee.address,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: EmployeeActionsButtons(employee: employee),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String role;
  const _RoleBadge({required this.role});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (role.toLowerCase()) {
      case 'admin':
        bg = const Color(0xFFEDE9FE);
        fg = const Color(0xFF5B21B6);
        break;
      case 'supervisor':
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0369A1);
        break;
      default:
        bg = const Color(0xFFFFF4E6);
        fg = const Color(0xFFC2410C);
        break;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20.r)),
        child: Text(
          role,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: fg),
        ),
      ),
    );
  }
}
