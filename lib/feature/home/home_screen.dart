import 'package:employeemanager/constant/string_constant.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddEmployeeScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 70,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.appButtoncolor,
                        ),
                        child: Center(
                          child: Text(
                            "Add Employee",
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -22, // Adjust this value to control the overlap
                      top: 12, // Center the icon vertically
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          AssetImages.addEmployeeImage,
                          fit: BoxFit.cover,
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 25),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const EmployeeList();
                        }));
                      },
                      child: Container(
                        height: 70,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.appButtoncolor),
                        child: Center(
                            child: Text(
                          "List",
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: AppColors.primary),
                        )),
                      ),
                    ),
                    Positioned(
                      left: -20, // Adjust this value to control the overlap
                      top: 12, // Center the icon vertically
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            AssetImages.employeeListImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const EmployeeAttendenceScreen();
                        }));
                      },
                      child: Container(
                        height: 70,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.appButtoncolor),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Mark",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: AppColors.primary),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Attendance",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: AppColors.primary),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -20, // Adjust this value to control the overlap
                      top: 12, // Center the icon vertically
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          AssetImages.markEmployeeImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 25),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const EmployeeSalarySlipScreen();
                        }));
                      },
                      child: Container(
                        height: 70,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.appButtoncolor),
                        child: Center(
                            child: Text(
                          "Salary Slip",
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: AppColors.primary),
                        )),
                      ),
                    ),
                    Positioned(
                      left: -20, // Adjust this value to control the overlap
                      top: 12, // Center the icon vertically
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          AssetImages.salaryslip,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const MultipleAttendence();
                        }));
                      },
                      child: Container(
                        height: 70,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.appButtoncolor,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Multiple",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: AppColors.primary),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Attendance",
                                style: theme.textTheme.bodyLarge!
                                    .copyWith(color: AppColors.primary),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -20, // Adjust this value to control the overlap
                      top: 12, // Center the icon vertically
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          AssetImages.multipleAttendence,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 25),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const EmployeeSalarySlipScreen();
                        }));
                      },
                      child: Container(
                        height: 70,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.appButtoncolor,
                        ),
                        child: Center(
                          child: Text(
                            "Salary Slip",
                            style: theme.textTheme.bodyLarge!
                                .copyWith(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -20, // Adjust this value to control the overlap
                      top: 12, // Center the icon vertically
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          AssetImages.salaryslip,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // ElevatedButton(
            //   style: const ButtonStyle(
            //     minimumSize: MaterialStatePropertyAll(
            //       Size(220, 50),
            //     ),
            //   ),
            //   onPressed: () {
            //     ref.read(authProvider.notifier).signOut();
            //     context.pushReplacement(AppRoutes.mainScreen);
            //   },
            //   child: const Text('Logout'),
            // ),
          ],
        ),
      ),
    );
  }
}
