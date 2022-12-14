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
    const deviceId = '3edf4180-3312-11ed-beac-410b5c7ea157';
    // const deviceId = '33dcf520-3312-11ed-beac-410b5c7ea157';
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
          ),
          const SizedBox(
            height: 240,
            child: TelemetryBlock(),
          ),
          Expanded(
            child: PowerSwitch(),
          ),
          const SizedBox(
            height: 9,
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
                            Icons.electric_meter,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            '????????????: ${_controlStore.energyNotifier.value} ??????',
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
                              _controlStore.switchNotifier.value ? '??????' : '??????',
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
  List<bool> delayToggleStatus = <bool>[false];

  Future<void> toggleSwitch(int index) async {
    const deviceId = '3edf4180-3312-11ed-beac-410b5c7ea157';
    // const deviceId = '33dcf520-3312-11ed-beac-410b5c7ea157';
    final data = jsonEncode({
      'method': 'Switch.Toggle',
      'params': {'id': 0}
    });
    await _tbClient.post<String>(
      '/api/rpc/twoway/$deviceId',
      data: data,
    );
  }

  Future<void> delayToggleSwitch(int index) async {
    const deviceId = '3edf4180-3312-11ed-beac-410b5c7ea157';
    // const deviceId = '33dcf520-3312-11ed-beac-410b5c7ea157';
    final delayClose = jsonEncode({
      'method': 'Switch.Set',
      'params': {'id': 0, 'on': true, 'toggle_after': 5}
    });
    await _tbClient.post<String>(
      '/api/rpc/twoway/$deviceId',
      data: delayClose,
    );
  }

  void checkToggleStatus() {
    if (_controlStore.switchNotifier.value) {
      toggleStatus = [true, false];
      delayToggleStatus = [true];
    } else {
      toggleStatus = [false, true];
      delayToggleStatus = [false];
    }
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
          children: const <Widget>[Text('??????'), Text('??????')],
        ),
        const SizedBox(
          width: 20,
        ),
        ToggleButtons(
          direction: Axis.vertical,
          onPressed: delayToggleSwitch,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: Colors.green[700],
          selectedColor: Colors.white,
          fillColor: Colors.green[200],
          color: Colors.green[400],
          constraints: const BoxConstraints(
            minHeight: 160,
            minWidth: 160,
          ),
          isSelected: delayToggleStatus,
          children: const <Widget>[Text('????????????')],
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

  final _tbClient = Modular.get<ThingsboardClient>();
  final _controlStore = Modular.get<ControlStore>();
  final energyTranslateList = {
    'voltage': '??????',
    'current': '??????',
    'power': '??????',
    'total': '????????????',
  };

  // final baseWSURL = 'wss://rv.5giotlead.com';

  final baseWSURL = 'wss://rv.5giotlead.com:8080';
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
      ..name = '??????'
      ..updateTime = DateTime.now()
      ..data = 0
      ..unit = 'V'
      ..icon = const Icon(Icons.energy_savings_leaf_outlined),
    Telemetry()
      ..name = '??????'
      ..updateTime = DateTime.now()
      ..data = 0
      ..unit = 'mA'
      ..icon = const Icon(Icons.flash_auto),
    Telemetry()
      ..name = '??????'
      ..updateTime = DateTime.now()
      ..data = 0
      ..unit = 'W'
      ..icon = const Icon(Icons.power_outlined),
    // Telemetry()
    //   ..name = 'reactive_power'
    //   ..updateTime = DateTime.now()
    //   ..data = 0
    //   ..icon = const Icon(Icons.energy_savings_leaf),
    Telemetry()
      ..name = '????????????'
      ..updateTime = DateTime.now()
      ..data = 0
      ..unit = '??????'
      ..icon = const Icon(
        Icons.electric_meter_outlined,
      ),
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

  void onData(List<AttributeData> message) {
    print(message);

    // data example
    // [
    //   AttributeData
    //   {lastUpdateTs: 1663317744618, key: pf, value: 0.98},
    //   AttributeData
    //   {lastUpdateTs: 1663317744618, key: power, value: 45.78},
    //   AttributeData
    //   {lastUpdateTs: 1663317744618, key: reactive_power, value: 8.88},
    //   AttributeData
    //   {lastUpdateTs: 1663317744618, key: total, value: 368254.4},
    //   AttributeData
    //   {lastUpdateTs: 1663317744618, key: total_returned, value: 50.6},
    //   AttributeData
    //   {lastUpdateTs: 1663317744618, key: voltage, value: 227.13}
    // ]
  }

  void subByTBClient() {
    final telemetrySub = TelemetrySubscriber.createEntityAttributesSubscription(
      telemetryService: _tbClient.getTelemetryService(),
      entityId: EntityId.fromTypeAndUuid(
        EntityType.DEVICE,
        '7f14f9f0-331e-11ed-9d40-89fa88f80717',
      ),
      attributeScope: 'LATEST_TELEMETRY',
    )
      ..subscribe();
    telemetrySub.attributeDataStream.listen(onData);
  }

  void _startWS(String type) {
    var entityId = '';
    final uri = Uri.parse(
      '$baseWSURL/api/ws/plugins/telemetry?token=${_tbClient.getJwtToken()}',
    );
    if (type == 'p1') {
      entityId = '3edf4180-3312-11ed-beac-410b5c7ea157';
      // entityId = '33dcf520-3312-11ed-beac-410b5c7ea157';
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
      entityId = 'fb9ce810-3d47-11ed-996d-3ddca1d12b3d';
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
                .where(
                  (telemetry) => telemetry.name == energyTranslateList['total'],
            )
                .first
              ..updateTime = DateTime.fromMillisecondsSinceEpoch(
                element.value[0][0] as int,
              )
              ..data = energy.floorToDouble();
          } else if (element.key == 'voltage') {
            telemetryData
                .where(
                  (telemetry) =>
              telemetry.name == energyTranslateList['voltage'],
            )
                .first
              ..updateTime = DateTime.fromMillisecondsSinceEpoch(
                element.value[0][0] as int,
              )
              ..data = double.parse(element.value[0][1] as String);
          } else if (element.key == 'power') {
            telemetryData
                .where(
                  (telemetry) => telemetry.name == energyTranslateList['power'],
            )
                .first
              ..updateTime = DateTime.fromMillisecondsSinceEpoch(
                element.value[0][0] as int,
              )
              ..data = double.parse(element.value[0][1] as String);
          }
        }
        final voltageData = telemetryData
            .where(
              (telemetry) => telemetry.name == energyTranslateList['voltage'],
        )
            .first;
        final powerData = telemetryData
            .where(
              (telemetry) => telemetry.name == energyTranslateList['power'],
        )
            .first;
        final current = powerData.data / voltageData.data * 10000;
        final currentTime = powerData.updateTime;
        telemetryData
            .where(
              (telemetry) => telemetry.name == energyTranslateList['current'],
        )
            .first
          ..updateTime = currentTime
          ..data = current.floorToDouble() / 10;
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
    return ListView.builder(
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
                  title: Text(
                    '${telemetry.name}: ${telemetry.data} ${telemetry.unit}',
                  ),
                  subtitle: Text(formatter.format(telemetry.updateTime)),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: telemetryData.length,
    );
  }
}
