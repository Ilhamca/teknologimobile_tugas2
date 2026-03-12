import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';
import 'package:teknologimobile_tugas2/theme/app_color.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key, required this.username});
  final String username;

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch stopwatch = Stopwatch();
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startStopwatch() {
    if (stopwatch.isRunning) return;
    stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (mounted) setState(() {});
    });
    setState(() {});
  }

  void _stopStopwatch() {
    stopwatch.stop();
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  void _resetStopwatch() {
    stopwatch
      ..stop()
      ..reset();
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  String _formatElapsedTime() {
    final elapsed = stopwatch.elapsed;
    final minutes = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    final centiseconds = (elapsed.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(2, '0');
    return '$minutes:$seconds.$centiseconds';
  }

  // Tombol bulat stopwatch
  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required Color color,
    bool isBig = false,
  }) {
    final double size = isBig ? 72.0 : 56.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: onPressed == null ? Colors.grey.shade200 : color.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: onPressed == null ? Colors.grey.shade300 : color,
                width: isBig ? 2.5 : 1.5,
              ),
            ),
            child: Icon(
              icon,
              color: onPressed == null ? Colors.grey.shade400 : color,
              size: isBig ? 32 : 24,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: onPressed == null ? Colors.grey.shade400 : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isRunning = stopwatch.isRunning;
    final bool hasTime = stopwatch.elapsed.inMilliseconds > 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch')),
      drawer: NavigationDrawerWidget(
        username: widget.username,
        currentPage: 'Stopwatch',
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lingkaran besar timer
              Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: (isRunning ? AppColors.error : AppColors.primary).withOpacity(0.15),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                  border: Border.all(
                    color: isRunning ? AppColors.error : AppColors.primary,
                    width: 3,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Dot indikator berjalan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isRunning ? AppColors.error : (hasTime ? AppColors.warning : AppColors.border),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isRunning ? 'Berjalan' : (hasTime ? 'Berhenti' : 'Siap'),
                          style: TextStyle(
                            fontSize: 12,
                            color: isRunning ? AppColors.error : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Tampilan waktu
                    Text(
                      _formatElapsedTime(),
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: isRunning ? AppColors.error : AppColors.textPrimary,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'MM : SS . cs',
                      style: TextStyle(fontSize: 10, color: AppColors.textSecondary, letterSpacing: 3),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Tombol kontrol
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildControlButton(
                    icon: Icons.refresh_rounded,
                    label: 'Reset',
                    onPressed: hasTime ? _resetStopwatch : null,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 28),
                  _buildControlButton(
                    icon: isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    label: isRunning ? 'Pause' : 'Start',
                    onPressed: isRunning ? _stopStopwatch : _startStopwatch,
                    color: isRunning ? AppColors.error : AppColors.success,
                    isBig: true,
                  ),
                  const SizedBox(width: 28),
                  // Placeholder tombol ketiga (simetri)
                  const SizedBox(width: 56),
                ],
              ),

              const SizedBox(height: 32),

              // Info hint
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline_rounded, color: AppColors.textSecondary, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Tekan Start untuk memulai stopwatch',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
