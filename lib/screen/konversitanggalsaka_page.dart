import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';
import 'package:teknologimobile_tugas2/theme/app_color.dart';

class KonversiTanggalSaka extends StatefulWidget {
  const KonversiTanggalSaka({super.key, required this.username});

  final String username;

  @override
  State<KonversiTanggalSaka> createState() => _KonversiTanggalSakaState();
}

class _KonversiTanggalSakaState extends State<KonversiTanggalSaka> {
  DateTime? _selectedDate;
  String? _conversionResult;

  static const List<String> _sakaMonthNames = [
    'Chaitra',
    'Vaisakha',
    'Jyaistha',
    'Asadha',
    'Sravana',
    'Bhadra',
    'Asvina',
    'Kartika',
    'Agrahayana',
    'Pausa',
    'Magha',
    'Phalguna',
  ];

  Future<void> _pickDateAndConvert() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      helpText: 'Pilih Tanggal',
      locale: const Locale('id', 'ID'),
    );

    if (pickedDate == null) return;

    final result = _convertMasehiToSaka(pickedDate);

    setState(() {
      _selectedDate = pickedDate;
      _conversionResult = result;
    });
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  bool _isGregorianLeapYear(int year) {
    if (year % 400 == 0) return true;
    if (year % 100 == 0) return false;
    return year % 4 == 0;
  }

  List<int> _sakaMonthLengthsForGregorianYear(int gregorianYear) {
    final chaitraLength = _isGregorianLeapYear(gregorianYear) ? 31 : 30;
    return [chaitraLength, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 30];
  }

  DateTime _sakaYearStartInGregorian(int gregorianYear) {
    final startDay = _isGregorianLeapYear(gregorianYear) ? 21 : 22;
    return DateTime(gregorianYear, 3, startDay);
  }

  ({int day, int month, int year}) _gregorianToSaka(DateTime date) {
    final currentYearStart = _sakaYearStartInGregorian(date.year);

    late final int sakaYear;
    late final DateTime sakaStart;
    late final List<int> monthLengths;

    if (!date.isBefore(currentYearStart)) {
      sakaYear = date.year - 78;
      sakaStart = currentYearStart;
      monthLengths = _sakaMonthLengthsForGregorianYear(date.year);
    } else {
      final prevGregorianYear = date.year - 1;
      sakaYear = date.year - 79;
      sakaStart = _sakaYearStartInGregorian(prevGregorianYear);
      monthLengths = _sakaMonthLengthsForGregorianYear(prevGregorianYear);
    }

    var dayOfYear = date.difference(sakaStart).inDays + 1;
    var sakaMonth = 1;

    for (final length in monthLengths) {
      if (dayOfYear <= length) break;
      dayOfYear -= length;
      sakaMonth++;
    }

    return (day: dayOfYear, month: sakaMonth, year: sakaYear);
  }

  String _formatSakaDate(int day, int month, int year) {
    final monthName = _sakaMonthNames[month - 1];
    return '${day.toString().padLeft(2, '0')} $monthName $year';
  }

  String _convertMasehiToSaka(DateTime date) {
    final saka = _gregorianToSaka(date);
    return 'Tanggal Masehi: ${_formatDate(date)}\nTanggal Saka: ${_formatSakaDate(saka.day, saka.month, saka.year)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Tanggal Saka'),
      ),
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Konversi Tanggal Saka',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.primary],
                  begin: Alignment.topLeft,

                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Konversi Tanggal Saka',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Konversi satu arah dari Masehi ke Saka',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickDateAndConvert,
              icon: const Icon(Icons.date_range_rounded),
              label: Text(
                _selectedDate == null
                    ? 'Pilih Tanggal'
                    : _formatDate(_selectedDate!),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                _conversionResult ??
                    'Belum ada hasil konversi. Pilih tanggal biasa terlebih dahulu.',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
