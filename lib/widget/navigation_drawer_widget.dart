import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/screen/calculator_page.dart';
import 'package:teknologimobile_tugas2/screen/ganjilgenapprima_page.dart';
import 'package:teknologimobile_tugas2/screen/menu_page.dart';
import 'package:teknologimobile_tugas2/screen/rumuspiramid_page.dart';
import 'package:teknologimobile_tugas2/screen/stopwatch_page.dart';
import 'package:teknologimobile_tugas2/screen/totalangka_page.dart';
import 'package:teknologimobile_tugas2/theme/app_color.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({
    super.key,
    required this.username,
    required this.currentPage,
  });

  final String username;
  final String currentPage;

  // Data menu: nama, ikon, rute, warna
  static const List<Map<String, dynamic>> _menuItems = [
    {'label': 'Data Kelompok',      'icon': Icons.group_rounded,          'page': 'Data Kelompok'},
    {'label': 'Calculator',         'icon': Icons.calculate_rounded,       'page': 'Calculator'},
    {'label': 'Ganjil/Genap/Prima', 'icon': Icons.functions_rounded,       'page': 'Ganjil/Genap/Prima'},
    {'label': 'Stopwatch',          'icon': Icons.timer_rounded,           'page': 'Stopwatch'},
    {'label': 'Total Angka',        'icon': Icons.add_chart_rounded,       'page': 'Total Angka'},
    {'label': 'Rumus Piramid',      'icon': Icons.change_history_rounded,  'page': 'Rumus Piramid'},
  ];

  WidgetBuilder _getPageBuilder(String pageName) {
    switch (pageName) {
      case 'Data Kelompok':
        return (ctx) => MenuPage(username: username);
      case 'Calculator':
        return (ctx) => CalculatorPage(username: username);
      case 'Ganjil/Genap/Prima':
        return (ctx) => GanjilGenapPrimaPage(username: username);
      case 'Stopwatch':
        return (ctx) => StopwatchPage(username: username);
      case 'Total Angka':
        return (ctx) => TotalangkaPage(username: username);
      case 'Rumus Piramid':
        return (ctx) => RumusPiramidPage(username: username);
      default:
        return (ctx) => MenuPage(username: username);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Header drawer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Halo, $username! 👋',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Teknologi dan Pemrogaman Mobile',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // List menu navigasi
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  final String label = item['label'] as String;
                  final IconData icon = item['icon'] as IconData;
                  final bool isActive = currentPage == label;
                  final Color color = AppColors.menuColors[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      color: isActive ? color.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isActive ? color.withOpacity(0.15) : AppColors.bg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(icon, color: isActive ? color : AppColors.textSecondary, size: 22),
                      ),
                      title: Text(
                        label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                          color: isActive ? color : AppColors.textPrimary,
                        ),
                      ),
                      trailing: isActive
                          ? Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            )
                          : null,
                      onTap: isActive
                          ? null
                          : () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: _getPageBuilder(label)),
                              );
                            },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
