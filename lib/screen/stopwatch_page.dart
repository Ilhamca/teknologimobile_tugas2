import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/widget/navigation_drawer_widget.dart';

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
    if (stopwatch.isRunning) {
      return;
    }

    stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (mounted) {
        setState(() {});
      }
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
    final centiseconds = (elapsed.inMilliseconds.remainder(1000) ~/ 10)
        .toString()
        .padLeft(2, '0');

    return '$minutes:$seconds:$centiseconds';
  }

  @override
  Widget build(BuildContext context) {
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
              const Text(
                'Simple Stopwatch',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Text(
                _formatElapsedTime(),
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: stopwatch.isRunning ? null : _startStopwatch,
                    child: const Text('Start'),
                  ),
                  ElevatedButton(
                    onPressed: stopwatch.isRunning ? _stopStopwatch : null,
                    child: const Text('Stop'),
                  ),
                  ElevatedButton(
                    onPressed: _resetStopwatch,
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
