import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../themes/theme.dart';
import '../widgets/gauge.dart';

class DashCard extends StatelessWidget {
  final String cardTitle;
  final String cardContent;
  final IconData cardIcon;
  final bool? isTemp;
  final bool isVoltage;
  const DashCard({
    Key? key,
    required this.cardTitle,
    required this.cardContent,
    required this.cardIcon,
    this.isTemp = false,
    this.isVoltage = false,
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
                    "$cardContent ${isTemp == null ? "V" : isTemp! ? "°C" : "KM/H"}",
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

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({super.key, required this.server});

  @override
  _ChatPage createState() => _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  static const clientID = 0;
  BluetoothConnection? connection;

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  final StreamController<String> _streamController = StreamController();
  late final Stream<String> _stream =
      _streamController.stream.asBroadcastStream();
  late StreamSubscription _streamSubscription;

  late List<String> espData;

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();
    espData = ["0", "0", "0", "0", "0", "0", "0", "0", "0", "0"];
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });

    _streamSubscription = _stream.listen((event) {
      final result = event.split(",");
      //manage this line -----------------------performance improvement
      setState(() {
        espData = result;
      });
      //log("data - ${result.toString()}");
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //String voltage = "50.3";
    //String milage = "32";
    //String batteryTemperature = "43.4";
    //String motorTemperature = "39.8";
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:
            Color(0xFF1D202C), //or set color with: Color(0xFF0000FF)
      ),
    );

    final List<Row> list = messages.map(
      (_message) {
        _streamController.sink.add(_message.text);
        //_message.text -- contains data
        return Row(
          mainAxisAlignment: _message.whom == clientID
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              margin: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              width: 222.0,
              decoration: BoxDecoration(
                  color: _message.whom == clientID
                      ? Colors.blueAccent
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(7.0)),
              child: Text(
                  (text) {
                    return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                  }(_message.text.trim()),
                  style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    ).toList();

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
          child: espData[0].isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(strokeWidth: 2),
                      SizedBox(height: 20),
                      Text("Establishing connection...")
                    ],
                  ),
                )
              : SizedBox(
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
                            children: [
                              Text(
                                "ESTIMATIONS",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              DashCard(
                                cardTitle: "VOLTAGE",
                                cardContent: espData[0].split(":").last,
                                cardIcon: MdiIcons.flashTriangle,
                                isTemp: null,
                              ),
                              DashCard(
                                cardTitle: "RANGE",
                                cardContent: espData[1].split(":").last,
                                cardIcon: MdiIcons.speedometer,
                                isTemp: false,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 530,
                            width: 530,
                            child: GaugeWidget(
                              speed: espData[2].split(":").last,
                              batteryPercent:
                                  double.parse(espData[7].split(":").last),
                              seatBelt: espData[9].split(":").last == 0
                                  ? false
                                  : true,
                              odometer: espData[5].split(":").last,
                              handBrake: espData[8].split(":").last == 0
                                  ? false
                                  : true,
                              gear: espData[6].split(":").last,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "TEMPERATURES",
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              DashCard(
                                cardTitle: "BATTERY",
                                cardContent: espData[3].split(":").last,
                                cardIcon: MdiIcons.sunThermometer,
                                isTemp: true,
                              ),
                              DashCard(
                                cardTitle: "MOTOR",
                                cardContent: espData[4].split(":").last,
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
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    //log("data - ${data.toString()}");
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    for (var byte in data) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    }
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.isNotEmpty) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode("$text\r\n")));
        await connection!.output.allSent;

        setState(() {
          messages.add(_Message(clientID, text));
        });

        Future.delayed(const Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}

// data modal

