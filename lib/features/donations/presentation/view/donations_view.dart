import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:donation_management_system/core/theme/colors.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/widgets.dart';

class DonationsView extends StatefulWidget {
  const DonationsView({super.key});

  @override
  State<DonationsView> createState() => _DonationsViewState();
}

class _DonationsViewState extends State<DonationsView> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;

  final List<String> _filters = ['All', 'Food', 'Health', 'Education'];

  final List<DonationData> _donations = [
    DonationData(
      donor: Donor(name: 'John Smith'),
      amount: '\$1,200',
      category: 'Food',
      date: DateTime(2026, 3, 8),
      status: 'Completed',
      employeeName: 'Alice',
    ),
    DonationData(
      donor: Donor(name: 'Sarah Johnson'),
      amount: '\$850',
      category: 'Health',
      date: DateTime(2026, 3, 7),
      status: 'Pending',
      employeeName: 'Bob',
    ),
    DonationData(
      donor: Donor(name: 'Michael Brown'),
      amount: '\$2,500',
      category: 'Education',
      date: DateTime(2026, 3, 6),
      status: 'Completed',
      employeeName: 'Charlie',
    ),
    DonationData(
      donor: Donor(name: 'Emily Davis'),
      amount: '\$500',
      category: 'Food',
      date: DateTime(2026, 3, 5),
      status: 'Completed',
      employeeName: 'Alice',
    ),
    DonationData(
      donor: Donor(name: 'David Wilson'),
      amount: '\$1,800',
      category: 'Health',
      date: DateTime(2026, 3, 4),
      status: 'Pending',
      employeeName: 'Bob',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageHeader(
                title: 'Donations Tracking',
                subtitle: 'Monitor and manage all donations in one place',
                outlinedButtonText: 'Export CSV',
                filledButtonText: '+ New Donation',
                onOutlinedPressed: () {},
                onFilledPressed: () {},
              ),
              Gap(24.h),
              _buildStatsRow(),
              Gap(24.h),
              _buildMainContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            title: 'Total Donations',
            value: '\$124,500',
            percentageChange: 12,
            icon: Icons.attach_money,
          ),
        ),
        Gap(16.w),
        Expanded(
          child: StatCard(
            title: 'Completed',
            value: '1,230',
            percentageChange: 5,
            icon: Icons.check_circle_outline,
          ),
        ),
        Gap(16.w),
        Expanded(
          child: StatCard(
            title: 'Pending',
            value: '45',
            percentageChange: -2,
            icon: Icons.pending_outlined,
          ),
        ),
        Gap(16.w),
        Expanded(
          child: StatCard(
            title: 'Avg. Amount',
            value: '\$850',
            percentageChange: 8,
            icon: Icons.trending_up_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              FilterChips(
                filters: _filters,
                selectedFilter: _selectedFilter,
                onFilterSelected: (filter) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
                searchController: _searchController,
                onSearchChanged: (value) {},
                onSortPressed: () {},
              ),
              Gap(16.h),
              DonationTable(donations: _donations),
              Gap(16.h),
              Pagination(
                currentPage: _currentPage,
                totalItems: 45,
                itemsPerPage: 5,
                onPreviousPressed: () {
                  if (_currentPage > 1) {
                    setState(() {
                      _currentPage--;
                    });
                  }
                },
                onNextPressed: () {
                  if (_currentPage < 9) {
                    setState(() {
                      _currentPage++;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        Gap(24.w),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              RecordDonationForm(
                onConfirmPressed: () {},
              ),
              Gap(20.h),
              CampaignGoalCard(
                goalAmount: '\$100k',
                currentAmount: '\$45,200',
                description: 'Help us reach our goal to support more families in need. Every donation counts!',
                progress: 0.452,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
