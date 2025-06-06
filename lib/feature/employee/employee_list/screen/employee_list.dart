import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/employee/add_employee/provider/add_employee_provider.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmployeeList extends ConsumerStatefulWidget {
  const EmployeeList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeeListState();
}

class _EmployeeListState extends ConsumerState<EmployeeList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(addEmployeeProvider.notifier).fetchAllEmployee();
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
          backgroundColor: AppColors.whiteColors,
          iconTheme: const IconThemeData(color: AppColors.primary),
          title: Text(
            "Employee List",
            style: theme.textTheme.titleMedium!.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: employeeList.length,
            itemBuilder: (context, index) {
              final employee = employeeList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
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
                                  child:
                                      employee.employeePic?.isNotEmpty ?? false
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(51),
                                              child: Image.network(
                                                employee.employeePic ??
                                                    'https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061131_640.png',
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  employee.name ?? '',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Text(
                                  (employee.designation).toString(),
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Text(
                                  (employee.cnicId).toString(),
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppColors.primary,
                                    title: Text(
                                      "Delete Employee",
                                      style: context.theme.textTheme.bodyLarge,
                                    ),
                                    content: const Text(
                                        "Are you sure you want to delete Employee? This action cannot be undone."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(
                                                  addEmployeeProvider.notifier)
                                              .deleteEmployee(employee.id);

                                          Future.delayed(Duration.zero, () {
                                            context.pop();
                                          });
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
