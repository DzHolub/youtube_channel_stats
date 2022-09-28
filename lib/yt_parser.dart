import 'keys.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:home_widget/home_widget.dart';

const String kChannelPage =
    'https://www.googleapis.com/youtube/v3/channels?part=statistics,snippet&id=';
const String kSearchLastVideo =
    "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&order=date&type=video&channelId=";
const String kSearchBestVideo =
    "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&order=viewCount&type=video&channelId=";
const String kVideoPage =
    "https://www.googleapis.com/youtube/v3/videos?part=statistics,snippet&id=";

class YoutubeData {
  YoutubeData(
      {this.channelTitle,
      this.channelCustomUrl,
      this.viewCount,
      this.subscriberCount,
      this.videoCount,
      this.videoTitle,
      this.likeCount,
      this.videoId,
      this.videoThumbnail});

  String? channelTitle;
  String? channelCustomUrl;
  String? viewCount;
  String? subscriberCount;
  String? videoCount;
  String? videoTitle;
  String? likeCount;
  String? videoId;
  String? videoThumbnail;

  factory YoutubeData.fromJson(Map<String, dynamic> json) => YoutubeData(
        channelTitle: json["items"][0]["kind"] == "youtube#searchResult"
            ? 'null'
            : json["items"][0]["snippet"]["title"],
        channelCustomUrl: json["items"][0]["kind"] == "youtube#searchResult"
            ? 'null'
            : json["items"][0]["snippet"]["customUrl"],
        viewCount: json["items"][0]["kind"] == "youtube#searchResult"
            ? 'null'
            : json["items"][0]["statistics"]["viewCount"],
        subscriberCount: json["items"][0]["kind"] == "youtube#searchResult"
            ? 'null'
            : json["items"][0]["statistics"]["subscriberCount"],
        videoCount: json["items"][0]["kind"] == "youtube#searchResult"
            ? 'null'
            : json["items"][0]["statistics"]["videoCount"],
        likeCount: json["items"][0]["kind"] == "youtube#searchResult"
            ? 'null'
            : json["items"][0]["statistics"]["likeCount"],
        videoTitle: json["items"][0]["kind"] == "youtube#video"
            ? json["items"][0]["snippet"]["title"]
            : 'null',
        videoId: json["items"][0]["kind"] == "youtube#searchResult"
            ? json["items"][0]["id"]["videoId"]
            : 'null',
        videoThumbnail: json["items"][0]["kind"] == "youtube#video"
            ? json["items"][0]["snippet"]["thumbnails"]["high"]["url"]
            : 'null',
      );

  static YoutubeData channelFromJson(String str) =>
      YoutubeData.fromJson(json.decode(str));

  static Future<dynamic> fetchData(String page, String id) async {
    final response = await http.get(Uri.parse('$page$id&key=$apiKey'));

    if (response.statusCode == 200) {
      return channelFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class FinalData {
  FinalData({
    this.channelTitle,
    this.channelCustomUrl,
    this.channelViewCount,
    this.subscriberCount,
    this.videoCount,
    this.latestVideoTitle,
    this.latestVideoThumbnail,
    this.latestVideoViewCount,
    this.latestVideoLikeCount,
    this.bestVideoTitle,
    this.bestVideoThumbnail,
    this.bestVideoViewCount,
    this.bestVideoLikeCount,
    this.updateTime,
  });

  String? channelTitle;
  String? channelCustomUrl;
  String? channelViewCount;
  String? subscriberCount;
  String? videoCount;
  String? latestVideoTitle;
  String? latestVideoThumbnail;
  String? latestVideoViewCount;
  String? latestVideoLikeCount;
  String? bestVideoTitle;
  String? bestVideoThumbnail;
  String? bestVideoViewCount;
  String? bestVideoLikeCount;
  String? updateTime;

  static Future<FinalData> getData() async {
    YoutubeData getChannelInfo =
        await YoutubeData.fetchData(kChannelPage, channelId);
    YoutubeData getLatestVideo =
        await YoutubeData.fetchData(kSearchLastVideo, channelId);
    YoutubeData getLatestVideoInfo =
        await YoutubeData.fetchData(kVideoPage, getLatestVideo.videoId!);
    YoutubeData getBestVideo =
        await YoutubeData.fetchData(kSearchBestVideo, channelId);
    YoutubeData getBestVideoInfo =
        await YoutubeData.fetchData(kVideoPage, getBestVideo.videoId!);

    DateTime _getTime = DateTime.now().toLocal();
    String _convertedTime =
        "${_getTime.hour.toString().padLeft(2, '0')}:${_getTime.minute.toString().padLeft(2, '0')}:${_getTime.second.toString().padLeft(2, '0')} ${_getTime.day.toString().padLeft(2, '0')}.${_getTime.month.toString().padLeft(2, '0')}.${_getTime.year.toString()}";

    return FinalData(
      channelTitle: getChannelInfo.channelTitle,
      channelCustomUrl: getChannelInfo.channelCustomUrl,
      channelViewCount: getChannelInfo.viewCount,
      subscriberCount: getChannelInfo.subscriberCount,
      videoCount: getChannelInfo.videoCount,
      latestVideoTitle: getLatestVideoInfo.videoTitle,
      latestVideoThumbnail: getLatestVideoInfo.videoThumbnail,
      latestVideoViewCount: getLatestVideoInfo.viewCount,
      latestVideoLikeCount: getLatestVideoInfo.likeCount,
      bestVideoTitle: getBestVideoInfo.videoTitle,
      bestVideoThumbnail: getBestVideoInfo.videoThumbnail,
      bestVideoViewCount: getBestVideoInfo.viewCount,
      bestVideoLikeCount: getBestVideoInfo.likeCount,
      updateTime: _convertedTime,
    );
  }

  static Future<FinalData> getSavedDataFromDevice() async {
    dynamic deviceData = await HomeWidget.getWidgetData<String>('ytData',
        defaultValue: jsonEncode(FinalData()));
    deviceData = jsonDecode(deviceData);

    return FinalData(
      channelTitle: deviceData['channelTitle'],
      channelCustomUrl: deviceData['channelCustomUrl'],
      channelViewCount: deviceData['channelViewCount'],
      subscriberCount: deviceData['subscriberCount'],
      videoCount: deviceData['videoCount'],
      latestVideoTitle: deviceData['latestVideoTitle'],
      latestVideoThumbnail: deviceData['latestVideoThumbnail'],
      latestVideoViewCount: deviceData['latestVideoViewCount'],
      latestVideoLikeCount: deviceData['latestVideoLikeCount'],
      bestVideoTitle: deviceData['bestVideoTitle'],
      bestVideoThumbnail: deviceData['bestVideoThumbnail'],
      bestVideoViewCount: deviceData['bestVideoViewCount'],
      bestVideoLikeCount: deviceData['bestVideoLikeCount'],
      updateTime: deviceData['updateTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'channelTitle': channelTitle,
        'channelCustomUrl': channelCustomUrl,
        'channelViewCount': channelViewCount,
        'subscriberCount': subscriberCount,
        'videoCount': videoCount,
        'latestVideoTitle': latestVideoTitle,
        'latestVideoThumbnail': latestVideoThumbnail,
        'latestVideoViewCount': latestVideoViewCount,
        'latestVideoLikeCount': latestVideoLikeCount,
        'bestVideoTitle': bestVideoTitle,
        'bestVideoThumbnail': bestVideoThumbnail,
        'bestVideoViewCount': bestVideoViewCount,
        'bestVideoLikeCount': bestVideoLikeCount,
        'updateTime': updateTime,
      };
}
