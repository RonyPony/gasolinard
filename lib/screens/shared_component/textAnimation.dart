import 'package:flutter/material.dart';
import 'dart:async';

class ChangingTextWidget extends StatefulWidget {
  @override
  _ChangingTextWidgetState createState() => _ChangingTextWidgetState();
}

class _ChangingTextWidgetState extends State<ChangingTextWidget> {
  final List<String> _words = [
    "CONFIABLE",
    "SEGURA",
    "PRECISA",
    "SIMPLE",
    "RÁPIDA",
    "EFICIENTE",
    "ACCESIBLE"
  ];
  String _text = "SOMOS...";
  late Timer _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 750), (Timer timer) {
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
    Size baseSize = MediaQuery.of(context).size;
    return SizedBox(
      width: baseSize.width * .5, // Ajusta el ancho según sea necesario
      child: Text(
        _text,
        style: TextStyle(fontSize: 35, color: Colors.white),
      ),
    );
  }
}
