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
    // const deviceId = '3edf4180-3312-11ed-beac-410b5c7ea157';
    const deviceId = '33dcf520-3312-11ed-beac-410b5c7ea157';
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
                  // 'https://rv.5giotlead.com/static/all/black.jpg',
                  // 'https://rv.5giotlead.com/static/all/white.jpg',
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
          const SizedBox(
            height: 200,
          ),
          PowerSwitch(),
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
                      width: 160,
                      height: 40,
                      color: const Color.fromARGB(160, 250, 240, 230),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.power,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            '總耗電量: ${_controlStore.energyNotifier.value} 度電',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 160,
                      height: 40,
                      color: const Color.fromARGB(160, 250, 240, 230),
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
                              _controlStore.switchNotifier.value ? '開啟' : '關閉',
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
  List<bool> toggleStatus = <bool>[false, false];

  Future<void> toggleSwitch(int index) async {
    // const deviceId = '3edf4180-3312-11ed-beac-410b5c7ea157';
    const deviceId = '33dcf520-3312-11ed-beac-410b5c7ea157';
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

  void checkToggleStatus() {
    _controlStore.switchNotifier.value
        ? toggleStatus = [true, false]
        : toggleStatus = [false, true];
  }

  @override
  Widget build(BuildContext context) {
    checkToggleStatus();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButtons(
          direction: Axis.vertical,
          onPressed: toggleSwitch,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: Colors.red[700],
          selectedColor: Colors.white,
          fillColor: Colors.red[200],
          color: Colors.red[400],
          constraints: const BoxConstraints(
            minHeight: 80,
            minWidth: 80,
          ),
          isSelected: toggleStatus,
          children: const <Widget>[Text('開啟'), Text('關閉')],
        ), // Switch(
        //   value: _controlStore.switchNotifier.value,
        //   onChanged: (value) {
        //     toggleSwitch();
        //   },
        // ),
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

  final baseWSURL = 'wss://rv.5giotlead.com';

  // final baseWSURL = 'wss://rv.5giotlead.com:8080';
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
      // entityId = '3edf4180-3312-11ed-beac-410b5c7ea157';
      entityId = '33dcf520-3312-11ed-beac-410b5c7ea157';
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
      entityId = '7f14f9f0-331e-11ed-9d40-89fa88f80717';
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
      // child: ListView.builder(
      //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      //   itemBuilder: (BuildContext context, int index) {
      //     final telemetry = telemetryData[index];
      //     return Center(
      //       child: Card(
      //         child: Column(
      //           mainAxisSize: MainAxisSize.min,
      //           children: <Widget>[
      //             ListTile(
      //               leading: telemetry.icon,
      //               title: Text('${telemetry.name}: ${telemetry.data}'),
      //               subtitle: Text(formatter.format(telemetry.updateTime)),
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      //   itemCount: telemetryData.length,
      // ),
    );
  }
}
