import 'dart:async';
import 'package:flutter/material.dart';


void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreen createState() => _TimerScreen();
}

class _TimerScreen extends State<TimerScreen> {
  late int _inputTime;
  late Duration _duration;
  late Timer _timer;
  bool _isPaused = false;
  bool _isTimeUp = false; 
  bool _isStarted = false; 

  @override
  void initState() {
    super.initState();
    _inputTime = 0;
    _duration = Duration(seconds: 0);
  }


  void _pauseCountdown() {
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeCountdown() {
    setState(() {
      _isPaused = false;
    });
  }

   void _startCountdown() {
    if (_inputTime > 0) {
      _duration = Duration(seconds: _inputTime);
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (!_isPaused) {
          setState(() {
            if (_duration.inSeconds > 0) {
              _duration -= Duration(seconds: 1);
            } else {
              _timer.cancel();
              _isTimeUp = true; 
            }
          });
        }
      });
      _isStarted = true; 
    }
  }

  void _resetCountdown() {
    _timer.cancel();
    setState(() {
      _duration = Duration(seconds: 0);
      _isPaused = false;
      _isTimeUp = false; 
      _isStarted = false; 
    });
  }

  void _restartCountdown() {
    setState(() {
      _inputTime = 0;
      _duration = Duration(seconds: 0);
      _isPaused = false;
      _isTimeUp = false;
      _isStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selamat Datang',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), 
              ),
            Text(
              'Firdha Anugrah Cahyaningtyas',
              style: TextStyle(fontSize: 18),
            ),
            Text(
            '222410102030',
            style: TextStyle(fontSize: 18),
            )
          ],
        ),
        centerTitle: true,

      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Masukkan Waktu (Detik)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _inputTime = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isStarted ? null : _startCountdown,
              child: Text('Mulai'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue[600],
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      _isTimeUp
                          ? 'Waktu Habis!'
                          : '${_duration.inHours.toString().padLeft(2, '0')}:${(_duration.inMinutes % 60).toString().padLeft(2, '0')}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: _isTimeUp ? 20 : 48,
                        color: _isTimeUp ? Colors.red : Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_isTimeUp)
                      ElevatedButton(
                        onPressed: _restartCountdown,
                        child: Text('Mulai Ulang'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.blue[600],
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: _isPaused ? _resumeCountdown : _pauseCountdown,
                            child: Text(_isPaused ? 'Mulai Ulang' : 'Jeda'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.blueGrey[300],
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _resetCountdown,
                            child: Text('Berhenti'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.pink[500],
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                        ],
                      ),
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
