import 'package:employeemanager/constant/data_constant.dart';
import 'package:employeemanager/constant/extension_constants.dart';
import 'package:employeemanager/constant/string_constant.dart';
import 'package:employeemanager/feature/employee/add_employee/provider/add_employee_provider.dart';
import 'package:employeemanager/feature/employee/employee_attendence/widgets/attendence_widget.dart';
import 'package:employeemanager/models/employee.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:employeemanager/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MarkAttendenceSheet extends ConsumerStatefulWidget {
  final Employee employee;
  const MarkAttendenceSheet({super.key, required this.employee});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MarkAttendenceSheetState();
}

class _MarkAttendenceSheetState extends ConsumerState<MarkAttendenceSheet> {
  TextEditingController basicPayController = TextEditingController();
  TextEditingController taxDebitController = TextEditingController();
  TextEditingController bonusController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  DateTime? selectedDate;
  EmployeeAttendenceStatus? selectEmployeeAttendence;

  @override
  void initState() {
    super.initState();
    basicPayController.text = widget.employee.pay.toString();
    taxDebitController.addListener(_updateTotalPayment);
    bonusController.addListener(_updateTotalPayment);
    totalController.text = widget.employee.pay.toString();

    _initializeAttendanceStatus(DateTime.now());
  }

  @override
  void dispose() {
    taxDebitController.removeListener(_updateTotalPayment);
    bonusController.removeListener(_updateTotalPayment);
    basicPayController.dispose();
    taxDebitController.dispose();
    bonusController.dispose();
    totalController.dispose();
    super.dispose();
  }

  void _updateTotalPayment() {
    final basicPay = int.tryParse(basicPayController.text) ?? 0;
    final tax = int.tryParse(taxDebitController.text) ?? 0;
    final bonus = int.tryParse(bonusController.text) ?? 0;
    final total = basicPay - tax + bonus;
    totalController.text = total.toString();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.blackBlue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: AppColors.blue, // body text color
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
        _initializeAttendanceStatus(picked);
      });
    }
  }

  void _initializeAttendanceStatus(DateTime date) {
    final attendances = widget.employee.employeeAttendence;
    final selectedDateFormatted = DateFormat('dd MMMM y').format(date);

    final matchingAttendances = attendances.where(
      (attendance) => attendance.dateTime == selectedDateFormatted,
    );

    if (matchingAttendances.isNotEmpty) {
      selectEmployeeAttendence = matchingAttendances.first.status;
      bonusController.text = matchingAttendances.first.bonus.toString();
      taxDebitController.text = matchingAttendances.first.taxDebit.toString();
    } else {
      selectEmployeeAttendence = null; // No attendance found for the given date
      bonusController.text = '0';
      taxDebitController.text = '0';
    }
    setState(() {
      selectedDate = date; // Set the selected date
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(addEmployeeProvider).employeeAttendenceStatus;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        iconTheme: const IconThemeData(color: AppColors.primary),
        title: Text(
          "Mark Attendence",
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
                                  width:
                                      4, // Adjust this value to your preference
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
                              widget.employee.name!,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Date",
                    style: theme.textTheme.bodyLarge,
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          selectedDate != null
                              ? DateFormat('dd MMMM y').format(selectedDate!)
                              : DateFormat('dd MMMM y').format(DateTime.now()),
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Display attendance checkboxes
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Wrap(
                    spacing: 8,
                    children: EmployeeAttendenceStatus.values.map((item) {
                      return AttendenceMarkWidget(
                        text: getEmployeeAttendenceStatus(item),
                        isSelected: selectEmployeeAttendence == item,
                        onPressed: () {
                          setState(() {
                            selectEmployeeAttendence = item;
                          });
                          ref
                              .read(addEmployeeProvider.notifier)
                              .setAttendence(item);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.fieldGrey,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      "Basic Pay",
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppTextField(
                        height: 65,
                        enabled: false,
                        // hintText: "Basic Pay",
                        textAlign: TextAlign.end,
                        textController: basicPayController,
                        fillColor: AppColors.fieldGrey,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Check Basic Pay";
                          }
                          return null;
                        },
                        hintStyle: theme.textTheme.bodyLarge,
                        lines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.fieldGrey,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      "Tax/Debit",
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppTextField(
                        height: 65,
                        // hintText: "Tax/Debit",
                        textAlign: TextAlign.end,
                        textController: taxDebitController,
                        fillColor: AppColors.fieldGrey,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Check Tax/Debit";
                          }
                          return null;
                        },
                        hintStyle: theme.textTheme.bodyLarge,
                        lines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.fieldGrey,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      "Bonus",
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppTextField(
                        height: 65,
                        // hintText: "Bonus",
                        textAlign: TextAlign.end,
                        textController: bonusController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        fillColor: AppColors.fieldGrey,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Check Bonus";
                          }
                          return null;
                        },
                        hintStyle: theme.textTheme.bodyLarge,
                        lines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: AppColors.fieldGrey,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      "Total Payments",
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AppTextField(
                        height: 65,
                        enabled: false,
                        // hintText: "Total Payments",
                        textAlign: TextAlign.end,
                        textController: totalController,
                        fillColor: AppColors.fieldGrey,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Check Total Payments";
                          }
                          return null;
                        },
                        hintStyle: theme.textTheme.bodyLarge,
                        lines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  final response =
                      ref.read(addEmployeeProvider.notifier).updateAttendence(
                            widget.employee.id,
                            int.parse(taxDebitController.text),
                            int.parse(bonusController.text),
                            int.parse(totalController.text),
                            selectedDate ?? DateTime.now(),
                            status ?? EmployeeAttendenceStatus.present,
                          );
                  response.then((e) {
                    if (e.errorMessage.isEmpty) {
                      return context.showSuccessSnackBar(
                          "Attendence updated succussfully");
                    }
                  });
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
