import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:donation_management_system/features/employees/presentation/view/widgets/employees_table.dart';

class EmployeesViewBody extends StatefulWidget {
  const EmployeesViewBody({super.key});

  @override
  State<EmployeesViewBody> createState() => _EmployeesViewBodyState();
}

class _EmployeesViewBodyState extends State<EmployeesViewBody> {
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  String _sortBy = 'Newest Added';

  static const int _totalItems = 48;
  static const int _itemsPerPage = 5;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int get _totalPages =>
      (_totalItems / _itemsPerPage).ceil().clamp(1, 999);

  int get _startItem => (_currentPage - 1) * _itemsPerPage + 1;

  int get _endItem =>
      (_currentPage * _itemsPerPage).clamp(1, _totalItems);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: SizedBox(
                height: 44.h,
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: TextStyle(fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Search employees...',
                    hintStyle: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textLight,
                    ),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.textLight,
                    ),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
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
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                ),
              ),
            ),
            Gap(16.w),
            Text(
              'Sort by:',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _sortBy,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textSecondary,
                    size: 22.sp,
                  ),
                  style: AppTypography.button.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Newest Added',
                      child: Text('Newest Added'),
                    ),
                    DropdownMenuItem(
                      value: 'Oldest First',
                      child: Text('Oldest First'),
                    ),
                    DropdownMenuItem(
                      value: 'Name A-Z',
                      child: Text('Name A-Z'),
                    ),
                  ],
                  onChanged: (v) {
                    if (v != null) {
                      setState(() => _sortBy = v);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        Gap(16.h),
        const EmployeesTable(),
        Gap(16.h),
        Text(
          'Showing $_startItem to $_endItem of $_totalItems employees',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(12.h),
        Pagination(
          currentPage: _currentPage,
          totalItems: _totalItems,
          itemsPerPage: _itemsPerPage,
          onPreviousPressed: () {
            if (_currentPage > 1) {
              setState(() => _currentPage--);
            }
          },
          onNextPressed: () {
            if (_currentPage < _totalPages) {
              setState(() => _currentPage++);
            }
          },
        ),
      ],
    );
  }
}
