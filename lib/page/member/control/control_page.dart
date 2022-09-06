import 'dart:async';
import 'dart:convert';

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

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<StatefulWidget> createState() => _ControlState();
}

class _ControlState extends State<ControlPage> {
  final _tbClient = Modular.get<ThingsboardClient>();
  final _controlStore = Modular.get<ControlStore>();

  void initListener() {
    _controlStore.switchNotifier.addListener(reBuild);
    _controlStore.energyNotifier.addListener(reBuild);
  }

  void disposeListener() {
    _controlStore.switchNotifier.removeListener(reBuild);
    _controlStore.energyNotifier.removeListener(reBuild);
  }

  void reBuild() {
    setState(() {});
  }

  Future<void> getStatus() async {
    // const deviceId = '623188e0-1176-11ed-b3ac-871000fc4069';
    const deviceId = '7f07f5a0-1174-11ed-b3ac-871000fc4069';
    final data = jsonEncode({
      'method': 'Switch.GetStatus',
      'params': {'id': 0}
    });
    final res = await _tbClient.post<String>(
      '/api/rpc/twoway/$deviceId',
      data: data,
    );
    final status = res.data;
    _controlStore.setSwitchStatus((jsonDecode(status!)['output'] as bool));
  }

  @override
  void initState() {
    super.initState();
    initListener();
    getStatus();
  }

  @override
  void dispose() {
    super.dispose();
    disposeListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 217, 217),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Stack(
              children: [
                Image.network(
                  'https://rv.5giotlead.com/static/rv/0ca29309-3f7d-49ab-a38c-183cd9592823.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Align(alignment: Alignment.topRight, child: Canvas()),
              ],
            ),
            //   ],
            // ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: PowerSwitch(),
          ),
          const SizedBox(
            height: 15,
          ),
          const Expanded(
            child: TelemetryBlock(),
          ),
        ],
      ),
    );
  }
}

class Canvas extends StatelessWidget {
  Canvas({super.key});

  final _controlStore = Modular.get<ControlStore>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 40,
                      color: const Color.fromARGB(116, 141, 139, 139),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.power,
                            color: Colors.black,
                            size: 20,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              15,
                              0,
                              0,
                              0,
                            ),
                            child: Text(
                              '${_controlStore.energyNotifier.value} kWh',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 40,
                      color: const Color.fromARGB(116, 141, 139, 139),
                      child: Row(
                        children: [
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return _controlStore.switchNotifier.value
                                  ? const Icon(
                                      Icons.sensor_door_rounded,
                                      color: Colors.red,
                                      size: 24,
                                    )
                                  : const Icon(
                                      Icons.sensor_door_rounded,
                                      color: Colors.black,
                                      size: 24,
                                    );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              10,
                              0,
                              0,
                              0,
                            ),
                            child: Text(
                              _controlStore.switchNotifier.value
                                  ? 'open'
                                  : 'closed',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
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
        ],
      ),
    );
  }
}

class PowerSwitch extends StatelessWidget {
  PowerSwitch({super.key});

  final _tbClient = Modular.get<ThingsboardClient>();
  final _controlStore = Modular.get<ControlStore>();

