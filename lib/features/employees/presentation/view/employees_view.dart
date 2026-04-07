import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/employees_kpis_cards.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/employees_view_body.dart';

class EmployeesView extends StatelessWidget {
  const EmployeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Employee Directory', style: AppTypography.h1),
                      Gap(5.h),
                      Text(
                        'Manage user roles, access permissions, and team status.',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                ),
                _EmployeesFilterButton(onTap: () {}),
                Gap(10.w),
                CustomAddButton(
                  onTap: () {},
                  text: 'Invite New Employee',
                ),
              ],
            ),
            Gap(20.h),
            const EmployeesKPIsCards(),
            Gap(20.h),
            const EmployeesViewBody(),
          ],
        ),
      ),
    );
  }
}

class _EmployeesFilterButton extends StatelessWidget {
  final VoidCallback onTap;

  const _EmployeesFilterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Icon(
                Icons.filter_list_rounded,
                size: 18.sp,
                color: AppColors.textSecondary,
              ),
              Gap(6.w),
              Text(
                'Filter',
                style: AppTypography.button.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
