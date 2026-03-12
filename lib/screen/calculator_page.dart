import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';
import 'package:teknologimobile_tugas2/theme/app_color.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key, required this.username});
  final String username;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();

  double? _additionResult;
  double? _subtractionResult;
  String? _calculationError;

  @override
  void dispose() {
    _firstNumberController.dispose();
    _secondNumberController.dispose();
    super.dispose();
  }

  void _calculateResults() {
    final firstNumber = double.tryParse(_firstNumberController.text.trim());
    final secondNumber = double.tryParse(_secondNumberController.text.trim());

    if (firstNumber == null || secondNumber == null) {
      setState(() {
        _calculationError = 'Masukkan dua angka yang valid.';
        _additionResult = null;
        _subtractionResult = null;
      });
      return;
    }

    setState(() {
      _calculationError = null;
      _additionResult = firstNumber + secondNumber;
      _subtractionResult = firstNumber - secondNumber;
    });
  }

  void _resetCalculator() {
    setState(() {
      _firstNumberController.clear();
      _secondNumberController.clear();
      _additionResult = null;
      _subtractionResult = null;
      _calculationError = null;
    });
  }

  String _formatNumber(double? value) {
    if (value == null) return '-';
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
  }

  // Widget satu baris hasil (misal: "A + B = 30")
  Widget _buildResultRow({
    required String label,
    required String expression,
    required String result,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          // Ikon operasi
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(
                  expression,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
          // Hasil besar di kanan
          Text(
            result,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final a = _firstNumberController.text.trim();
    final b = _secondNumberController.text.trim();

    return Scaffold(
      appBar: AppBar(title: const Text('Kalkulator')),
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Calculator',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.success, Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(Icons.calculate_rounded, color: Colors.white, size: 32),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kalkulator',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Penjumlahan & Pengurangan',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Input Angka Pertama
            const Text(
              'Angka Pertama',
              style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _firstNumberController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(
                hintText: 'Masukkan angka pertama',
                prefixIcon: Icon(Icons.looks_one_outlined, color: AppColors.primary),
              ),
            ),

            const SizedBox(height: 16),

            // Input Angka Kedua
            const Text(
              'Angka Kedua',
              style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _secondNumberController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: InputDecoration(
                hintText: 'Masukkan angka kedua',
                prefixIcon: const Icon(Icons.looks_two_outlined, color: AppColors.primary),
                errorText: _calculationError,
              ),
            ),

            const SizedBox(height: 20),

            // Tombol Hitung dan Reset
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _calculateResults,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Hitung'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _resetCalculator,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Reset'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Kartu Hasil
            if (_additionResult != null || _subtractionResult != null) ...[
              const Text(
                'Hasil Perhitungan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              _buildResultRow(
                label: 'Penjumlahan',
                expression: '$a + $b',
                result: _formatNumber(_additionResult),
                color: AppColors.success,
                icon: Icons.add_circle_outline_rounded,
              ),
              const SizedBox(height: 10),
              _buildResultRow(
                label: 'Pengurangan',
                expression: '$a − $b',
                result: _formatNumber(_subtractionResult),
                color: AppColors.error,
                icon: Icons.remove_circle_outline_rounded,
              ),
            ] else ...[
              // Placeholder sebelum hitung
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.calculate_outlined, size: 40, color: AppColors.border),
                    SizedBox(height: 8),
                    Text(
                      'Masukkan angka lalu tekan Hitung',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
