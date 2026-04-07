import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/categories/data/models/category_table_model.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donor_data_row.dart';

class CategoriesTable extends StatelessWidget {
  const CategoriesTable({super.key});

  static const List<TableHeader> _headers = [
    TableHeader(text: 'Category Name', flex: 2),
    TableHeader(text: 'Description', flex: 3),
    TableHeader(text: 'Total Cases', flex: 1),
    TableHeader(text: 'Total Donations', flex: 1),
    TableHeader(text: 'Actions', flex: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomTable(
      headerCells: _headers,
      dataRow: const [
        CategoryTableModel(
          name: 'Medical Aid',
          description:
              'Critical support for life-saving surgeries, medication supplies, and emergency clinical procedures globally.',
          totalCases: '1,242',
          totalDonations: '\$450,800',
        ),
        CategoryTableModel(
          name: 'Education',
          description:
              'Funding for primary schools, digital literacy programs, and higher education scholarships for low-income students.',
          totalCases: '894',
          totalDonations: '\$212,150',
        ),
        CategoryTableModel(
          name: 'Food Security',
          description:
              'Sustainable community gardens, food banks, and monthly nutrition ration programs for vulnerable communities.',
          totalCases: '3,412',
          totalDonations: '\$185,400',
        ),
        CategoryTableModel(
          name: 'Housing',
          description:
              'Urban development projects and emergency shelter construction for families displaced by disasters or hardship.',
          totalCases: '456',
          totalDonations: '\$1,024,900',
        ),
        CategoryTableModel(
          name: 'Emergency Relief',
          description:
              'Rapid-response kits, temporary housing, and logistics for communities affected by natural disasters.',
          totalCases: '612',
          totalDonations: '\$328,500',
        ),
      ],
      itemBuilder: (item) => CategoryDataRow(category: item),
    );
  }
}

class CategoryDataRow extends StatelessWidget {
  final CategoryTableModel category;

  const CategoryDataRow({super.key, required this.category});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    category.name.substring(0, 1).toUpperCase(),
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
                    category.name,
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
          Expanded(
            flex: 3,
            child: Text(
              category.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
                height: 1.35,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              category.totalCases,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              category.totalDonations,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          const ActionsButtons(),
        ],
      ),
    );
  }
}
