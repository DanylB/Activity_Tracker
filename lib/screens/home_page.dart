// import 'package:activity_tracker/logic/google_login.dart';
import 'package:activity_tracker/models/google_fit_data_model.dart';
import 'package:activity_tracker/widgets/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    var provider = Provider.of<GoogleFitDataModel>(context, listen: false);

    provider.getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;
    TabController tabController = TabController(length: 4, vsync: this);
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      await Future.delayed(Duration(milliseconds: 500));
      _refreshController.refreshCompleted();
    }

    void _onLoading() async {
      var provider = Provider.of<GoogleFitDataModel>(context, listen: false);
      provider.getData();
      // await Future.delayed(Duration(milliseconds: 500));
      _refreshController.loadComplete();
    }

    final provider = Provider.of<GoogleFitDataModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(height: sizeH),
          BuildAppBar(sizeW: sizeW),
          Positioned(
            top: 100,
            child: Container(
              padding: const EdgeInsets.fromLTRB(22, 90, 22, 0),
              width: sizeW,
              height: sizeH * .8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            child: Column(
              children: [
                _buildTabBar(sizeW, tabController),
                SizedBox(
                  height: sizeH,
                  width: sizeW,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      SmartRefresher(
                        child: _buildReviewTab(provider, context),
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: true,
                        // header: WaterDropHeader(),
                        header: ClassicHeader(),
                        // header: WaterDropMaterialHeader(),
                        onRefresh: _onRefresh,
                        onLoading: _onLoading,
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text('Ходьба'),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text('Калории'),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text('Сон'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildReviewTab(GoogleFitDataModel provider, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
      child: CustomScrollView(
        primary: false,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              _buildStepCard(provider),
              const SizedBox(height: 22),
              _buildDistanseCard(provider),
              const SizedBox(height: 22),
              _buildCaloriesCard(provider),
              const SizedBox(height: 22),
              _buildActivityTimeCard(provider),
              const SizedBox(height: 22),
              // _buildGetStepDataButton(context),
              // _buildLogoutButton(context),
              const SizedBox(height: 250),
            ]),
          ),
        ],
      ),
    );
  }

  SizedBox _buildTabBar(double sizeW, TabController tabController) {
    return SizedBox(
      height: 80,
      width: sizeW,
      child: TabBar(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        labelPadding: EdgeInsets.zero,
        controller: tabController,
        indicatorColor: Colors.transparent,
        labelColor: const Color(0xFF4A4A4A),
        unselectedLabelColor: const Color(0xFF4A4A4A).withOpacity(.4),
        labelStyle:
            GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold),
        tabs: const [
          Text('Обзор'),
          Text('Ходьба'),
          Text('Калории'),
          Text('Сон'),
        ],
      ),
    );
  }

  // ElevatedButton _buildLogoutButton(BuildContext context) {
  //   return ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       primary: Colors.red,
  //     ),
  //     onPressed: () {
  //       final googleLogoutProvider =
  //           Provider.of<GoogleSignInProvider>(context, listen: false);
  //       googleLogoutProvider.logout();
  //     },
  //     child: const Text('Logout'),
  //   );
  // }

  BuildDashboardCard _buildStepCard(GoogleFitDataModel provider) {
    return BuildDashboardCard(
      title: 'Пройдено шагов',
      counterValue: '${provider.stepCount} / 10 000',
      progressPercent: provider.stepProgress,
      cardBackground: const Color(0xFFC0CAFF).withOpacity(.1),
      progressBackgroundColor: const Color(0xFF1E42FF).withOpacity(.2),
      progressValueColor: const Color(0xFF1E42FF),
      iconBackgroundColor: const Color(0xFF1E42FF).withOpacity(.05),
      icon: 'assets/step_icon.png',
    );
  }

  BuildDashboardCard _buildDistanseCard(GoogleFitDataModel provider) {
    return BuildDashboardCard(
      title: 'Расстояние',
      counterValue: '${provider.distanceCount} км / 20 км',
      progressPercent: provider.distanceProgress,
      cardBackground: const Color(0xFFC9FFE3).withOpacity(.1),
      progressBackgroundColor: const Color(0xFF22C771).withOpacity(.2),
      progressValueColor: const Color(0xFF22C771),
      iconBackgroundColor: const Color(0xFF22C771).withOpacity(.05),
      icon: 'assets/distanse_icon.png',
    );
  }

  BuildDashboardCard _buildCaloriesCard(GoogleFitDataModel provider) {
    return BuildDashboardCard(
      title: 'Сожжено калорий',
      counterValue: '${provider.caloriesCount} кал',
      progressPercent: provider.caloriesProgress,
      cardBackground: const Color(0xFFFFDEE0).withOpacity(.1),
      progressBackgroundColor: const Color(0xFFFF4A55).withOpacity(.2),
      progressValueColor: const Color(0xFFFF4A55),
      iconBackgroundColor: const Color(0xFFFF4A55).withOpacity(.05),
      icon: 'assets/calories_icon.png',
    );
  }

  BuildDashboardCard _buildActivityTimeCard(GoogleFitDataModel provider) {
    return BuildDashboardCard(
      title: 'Время активности',
      counterValue: '${provider.activMinutesCount} мин / 120 мин',
      progressPercent: provider.activMinutesProgress,
      cardBackground: const Color(0xFFCEC6FD).withOpacity(.1),
      progressBackgroundColor: const Color(0xFF6D55FF).withOpacity(.2),
      progressValueColor: const Color(0xFF6D55FF),
      iconBackgroundColor: const Color(0xFF6D55FF).withOpacity(.05),
      icon: 'assets/activ_time_icon.png',
    );
  }

  _buildGetStepDataButton(BuildContext context) {
    var provider = Provider.of<GoogleFitDataModel>(context, listen: false);
    return ElevatedButton(
      onPressed: () => provider.getData(),
      child: const Text('TAP ME !!!'),
    );
  }
}
