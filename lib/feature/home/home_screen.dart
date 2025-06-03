import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/auth/providers/auth_provider.dart';
import 'package:employeemanager/feature/employee/add_employee/screen/add_employee_screen.dart';
import 'package:employeemanager/feature/employee/employee_attendence/screen/multiple_attendence.dart';
import 'package:employeemanager/feature/employee/employee_list/screen/employee_list.dart';
import 'package:employeemanager/feature/employee/employee_attendence/screen/employee_attendence_screen.dart';
import 'package:employeemanager/feature/employee/employee_salary_slip/employee_salary_slip_screen.dart';
import 'package:employeemanager/feature/home/widgets/home_card_widget.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:employeemanager/theme/theme_export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: AppColors.whiteColors,
        // iconTheme: const IconThemeData(color: AppColors.primary),
        title: Text(
          "Employee Manager",
          style: theme.textTheme.titleLarge!.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // drawer: const AppDrawer(),
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 20,
          runSpacing: 20,
          children: [
            // Add Employee
            HomeCardWidget(
              imagePath: AssetImages.addEmployeeImage,
              label: 'Add Employee',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddEmployeeScreen(),
                  ),
                );
              },
            ),

            // Repeat this block for each button, just change label + icon + screen
            HomeCardWidget(
              imagePath: AssetImages.employeeListImage,
              label: 'Employee List',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EmployeeList()),
                );
              },
            ),

            // Salary Slip
            HomeCardWidget(
              imagePath: AssetImages.salaryslip,
              label: 'Salary Slip',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EmployeeSalarySlipScreen(),
                  ),
                );
              },
            ),

            // Mark Attendance
            HomeCardWidget(
              imagePath: AssetImages.markEmployeeImage,
              label: 'Mark Attendance',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EmployeeAttendenceScreen(),
                  ),
                );
              },
            ),

            // Multiple Attendance
            HomeCardWidget(
              imagePath: AssetImages.multipleAttendence,
              label: 'Multiple Attendance',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MultipleAttendence(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
