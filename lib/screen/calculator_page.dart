import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/screen/stopwatch_page.dart';
import 'package:teknologimobile_tugas2/screen/totalangka_page.dart';
import 'package:teknologimobile_tugas2/screen/rumuspiramid_page.dart';
import 'package:teknologimobile_tugas2/screen/menu_page.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key, required this.username});
  final String username;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  Widget _loginButton(String pageName, WidgetBuilder pageBuilder, {bool enabled = true}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: enabled ? Colors.grey : Colors.grey.shade300,
      ),
      onPressed: enabled
          ? () {
              Navigator.pop(context); // close the drawer
              Navigator.push(context, MaterialPageRoute(builder: pageBuilder));
            }
          : null,
      child: Text(pageName, style: TextStyle(color: enabled ? Colors.black : Colors.black38)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Menu')),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello ${widget.username}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _loginButton(
                  'Data Kelompok',
                  (context) => MenuPage(username: widget.username),
                ),
                const SizedBox(height: 16),
                _loginButton(
                  'Calculator',
                  (context) => CalculatorPage(username: widget.username),
                  enabled: false,
                ),
                const SizedBox(height: 10),
                _loginButton(
                  'Stopwatch',
                  (context) => StopwatchPage(username: widget.username),
                ),
                const SizedBox(height: 10),
                _loginButton(
                  'Total Angka',
                  (context) => TotalangkaPage(username: widget.username),
                ),
                const SizedBox(height: 10),
                _loginButton(
                  'Rumus Piramid',
                  (context) => RumusPiramidPage(username: widget.username),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