  Future<void> toggleSwitch() async {
    // const deviceId = '623188e0-1176-11ed-b3ac-871000fc4069';
    const deviceId = '7f07f5a0-1174-11ed-b3ac-871000fc4069';
    final data = jsonEncode({
      'method': 'Switch.Toggle',
      'params': {'id': 0}
    });
    // final delayClose = jsonEncode({
    //   'method': 'Switch.Set',
    //   'params': {'id': 0, 'on': _controlStore.state, 'toggle_after': 5}
    // });
    await _tbClient.post<String>(
      '/api/rpc/twoway/$deviceId',
      data: data,
    );
    // await _tbClient.post<String>(
    //   '/api/rpc/twoway/$deviceId',
    //   data: delayClose,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('開關'),
        Switch(
          value: _controlStore.switchNotifier.value,
          onChanged: (value) {
            toggleSwitch();
          },
        ),
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
  bool _switchConnected = false;
  bool _energyConnected = false;
  final _storage = Modular.get<FlutterSecureStorage>();
  final _controlStore = Modular.get<ControlStore>();

  // final baseWSURL = 'wss://rv.5giotlead.com';
  final baseWSURL = 'wss://rv.5giotlead.com:8081';
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss a');
  late WebSocketChannel wsSwitch;
  late WebSocketChannel wsEnergy;
  List<Telemetry> telemetryData = <Telemetry>[
    // Telemetry()
    //   ..name = 'pf'
    //   ..updateTime = DateTime.now()
    //   ..data = 0
    //   ..icon = const Icon(Icons.flash_on),
    Telemetry()
      ..name = 'voltage'
      ..updateTime = DateTime.now()
      ..data = 0
      ..icon = const Icon(Icons.flash_auto),
    // Telemetry()
    //   ..name = 'power'
    //   ..updateTime = DateTime.now()
    //   ..data = 0
    //   ..icon = const Icon(Icons.energy_savings_leaf),
    // Telemetry()
    //   ..name = 'reactive_power'
    //   ..updateTime = DateTime.now()
    //   ..data = 0
    //   ..icon = const Icon(Icons.energy_savings_leaf),
    Telemetry()
      ..name = 'total'
      ..updateTime = DateTime.now()
      ..data = 0
      ..icon = const Icon(Icons.energy_savings_leaf),
    // Telemetry()
    //   ..name = 'total_returned'
    //   ..updateTime = DateTime.now()
    //   ..data = 0
    //   ..icon = const Icon(Icons.energy_savings_leaf),
  ];

  @override
  void initState() {
    super.initState();
  }

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

  Future<void> _startWS(String type) async {
    var entityId = '';
    final token = await _storage.read(key: 'token');
    final uri = Uri.parse(
      '$baseWSURL/api/ws/plugins/telemetry?token=$token',
    );
    if (type == 'p1') {
      // entityId = '623188e0-1176-11ed-b3ac-871000fc4069';
      entityId = '7f07f5a0-1174-11ed-b3ac-871000fc4069';
      final object = {
        'tsSubCmds': [
          {
            'entityType': 'DEVICE',
            'entityId': entityId,
            'scope': 'LATEST_TELEMETRY',
          }
        ],
      };
      if (!_switchConnected) {
        wsSwitch = WebSocketChannel.connect(uri);
        _switchConnected = true;
        wsSwitch.sink.add(jsonEncode(object));
        wsSwitch.stream.listen(_setSwitchTelemetry);
      }
    } else if (type == 'em') {
      entityId = '9031bf40-1954-11ed-a371-210ec0665214';
      final object = {
        'tsSubCmds': [
          {
            'entityType': 'DEVICE',
            'entityId': entityId,
            'scope': 'LATEST_TELEMETRY',
          }
        ],
      };
      if (!_energyConnected) {
        wsEnergy = WebSocketChannel.connect(uri);
        _energyConnected = true;
        wsEnergy.sink.add(jsonEncode(object));
        wsEnergy.stream.listen(_setEnergyTelemetry);
      }
    }
  }

  void _setSwitchTelemetry(dynamic message) {
    if (message is String) {
      setState(() {
        final data = jsonDecode(message)['data'] as Map;
        for (final element in data.entries) {
          if (element.key == 'SWITCH') {
            if (element.value[0][1] is String) {
              _controlStore.setSwitchStatus(element.value[0][1]);
            }
          }
        }
      });
    }
  }

  void _setEnergyTelemetry(dynamic message) {
    if (message is String) {
      setState(() {
        final data = jsonDecode(message)['data'] as Map;
        for (final element in data.entries) {
          if (element.key == 'total') {
            final energy = double.parse(element.value[0][1] as String) / 1000;
            _controlStore.setEnergyStatus(energy.floorToDouble());
            telemetryData
                .where((telemetry) => telemetry.name == element.key)
                .first
              ..updateTime = DateTime.fromMillisecondsSinceEpoch(
                element.value[0][0] as int,
              )
              ..data = energy.floorToDouble();
          } else if (element.key == 'voltage') {
            telemetryData
                .where((telemetry) => telemetry.name == element.key)
                .first
              ..updateTime = DateTime.fromMillisecondsSinceEpoch(
                element.value[0][0] as int,
              )
              ..data = double.parse(element.value[0][1] as String);
          }
        }
      });
    }
  }

  void _closeWS() {
    if (_energyConnected) {
      wsEnergy.sink.close();
    }
    if (_switchConnected) {
      wsSwitch.sink.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    _startWS('em');
    _startWS('p1');
    return SizedBox(
      height: 500,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        itemBuilder: (BuildContext context, int index) {
          final telemetry = telemetryData[index];
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
                ],
              ),
            ),
          );
        },
        itemCount: telemetryData.length,
      ),
    );
  }
}
