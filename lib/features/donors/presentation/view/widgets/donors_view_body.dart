import 'package:donation_management_system/core/widgets/filter_chips.dart';
import 'package:donation_management_system/features/donations/presentation/view/widgets/pagination.dart';
import 'package:donation_management_system/features/donors/presentation/view/widgets/donors_table.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_cubit.dart';
import 'package:donation_management_system/features/donors/presentation/view_model/donors_cubit/donors_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final List<String> _filters = ["All", "Individual", "Corporate"];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonorsCubit, DonorsState>(
      builder: (context, state) {
        if (state is DonorsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is DonorsError) {
          return Center(child: Text(state.message));
        } else if (state is DonorsLoaded) {
          final donors = state.donorsResponse.donors;
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
                    DonorsTable(donors: donors),
                    Gap(16.h),
                    Pagination(
                      currentPage: state.donorsResponse.page,
                      totalItems: state.donorsResponse.totalCount,
                      itemsPerPage: state.donorsResponse.pageSize,
                      onPreviousPressed: () {
                        if (state.donorsResponse.page > 1) {
                          context.read<DonorsCubit>().getDonors(
                                page: state.donorsResponse.page - 1,
                                pageSize: state.donorsResponse.pageSize,
                              );
                        }
                      },
                      onNextPressed: () {
                        if (state.donorsResponse.page <
                            state.donorsResponse.totalPages) {
                          context.read<DonorsCubit>().getDonors(
                                page: state.donorsResponse.page + 1,
                                pageSize: state.donorsResponse.pageSize,
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
