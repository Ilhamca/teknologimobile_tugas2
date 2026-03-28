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
	bool _isMasehiToHijriah = true;
	DateTime? _selectedDate;
	String? _conversionResult;

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

		final result = _isMasehiToHijriah
				? _approxMasehiToHijriah(pickedDate)
				: _approxHijriahToMasehi(pickedDate);

		setState(() {
			_selectedDate = pickedDate;
			_conversionResult = result;
		});
	}

	String _formatDate(DateTime date) {
		return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
	}

	String _approxMasehiToHijriah(DateTime date) {
		final hijriYear = ((date.year - 622) * 33 / 32).floor();
		return 'Perkiraan Hijriah: ${date.day}/${date.month}/$hijriYear H';
	}

	String _approxHijriahToMasehi(DateTime date) {
		final masehiYear = (date.year * 32 / 33 + 622).floor();
		return 'Perkiraan Masehi: ${date.day}/${date.month}/$masehiYear M';
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Konversi Hijriah-Masehi')),
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
													'Konversi Hijriah-Masehi',
													style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
												),
												SizedBox(height: 2),
												Text(
													'Konversi tanggal dua kalender',
													style: TextStyle(color: Colors.white70, fontSize: 12),
												),
											],
										),
									),
								],
							),
						),
						const SizedBox(height: 24),
						SegmentedButton<bool>(
							segments: const [
								ButtonSegment<bool>(
									value: true,
									label: Text('Masehi -> Hijriah'),
									icon: Icon(Icons.arrow_forward_rounded),
								),
								ButtonSegment<bool>(
									value: false,
									label: Text('Hijriah -> Masehi'),
									icon: Icon(Icons.arrow_back_rounded),
								),
							],
							selected: {_isMasehiToHijriah},
							onSelectionChanged: (selection) {
								setState(() {
									_isMasehiToHijriah = selection.first;
									_conversionResult = null;
								});
							},
						),
						const SizedBox(height: 16),
						ElevatedButton.icon(
							onPressed: _pickDateAndConvert,
							icon: const Icon(Icons.date_range_rounded),
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
							child: Text(
								_conversionResult ?? 'Belum ada hasil konversi. Pilih mode dan tanggal terlebih dahulu.',
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
