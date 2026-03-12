import 'package:donation_management_system/core/widgets/filter_chips.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donors_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DonorsViewBody extends StatefulWidget {
  const DonorsViewBody({super.key});

  @override
  State<DonorsViewBody> createState() => _DonorsViewBodyState();
}

class _DonorsViewBodyState extends State<DonorsViewBody> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;

  final List<String> _filters = ["All", "Individual", "Corporate"];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              FilterChips(
                hintText: 'Search donors...',
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
              DonorsTable(),
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
      ],
    );
  }
}
