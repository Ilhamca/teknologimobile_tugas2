import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';

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
      });
      return;
    }

    setState(() {
      _analysisError = null;
      _parityResult = number.isEven ? 'Genap' : 'Ganjil';
      _primeResult = _isPrime(number) ? 'Bilangan prima' : 'Bukan bilangan prima';
    });
  }

  bool _isPrime(int number) {
    if (number < 2) {
      return false;
    }

    for (var divisor = 2; divisor * divisor <= number; divisor++) {
      if (number % divisor == 0) {
        return false;
      }
    }

    return true;
  }

  void _resetForm() {
    setState(() {
      _analysisNumberController.clear();
      _parityResult = null;
      _primeResult = null;
      _analysisError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ganjil, Genap, dan Prima')),
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Ganjil/Genap/Prima',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cek Ganjil, Genap, dan Prima',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Masukkan satu bilangan bulat untuk mengetahui jenis bilangannya.'),
            const SizedBox(height: 16),
            TextField(
              controller: _analysisNumberController,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              decoration: InputDecoration(
                labelText: 'Input bilangan',
                border: const OutlineInputBorder(),
                errorText: _analysisError,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _analyzeNumber,
                    child: const Text('Cek Bilangan'),
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
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jenis bilangan: ${_parityResult ?? '-'}'),
                    const SizedBox(height: 8),
                    Text('Status prima: ${_primeResult ?? '-'}'),
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