import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/employee/add_employee/provider/add_employee_provider.dart';
import 'package:employeemanager/feature/employee/employee_salary_slip/employee_attendence_sheet.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeSalarySlipScreen extends ConsumerStatefulWidget {
  const EmployeeSalarySlipScreen({super.key});

  @override
  ConsumerState<EmployeeSalarySlipScreen> createState() =>
      _EmployeeSalarySlipScreenState();
}

class _EmployeeSalarySlipScreenState
    extends ConsumerState<EmployeeSalarySlipScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.watch(addEmployeeProvider).employeeList.isEmpty) {
        ref.read(addEmployeeProvider.notifier).fetchAllEmployee();
      }
    });
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
          backgroundColor: AppColors.secondary,
          iconTheme: const IconThemeData(color: AppColors.primary),
          title: Text(
            "Employee Salary Slip",
            style: theme.textTheme.titleMedium!.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            itemCount: employeeList.length,
            itemBuilder: (context, index) {
              final employee = employeeList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EmployeeAttendenceSheet(employee: employee);
                  }));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.tertiary,
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
                                  employee.name!,
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
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
