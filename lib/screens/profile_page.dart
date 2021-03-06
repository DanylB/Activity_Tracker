import 'package:activity_tracker/logic/deserialization_data_from_google_fit.dart';
import 'package:activity_tracker/widgets/export.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:activity_tracker/widgets/BuildProfileAppBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Scaffold(
//       body: Center(
//         child: Text(
//           'Build 0.7.100',
//           style: Theme.of(context).textTheme.headline5,
//         ),
//       ),
//     ));
//   }
// }
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;

    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(height: sizeH),
          BuildProfileAppBar(sizeW: sizeW),
          Positioned(
            top: 100,
            child: Container(
              padding: const EdgeInsets.fromLTRB(22, 90, 22, 0),
              width: sizeW,
              // height: sizeH * .5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: CustomScrollView(
              primary: false,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          _buildAvatar(user, sizeW),
                          SizedBox(height: 20),
                          _buildUserName(user),
                          SizedBox(height: 30),
                          _buildBodyInformation(sizeW),
                          SizedBox(height: 10),
                          _buildRecordTitleWithShare(),
                          SizedBox(height: 10),
                          _buildRecordGrid(sizeW, sizeH),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _buildUserName(User user) {
    return Text(
      user.displayName!,
      style: GoogleFonts.roboto(
          fontSize: 22, color: Color(0xFF323232), fontWeight: FontWeight.w500),
    );
  }

  // CircleAvatar _buildAvatar(User user, double sizeW) {
  //   return CircleAvatar(
  //     backgroundImage: NetworkImage(user.photoURL!),
  //     radius: sizeW * .12,
  //   );
  // }
  _buildAvatar(User user, double sizeW) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(sizeW),
      child: CachedNetworkImage(
        imageUrl: user.photoURL!,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Row _buildRecordTitleWithShare() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '???????????? ??????????????',
          style: GoogleFonts.roboto(
              fontSize: 16,
              color: Color(0xFF505050),
              fontWeight: FontWeight.w500),
        ),
        // SizedBox(width: 10),

        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/share_icon_bold.svg'),
          iconSize: 26,
          padding: const EdgeInsets.all(5),
          highlightColor: Color(0xFF1F88FE).withOpacity(.1),
          splashColor: Color(0xFF1F88FE).withOpacity(.2),
        ),

        // SvgPicture.asset('assets/share_icon.svg')
      ],
    );
  }

  ConstrainedBox _buildRecordGrid(double sizeW, double sizeH) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: Container(
        width: sizeW,
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                BuildRecordCard(
                  sizeW: sizeW,
                  svgIconPath: 'assets/step_icon.svg',
                  title: '??????????',
                  value: '18 695',
                ),
                SizedBox(width: 20),
                BuildRecordCard(
                  sizeW: sizeW,
                  svgIconPath: 'assets/sleep_icon.svg',
                  title: '??????',
                  value: '10 ?? 15 ??????',
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                BuildRecordCard(
                  sizeW: sizeW,
                  svgIconPath: 'assets/distanse_icon.svg',
                  title: '????????????????',
                  value: '12.7 ????',
                ),
                SizedBox(width: 20),
                BuildRecordCard(
                  sizeW: sizeW,
                  svgIconPath: 'assets/activ_time_icon.svg',
                  title: '????????????????????',
                  value: '2 ?? 43 ??????',
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                BuildRecordCard(
                  sizeW: sizeW,
                  svgIconPath: 'assets/speed_icon.svg',
                  title: '????????????????',
                  value: '9.36 ????',
                ),
                SizedBox(width: 20),
                BuildRecordCard(
                  sizeW: sizeW,
                  svgIconPath: 'assets/calories_icon.svg',
                  title: '??????????????',
                  value: '1 316 ??????',
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  ConstrainedBox _buildBodyInformation(double sizeW) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: Container(
        width: sizeW,
        padding: const EdgeInsets.fromLTRB(66, 0, 66, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '??????????????',
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Color(0xFF808080),
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 5),
                Text(
                  '23 ????????',
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '??????',
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Color(0xFF808080),
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 5),
                Text(
                  '60 ????',
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '????????',
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Color(0xFF808080),
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 5),
                Text(
                  '170 ????',
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
