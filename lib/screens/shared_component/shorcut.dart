import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shortcut extends StatefulWidget {
  const Shortcut({super.key, this.texxt = "Placeholder", required this.value});
  final String texxt;
  final double value;
  @override
  State<StatefulWidget> createState() => _createState();
}

class _createState extends State<Shortcut> {
  @override
  Widget build(BuildContext context) {
    Size baseSize = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: baseSize.width * .37,
          height: baseSize.height * .23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: const Color(0xff353535),
          ),
          padding: const EdgeInsets.only(
            left: 13,
            right: 12,
            bottom: 17,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 77,
                height: 78,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset("assets/fuel1.png"),
              ),
              SizedBox(height: 0.50),
              Text(
                widget.value.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                ),
              ),
              SizedBox(height: 0.50),
              Text(
                widget.texxt,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
