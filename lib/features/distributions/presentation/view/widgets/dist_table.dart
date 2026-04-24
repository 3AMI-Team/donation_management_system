import 'package:donation_management_system/core/widgets/widgets.dart';
import 'package:donation_management_system/features/distributions/domain/entity/distribution_entity.dart';

class DistributionTable extends StatelessWidget {
  final List<DistributionEntity> distributions;

  const DistributionTable({super.key, required this.distributions});

  final List<TableHeader> headerCells = const [
    TableHeader(text: 'Case', flex: 2),
    TableHeader(text: 'Donation Source', flex: 1),
    TableHeader(text: 'Amount', flex: 1),
    TableHeader(text: 'Date', flex: 1),
    TableHeader(text: 'Employee', flex: 1),
    TableHeader(text: 'Status', flex: 1),
    TableHeader(text: 'Actions', flex: 1, textAlign: TextAlign.right),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomTable(
      headerCells: headerCells,
      dataRow: distributions,
      itemBuilder: (item) => DistributionDataRow(distribution: item),
    );
  }
}

class DistributionDataRow extends StatelessWidget {
  final DistributionEntity distribution;

  const DistributionDataRow({super.key, required this.distribution});

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
          // Case Name column
          Expanded(
            flex: 2,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    distribution.caseName.isNotEmpty
                        ? distribution.caseName.substring(0, 1).toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        distribution.caseName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'ID: #${distribution.id}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Donation Source column
          Expanded(
            flex: 1,
            child: Text(
              distribution.donorName,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Amount column
          Expanded(
            flex: 1,
            child: Text(
              '${distribution.amount.toStringAsFixed(2)} EGP',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),

          // Date column
          Expanded(
            flex: 1,
            child: Text(
              '${distribution.distributionDate.day}/${distribution.distributionDate.month}/${distribution.distributionDate.year}',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          // Employee column
          Expanded(
            flex: 1,
            child: Text(
              distribution.handledByEmployeeName,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Status column
          Expanded(
            flex: 1,
            child: _StatusBadge(status: distribution.status),
          ),

          // Actions column
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: _DistributionActions(distribution: distribution),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status.toLowerCase()) {
      case 'delivered':
      case 'completed':
        bg = const Color(0xFFDCFCE7);
        fg = const Color(0xFF166534);
        break;
      case 'pending':
        bg = const Color(0xFFFEF9C3);
        fg = const Color(0xFF854D0E);
        break;
      case 'processing':
        bg = const Color(0xFFDBEAFE);
        fg = const Color(0xFF1E40AF);
        break;
      default:
        bg = AppColors.border.withOpacity(0.3);
        fg = AppColors.textSecondary;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: fg,
          ),
        ),
      ),
    );
  }
}

class _DistributionActions extends StatelessWidget {
  final DistributionEntity distribution;

  const _DistributionActions({required this.distribution});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, size: 20.sp, color: AppColors.textSecondary),
      onSelected: (value) {
        switch (value) {
          case 'view':
            // TODO: Implement view details
            break;
          case 'edit':
            // TODO: Implement edit
            break;
          case 'delete':
            showDialog(
              context: context,
              builder: (dialogContext) => DeleteConfirmationDialog(
                title: 'Delete Distribution',
                content:
                    'Are you sure you want to delete this distribution for ${distribution.caseName}? This action cannot be undone.',
                onDeletePressed: () {
                  // TODO: Implement delete functionality when API is ready
                },
              ),
            );
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'view',
          child: Row(
            children: [
              Icon(Icons.visibility_outlined, size: 18),
              Gap(8),
              Text('View Details'),
            ],
          ),
        ),
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
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete_outline, size: 18, color: Colors.red),
              Gap(8),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
