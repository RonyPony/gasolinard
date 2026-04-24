import 'package:flutter/material.dart';

class Shortcut extends StatelessWidget {
  const Shortcut({
    super.key,
    this.texxt = 'Placeholder',
    required this.value,
  });

  final String texxt;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 188,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF1F2937), Color(0xFF111827)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF43F5E).withOpacity(.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'RD',
                  style: TextStyle(
                    color: Color(0xFFFDA4AF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Image.asset('assets/fuel1.png', height: 54),
            Text(
              value ?? '--',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              texxt,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
