import 'dart:math';
import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';
import 'package:teknologimobile_tugas2/theme/app_color.dart';

class RumusPiramidPage extends StatefulWidget {
  const RumusPiramidPage({super.key, required this.username});
  final String username;

  @override
  State<RumusPiramidPage> createState() => _RumusPiramidPageState();
}

class _RumusPiramidPageState extends State<RumusPiramidPage> {
  final TextEditingController _sideController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? _surfaceArea;
  double? _volume;
  String? _errorText;

  @override
  void dispose() {
    _sideController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculatePyramid() {
    final side = double.tryParse(_sideController.text.trim());
    final height = double.tryParse(_heightController.text.trim());

    if (side == null || height == null || side <= 0 || height <= 0) {
      setState(() {
        _errorText = 'Masukkan nilai sisi alas dan tinggi yang valid.';
        _surfaceArea = null;
        _volume = null;
      });
      return;
    }

    final slantHeight = sqrt(pow(side / 2, 2) + pow(height, 2));
    final surfaceArea = pow(side, 2) + (2 * side * slantHeight);
    final volume = (pow(side, 2) * height) / 3;

    setState(() {
      _errorText = null;
      _surfaceArea = surfaceArea.toDouble();
      _volume = volume.toDouble();
    });
  }

  void _resetForm() {
    setState(() {
      _sideController.clear();
      _heightController.clear();
      _surfaceArea = null;
      _volume = null;
      _errorText = null;
    });
  }

  String _formatValue(double? value) {
    if (value == null) return '-';
    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
  }

  // Widget kartu satu hasil
  Widget _buildResultCard({
    required String label,
    required String formula,
    required String value,
    required String unit,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formula,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                unit,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rumus Piramid')),
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Rumus Piramid',
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
                  colors: [Color(0xFFEC4899), Color(0xFFBE185D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.change_history_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Piramid Segi Empat',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Hitung Luas Permukaan & Volume',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Info rumus singkat
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.primary,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Rumus yang digunakan:',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    '• Luas = s² + 2 × s × l  (l = sisi miring)\n• Volume = (s² × t) / 3',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Input Sisi Alas
            const Text(
              'Sisi Alas (s)',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _sideController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                hintText: 'Masukkan panjang sisi alas',
                prefixIcon: Icon(
                  Icons.straighten_rounded,
                  color: Color(0xFFEC4899),
                ),
                suffixText: 'cm',
              ),
            ),

            const SizedBox(height: 16),

            // Input Tinggi
            const Text(
              'Tinggi Piramid (t)',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _heightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintText: 'Masukkan tinggi piramid',
                prefixIcon: const Icon(
                  Icons.height_rounded,
                  color: Color(0xFFEC4899),
                ),
                suffixText: 'cm',
                errorText: _errorText,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _calculatePyramid,
                    icon: const Icon(Icons.calculate_rounded),
                    label: const Text('Hitung'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEC4899),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _resetForm,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEC4899),
                      side: const BorderSide(color: Color(0xFFEC4899)),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Kartu hasil
            if (_surfaceArea != null || _volume != null) ...[
              const Text(
                'Hasil Perhitungan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              _buildResultCard(
                label: 'Luas Permukaan',
                formula: 'L = s² + 2 × s × l',
                value: _formatValue(_surfaceArea),
                unit: 'cm²',
                color: const Color(0xFFEC4899),
                icon: Icons.square_foot_rounded,
              ),
              const SizedBox(height: 12),
              _buildResultCard(
                label: 'Volume',
                formula: 'V = (s² × t) / 3',
                value: _formatValue(_volume),
                unit: 'cm³',
                color: const Color(0xFF8B5CF6),
                icon: Icons.view_in_ar_rounded,
              ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 36),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.change_history_rounded,
                      size: 44,
                      color: AppColors.border,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Masukkan sisi & tinggi lalu tekan Hitung',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
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
