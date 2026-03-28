import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/theme/app_color.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';

class KonversiHariWetonPage extends StatefulWidget {
	const KonversiHariWetonPage({super.key, required this.username});

	final String username;

	@override
	State<KonversiHariWetonPage> createState() => _KonversiHariWetonPageState();
}

class _KonversiHariWetonPageState extends State<KonversiHariWetonPage> {
	static const List<String> _hariNames = [
		'Minggu',
		'Senin',
		'Selasa',
		'Rabu',
		'Kamis',
		'Jumat',
		'Sabtu',
	];

	static const List<String> _pasaranNames = [
		'Legi',
		'Pahing',
		'Pon',
		'Wage',
		'Kliwon',
	];

	DateTime? _selectedDate;
	String? _hariResult;
	String? _wetonResult;

	Future<void> _pickDate() async {
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

		final normalizedDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
		final referenceDate = DateTime(2024, 1, 1);
		final int dayDifference = normalizedDate.difference(referenceDate).inDays;
		final int pasaranIndex = ((dayDifference % 5) + 5) % 5;
		final String hari = _hariNames[normalizedDate.weekday % 7];
		final String pasaran = _pasaranNames[pasaranIndex];

		setState(() {
			_selectedDate = normalizedDate;
			_hariResult = hari;
			_wetonResult = pasaran;
		});
	}

	String _formatDate(DateTime date) {
		return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Konversi Hari Weton')),
			drawer: NavigationDrawerWidget(
				username: widget.username,
				currentPage: 'Konversi Hari Weton',
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
									colors: [AppColors.warning, Color(0xFFD97706)],
									begin: Alignment.topLeft,
									end: Alignment.bottomRight,
								),
								borderRadius: BorderRadius.circular(18),
							),
							child: const Row(
								children: [
									Icon(Icons.calendar_today_rounded, color: Colors.white, size: 30),
									SizedBox(width: 14),
									Expanded(
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Text(
													'Konversi Hari Weton',
													style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
												),
												SizedBox(height: 2),
												Text(
													'Hitung hari dan pasaran Jawa',
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
							onPressed: _pickDate,
							icon: const Icon(Icons.event_available_rounded),
							label: Text(_selectedDate == null ? 'Pilih Tanggal' : _formatDate(_selectedDate!)),
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
							child: _selectedDate == null
									? const Column(
											children: [
												Icon(Icons.info_outline_rounded, color: AppColors.textSecondary),
												SizedBox(height: 6),
												Text(
													'Pilih tanggal untuk melihat hasil konversi.',
													style: TextStyle(color: AppColors.textSecondary),
												),
											],
										)
									: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												const Text(
													'Hasil Konversi',
													style: TextStyle(
														fontSize: 15,
														fontWeight: FontWeight.bold,
														color: AppColors.textPrimary,
													),
												),
												const SizedBox(height: 10),
												Row(
													children: [
														const Icon(Icons.today_rounded, color: AppColors.primary),
														const SizedBox(width: 8),
														Text('Hari: ${_hariResult ?? '-'}'),
													],
												),
												const SizedBox(height: 8),
												Row(
													children: [
														const Icon(Icons.auto_awesome_rounded, color: AppColors.warning),
														const SizedBox(width: 8),
														Text('Pasaran: ${_wetonResult ?? '-'}'),
													],
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
