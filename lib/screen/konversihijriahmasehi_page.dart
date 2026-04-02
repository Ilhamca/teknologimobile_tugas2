import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/theme/app_color.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';

class KonversiHijriahMasehiPage extends StatefulWidget {
	const KonversiHijriahMasehiPage({super.key, required this.username});

	final String username;

	@override
	State<KonversiHijriahMasehiPage> createState() => _KonversiHijriahMasehiPageState();
}

class _KonversiHijriahMasehiPageState extends State<KonversiHijriahMasehiPage> {
	DateTime? _selectedDate;
	String? _conversionResult;
	String? _conversionDetail;

	static const List<String> _hijriMonthNames = [
		'Muharram', 'Safar', 'Rabiul Awal', 'Rabiul Akhir',
		'Jumadil Awal', 'Jumadil Akhir', 'Rajab', 'Syaban',
		'Ramadan', 'Syawal', 'Zulkaidah', 'Zulhijah',
	];

	static const List<String> _masehiMonthNames = [
		'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
		'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
	];

	Future<void> _pickDateAndConvert() async {
		final now = DateTime.now();
		final pickedDate = await showDatePicker(
			context: context,
			initialDate: _selectedDate ?? now,
			firstDate: DateTime(622),
			lastDate: DateTime(2100),
			helpText: 'Pilih Tanggal Masehi',
			locale: const Locale('id', 'ID'),
		);

		if (pickedDate == null) return;

		final hijri = _masehiToHijriah(pickedDate);

		setState(() {
			_selectedDate = pickedDate;
			_conversionResult = '${hijri['day']} ${hijri['monthName']} ${hijri['year']} H';
			_conversionDetail =
				'Masehi  : ${pickedDate.day} ${_masehiMonthNames[pickedDate.month - 1]} ${pickedDate.year}\n'
				'Hijriah : ${hijri['day']} ${hijri['monthName']} ${hijri['year']} H';
		});
	}

	/// Konversi Masehi ke Hijriah menggunakan algoritma Julian Day Number
	Map<String, dynamic> _masehiToHijriah(DateTime date) {
		int d = date.day;
		int m = date.month;
		int y = date.year;

		// Hitung Julian Day Number dari tanggal Gregorian
		int jd = (1461 * (y + 4800 + (m - 14) ~/ 12)) ~/ 4
			+ (367 * (m - 2 - 12 * ((m - 14) ~/ 12))) ~/ 12
			- (3 * ((y + 4900 + (m - 14) ~/ 12) ~/ 100)) ~/ 4
			+ d - 32075;

		// Konversi JD ke kalender Hijriah
		int l = jd - 1948440 + 10632;
		int n = (l - 1) ~/ 10631;
		l = l - 10631 * n + 354;
		int j = ((10985 - l) ~/ 5316) * ((50 * l) ~/ 17719)
			+ (l ~/ 5670) * ((43 * l) ~/ 15238);
		l = l - ((30 - j) ~/ 15) * ((17719 * j) ~/ 50)
			- (j ~/ 16) * ((15238 * j) ~/ 43) + 29;
		int hMonth = (24 * l) ~/ 709;
		int hDay = l - (709 * hMonth) ~/ 24;
		int hYear = 30 * n + j - 30;

		return {
			'day': hDay,
			'month': hMonth,
			'year': hYear,
			'monthName': _hijriMonthNames[hMonth - 1],
		};
	}

	String _formatDate(DateTime date) {
		return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Konversi Masehi ke Hijriah')),
			drawer: NavigationDrawerWidget(
				username: widget.username,
				currentPage: 'Konversi Hijriah-Masehi',
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
									colors: [AppColors.accent, AppColors.primary],
									begin: Alignment.topLeft,
									end: Alignment.bottomRight,
								),
								borderRadius: BorderRadius.circular(18),
							),
							child: const Row(
								children: [
									Icon(Icons.calendar_month_rounded, color: Colors.white, size: 30),
									SizedBox(width: 14),
									Expanded(
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Text(
													'Konversi Masehi → Hijriah',
													style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
												),
												SizedBox(height: 2),
												Text(
													'Masukkan tanggal Masehi untuk dikonversi',
													style: TextStyle(color: Colors.white70, fontSize: 12),
												),
											],
										),
									),
								],
							),
						),
						const SizedBox(height: 24),
						ElevatedButton.icon(
							onPressed: _pickDateAndConvert,
							icon: const Icon(Icons.date_range_rounded),
							label: Text(
								_selectedDate == null
									? 'Pilih Tanggal Masehi'
									: _formatDate(_selectedDate!),
							),
						),
						const SizedBox(height: 18),
						Container(
							width: double.infinity,
							padding: const EdgeInsets.all(18),
							decoration: BoxDecoration(
								color: Colors.white,
								borderRadius: BorderRadius.circular(14),
								border: Border.all(color: AppColors.border),
							),
							child: _conversionResult == null
								? const Column(
									children: [
										Icon(Icons.swap_horiz_rounded, color: AppColors.textSecondary, size: 32),
										SizedBox(height: 8),
										Text(
											'Pilih tanggal Masehi untuk melihat hasil konversi.',
											textAlign: TextAlign.center,
											style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
										),
									],
								)
								: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Row(
											children: [
												const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 20),
												const SizedBox(width: 8),
												const Text(
													'Hasil Konversi',
													style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
												),
											],
										),
										const SizedBox(height: 12),
										Container(
											width: double.infinity,
											padding: const EdgeInsets.all(14),
											decoration: BoxDecoration(
												color: AppColors.primary.withOpacity(0.06),
												borderRadius: BorderRadius.circular(10),
												border: Border.all(color: AppColors.primary.withOpacity(0.2)),
											),
											child: Text(
												_conversionResult!,
												style: const TextStyle(
													fontSize: 20,
													fontWeight: FontWeight.bold,
													color: AppColors.primary,
												),
											),
										),
										const SizedBox(height: 10),
										Text(
											_conversionDetail ?? '',
											style: const TextStyle(
												fontSize: 13,
												color: AppColors.textSecondary,
												height: 1.8,
												fontFamily: 'monospace',
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
