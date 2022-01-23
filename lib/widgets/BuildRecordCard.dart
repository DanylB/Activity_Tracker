import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildRecordCard extends StatelessWidget {
  final double sizeW;
  final String svgIconPath;
  final String title;
  final String value;

  const BuildRecordCard({
    Key? key,
    required this.sizeW,
    required this.svgIconPath,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: sizeW,
        height: 75,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF808080).withOpacity(.25),
                blurRadius: 12,
                spreadRadius: -2,
                offset: Offset(0, 4),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(svgIconPath),
                SizedBox(width: 10),
                Text(
                  value,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Text(
              title,
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF808080),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
