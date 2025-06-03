import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/employee/add_employee/provider/add_employee_provider.dart';
import 'package:employeemanager/models/employee.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MultipleAttendence extends ConsumerStatefulWidget {
  const MultipleAttendence({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmployeeAttendenceScreenState();
}

class _EmployeeAttendenceScreenState extends ConsumerState<MultipleAttendence> {
  DateTime? selectedDate;
  List<Employee> selectedEmployees = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now(); // Set the default date to today
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(addEmployeeProvider.notifier).fetchAllEmployee();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.tertiary, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: AppColors.tertiary, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool _isEmployeePresentOnDate(Employee employee, DateTime date) {
    return employee.employeeAttendence.any((attendance) {
      final selectedDateFormatted = DateFormat('dd MMMM y').format(date);
      return attendance.dateTime == selectedDateFormatted;
    });
  }

  void _toggleEmployeeSelection(Employee employee) {
    setState(() {
      if (selectedEmployees.contains(employee)) {
        selectedEmployees.remove(employee);
      } else {
        selectedEmployees.add(employee);
      }
    });
  }

  void _markAttendanceForSelectedEmployees() {
    for (var employee in selectedEmployees) {
      ref.read(addEmployeeProvider.notifier).updateAttendence(
            employee.id,
            0, // Tax/Debit (you can change as needed)
            0, // Bonus (you can change as needed)
            employee.pay, // Total Payment (you can change as needed)
            selectedDate ?? DateTime.now(),
            EmployeeAttendenceStatus.present,
          );
    }
    setState(() {
      selectedEmployees.clear(); // Clear selection after marking attendance
    });
    context.showSuccessSnackBar("Attendance marked for selected employees.");
  }

  @override
  Widget build(BuildContext context) {
    final employeeList = ref.watch(addEmployeeProvider).employeeList;
    final theme = context.theme;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColors,
          iconTheme: const IconThemeData(color: AppColors.primary),
          title: Text(
            "Employee Multiple Attendance",
            style: theme.textTheme.titleMedium!.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            if (selectedEmployees.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: _markAttendanceForSelectedEmployees,
              ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Date",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.tertiary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        DateFormat('dd MMMM y').format(selectedDate!),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: employeeList.length,
                itemBuilder: (context, index) {
                  final employee = employeeList[index];
                  final hasStatus =
                      _isEmployeePresentOnDate(employee, selectedDate!);
                  final isSelected = selectedEmployees.contains(employee);

                  return GestureDetector(
                    onTap: () => _toggleEmployeeSelection(employee),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected
                              ? AppColors.tertiary
                              : AppColors.primary.withOpacity(0.4),
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    border: Border.all(
                                      color: AppColors.tertiary,
                                      width:
                                          4, // Adjust this value to your preference
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    maxRadius: 60,
                                    minRadius: 60,
                                    backgroundColor: AppColors.tertiary,
                                    child: employee.employeePic!.isNotEmpty
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(51),
                                            child: Image.network(
                                              employee.employeePic!,
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
                                  employee.name ?? '',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Text(
                                  (employee.designation).toString(),
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Text(
                                  (employee.cnicId).toString(),
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (hasStatus)
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
