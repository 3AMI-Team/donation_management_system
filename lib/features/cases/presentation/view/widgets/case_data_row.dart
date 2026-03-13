
import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/data/models/case_model.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donor_data_row.dart';

class CaseDataRow extends StatelessWidget {
  final CaseModel caseModel;

  const CaseDataRow({super.key, required this.caseModel});

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
          // case name with avatar
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),

                  child: Text(
                    caseModel.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Text(
                    caseModel.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          //case Catygory
          Expanded(
            flex: 1,
            child: Text(
              caseModel.category,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
            ),
          ),

          //case Contact info
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  caseModel.phone,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Gap(5.h),
                Text(
                  overflow: TextOverflow.fade,
                  caseModel.email,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          //case registration date
          Expanded(
            //Donor registration date
            flex: 1,
            child: Text(
              '${caseModel.registDate.day}/${caseModel.registDate.month}/${caseModel.registDate.year}',
              style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
            ),
          ),

          //Case Status
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Text(
                  caseModel.status,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          //Case address
          Expanded(
            flex: 1,
            child: Text(
              caseModel.address,
              style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          //Actions buttons
          ActionsButtons(),
        ],
      ),
    );
  }
}
