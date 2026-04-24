import 'package:flutter/material.dart';
import 'package:gasolinard/screens/shared_component/textAnimation.dart';

class CustomCardPromo extends StatelessWidget {
  const CustomCardPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmall = constraints.maxWidth < 350;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0B1220), Color(0xFF172554), Color(0xFF1E293B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFF38BDF8).withOpacity(.35)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 16,
                offset: Offset(0, 7),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Flex(
            direction: isSmall ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isSmall
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: isSmall ? 0 : 3,
                child: Column(
                  crossAxisAlignment: isSmall
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.auto_awesome,
                          color: Color(0xFF38BDF8),
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Actualizado cada semana',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const ChangingTextWidget(),
                    const SizedBox(height: 4),
                    const Text(
                      'Del pueblo y para el pueblo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0EA5E9), Color(0xFF6366F1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.flag_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'REPÚBLICA DOMINICANA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: .4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isSmall) const SizedBox(width: 12),
              Padding(
                padding: EdgeInsets.only(top: isSmall ? 10 : 0),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: .95, end: 1),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Image.asset(
                    'assets/fuel1.png',
                    scale: isSmall ? 5 : 4.2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
