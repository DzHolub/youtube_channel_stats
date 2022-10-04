import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'yt_parser.dart';
import 'home_screen_widget.dart';
import 'package:home_widget/home_widget.dart';
import '/screens/main_screen.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  HomeWidget.registerBackgroundCallback(bgCallback);

  runApp(const MyApp());
}

Future<void> bgCallback(Uri? uri) async {
  if (uri?.host == 'refresh') ScreenWidget.updateAppWidget();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appCustomTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FinalData gatheredInfo = FinalData();

  @override
  void initState() {
    super.initState();
    HomeWidget.widgetClicked.listen((Uri? uri) => _getWidgetData());
    _getWidgetData();
  }

  void _getWidgetData() async {
    gatheredInfo = await ScreenWidget.loadData();
    setState(() {});
  }

  void _refreshData() async {
    gatheredInfo = await ScreenWidget.updateAppWidget();
    print('Previous data: ${ScreenWidget.previouslySavedInfo?.updateTime}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YOUTUBE STATS')),
      body: Center(
        child: MainScreen(gatheredInfo: gatheredInfo),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        height: 50,
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          onPressed: _refreshData,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('${gatheredInfo.updateTime}'),
            const Icon(Icons.replay_rounded)
          ]),
        ),
      ),
    );
  }
}
