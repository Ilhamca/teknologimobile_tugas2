import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';
import 'package:teknologimobile_tugas2/theme/app_color.dart';

class TotalangkaPage extends StatefulWidget {
  const TotalangkaPage({super.key, required this.username});
  final String username;

  @override
  State<TotalangkaPage> createState() => _TotalangkaPageState();
}

class _TotalangkaPageState extends State<TotalangkaPage> {
  final TextEditingController _numbersController = TextEditingController();
  double _total = 0;
  String? _errorText;
  bool _hasCalculated = false;
  int _countNumbers = 0;

  @override
  void dispose() {
    _numbersController.dispose();
    super.dispose();
  }

  void _calculateTotal() {
    final rawInput = _numbersController.text.trim();

    if (rawInput.isEmpty) {
      setState(() {
        _total = 0;
        _errorText = 'Masukkan angka terlebih dahulu.';
        _hasCalculated = false;
        _countNumbers = 0;
      });
      return;
    }

    final parts = rawInput.split(RegExp(r'[,\s]+'));
    double sum = 0;
    int count = 0;

    for (final part in parts) {
      if (part.isEmpty) continue;
      final parsed = double.tryParse(part);
      if (parsed == null) {
        setState(() {
          _errorText = 'Input tidak valid. Gunakan angka yang dipisahkan koma atau spasi.';
          _hasCalculated = false;
        });
        return;
      }
      sum += parsed;
      count++;
    }

    setState(() {
      _total = sum;
      _errorText = null;
      _hasCalculated = true;
      _countNumbers = count;
    });
  }

  void _resetForm() {
    setState(() {
      _numbersController.clear();
      _total = 0;
      _errorText = null;
      _hasCalculated = false;
      _countNumbers = 0;
    });
  }

  String _formatTotal(double val) {
    return val % 1 == 0 ? val.toInt().toString() : val.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Total Angka')),
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Total Angka',
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
                  colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(Icons.add_chart_rounded, color: Colors.white, size: 32),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Angka',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Jumlahkan semua angka sekaligus',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Input Angka-angka',
              style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 4),
            const Text(
              'Pisahkan tiap angka dengan koma atau spasi',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _numbersController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Contoh: 10, 20, 30 atau 10 20 30',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 36),
                  child: Icon(Icons.list_rounded, color: Color(0xFF8B5CF6)),
                ),
                errorText: _errorText,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _calculateTotal,
                    icon: const Icon(Icons.functions_rounded),
                    label: const Text('Hitung Total'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
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
                      foregroundColor: const Color(0xFF8B5CF6),
                      side: const BorderSide(color: Color(0xFF8B5CF6)),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Hasil
            if (_hasCalculated) ...[
              // Kartu total besar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Jumlah Total',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatTotal(_total),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$_countNumbers angka dijumlahkan',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // Placeholder
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
                    Icon(Icons.functions_rounded, size: 40, color: AppColors.border),
                    SizedBox(height: 8),
                    Text(
                      'Masukkan angka lalu tekan Hitung Total',
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
