import 'package:home_widget/home_widget.dart';
import 'yt_parser.dart';
import 'dart:convert';

class ScreenWidget {
  static FinalData? previouslySavedInfo = FinalData();

  static Future<dynamic> loadData() async {
    FinalData? _gatheredInfo;
    await FinalData.getSavedDataFromDevice()
        .then((value) => _gatheredInfo = value);
    return _gatheredInfo;
  }

  static Future<dynamic> updateAppWidget() async {
    previouslySavedInfo = await loadData();
    FinalData? _gatheredInfo;
    await FinalData.getData().then((value) => _gatheredInfo = value);
    await HomeWidget.saveWidgetData<String>(
        'ytData', jsonEncode(_gatheredInfo));
    await dataForWidget(_gatheredInfo);
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
    return _gatheredInfo;
  }

  static Future<dynamic> dataForWidget(FinalData? gatheredInfo) async {
    await HomeWidget.saveWidgetData<String>(
        'channelViewCount', gatheredInfo?.channelViewCount);
    await HomeWidget.saveWidgetData<String>(
        'subscriberCount', gatheredInfo?.subscriberCount);
    await HomeWidget.saveWidgetData<String>(
        'channelTitle', gatheredInfo?.channelTitle);
    await HomeWidget.saveWidgetData<String>(
        'channelCustomUrl', gatheredInfo?.channelCustomUrl);
  }
}
