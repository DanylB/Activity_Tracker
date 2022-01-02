import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({
    Key? key,
    required this.sizeW,
  }) : super(key: key);

  final double sizeW;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(
                width: sizeW,
                height: 150,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0078FF),
                      Color(0xFF4D2DCA),
                      Color(0xFF6119BC),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: Text(
              'Activity Tracker',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
