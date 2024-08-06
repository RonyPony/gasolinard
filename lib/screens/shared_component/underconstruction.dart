import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnderConstructionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.string(
            '''
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100" height="100">
              <rect width="100" height="100" fill="#FFD700"/>
              <polygon points="20,80 50,20 80,80" fill="#000"/>
              <text x="50" y="90" font-family="Arial" font-size="10" text-anchor="middle" fill="#000">UNDER CONSTRUCTION</text>
            </svg>
            ''',
            height: 150.0,
          ),
          SizedBox(height: 20),
          Text(
            'Esta pantalla no está lista aún.',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Estamos trabajando para mejorarla.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
