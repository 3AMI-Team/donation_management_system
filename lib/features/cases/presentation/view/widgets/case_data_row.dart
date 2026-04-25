import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/cases/domain/entity/case_entity.dart';
import 'package:donation_management_system/features/cases/presentation/view/widgets/add_new_case.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/add_case_cubit/add_case_cubit.dart';
import 'package:donation_management_system/features/cases/presentation/view_model/cases_cubit/cases_cubit.dart';
import 'package:donation_management_system/features/categories/presentation/view_model/categories_bloc/categories_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
              caseEntity.name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Amount -> CategoryName
          Expanded(
            flex: 1,
            child: Text(
              caseEntity.categoryName,
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
              '${caseEntity.registDate.day}/${caseEntity.registDate.month}/${caseEntity.registDate.year}',
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
          CaseActionsButtons(caseEntity: caseEntity),
        ],
      ),
    );
  }
}

class CaseActionsButtons extends StatelessWidget {
  final CaseEntity caseEntity;
  const CaseActionsButtons({super.key, required this.caseEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          size: 20.sp,
          color: AppColors.textSecondary,
        ),
        onSelected: (value) {
          switch (value) {
            case 'edit':
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: context.read<AddCaseCubit>()),
                      BlocProvider.value(value: context.read<CasesCubit>()),
                      BlocProvider.value(value: context.read<CategoriesBloc>()),
                    ],
                    child: AddCaseDialog(caseEntity: caseEntity),
                  );
                },
              );
              break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit_outlined, size: 18),
                Gap(8),
                Text('Edit'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
