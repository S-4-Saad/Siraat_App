import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import '../buttons/floatingaction.dart';
import '../sections/bottomnavigation.dart';
import '../sections/qibla_section.dart';
import '../sections/top_card.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(bottom: kBottomNavigationBarHeight+10),
          child: Column(
            children: [
              const SizedBox(height: 30),
              TopCard(),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: QiblahCompassWidget(),
              ),


            ],

          ),
        ),
      ),
      floatingActionButton: CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Bottomnavigation(),

    );
  }
}

