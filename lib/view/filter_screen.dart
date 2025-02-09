import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/coloors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../res/widgets/buttons/backButton.dart';
import '../../res/widgets/buttons/primaryButton.dart';
import '../utils/utils.dart';

class FilterScreen extends StatefulWidget {
  final Map<String, dynamic> currentFilter;

  const FilterScreen({Key? key, required this.currentFilter}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool sortOldest = false;
  bool sortLatest = false;
  bool filterByDateRange = false;
  DateTimeRange? selectedDateRange;
  late Map<String, dynamic> _currentFilter;

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.currentFilter;
    sortOldest = _currentFilter["sortOldest"] ?? false;
    sortLatest = _currentFilter["sortLatest"] ?? false;
    filterByDateRange = _currentFilter["dateRange"] != null;
    selectedDateRange = _currentFilter["dateRange"];
  }

  void _selectDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  void _resetFilters() {
    setState(() {
      sortOldest = false;
      sortLatest = false;
      filterByDateRange = false;
      selectedDateRange = null;
    });
  }

  void _applyFilters() {
    Map<String, dynamic> filter = {
      "sortOldest": sortOldest,
      "sortLatest": sortLatest,
      "dateRange": selectedDateRange,
    };
    context.pop(filter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filter",
          style: AppTextStyle.body.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: CustomBackButton(
            onPressed: () {
              context.pop({});
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CheckboxListTile(
              title: const Text("Oldest"),
              value: sortOldest,
              onChanged: (value) {
                setState(() {
                  sortOldest = value!;
                  if (sortOldest) sortLatest = false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Latest"),
              value: sortLatest,
              onChanged: (value) {
                setState(() {
                  sortLatest = value!;
                  if (sortLatest) sortOldest = false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Date Range"),
              value: filterByDateRange,
              onChanged: (value) {
                setState(() {
                  filterByDateRange = value!;
                  if (!filterByDateRange) {
                    selectedDateRange = null;
                  }
                });
              },
            ),
            if (filterByDateRange)
              PrimaryButton(
                context: context,
                text: selectedDateRange == null
                    ? "Select Date Range"
                    : "${Utils.formatDate(selectedDateRange!.start.toLocal())} - ${Utils.formatDate(selectedDateRange!.end.toLocal())}",
                onPressed: _selectDateRange,
              ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _resetFilters,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(0, 50),
                  backgroundColor: AppColors.lightPrimaryColor,
                ),
                child: const Text(
                  "Reset Filter",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(0, 50),
                  backgroundColor: AppColors.primaryColor,
                ),
                child: const Text(
                  "Apply",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
