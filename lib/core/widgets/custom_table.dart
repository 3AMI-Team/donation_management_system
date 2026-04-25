import 'package:donation_management_system/core/widgets/table_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:donation_management_system/core/theme/colors.dart';

class CustomTable<T> extends StatefulWidget {
  final VoidCallback? onMenuPressed;
  final List<TableHeader> headerCells;
  final List<T> dataRow;
  final Widget Function(T item) itemBuilder;
  final Map<int, dynamic Function(T)>? sortKeyExtractors;

  const CustomTable({
    super.key,
    this.onMenuPressed,
    required this.headerCells,
    required this.dataRow,
    required this.itemBuilder,
    this.sortKeyExtractors,
  });

  @override
  State<CustomTable<T>> createState() => _CustomTableState<T>();
}

class _CustomTableState<T> extends State<CustomTable<T>> {
  int? _currentSortIndex;
  bool _isAscending = true;
  late List<T> _sortedData;

  @override
  void initState() {
    super.initState();
    _sortedData = List.from(widget.dataRow);
  }

  @override
  void didUpdateWidget(covariant CustomTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dataRow != widget.dataRow) {
      _sortedData = List.from(widget.dataRow);
      if (_currentSortIndex != null) {
        _applySort();
      }
    }
  }

  void _applySort() {
    if (_currentSortIndex == null || widget.sortKeyExtractors == null) return;
    final extractor = widget.sortKeyExtractors![_currentSortIndex!];
    if (extractor == null) return;

    setState(() {
      _sortedData.sort((a, b) {
        final valA = extractor(a);
        final valB = extractor(b);

        if (valA == null || valB == null) return 0;

        int result;
        if (valA is Comparable && valB is Comparable) {
          result = valA.compareTo(valB);
        } else {
          result = valA.toString().compareTo(valB.toString());
        }

        return _isAscending ? result : -result;
      });
    });
  }

  void _onSort(int index) {
    if (widget.sortKeyExtractors == null || !widget.sortKeyExtractors!.containsKey(index)) return;

    setState(() {
      if (_currentSortIndex == index) {
        _isAscending = !_isAscending;
      } else {
        _currentSortIndex = index;
        _isAscending = true;
      }
      _applySort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              border: Border(bottom: BorderSide(color: AppColors.divider)),
            ),
            child: Row(
              children: List.generate(widget.headerCells.length, (index) {
                final header = widget.headerCells[index];
                final canSort = widget.sortKeyExtractors?.containsKey(index) ?? false;

                return TableHeader(
                  text: header.text,
                  flex: header.flex,
                  textAlign: header.textAlign,
                  isSorted: _currentSortIndex == index,
                  isAscending: _isAscending,
                  onSort: canSort ? () => _onSort(index) : null,
                );
              }),
            ),
          ),
          if (_sortedData.isEmpty)
            Padding(
              padding: EdgeInsets.all(32.r),
              child: const Center(child: Text('No data found')),
            )
          else
            ..._sortedData.map((item) => widget.itemBuilder(item)),
        ],
      ),
    );
  }
}
