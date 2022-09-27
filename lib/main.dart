import 'package:flutter/material.dart';
import 'yt_parser.dart';
import 'screen_widget.dart';
import 'package:home_widget/home_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(bgCallback);

  runApp(const MyApp());
}

Future<void> bgCallback(Uri? uri) async {
  if (uri?.host == 'refresh') {
    ScreenWidget.updateAppWidget();
    print('updated through the widget');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
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
    //HomeWidget.widgetClicked.listen((Uri? uri) => ScreenWidget.loadData());
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'CHANNEL STATISTICS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('NAME: ${gatheredInfo.channelTitle}'),
            Text('${gatheredInfo.channelCustomUrl}'),
            Text('Channel views: ${gatheredInfo.channelViewCount}'),
            Text('Subs: ${gatheredInfo.subscriberCount}'),
            Text('Total videos: ${gatheredInfo.videoCount}'),
            Text('Latest video name: ${gatheredInfo.latestVideoTitle}'),
            Image.network(
              '${gatheredInfo.latestVideoThumbnail}',
              scale: 1,
              height: 100,
            ),
            Text('Views: ${gatheredInfo.latestVideoViewCount}'),
            Text('Likes: ${gatheredInfo.latestVideoLikeCount}'),
            Text('Most viewed video: ${gatheredInfo.bestVideoTitle}'),
            Text('Views: ${gatheredInfo.bestVideoViewCount}'),
            Image.network(
              '${gatheredInfo.bestVideoThumbnail}',
              scale: 1,
              height: 100,
            ),
            Text('Last time updated: ${gatheredInfo.updateTime}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshData,
        child: const Icon(Icons.replay_rounded),
      ),
    );
  }
}
