import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/theme/app_color.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';

class InputTanggalLahirPage extends StatefulWidget {
  const InputTanggalLahirPage({super.key, required this.username});

  final String username;

  @override
  State<InputTanggalLahirPage> createState() => _InputTanggalLahirPageState();
}

class _InputTanggalLahirPageState extends State<InputTanggalLahirPage> {
  DateTime? _selectedBirthDate;
  TimeOfDay? _selectedBirthTime;

  static const List<String> _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final initialDate =
        _selectedBirthDate ?? DateTime(now.year - 20, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: 'Pilih Tanggal Lahir',
      locale: const Locale('id', 'ID'),
    );

    if (pickedDate == null) return;
    setState(() => _selectedBirthDate = pickedDate);
  }

  Future<void> _pickBirthTime() async {
    final initialTime =
        _selectedBirthTime ?? const TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: 'Pilih Jam Lahir',
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;
    setState(() => _selectedBirthTime = pickedTime);
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} ${_monthNames[date.month - 1]} ${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hh = time.hour.toString().padLeft(2, '0');
    final mm = time.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }

  /// Hitung umur dari tanggal lahir ke sekarang
  String _getAge(DateTime birthDate) {
    final now = DateTime.now();
    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    if (days < 0) {
      months--;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }

    return '$years tahun, $months bulan, $days hari';
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    bool highlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: highlight ? AppColors.primary : AppColors.textSecondary,
            size: 18,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: highlight ? AppColors.primary : AppColors.textPrimary,
                fontSize: 13,
                fontWeight: highlight ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasDate = _selectedBirthDate != null;
    final hasTime = _selectedBirthTime != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Input Tanggal Lahir')),
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Ganti Tanggal Lahir',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(Icons.cake_rounded, color: Colors.white, size: 32),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Input Tanggal Lahir',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Masukkan tanggal, bulan, tahun, jam & menit',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Pilih Tanggal Lahir
            const Text(
              'Tanggal Lahir',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickBirthDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: hasDate ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: hasDate
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        hasDate
                            ? _formatDate(_selectedBirthDate!)
                            : 'Pilih tanggal lahir',
                        style: TextStyle(
                          fontSize: 14,
                          color: hasDate
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.edit_calendar_rounded,
                      color: AppColors.textSecondary,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Pilih Jam Lahir
            const Text(
              'Jam Lahir',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickBirthTime,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: hasTime ? AppColors.primary : AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: hasTime
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        hasTime
                            ? '${_formatTime(_selectedBirthTime!)} WIB'
                            : 'Pilih jam & menit lahir',
                        style: TextStyle(
                          fontSize: 14,
                          color: hasTime
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.timer_outlined,
                      color: AppColors.textSecondary,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Hasil / Preview
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data Tanggal Lahir',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(Icons.badge_outlined, 'User', widget.username),
                  _buildInfoRow(
                    Icons.event_note_rounded,
                    'Tanggal',
                    hasDate ? _formatDate(_selectedBirthDate!) : '-',
                    highlight: hasDate,
                  ),
                  _buildInfoRow(
                    Icons.access_time_rounded,
                    'Jam',
                    hasTime ? '${_formatTime(_selectedBirthTime!)} WIB' : '-',
                    highlight: hasTime,
                  ),
                  if (hasDate) ...[
                    const Divider(height: 20),
                    _buildInfoRow(
                      Icons.cake_rounded,
                      'Umur',
                      _getAge(_selectedBirthDate!),
                      highlight: true,
                    ),
                  ],
                  if (!hasDate && !hasTime)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Pilih tanggal dan jam lahir untuk melihat data.',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
