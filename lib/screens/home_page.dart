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

    final provider = Provider.of<MyModelStepData>(context);
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
                      BuildDashboardCard(
                        stepCount: provider.stepCount,
                        stepProgres: provider.stepProgres,
                      ),
                      const SizedBox(height: 22),
                      _buildGetStepDataButton(context),
                    ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildGetStepDataButton(BuildContext context) {
    var provider = Provider.of<MyModelStepData>(context, listen: false);
    return ElevatedButton(
      onPressed: () => provider.getData(),
      child: const Text('TAP ME !!!'),
    );
  }
}
