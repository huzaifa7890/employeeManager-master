import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/constant/ui_constant.dart';
import 'package:employeemanager/feature/auth/providers/auth_provider.dart';
import 'package:employeemanager/feature/drawer/screens/drawer.dart';
import 'package:employeemanager/feature/employee/add_employee/screen/add_employee_screen.dart';
import 'package:employeemanager/feature/employee/employee_attendence/screen/multiple_attendence.dart';
import 'package:employeemanager/feature/employee/employee_list/screen/employee_list.dart';
import 'package:employeemanager/feature/employee/employee_attendence/screen/employee_attendence_screen.dart';
import 'package:employeemanager/feature/employee/employee_salary_slip/employee_salary_slip_screen.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:employeemanager/theme/theme_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (auth.currentUser != null) {
        ref
            .read(authProvider.notifier)
            .fetchInvestNetworkUser(auth.currentUser?.uid ?? '');
        ref.read(authProvider.notifier).saveAuthUser(auth.currentUser);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: Text(
          "Employee Manager",
          style: theme.textTheme.titleLarge!.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 25,
          children: [
            // Add Employee
            SizedBox(
              height: 140,
              width: 140,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddEmployeeScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2),
                        ),
                        child: Center(
                          child: Image.asset(
                            AssetImages.addEmployeeImage,
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.tertiary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Add Employee',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Repeat this block for each button, just change label + icon + screen

            SizedBox(
              height: 140,
              width: 140,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const EmployeeList()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2),
                        ),
                        child: Center(
                          child: Image.asset(
                            AssetImages.employeeListImage,
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.tertiary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Add List',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Salary Slip
            SizedBox(
              height: 140,
              width: 140,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const EmployeeSalarySlipScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2),
                        ),
                        child: Center(
                          child: Image.asset(
                            AssetImages.salaryslip,
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.tertiary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Salary Slip',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Mark Attendance
            SizedBox(
              height: 140,
              width: 140,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const EmployeeAttendenceScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2),
                        ),
                        child: Center(
                          child: Image.asset(
                            AssetImages.markEmployeeImage,
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.tertiary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Mark Attendance',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Multiple Attendance
            SizedBox(
              height: 140,
              width: 140,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MultipleAttendence()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2),
                        ),
                        child: Center(
                          child: Image.asset(
                            AssetImages.multipleAttendence,
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.tertiary,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Multiple Attendance',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
