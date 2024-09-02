import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/employee/employee_salary_slip/pdf_view_screen.dart';
import 'package:employeemanager/models/employee.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class EmployeeAttendenceSheet extends ConsumerStatefulWidget {
  final Employee employee;
  const EmployeeAttendenceSheet({
    super.key,
    required this.employee,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmployeeAttendenceSheetState();
}

class _EmployeeAttendenceSheetState
    extends ConsumerState<EmployeeAttendenceSheet> {
  late DateTimeRange selectedDateRange;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    DateTime thirtyDaysAgo = now.subtract(const Duration(days: 30));
    selectedDateRange = DateTimeRange(start: thirtyDaysAgo, end: now);
  }

  List<String> getFilteredAttendence(Employee employee) {
    return employee.employeeAttendence
        .where((attendance) {
          DateTime attendanceDate =
              DateFormat('dd MMMM y').parse(attendance.dateTime);
          return attendanceDate.isAfter(
                  selectedDateRange.start.subtract(const Duration(days: 1))) &&
              attendanceDate
                  .isBefore(selectedDateRange.end.add(const Duration(days: 1)));
        })
        .map((attendance) => attendance.dateTime)
        .toList();
  }

  EmployeeAttendenceStatus? getEmployeeStatusOnDate(
      Employee employee, String date) {
    for (var attendance in employee.employeeAttendence) {
      if (attendance.dateTime == date) {
        return attendance.status;
      }
    }
    return null;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: AppColors.secondary, // Change primary color as needed
              secondary: AppColors.amber,
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black), // Customize text color
              bodyMedium:
                  TextStyle(color: Colors.black), // Customize text color
              bodySmall: TextStyle(
                  color: AppColors.secondary), // Customize calendar text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final attendenceList = getFilteredAttendence(widget.employee);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: Text(
          'Employee Attendance Sheet',
          style: theme.textTheme.titleMedium!.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.fieldGrey,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 4,
                                ),
                              ),
                              child: CircleAvatar(
                                maxRadius: 60,
                                minRadius: 60,
                                backgroundColor: AppColors.fieldGrey,
                                child: widget.employee.employeePic!.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(51),
                                        child: Image.network(
                                          widget.employee.employeePic!,
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.asset(
                                        AssetImages.personIcon,
                                        height: 55,
                                        width: 55,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.employee.name ?? '',
                              style: theme.textTheme.bodyLarge,
                            ),
                            Text(
                              (widget.employee.designation).toString(),
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              (widget.employee.cnicId).toString(),
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Attendance Records",
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true, // Added to ensure proper height calculation
                physics: const NeverScrollableScrollPhysics(),
                itemCount: attendenceList.length,
                itemBuilder: (context, index) {
                  final attendanceDate = attendenceList[index];
                  final employeeAttendence = widget.employee.employeeAttendence
                      .firstWhere((attendance) =>
                          attendance.dateTime == attendanceDate);
                  final status =
                      getEmployeeStatusOnDate(widget.employee, attendanceDate);

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.fieldGrey,
                      ),
                      child: ListTile(
                        title: Text(
                          status?.name ?? 'No status',
                          style: theme.textTheme.titleLarge,
                        ),
                        subtitle: Text(
                          attendanceDate,
                          style: theme.textTheme.bodyMedium,
                        ),
                        trailing: Text(
                          employeeAttendence.totalPayment.toString(),
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDateRange(context),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '${DateFormat('dd MMMM y').format(selectedDateRange.start)} - ${DateFormat('dd MMMM y').format(selectedDateRange.end)}',
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewScreen(
                          employee: widget.employee,
                          selectedDateRange: selectedDateRange,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Generate Pay Slip ",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: AppColors.primary,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
