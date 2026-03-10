import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';

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
    if (value == null) {
      return '-';
    }

    return value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(2);
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hitung Luas dan Volume Piramid',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Masukkan sisi alas dan tinggi untuk piramid segi empat.'),
            const SizedBox(height: 16),
            TextField(
              controller: _sideController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Sisi alas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _heightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Tinggi',
                border: const OutlineInputBorder(),
                errorText: _errorText,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculatePyramid,
                    child: const Text('Hitung'),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hasil Perhitungan',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    Text('Luas permukaan: ${_formatValue(_surfaceArea)}'),
                    const SizedBox(height: 8),
                    Text('Volume: ${_formatValue(_volume)}'),
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