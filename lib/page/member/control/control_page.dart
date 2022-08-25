import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/page/member/control/control_store.dart';
import 'package:flutter_rv_pms/shared/models/telemetry.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:thingsboard_client/thingsboard_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const assetId = '5cb562f0-1951-11ed-a371-210ec0665214';

ThingsboardClient tbClient = Modular.get<ThingsboardClient>();

class ControlPage extends StatelessWidget {
  ControlPage({super.key});

  final store = Modular.get<ControlStore>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 217, 217),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Stack(children: [
              Image.network(
                'https://picsum.photos/seed/762/600',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                height: 260,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, -1.03),
                      child: Container(
                        color: Color.fromARGB(204, 150, 150, 150),
                        width: double.infinity,
                        height: 30,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.place,
                              color: Colors.black,
                              size: 24,
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                              child: Text(
                                '南投縣 畢瓦客露營區',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.power,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                      child: Text(
                                        'Good',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 40,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.sensor_door_rounded,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        store.state ? 'ON' : 'OFF',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
                    Expanded(
                      child: Container(
                        color: Color.fromARGB(204, 150, 150, 150),
                        alignment: Alignment.bottomCenter,
                        width: double.infinity,
                        height: 25,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, top: 0, right: 0, bottom: 0),
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 100,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.directions_car_rounded,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'NOMADIC 5 遊牧旅居車',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 100,
                              child: Align(
                                alignment: AlignmentDirectional(0.8, 0.05),
                                child: Text(
                                  '20220822 08:03',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: PowerSwitch(),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            // padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: TelemetryBlock(),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 24.0),
          //   child: ListView.separated(
          //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
          //     scrollDirection: Axis.vertical,
          //     itemBuilder: (BuildContext context, int index) {
          //       // Lets create a property card widget
          //       return SenserCard(StaticData.sensers[0]);
          //     },
          //     separatorBuilder: (BuildContext context, int index) {
          //       return const SizedBox(
          //         width: 20,
          //       );
          //     },
          //     // Make the length our static data length
          //     itemCount: StaticData.sensers.length,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class PowerSwitch extends StatefulWidget {
  PowerSwitch({super.key});

  @override
  State<StatefulWidget> createState() => _PowerState();
}

class _PowerState extends State<PowerSwitch> {
  final tbClient = Modular.get<ThingsboardClient>();
  final _storage = Modular.get<FlutterSecureStorage>();
  final _dio = Modular.get<Dio>();
  final store = Modular.get<ControlStore>();

  @override
  void initState() {
    super.initState();
    getStatus();
  }

  Future<void> getStatus() async {
    const deviceId = '623188e0-1176-11ed-b3ac-871000fc4069';
    final data = jsonEncode({
      'method': 'Switch.GetStatus',
      'params': {'id': 0}
    });
    final res = await tbClient.post<String>(
      '/api/rpc/twoway/$deviceId',
      data: data,
    );
    final status = res.data;
    store.setSwitchStatus(jsonDecode(status!)['output'] as bool);
    setState(() {
      store.state;
    });
  }

  Future<void> toggleSwitch() async {
    const deviceId = '623188e0-1176-11ed-b3ac-871000fc4069';
    final data = jsonEncode({
      'method': 'Switch.Toggle',
      'params': {'id': 0}
    });
    final res = await tbClient.post<String>(
      '/api/rpc/twoway/$deviceId',
      data: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('開關'),
        Switch(
          value: store.state,
          onChanged: (value) {
            setState(() {
              store.setSwitchStatus(!store.state);
              toggleSwitch();
            });
          },
        )
      ],
    );
  }
}

class TelemetryBlock extends StatefulWidget {
  const TelemetryBlock({super.key});

  @override
  State<StatefulWidget> createState() => _TelemetryBlockState();
}

class _TelemetryBlockState extends State<TelemetryBlock> {
  bool _connected = false;
  final _storage = Modular.get<FlutterSecureStorage>();

  final baseWSURL = 'wss://rv.5giotlead.com';

  // final baseWSURL = 'wss://rv.5giotlead.com:8081';

  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss a');
  late WebSocketChannel ws;
  List<Telemetry> telemetryData = <Telemetry>[
    Telemetry()
      ..name = 'pf'
      ..updateTime = DateTime.now()
      ..data = '0'
      ..icon = const Icon(Icons.flash_on),
    Telemetry()
      ..name = 'voltage'
      ..updateTime = DateTime.now()
      ..data = '0'
      ..icon = const Icon(Icons.flash_auto),
    Telemetry()
      ..name = 'power'
      ..updateTime = DateTime.now()
      ..data = '0'
      ..icon = const Icon(Icons.energy_savings_leaf),
    Telemetry()
      ..name = 'reactive_power'
      ..updateTime = DateTime.now()
      ..data = '0'
      ..icon = const Icon(Icons.energy_savings_leaf),
    Telemetry()
      ..name = 'total'
      ..updateTime = DateTime.now()
      ..data = '0'
      ..icon = const Icon(Icons.energy_savings_leaf),
    Telemetry()
      ..name = 'total_returned'
      ..updateTime = DateTime.now()
      ..data = '0'
      ..icon = const Icon(Icons.energy_savings_leaf),
  ];

  @override
  void deactivate() {
    super.deactivate();
    _closeWS();
  }

  @override
  void dispose() {
    super.dispose();
    _closeWS();
  }

  Future<void> _startWS() async {
    const entityId = '9031bf40-1954-11ed-a371-210ec0665214';
    final token = await _storage.read(key: 'token');
    final uri = Uri.parse(
      '$baseWSURL/api/ws/plugins/telemetry?token=$token',
    );
    var object = {
      'tsSubCmds': [
        {
          'entityType': 'DEVICE',
          'entityId': entityId,
          'scope': 'LATEST_TELEMETRY',
          // 'cmdId': 10
        }
      ],
      // 'historyCmds': [],
      // 'attrSubCmds': []
    };
    if (!_connected) {
      ws = WebSocketChannel.connect(uri);
      _connected = true;
      ws.sink.add(jsonEncode(object));
      ws.stream.listen(_setTelemetry);
    }
  }

  void _setTelemetry(dynamic message) {
    if (message is String) {
      setState(() {
        final data = jsonDecode(message)['data'] as Map;
        for (final element in data.entries) {
          telemetryData
              .where((telemetry) => telemetry.name == element.key)
              .first
            ..updateTime = DateTime.fromMillisecondsSinceEpoch(
              element.value[0][0] as int,
            )
            ..data = element.value[0][1] as String;
        }
      });
    }
  }

  void _closeWS() {
    if (_connected) {
      ws.sink.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    _startWS();
    return SizedBox(
      height: 500,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final telemetry = telemetryData[index];
          //   // Lets create a property card widget
          return Center(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: telemetry.icon,
                    title: Text('${telemetry.name}: ${telemetry.data}'),
                    subtitle: Text(formatter.format(telemetry.updateTime)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('Chart'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: const Text('Log'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        // Make the length our static data length
        itemCount: telemetryData.length,
      ),
    );
  }
}
