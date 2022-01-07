import 'package:activity_tracker/logic/google_login.dart';
import 'package:activity_tracker/model/MyModelStepData.dart';
import 'package:activity_tracker/widgets/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;

    final provider = Provider.of<MyModelGoogleFitData>(context);
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          Container(height: sizeH),
          BuildAppBar(sizeW: sizeW),
          Positioned(
            top: 100,
            child: Container(
              padding: const EdgeInsets.fromLTRB(22, 90, 22, 0),
              width: sizeW,
              height: sizeH,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
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
                      _buildGetStepDataButton(context),
                      _buildLogoutButton(context),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Text(
              'Build 0.5.500',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
      ),
      onPressed: () {
        final googleLogoutProvider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        googleLogoutProvider.logout();
      },
      child: const Text('Logout'),
    );
  }

  BuildDashboardCard _buildStepCard(MyModelGoogleFitData provider) {
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

  BuildDashboardCard _buildDistanseCard(MyModelGoogleFitData provider) {
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

  BuildDashboardCard _buildCaloriesCard(MyModelGoogleFitData provider) {
    return BuildDashboardCard(
      title: 'Сожжено калорий',
      counterValue: '${provider.caloriesCount} ккал',
      progressPercent: provider.caloriesProgress,
      cardBackground: const Color(0xFFFFDEE0).withOpacity(.1),
      progressBackgroundColor: const Color(0xFFFF4A55).withOpacity(.2),
      progressValueColor: const Color(0xFFFF4A55),
      iconBackgroundColor: const Color(0xFFFF4A55).withOpacity(.05),
      icon: 'assets/calories_icon.png',
    );
  }

  BuildDashboardCard _buildActivityTimeCard(MyModelGoogleFitData provider) {
    return BuildDashboardCard(
      title: 'Время активности',
      counterValue: 'пока хз',
      progressPercent: provider.caloriesProgress,
      cardBackground: const Color(0xFFCEC6FD).withOpacity(.1),
      progressBackgroundColor: const Color(0xFF6D55FF).withOpacity(.2),
      progressValueColor: const Color(0xFF6D55FF),
      iconBackgroundColor: const Color(0xFF6D55FF).withOpacity(.05),
      icon: 'assets/activ_time_icon.png',
    );
  }

  _buildGetStepDataButton(BuildContext context) {
    var provider = Provider.of<MyModelGoogleFitData>(context, listen: false);
    return ElevatedButton(
      onPressed: () => provider.getData(),
      child: const Text('TAP ME !!!'),
    );
  }
}
