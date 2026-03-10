import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/screen/calculator_page.dart';
import 'package:teknologimobile_tugas2/screen/ganjilgenapprima_page.dart';
import 'package:teknologimobile_tugas2/screen/menu_page.dart';
import 'package:teknologimobile_tugas2/screen/rumuspiramid_page.dart';
import 'package:teknologimobile_tugas2/screen/stopwatch_page.dart';
import 'package:teknologimobile_tugas2/screen/totalangka_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({
    super.key,
    required this.username,
    required this.currentPage,
  });

  final String username;
  final String currentPage;

  Widget _navButton(
    BuildContext context,
    String pageName,
    WidgetBuilder pageBuilder, {
    bool enabled = true,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: enabled ? Colors.grey : Colors.grey.shade300,
      ),
      onPressed: enabled
          ? () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: pageBuilder));
            }
          : null,
      child: Text(
        pageName,
        style: TextStyle(color: enabled ? Colors.black : Colors.black38),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $username',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _navButton(
                context,
                'Data Kelompok',
                (context) => MenuPage(username: username),
                enabled: currentPage != 'Data Kelompok',
              ),
              const SizedBox(height: 10),
              _navButton(
                context,
                'Calculator',
                (context) => CalculatorPage(username: username),
                enabled: currentPage != 'Calculator',
              ),
              const SizedBox(height: 10),
              _navButton(
                context,
                'Ganjil/Genap/Prima',
                (context) => GanjilGenapPrimaPage(username: username),
                enabled: currentPage != 'Ganjil/Genap/Prima',
              ),
              const SizedBox(height: 10),
              _navButton(
                context,
                'Stopwatch',
                (context) => StopwatchPage(username: username),
                enabled: currentPage != 'Stopwatch',
              ),
              const SizedBox(height: 10),
              _navButton(
                context,
                'Total Angka',
                (context) => TotalangkaPage(username: username),
                enabled: currentPage != 'Total Angka',
              ),
              const SizedBox(height: 10),
              _navButton(
                context,
                'Rumus Piramid',
                (context) => RumusPiramidPage(username: username),
                enabled: currentPage != 'Rumus Piramid',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
