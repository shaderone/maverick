import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:maverick/themes/theme.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatelessWidget {
  final String speed;
  final double batteryPercent;
  final String odometer;
  final bool seatBelt;
  final bool handBrake;
  final String gear;
  const GaugeWidget({
    Key? key,
    required this.speed,
    required this.batteryPercent,
    required this.odometer,
    required this.seatBelt,
    required this.handBrake,
    required this.gear,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      animationDuration: 2000,
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          radiusFactor: 0.7,
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          // axisLabelStyle: GaugeTextStyle(color: primarColor),
          // backgroundImage: NetworkImage(
          //     "https://help.syncfusion.com/flutter/radial-gauge/images/overview/gauge_overview.png"),
          // canRotateLabels: false,
          useRangeColorForAxis: true,
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Stack(
                children: [
                  Image.asset(
                    "assets/vectors/battery_vector.png",
                    width: 135,
                  ),
                  Positioned(
                    top: 13,
                    left: 40,
                    child: Text(
                      ("$batteryPercent %"),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              positionFactor: 0.81,
              angle: 270,
            ),
            GaugeAnnotation(
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.arrow_circle_left_outlined,
                    size: 50,
                    color: Color(0xFF282D3E),
                  ),
                  SizedBox(width: 30),
                  Icon(
                    CupertinoIcons.light_max,
                    // CupertinoIcons.light_min,
                    size: 50,
                    //color: primaryColor,
                    color: Color(0xFF282D3E),
                  ),
                  SizedBox(width: 30),
                  Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 50,
                    color: Color(0xFF282D3E),
                  )
                ],
              ),
              angle: -90,
              positionFactor: 0.53,
            ),
            GaugeAnnotation(
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 303,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              speed,
                              style: const TextStyle(
                                fontSize: 120,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'KM/H',
                              style: TextStyle(
                                height: 0.01,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFfB4B9CB),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xFF282D3E),
                            border: Border.all(
                              width: 5,
                              color: primaryColor,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                gear,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              angle: 90,
              positionFactor: 0.07,
            ),
            //GaugeAnnotation(
            //  widget: Indicator(
            //    child: Center(
            //      child: Icon(
            //        MdiIcons.seatbelt,
            //        color: seatBelt ? Colors.amber : Colors.white,
            //        size: 32,
            //      ),
            //    ),
            //  ),
            //  angle: -23,
            //  positionFactor: 1.325,
            //),
            //GaugeAnnotation(
            //  widget: Indicator(
            //    child: Center(
            //      child: Icon(
            //        MdiIcons.carBrakeHold,
            //        color: handBrake ? Colors.amber : Colors.white,
            //        size: 32,
            //      ),
            //    ),
            //  ),
            //  angle: -156,
            //  positionFactor: 1.315,
            //),
            GaugeAnnotation(
              widget: Indicator(
                child: Center(
                  child: Icon(
                    MdiIcons.carBrakeHold,
                    color: handBrake ? Colors.amber : Colors.white,
                    //MdiIcons.lightningBolt,
                    //// Icons.bolt,
                    //// Icons.battery_charging_full,
                    //// Icons.battery_alert_rounded,
                    //color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              angle: -176,
              positionFactor: 1.325,
            ),
            //GaugeAnnotation(
            //  widget: Indicator(
            //    child: Center(
            //      child: Transform(
            //        alignment: Alignment.center,
            //        transform: Matrix4.rotationY(3.14), //pi value
            //        child: const Icon(
            //          MdiIcons.carDoor,
            //          color: Colors.white,
            //          size: 32,
            //        ),
            //      ),
            //    ),
            //  ),
            //  // angle: -175, -- center
            //  angle: -196,
            //  positionFactor: 1.325,
            //),
            //const GaugeAnnotation(
            //  widget: Indicator(
            //    child: Center(
            //      child: Icon(
            //        MdiIcons.carDoor,
            //        color: Colors.white,
            //        size: 32,
            //      ),
            //    ),
            //  ),
            //  angle: 16,
            //  positionFactor: 1.325,
            //),
            GaugeAnnotation(
              widget: Indicator(
                child: Center(
                  child: Icon(
                    MdiIcons.seatbelt,
                    color: seatBelt ? Colors.amber : Colors.white,
                    //MdiIcons.engine,
                    //color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
              angle: -3.5,
              positionFactor: 1.35,
            ),
            GaugeAnnotation(
              widget: Container(
                width: 180,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF1D202C),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "$odometer KM",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              angle: 90,
              positionFactor: 0.8,
            ),
            const GaugeAnnotation(
              widget: Text(
                '0%',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // angle: 146,
              angle: 141,
              positionFactor: 1.17,
              // positionFactor: 1.30,
            ),
            const GaugeAnnotation(
              widget: Text(
                '100%',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // angle: 146,
              angle: 36,
              positionFactor: 1.25,
              // positionFactor: 1.30,
            ),
          ],
          axisLineStyle: const AxisLineStyle(
            // link width
            thickness: 0.125,
            cornerStyle: CornerStyle.bothCurve,
            thicknessUnit: GaugeSizeUnit.factor,
            color: Color(0xFF222533),
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: batteryPercent,
              width: 23.5,
              cornerStyle: CornerStyle.bothCurve,
              color: primaryColor,
            ),
          ],
        )
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final Widget child;
  const Indicator({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF32374c),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Color(0xFF1e212e),
            offset: Offset(5, 5),
          ),
          BoxShadow(
            blurRadius: 8,
            color: Color(0xFF464d6a),
            offset: Offset(-5, -5),
          ),
        ],
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2d3244),
            Color(0xFF363b51),
          ],
          stops: [0, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
