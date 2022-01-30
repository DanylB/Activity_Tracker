import 'package:flutter/material.dart';
import 'package:activity_tracker/widgets/export.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(height: sizeH),
          BuildSettingsAppBar(sizeW: sizeW),
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
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
              child: CustomScrollView(
                primary: false,
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              'Профиль',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 30),
                            _buildProfileSettings(sizeW),
                            const SizedBox(height: 30),
                            Text(
                              'Цели',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 30),
                            _buildGoals(),
                            const SizedBox(height: 30),
                            Text(
                              'Система',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              height: 60,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xFF808080)
                                          .withOpacity(.25),
                                      blurRadius: 12,
                                      spreadRadius: -2,
                                      offset: const Offset(0, 4)),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Тема',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF3A3A3A)),
                                  ),
                                  Text('Toggle'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 60,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0xFF808080)
                                          .withOpacity(.25),
                                      blurRadius: 12,
                                      spreadRadius: -2,
                                      offset: const Offset(0, 4)),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Push - уведомления',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF3A3A3A)),
                                  ),
                                  Text('Toggle'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildGoals() {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF808080).withOpacity(.25),
              blurRadius: 12,
              spreadRadius: -2,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Text(
            ' 20 000 шагов в день',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF3A3A3A),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildProfileSettings(double sizeW) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF808080).withOpacity(.25),
              blurRadius: 12,
              spreadRadius: -2,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserNameField(),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBodyParameterField(
                label: 'Возраст',
                hintText: '23',
                suffixText: 'года',
              ),
              const SizedBox(width: 15),
              _buildBodyParameterField(
                label: 'Вес',
                hintText: '60',
                suffixText: 'кг',
              ),
              const SizedBox(width: 15),
              _buildBodyParameterField(
                label: 'Рост',
                hintText: '170',
                suffixText: 'см',
              ),
              const SizedBox(height: 15),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSaveButton(),
              SizedBox(width: sizeW * .08),
              _buildCancelBytton(),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector _buildCancelBytton() {
    return GestureDetector(
      onTap: () {
        print('Отмена');
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Color(0xFFCCCCCC).withOpacity(.5),
              width: 1,
            )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Text(
            'Отмена',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildSaveButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          print('Сохранить');
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0071FF),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF0071FF),
                blurRadius: 2,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Сохранить',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildBodyParameterField({
    required String label,
    required String hintText,
    required String suffixText,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF646464),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            style: GoogleFonts.roboto(
              color: const Color(0xFF3A3A3A),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              suffixText: suffixText,
              contentPadding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: const Color(0xFFC4C4C4).withOpacity(.2),
                ),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildUserNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Имя пользователя',
          style: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF646464),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          style: GoogleFonts.roboto(
            color: const Color(0xFF3A3A3A),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 20),
            prefixIcon: const Icon(Icons.person),
            hintText: 'Emma Linues',
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                color: const Color(0xFFC4C4C4).withOpacity(.2),
              ),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
