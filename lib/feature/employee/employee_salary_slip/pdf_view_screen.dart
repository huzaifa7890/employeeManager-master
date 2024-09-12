import 'package:employeemanager/feature/auth/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:employeemanager/models/employee.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:employeemanager/theme/app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class PdfViewScreen extends ConsumerStatefulWidget {
  final Employee employee;
  final DateTimeRange selectedDateRange;

  const PdfViewScreen({
    super.key,
    required this.employee,
    required this.selectedDateRange,
  });

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

  String formatDate(String dateTime) {
    try {
      // Parse the date using the correct format
      DateTime parsedDate = DateFormat('dd MMMM y').parse(dateTime);
      // Format the parsed date to the desired format
      return DateFormat('EEE, d MMM').format(parsedDate);
    } catch (e) {
      // Handle any parsing error
      return "Invalid date";
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    final theme = Theme.of(context);
    final user = ref.read(userProvider);

    double totalPayment =
        widget.employee.employeeAttendence.where((attendance) {
      DateTime attendanceDate =
          DateFormat('dd MMMM y').parse(attendance.dateTime);
      return attendanceDate.isAfter(widget.selectedDateRange.start
              .subtract(const Duration(days: 1))) &&
          attendanceDate.isBefore(
              widget.selectedDateRange.end.add(const Duration(days: 1)));
    }).fold(0.0, (sum, attendance) => sum + attendance.totalPayment);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                // Generate the PDF
                final pdfData = await _generatePdf(
                    widget.employee,
                    theme,
                    user?.profilePic ??
                        'https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061131_640.png');
                // Share the PDF
                _sharePdf(pdfData);
              },
            ),
          ],
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
                          child: widget.employee.employeePic!.isNotEmpty
                              ? Image.network(
                                  widget.employee.employeePic ??
                                      'https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061131_640.png',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showBottomBorder: true,
                    dividerThickness: 1,
                    headingRowColor:
                        const WidgetStatePropertyAll(AppColors.appThemeColor),
                    dataRowColor:
                        const WidgetStatePropertyAll(AppColors.fieldGrey),
                    columnSpacing: 12,
                    columns: <DataColumn>[
                      DataColumn(
                          label: Text(
                        'Date',
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: AppColors.primary),
                      )),
                      DataColumn(
                          label: Text(
                        'Status',
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: AppColors.primary),
                      )),
                      DataColumn(
                          label: Text(
                        'Pay',
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: AppColors.primary),
                      )),
                      DataColumn(
                          label: Text(
                        'Debit',
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: AppColors.primary),
                      )),
                      DataColumn(
                          label: Text(
                        'Bonus',
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: AppColors.primary),
                      )),
                      DataColumn(
                          label: Text(
                        'Net Pay',
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: AppColors.primary),
                      )),
                    ],
                    rows:
                        widget.employee.employeeAttendence.where((attendance) {
                      DateTime attendanceDate =
                          DateFormat('dd MMMM y').parse(attendance.dateTime);
                      return attendanceDate.isAfter(widget
                              .selectedDateRange.start
                              .subtract(const Duration(days: 1))) &&
                          attendanceDate.isBefore(widget.selectedDateRange.end
                              .add(const Duration(days: 1)));
                    }).map((attendance) {
                      final netPay = attendance.totalPayment +
                          (attendance.bonus) -
                          (attendance.taxDebit);

                      return DataRow(cells: [
                        DataCell(
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  formatDate(attendance.dateTime),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: AppColors
                                    .dividerColor, // You can define a divider color in your theme or use any color
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  attendance.status.name,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: AppColors
                                    .dividerColor, // You can define a divider color in your theme or use any color
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  attendance.totalPayment.toString(),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: AppColors
                                    .dividerColor, // You can define a divider color in your theme or use any color
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  (attendance.taxDebit).toString(),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: AppColors
                                    .dividerColor, // You can define a divider color in your theme or use any color
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  (attendance.bonus).toString(),
                                  style: theme.textTheme.bodySmall,
                                ),
                              ),
                              const VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: AppColors
                                    .dividerColor, // You can define a divider color in your theme or use any color
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Text(
                            netPay.toString(),
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
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
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      Employee employee, ThemeData theme, String userProfilePic) async {
    final pdf = pw.Document();

    // Add content to the PDF document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  'Attendance PDF View',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      // pw.CircleAvatar(
                      //   radius: 30,
                      //   backgroundColor: PdfColors.grey,
                      //   backgroundImage: pw.MemoryImage(await networkImage(userProfilePic)),
                      // ),
                      pw.SizedBox(height: 10),
                      pw.Text(
                        'Employee: ${employee.name}',
                        style: const pw.TextStyle(
                            fontSize: 18, color: PdfColors.black),
                      ),
                      pw.Text(
                        'Employee ID: ${employee.cnicId}',
                        style: const pw.TextStyle(
                            fontSize: 16, color: PdfColors.black),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>[
                    'Date',
                    'Status',
                    'Pay',
                    'Debit',
                    'Bonus',
                    'Net Pay'
                  ],
                  ...employee.employeeAttendence.map((attendance) {
                    final netPay = attendance.totalPayment +
                        (attendance.bonus) -
                        (attendance.taxDebit);
                    return [
                      attendance.dateTime,
                      attendance.status.name,
                      attendance.totalPayment.toString(),
                      attendance.taxDebit.toString(),
                      attendance.bonus.toString(),
                      netPay.toString()
                    ];
                  })
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Total Payment: ${employee.employeeAttendence.fold(0.0, (sum, attendance) => sum + attendance.totalPayment)}',
                style: const pw.TextStyle(fontSize: 18, color: PdfColors.black),
              ),
            ],
          );
        },
      ),
    );

    // Return the generated PDF as a byte array
    return pdf.save();
  }

  Future<Uint8List> networkImage(String url) async {
    final response = await NetworkAssetBundle(Uri.parse(url)).load("");
    return response.buffer.asUint8List();
  }

  void _sharePdf(Uint8List pdfData) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/attendance.pdf');
    await file.writeAsBytes(pdfData);

    Share.shareXFiles([XFile(file.path)], text: 'Employee Attendance PDF');
  }
}
