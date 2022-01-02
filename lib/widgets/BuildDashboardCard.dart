import 'package:activity_tracker/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildDashboardCard extends StatefulWidget {
  final String stepCount;
  final double stepProgres;

  const BuildDashboardCard({
    Key? key,
    required this.stepCount,
    required this.stepProgres,
  }) : super(key: key);

  @override
  BuildDashboardCardState createState() => BuildDashboardCardState();
}

class BuildDashboardCardState extends State<BuildDashboardCard> {
  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? BuildMobileView(
            title: 'Пройдено шагов',
            counterValue: '${widget.stepCount} / 10 000',
            progressPercent: widget.stepProgres,
            cardBackground: const Color(0xFFC0CAFF).withOpacity(.1),
            progressBackgroundColor: const Color(0xFF1E42FF).withOpacity(.2),
            progressValueColor: const Color(0xFF1E42FF),
            iconBackgroundColor: const Color(0xFF1E42FF).withOpacity(.05),
            icon: Image.asset('assets/step_icon.png', scale: 4),
          )
        : BuildWatchView(
            title: 'Пройдено шагов',
            counterValue: '${widget.stepCount} / 10 000',
            progressPercent: widget.stepProgres,
            cardBackground: const Color(0xFFC0CAFF).withOpacity(.1),
            progressBackgroundColor: const Color(0xFF1E42FF).withOpacity(.2),
            progressValueColor: const Color(0xFF1E42FF),
            iconBackgroundColor: const Color(0xFF1E42FF).withOpacity(.05),
            icon: Image.asset('assets/step_icon.png', scale: 6),
          );
  }
}

class BuildMobileView extends StatelessWidget {
  final String title;
  final String counterValue;
  final double progressPercent;
  final Color cardBackground;
  final Color iconBackgroundColor;
  final Color progressBackgroundColor;
  final Color progressValueColor;
  final Image icon;

  const BuildMobileView({
    Key? key,
    required this.title,
    required this.counterValue,
    required this.progressPercent,
    required this.cardBackground,
    required this.iconBackgroundColor,
    required this.progressBackgroundColor,
    required this.progressValueColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(65, 9, 22, 0),
                  width: sizeW * .9,
                  height: 66,
                  color: cardBackground,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTitle(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildCounter(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildProgressIndicator(),
                    ],
                  ),
                ),
              ),
              _buildIcon(),
            ],
          ),
        ),
      ],
    );
  }

  Text _buildTitle() {
    return Text(
      title,
      style: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: .2,
        height: 1,
      ),
    );
  }

  Container _buildCounter() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        counterValue,
        style: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: .1,
          height: .6,
        ),
      ),
    );
  }

  Container _buildProgressIndicator() {
    return Container(
      height: 7,
      decoration: BoxDecoration(
        color: progressBackgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: progressPercent,
          child: Container(
            height: 7,
            decoration: BoxDecoration(
              color: progressValueColor,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildIcon() {
    return Positioned(
      top: -10,
      left: -30,
      child: Row(
        children: [
          ClipOval(
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              color: iconBackgroundColor,
              width: 81,
              height: 85,
              child: icon,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildWatchView extends StatelessWidget {
  final String title;
  final String counterValue;
  final double progressPercent;
  final Color cardBackground;
  final Color iconBackgroundColor;
  final Color progressBackgroundColor;
  final Color progressValueColor;
  final Image icon;

  const BuildWatchView({
    Key? key,
    required this.title,
    required this.counterValue,
    required this.progressPercent,
    required this.cardBackground,
    required this.iconBackgroundColor,
    required this.progressBackgroundColor,
    required this.progressValueColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                height: 90,
                color: cardBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTitle(),
                    _buildCounter(),
                    const SizedBox(height: 10),
                    _buildProgressIndicator(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Expanded _buildTitle() {
    return Expanded(
      flex: 2,
      child: Row(
        children: [
          icon,
          const SizedBox(width: 5),
          Text(
            'Пройдено шагов',
            style: GoogleFonts.roboto(
              color: const Color(0xFF1E42FF),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: .2,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildCounter() {
    return Expanded(
      flex: 1,
      child: Text(
        counterValue,
        style: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Container _buildProgressIndicator() {
    return Container(
      height: 7,
      decoration: BoxDecoration(
        color: progressBackgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: progressPercent,
          heightFactor: 1,
          child: Container(
            height: 7,
            decoration: BoxDecoration(
              color: progressValueColor,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}
