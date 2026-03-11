import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';

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
      });
      return;
    }

    final parts = rawInput.split(RegExp(r'[,\s]+'));
    double sum = 0;

    for (final part in parts) {
      if (part.isEmpty) {
        continue;
      }

      final parsed = double.tryParse(part);
      if (parsed == null) {
        setState(() {
          _errorText =
              'Input tidak valid. Gunakan angka yang dipisahkan koma atau spasi.';
        });
        return;
      }

      sum += parsed;
    }

    setState(() {
      _total = sum;
      _errorText = null;
    });
  }

  void _resetForm() {
    setState(() {
      _numbersController.clear();
      _total = 0;
      _errorText = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Total Angka')),
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Total Angka',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jumlah Total Angka',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan beberapa angka, lalu pisahkan dengan koma atau spasi.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _numbersController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Input angka',
                hintText: 'Contoh: 10, 20, 30 atau 10 20 30',
                border: const OutlineInputBorder(),
                errorText: _errorText,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculateTotal,
                    child: const Text('Hitung Total'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _resetForm,
                    child: const Text('Reset'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _total % 1 == 0
                          ? _total.toInt().toString()
                          : _total.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
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
