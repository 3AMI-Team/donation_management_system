import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/domain/entity/category_entity.dart';
import 'package:donation_management_system/features/categories/presentation/view/widgets/category_actions.dart';

class CategoryDataRow extends StatelessWidget {
  final CategoryEntity category;

  const CategoryDataRow({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              category.type,
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              category.description,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              category.totalCases.toString(),
              style: AppTypography.bodyMedium,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '\$${category.totalDonations.toStringAsFixed(0)}',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CategoryActions(category: category),
        ],
      ),
    );
  }
}
