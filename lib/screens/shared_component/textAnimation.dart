import 'dart:async';

import 'package:flutter/material.dart';

class ChangingTextWidget extends StatefulWidget {
  const ChangingTextWidget({super.key});

  @override
  State<ChangingTextWidget> createState() => _ChangingTextWidgetState();
}

class _ChangingTextWidgetState extends State<ChangingTextWidget> {
  final List<String> _words = [
    'CONFIABLE',
    'SEGURA',
    'PRECISA',
    'SIMPLE',
    'RÁPIDA',
    'EFICIENTE',
    'ACCESIBLE'
  ];
  String _text = 'SOMOS...';
  late Timer _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 750), (Timer timer) {
      setState(() {
        _text = _words[_index];
        _index = (_index + 1) % _words.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(
        _text,
        style: const TextStyle(
          fontSize: 34,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: .8,
        ),
      ),
    );
  }
}
