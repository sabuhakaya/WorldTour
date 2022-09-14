import 'dart:io';
import 'package:battery/battery.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';
import 'detail_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:connectivity/connectivity.dart';
import 'notificationManager.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

const myTask = "myTask";
List<CountryInfo> countries = [];
NotificationManager n = new NotificationManager();


Future<List<CountryInfo>> fetchCountries() async {


  var url = 'https://restcountries.eu/rest/v2/all';
  var response = await http.get(url);

  var countriesJson = json.decode(response.body);

  for (var countrieJson in countriesJson) {
    CountryInfo country = CountryInfo(
      countrieJson["name"],
      countrieJson["nativeName"],
      countrieJson["region"],
      countrieJson["subregion"],
      countrieJson["demonym"],
      countrieJson["alpha2Code"],
      countrieJson["capital"],
      countrieJson["population"],
    );

    countries.add(country);
  }
  print(countries.length);

  return countries;
}


void callbackDispatcher() async {
  Workmanager.executeTask((taskName, inputData) async {
    switch (taskName) {
      case myTask:
        await fetchCountries();
        print('API successfully updated');

        break;
    }
    return Future.value(true);
  });
}

class SecondPage extends StatefulWidget {


  @override
  _SecondPageState createState() => _SecondPageState();
}
enum _Platform { android, ios }

class PlatformEnabledButton extends RaisedButton {
  final _Platform platform;

  PlatformEnabledButton({
    this.platform,
    @required Widget child,
    @required VoidCallback onPressed,
  })  : assert(child != null, onPressed != null),
        super(
          child: child,
          onPressed: (Platform.isAndroid && platform == _Platform.android ||
              Platform.isIOS && platform == _Platform.ios)
              ? onPressed
              : null);
}

class _SecondPageState extends State<SecondPage> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;



  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }


  Battery _battery = Battery();

  BatteryState _batteryState;
  StreamSubscription<BatteryState> _batteryStateSubscription;



  @override
  initState()
  {
    Workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );

    Workmanager.registerPeriodicTask(
      "1",
      myTask,
      frequency: Duration(minutes: 15),
    );


    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) {
          setState(() {
            _batteryState = state;
          });
        });
    super.initState();
    AndroidAlarmManager.periodic(Duration(hours: 24), 0, notificate, exact: true, wakeup: true, rescheduleOnReboot: true);
   // oneShotAt(DateTime.now().add(Duration(seconds: 5)), 0, notificate, exact: true, allowWhileIdle: true, wakeup: true, rescheduleOnReboot: true, alarmClock: true);
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white54,

        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text("List of Countries"),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.battery_unknown),

                onPressed: () async {
                  final int batteryLevel = await _battery.batteryLevel;
                  // ignore: unawaited_futures
                  showDialog<void>(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Text('Battery: $batteryLevel%'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: Icon(Icons.wifi),

                onPressed: () async {
                  // ignore: unawaited_futures
                  showDialog<void>(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Text('Connection Status: $_connectionStatus'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],

        ),
        body: Container(
          child: FutureBuilder(
            future: fetchCountries(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Icon(
                    Icons.error,
                  ),
                );
              } else if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(140.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.deepPurpleAccent,
                            ),
                            height: 90.0,
                            width: 100.0,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                              child: Text("  Awaiting result..."),
                              height: 100.0,
                              width: 250.0),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                      color: Colors.white,
                      height: 55.0,
                      child: ListTile(
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(snapshot.data[index])));

                        },

                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 6,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }


  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _enablePlatformOverrideForDesktop();
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription.cancel();

      _connectivitySubscription.cancel();
    }
  }
}
class CountryInfo {
  String name;
  String nativeName;
  String region;
  String subregion;
  String demonym;
  String alpha2Code;
  String capital;
  int population;


  CountryInfo(this.name,this.nativeName, this.region,this.subregion, this.demonym,this.alpha2Code,this.capital,this.population);
}

Future<void> notificate()
async {

  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  n.initNotificationManager();
  n.showNotificationWithDefaultSound("World Tour", "Let's have a world tour!");
  return;
}


