import 'package:flutter/material.dart';
import 'package:youtube_channel_stats/yt_parser.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    required this.gatheredInfo,
  }) : super(key: key);

  final FinalData gatheredInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      NetworkImage('${gatheredInfo.channelThumbnail}'),
                ),
              ],
            ),
            const SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${gatheredInfo.channelTitle}',
                    style: const TextStyle(fontSize: 30)),
                Text('${gatheredInfo.channelCustomUrl}'),
                Text('Views: ${gatheredInfo.channelViewCount}'),
                Text('Subs: ${gatheredInfo.subscriberCount}'),
                Text('Videos: ${gatheredInfo.videoCount}'),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Flexible(
          flex: 9,
          child: VideoInformationCard(
            videoType: "LATEST VIDEO",
            videoLikeCount: gatheredInfo.latestVideoLikeCount,
            videoThumbnail: gatheredInfo.latestVideoThumbnail,
            videoTitle: gatheredInfo.latestVideoTitle,
            videoViewCount: gatheredInfo.latestVideoViewCount,
          ),
        ),
        const SizedBox(height: 10),
        Flexible(
          flex: 9,
          child: VideoInformationCard(
            videoType: "MOST VIEWED",
            videoLikeCount: gatheredInfo.bestVideoLikeCount,
            videoThumbnail: gatheredInfo.bestVideoThumbnail,
            videoTitle: gatheredInfo.bestVideoTitle,
            videoViewCount: gatheredInfo.bestVideoViewCount,
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}

class VideoInformationCard extends StatelessWidget {
  final String? videoType;
  final String? videoThumbnail;
  final String? videoTitle;
  final String? videoViewCount;
  final String? videoLikeCount;

  const VideoInformationCard(
      {Key? key,
      required this.videoType,
      required this.videoThumbnail,
      required this.videoTitle,
      required this.videoViewCount,
      required this.videoLikeCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black87,
        ),
        Center(
          child: Image.network(
            videoThumbnail!,
          ),
        ),
        CardText("$videoType: $videoTitle", 18.0),
        Positioned(
          bottom: 0,
          child: Row(
            children: [
              const Icon(
                Icons.remove_red_eye,
                shadows: [BoxShadow(spreadRadius: 20.0, blurRadius: 10.0)],
              ),
              CardText(videoViewCount!, 18.0),
              const SizedBox(width: 10),
              const Icon(
                Icons.thumb_up,
                shadows: [BoxShadow(spreadRadius: 20.0, blurRadius: 10.0)],
              ),
              CardText(videoLikeCount!, 18.0),
            ],
          ),
        )
      ],
    );
  }
}

class CardText extends StatelessWidget {
  final String text;
  final double fontSize;

  const CardText(this.text, this.fontSize, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        shadows: const [BoxShadow(spreadRadius: 20.0, blurRadius: 10.0)],
      ),
    );
  }
}
