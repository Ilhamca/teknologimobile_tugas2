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

	Future<void> _pickBirthDate() async {
		final now = DateTime.now();
		final initialDate = _selectedBirthDate ?? DateTime(now.year - 20, now.month, now.day);

		final pickedDate = await showDatePicker(
			context: context,
			initialDate: initialDate,
			firstDate: DateTime(1900),
			lastDate: now,
			helpText: 'Pilih Tanggal Lahir',
			locale: const Locale('id', 'ID'),
		);

		if (pickedDate == null) return;

		setState(() {
			_selectedBirthDate = pickedDate;
		});
	}

	String _formatDate(DateTime date) {
		return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
	}

	@override
	Widget build(BuildContext context) {
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
													'Pilih tanggal lahir untuk proses data',
													style: TextStyle(color: Colors.white70, fontSize: 12),
												),
											],
										),
									),
								],
							),
						),
						const SizedBox(height: 24),
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
								padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
								decoration: BoxDecoration(
									color: Colors.white,
									borderRadius: BorderRadius.circular(12),
									border: Border.all(color: AppColors.border),
								),
								child: Row(
									children: [
										const Icon(Icons.calendar_today_rounded, color: AppColors.primary, size: 20),
										const SizedBox(width: 10),
										Expanded(
											child: Text(
												_selectedBirthDate == null
														? 'Pilih tanggal lahir'
														: _formatDate(_selectedBirthDate!),
												style: TextStyle(
													fontSize: 14,
													color: _selectedBirthDate == null
															? AppColors.textSecondary
															: AppColors.textPrimary,
												),
											),
										),
										const Icon(Icons.edit_calendar_rounded, color: AppColors.textSecondary),
									],
								),
							),
						),
						const SizedBox(height: 20),
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
										'Preview Data',
										style: TextStyle(
											fontSize: 14,
											fontWeight: FontWeight.w700,
											color: AppColors.textPrimary,
										),
									),
									const SizedBox(height: 10),
									Row(
										children: [
											const Icon(Icons.badge_outlined, color: AppColors.textSecondary, size: 18),
											const SizedBox(width: 8),
											Text(
												'User: ${widget.username}',
												style: const TextStyle(color: AppColors.textSecondary),
											),
										],
									),
									const SizedBox(height: 6),
									Row(
										children: [
											const Icon(Icons.event_note_rounded, color: AppColors.textSecondary, size: 18),
											const SizedBox(width: 8),
											Text(
												'Tanggal: ${_selectedBirthDate == null ? '-' : _formatDate(_selectedBirthDate!)}',
												style: const TextStyle(color: AppColors.textSecondary),
											),
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
