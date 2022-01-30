import 'package:activity_tracker/models/bottom_nav_bar_page_index_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BuildBottomNavBar extends StatefulWidget {
  final int pageIndexPage;
  const BuildBottomNavBar({
    Key? key,
    required this.pageIndexPage,
  }) : super(key: key);

  @override
  _BuildBottomNavBarState createState() => _BuildBottomNavBarState();
}

class _BuildBottomNavBarState extends State<BuildBottomNavBar> {
  int pageIndex = 0;
  @override
  void initState() {
    pageIndex = widget.pageIndexPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<BottomNavBarPageIndexModel>(context, listen: false);
    final sizeW = MediaQuery.of(context).size.width;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Padding(
        /// out container
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: Container(
          width: sizeW,

          /// inside container
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFABABAB).withOpacity(.3),
                offset: Offset.zero,
                blurRadius: 15,
              ),
            ],
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  enableFeedback: true,
                  splashRadius: .1,
                  onPressed: () {
                    setState(() {
                      provider.getBottomNavBarPageIndex(0);
                      pageIndex = 0;
                    });
                  },
                  icon: SvgPicture.asset(
                    'assets/home.svg',
                    color: pageIndex == 0
                        ? const Color(0xFF4758FF)
                        : const Color(0xFF323232),
                  )),
              IconButton(
                  enableFeedback: true,
                  splashRadius: .1,
                  onPressed: () {
                    setState(() {
                      provider.getBottomNavBarPageIndex(1);
                      pageIndex = 1;
                    });
                  },
                  icon: SvgPicture.asset(
                    'assets/map.svg',
                    color: pageIndex == 1
                        ? const Color(0xFF4758FF)
                        : const Color(0xFF323232),
                  )),
              IconButton(
                  enableFeedback: true,
                  splashRadius: .1,
                  onPressed: () {
                    setState(() {
                      provider.getBottomNavBarPageIndex(2);
                      pageIndex = 2;
                    });
                  },
                  icon: SvgPicture.asset(
                    'assets/bar_code.svg',
                    color: pageIndex == 2
                        ? const Color(0xFF4758FF)
                        : const Color(0xFF323232),
                  )),
              IconButton(
                  enableFeedback: true,
                  splashRadius: .1,
                  onPressed: () {
                    setState(() {
                      provider.getBottomNavBarPageIndex(3);
                      pageIndex = 3;
                    });
                  },
                  icon: SvgPicture.asset(
                    'assets/community.svg',
                    color: pageIndex == 3
                        ? const Color(0xFF4758FF)
                        : const Color(0xFF323232),
                  )),
              IconButton(
                enableFeedback: true,
                splashRadius: .1,
                onPressed: () {
                  setState(() {
                    provider.getBottomNavBarPageIndex(4);
                    pageIndex = 4;
                  });
                },
                icon: SvgPicture.asset(
                  'assets/profile.svg',
                  color: pageIndex == 4
                      ? const Color(0xFF4758FF)
                      : const Color(0xFF323232),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
