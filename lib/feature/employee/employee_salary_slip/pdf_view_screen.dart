import 'package:employeemanager/feature/auth/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:employeemanager/models/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:employeemanager/theme/app_colors.dart';

class PdfViewScreen extends ConsumerStatefulWidget {
  final Employee employee;
  final DateTimeRange selectedDateRange;

  const PdfViewScreen({
    Key? key,
    required this.employee,
    required this.selectedDateRange,
  }) : super(key: key);

  @override
  ConsumerState<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends ConsumerState<PdfViewScreen> {
  List<String> getFilteredAttendence(Employee employee) {
    return employee.employeeAttendence
        .where((attendance) {
          DateTime attendanceDate =
              DateFormat('dd MMMM y').parse(attendance.dateTime);
          return attendanceDate.isAfter(widget.selectedDateRange.start
                  .subtract(const Duration(days: 1))) &&
              attendanceDate.isBefore(
                  widget.selectedDateRange.end.add(const Duration(days: 1)));
        })
        .map((attendance) => attendance.dateTime)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.read(userProvider);
    final attendanceList = getFilteredAttendence(widget.employee);

    double totalPayment =
        widget.employee.employeeAttendence.where((attendance) {
      DateTime attendanceDate =
          DateFormat('dd MMMM y').parse(attendance.dateTime);
      return attendanceDate.isAfter(widget.selectedDateRange.start
              .subtract(const Duration(days: 1))) &&
          attendanceDate.isBefore(
              widget.selectedDateRange.end.add(const Duration(days: 1)));
    }).fold(0.0, (sum, attendance) => sum + attendance.totalPayment);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance PDF View',
          style: theme.textTheme.titleMedium!.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColors.secondary,
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 30,
                      minRadius: 30,
                      backgroundColor: AppColors.fieldGrey,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(51),
                        child: Image.network(
                          user?.profilePic ??
                              'https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061131_640.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user?.name ?? '',
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: AppColors.appThemeColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Pay Slip",
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('dd MMMM y')
                          .format(widget.selectedDateRange.start),
                      style: theme.textTheme.titleSmall,
                    ),
                    Text(
                      'To',
                      style: theme.textTheme.titleLarge,
                    ),
                    Text(
                      DateFormat('dd MMMM y')
                          .format(widget.selectedDateRange.end),
                      style: theme.textTheme.titleSmall,
                    ),
                    Text(
                      'Employee ID: ${widget.employee.cnicId}',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      maxRadius: 30,
                      minRadius: 30,
                      backgroundColor: AppColors.fieldGrey,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(51),
                        child: Image.network(
                          widget.employee.employeePic ??
                              'https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061131_640.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.employee.name ?? '',
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: AppColors.appThemeColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.employee.phoneNo.toString(),
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Basic Pay: ${widget.employee.pay}",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const <DataColumn>[
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Pay')),
                  DataColumn(label: Text('Debit')),
                  DataColumn(label: Text('Bonus')),
                  DataColumn(label: Text('Net Pay')),
                ],
                rows: widget.employee.employeeAttendence.where((attendance) {
                  DateTime attendanceDate =
                      DateFormat('dd MMMM y').parse(attendance.dateTime);
                  return attendanceDate.isAfter(widget.selectedDateRange.start
                          .subtract(const Duration(days: 1))) &&
                      attendanceDate.isBefore(widget.selectedDateRange.end
                          .add(const Duration(days: 1)));
                }).map((attendance) {
                  final netPay = attendance.totalPayment +
                      (attendance.bonus ?? 0) -
                      (attendance.taxDebit ?? 0);

                  return DataRow(cells: [
                    DataCell(Text(attendance.dateTime)),
                    DataCell(Text(attendance.status?.name ?? 'N/A')),
                    DataCell(Text(attendance.totalPayment.toString())),
                    DataCell(Text((attendance.taxDebit ?? 0).toString())),
                    DataCell(Text((attendance.bonus ?? 0).toString())),
                    DataCell(Text(netPay.toString())),
                  ]);
                }).toList(),
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Payment: $totalPayment',
              style: theme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
