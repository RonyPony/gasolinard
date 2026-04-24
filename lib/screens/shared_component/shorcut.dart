import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Shortcut extends StatelessWidget {
  const Shortcut({
    super.key,
    this.texxt = 'Placeholder',
    required this.value,
    this.icon = Icons.local_gas_station_rounded,
    this.svgAsset,
    this.useExpanded = true,
  });

  final String texxt;
  final String? value;
  final IconData icon;
  final String? svgAsset;
  final bool useExpanded;

  Widget _card() {
    return Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF43F5E).withOpacity(.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 14, color: const Color(0xFFFDA4AF)),
                  const SizedBox(width: 5),
                  const Text(
                    'RD',
                    style: TextStyle(
                      color: Color(0xFFFDA4AF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.92, end: 1),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutBack,
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: svgAsset != null
                ? SvgPicture.asset(svgAsset!, height: 54)
                : Image.asset('assets/fuel1.png', height: 54),
          ),
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
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final card = _card();
    if (useExpanded) {
      return Expanded(child: card);
    }
    return card;
  }
}
