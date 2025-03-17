import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(FocusTimerApp());
}

class FocusTimerApp extends StatelessWidget {
  const FocusTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FocusTimerHome(),
    );
  }
}

class FocusTimerHome extends StatefulWidget {
  const FocusTimerHome({super.key});

  @override
  _FocusTimerHomeState createState() => _FocusTimerHomeState();
}

class _FocusTimerHomeState extends State<FocusTimerHome> {
  int _remainingTime = 1500; // Default 25 min
  final int _totalTime = 1500;
  Timer? _timer;
  bool _isRunning = false;

  void _startTimer() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _isRunning = false;
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
  }

  void _resetTimer() {
    _timer?.cancel();
    _isRunning = false;
    setState(() {
      _remainingTime = 1500; // Reset to 25 min
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = (1 - _remainingTime / _totalTime).clamp(0.0, 1.0);
    return Scaffold(
      appBar: AppBar(title: Text("Focus Timer")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                LinearProgressIndicator(value: progress, minHeight: 10),
                SizedBox(height: 10),
                Text(
                  "You have studied ${(progress * 25).toStringAsFixed(1)} minutes",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
          Text(
            "${(_remainingTime ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime % 60).toString().padLeft(2, '0')}",
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: _startTimer, child: Text("Start")),
              SizedBox(width: 10),
              ElevatedButton(onPressed: _pauseTimer, child: Text("Pause")),
              SizedBox(width: 10),
              ElevatedButton(onPressed: _resetTimer, child: Text("Reset")),
            ],
          ),
        ],
      ),
    );
  }
}
