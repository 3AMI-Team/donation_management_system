import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donor_data_row.dart';

class CaseDataRow extends StatelessWidget {
  final CaseEntity caseEntity;

  const CaseDataRow({super.key, required this.caseEntity});

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
          // ID
          Expanded(
            flex: 1,
            child: Text(
              '#${caseEntity.id}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Description
          Expanded(
            flex: 3,
            child: Text(
              caseEntity.description,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Amount
          Expanded(
            flex: 1,
            child: Text(
              '\$${caseEntity.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),

          // Date
          Expanded(
            flex: 1,
            child: Text(
              '${caseEntity.date.day}/${caseEntity.date.month}/${caseEntity.date.year}',
              style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
            ),
          ),

          // Status
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: (caseEntity.status == 'Open' 
                    ? Colors.green 
                    : caseEntity.status == 'In Progress' 
                        ? Colors.orange 
                        : Colors.grey).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                caseEntity.status,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: caseEntity.status == 'Open' 
                      ? Colors.green 
                      : caseEntity.status == 'In Progress' 
                          ? Colors.orange 
                          : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Actions
          const ActionsButtons(),
        ],
      ),
    );
  }
}
