import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maverick/themes/theme.dart';
import 'package:maverick/widgets/gauge.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: const Root(),
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(
          0xFF1D202C,
        ), //or set color with: Color(0xFF0000FF)
      ),
    );
    return Scaffold(
      //extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFF2A2F40),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF3B4259).withOpacity(.90),
              const Color(0xFF2A2F40),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              //->later
              //Positioned(
              //  top: 25,
              //  child: Column(
              //    children: [
              //      const Text(
              //        "MUSIC",
              //        style: TextStyle(color: Colors.white),
              //      ),
              //      const SizedBox(height: 10),
              //      Card(
              //        color: const Color(0xff1D202C),
              //        child: SizedBox(
              //          width: 100,
              //          child: ClipRRect(
              //            borderRadius: BorderRadius.circular(10),
              //            child: const LinearProgressIndicator(
              //              value: 0.4,
              //              backgroundColor: Color(0xff1D202C),
              //              color: Colors.blue,
              //              minHeight: 10,
              //            ),
              //          ),
              //        ),
              //      ),
              //    ],
              //  ),
              //),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "ESTIMATIONS",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      DashCard(
                        cardTitle: "VOLTAGE",
                        cardContent: "220V",
                        cardIcon: MdiIcons.flashTriangle,
                        isTemp: true,
                      ),
                      DashCard(
                        cardTitle: "MILAGE",
                        cardContent: "53",
                        cardIcon: MdiIcons.speedometer,
                        isTemp: true,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 530,
                    width: 530,
                    child: GaugeWidget(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "TEMPERATURES",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      DashCard(
                        cardTitle: "BATTERY",
                        cardContent: "67",
                        cardIcon: MdiIcons.sunThermometer,
                        isTemp: true,
                      ),
                      DashCard(
                        cardTitle: "MOTOR",
                        cardContent: "38",
                        cardIcon: MdiIcons.sunThermometer,
                        isTemp: true,
                      ),
                      //SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashCard extends StatelessWidget {
  final String cardTitle;
  final String cardContent;
  final IconData cardIcon;
  final bool isTemp;
  const DashCard({
    Key? key,
    required this.cardTitle,
    required this.cardContent,
    required this.cardIcon,
    this.isTemp = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Card(
        color: const Color(0xFF1D202C),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cardTitle),
                  const SizedBox(height: 8),
                  Text(
                    "$cardContent ${isTemp ? "°C" : "KM/H"}",
                    style: const TextStyle(color: primaryColor),
                  ),
                ],
              ),
              Icon(cardIcon, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
