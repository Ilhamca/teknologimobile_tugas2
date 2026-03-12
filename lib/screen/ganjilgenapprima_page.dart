import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';
import 'package:teknologimobile_tugas2/theme/app_color.dart';

class GanjilGenapPrimaPage extends StatefulWidget {
  const GanjilGenapPrimaPage({super.key, required this.username});
  final String username;

  @override
  State<GanjilGenapPrimaPage> createState() => _GanjilGenapPrimaPageState();
}

class _GanjilGenapPrimaPageState extends State<GanjilGenapPrimaPage> {
  final TextEditingController _analysisNumberController = TextEditingController();

  String? _parityResult;
  String? _primeResult;
  String? _analysisError;
  int? _lastCheckedNumber;

  @override
  void dispose() {
    _analysisNumberController.dispose();
    super.dispose();
  }

  void _analyzeNumber() {
    final number = int.tryParse(_analysisNumberController.text.trim());

    if (number == null) {
      setState(() {
        _analysisError = 'Masukkan bilangan bulat yang valid.';
        _parityResult = null;
        _primeResult = null;
        _lastCheckedNumber = null;
      });
      return;
    }

    setState(() {
      _analysisError = null;
      _lastCheckedNumber = number;
      _parityResult = number.isEven ? 'Genap' : 'Ganjil';
      _primeResult = _isPrime(number) ? 'Bilangan Prima' : 'Bukan Prima';
    });
  }

  bool _isPrime(int number) {
    if (number < 2) return false;
    for (var divisor = 2; divisor * divisor <= number; divisor++) {
      if (number % divisor == 0) return false;
    }
    return true;
  }

  void _resetForm() {
    setState(() {
      _analysisNumberController.clear();
      _parityResult = null;
      _primeResult = null;
      _analysisError = null;
      _lastCheckedNumber = null;
    });
  }

  // Widget kartu hasil satu kategori
  Widget _buildResultCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
    required bool isPositive,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasResult = _parityResult != null;
    final bool isEven = _parityResult == 'Genap';
    final bool isPrime = _primeResult == 'Bilangan Prima';

    return Scaffold(
      appBar: AppBar(title: const Text('Cek Bilangan')),
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Ganjil/Genap/Prima',
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
                  colors: [AppColors.warning, Color(0xFFD97706)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(Icons.functions_rounded, color: Colors.white, size: 32),
                  SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cek Bilangan',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Ganjil / Genap / Prima',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Masukkan Bilangan',
              style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _analysisNumberController,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Contoh: 7, 12, 100...',
                hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                prefixIcon: const Icon(Icons.tag_rounded, color: AppColors.warning),
                errorText: _analysisError,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _analyzeNumber,
                    icon: const Icon(Icons.search_rounded),
                    label: const Text('Cek Bilangan'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.warning),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _resetForm,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Reset'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.warning,
                      side: const BorderSide(color: AppColors.warning),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Tampilan hasil
            if (hasResult) ...[
              // Angka yang dicek
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Hasil untuk angka',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$_lastCheckedNumber',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Dua kartu hasil berdampingan
              Row(
                children: [
                  _buildResultCard(
                    title: 'Jenis Bilangan',
                    value: _parityResult!,
                    color: isEven ? AppColors.primary : AppColors.accent,
                    icon: isEven ? Icons.looks_two_rounded : Icons.looks_one_rounded,
                    isPositive: true,
                  ),
                  const SizedBox(width: 12),
                  _buildResultCard(
                    title: 'Status Prima',
                    value: _primeResult!,
                    color: isPrime ? AppColors.success : AppColors.textSecondary,
                    icon: isPrime ? Icons.star_rounded : Icons.star_border_rounded,
                    isPositive: isPrime,
                  ),
                ],
              ),

              // Penjelasan singkat
              if (_lastCheckedNumber != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb_outline_rounded, color: AppColors.warning, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _buildExplanation(_lastCheckedNumber!),
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                    Icon(Icons.search_rounded, size: 40, color: AppColors.border),
                    SizedBox(height: 8),
                    Text(
                      'Masukkan angka lalu tekan Cek',
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

  String _buildExplanation(int n) {
    final parityExplain = n.isEven
        ? '$n habis dibagi 2, sehingga termasuk bilangan genap.'
        : '$n tidak habis dibagi 2, sehingga termasuk bilangan ganjil.';
    final primeExplain = _isPrime(n)
        ? '$n hanya bisa dibagi 1 dan dirinya sendiri, sehingga merupakan bilangan prima.'
        : n < 2
            ? '$n kurang dari 2, bukan bilangan prima.'
            : '$n memiliki faktor selain 1 dan dirinya, sehingga bukan bilangan prima.';
    return '$parityExplain\n$primeExplain';
  }
}
