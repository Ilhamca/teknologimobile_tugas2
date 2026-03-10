import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';


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
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Data Kelompok',
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
