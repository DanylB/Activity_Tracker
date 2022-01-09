import 'package:activity_tracker/models/bottom_nav_bar_page_index_model.dart';
import 'package:activity_tracker/screens/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:activity_tracker/widgets/export.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var provider =
        Provider.of<BottomNavBarPageIndexModel>(context, listen: false);
    return Scaffold(
      body: PageView(
        controller: provider.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          Scaffold(
            body: MapPage(),
          ),
          Scaffold(
            body: BarCodePage(),
          ),
          Scaffold(
            body: CommunityPage(),
          ),
          Scaffold(
            body: ProfilePage(),
          ),
        ],
      ),
      bottomNavigationBar: BuildBottomNavBar(pageIndexPage: pageIndex),
    );
  }
}
