import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/screen/calculator_page.dart';
import 'package:teknologimobile_tugas2/screen/totalangka_page.dart';
import 'package:teknologimobile_tugas2/screen/rumuspiramid_page.dart';
import 'package:teknologimobile_tugas2/screen/menu_page.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key, required this.username});
  final String username;

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
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
      appBar: AppBar(title: const Text('Stopwatch')),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${widget.username}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _loginButton('Data Kelompok', (context) => MenuPage(username: widget.username)),
                const SizedBox(height: 10),
                _loginButton('Calculator', (context) => CalculatorPage(username: widget.username)),
                const SizedBox(height: 10),
                _loginButton('Stopwatch', (context) => StopwatchPage(username: widget.username), enabled: false),
                const SizedBox(height: 10),
                _loginButton('Total Angka', (context) => TotalangkaPage(username: widget.username)),
                const SizedBox(height: 10),
                _loginButton('Rumus Piramid', (context) => RumusPiramidPage(username: widget.username)),
              ],
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Stopwatch Page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}