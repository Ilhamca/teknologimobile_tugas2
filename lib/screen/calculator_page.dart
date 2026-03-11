import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';

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
    if (value == null) {
      return '-';
    }

    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Calculator',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Penjumlahan dan Pengurangan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan dua angka untuk menghitung hasil tambah dan kurang.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _firstNumberController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Angka pertama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _secondNumberController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: InputDecoration(
                labelText: 'Angka kedua',
                border: const OutlineInputBorder(),
                errorText: _calculationError,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculateResults,
                    child: const Text('Hitung'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetCalculator,
                    child: const Text('Reset Semua'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hasil penjumlahan: ${_formatNumber(_additionResult)}',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Hasil pengurangan: ${_formatNumber(_subtractionResult)}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
