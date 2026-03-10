import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/screen/calculator_page.dart';
import 'package:teknologimobile_tugas2/screen/stopwatch_page.dart';
import 'package:teknologimobile_tugas2/screen/totalangka_page.dart';
import 'package:teknologimobile_tugas2/screen/rumuspiramid_page.dart';


class MenuPage extends StatefulWidget {
  const MenuPage({super.key, required this.username});

  final String username;

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final List<Map<String, String>> _peopleDatabase = [
    {'name': 'Ilham Cesario Putra Wippri', 'studentId': '123230106'},
    {'name': 'Farhan Satya Nugraha', 'studentId': '123230126'},
    {'name': 'Dhimas Rizky Maulana Efendi', 'studentId': '123230166'},
  ];

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

  Widget _buildDatabaseTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Student ID')),
        ],
        rows: _peopleDatabase
            .map(
              (person) => DataRow(
                cells: [
                  DataCell(Text(person['name']!)),
                  DataCell(Text(person['studentId']!)),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
      ),
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
                _loginButton('Data Kelompok', (context) => MenuPage(username: widget.username), enabled: false),
                const SizedBox(height: 10),
                _loginButton('Calculator', (context) => CalculatorPage(username: widget.username)),
                const SizedBox(height: 10),
                _loginButton('Stopwatch', (context) => StopwatchPage(username: widget.username)),
                const SizedBox(height: 10),
                _loginButton('Total Angka', (context) => TotalangkaPage(username: widget.username)),
                const SizedBox(height: 10),
                _loginButton('Rumus Piramid', (context) => RumusPiramidPage(username: widget.username)),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'People Database',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('List of people who made this application.'),
            const SizedBox(height: 12),
            Expanded(child: _buildDatabaseTable()),
          ],
        ),
      ),
    );
  }
}
