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
        const Text(
          'LATEST VIDEO',
          style: TextStyle(fontSize: 20),
        ),
        Flexible(
          flex: 3,
          child: Stack(
            children: [
              Image.network(
                '${gatheredInfo.latestVideoThumbnail}',
                scale: 1,
              ),
              Text(
                '${gatheredInfo.latestVideoTitle}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  shadows: [
                    BoxShadow(
                        color: Colors.black,
                        spreadRadius: 20.0,
                        blurRadius: 10.0)
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                      size: 30,
                      shadows: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 20.0,
                            blurRadius: 10.0)
                      ],
                    ),
                    Text(' ${gatheredInfo.latestVideoViewCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          shadows: [
                            BoxShadow(
                                color: Colors.black,
                                spreadRadius: 20.0,
                                blurRadius: 10.0)
                          ],
                        )),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                      size: 30,
                      shadows: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 20.0,
                            blurRadius: 10.0)
                      ],
                    ),
                    Text(' ${gatheredInfo.latestVideoLikeCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          shadows: [
                            BoxShadow(
                                color: Colors.black,
                                spreadRadius: 20.0,
                                blurRadius: 10.0)
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        const Text(
          'MOST VIEWED',
          style: TextStyle(fontSize: 20),
        ),
        Flexible(
          flex: 3,
          child: Stack(
            children: [
              Image.network(
                '${gatheredInfo.bestVideoThumbnail}',
                scale: 1,
              ),
              Text(
                '${gatheredInfo.bestVideoTitle}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  shadows: [
                    BoxShadow(
                        color: Colors.black,
                        spreadRadius: 20.0,
                        blurRadius: 10.0)
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                      size: 30,
                      shadows: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 20.0,
                            blurRadius: 10.0)
                      ],
                    ),
                    Text(' ${gatheredInfo.bestVideoViewCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          shadows: [
                            BoxShadow(
                                color: Colors.black,
                                spreadRadius: 20.0,
                                blurRadius: 10.0)
                          ],
                        )),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                      size: 30,
                      shadows: [
                        BoxShadow(
                            color: Colors.black,
                            spreadRadius: 20.0,
                            blurRadius: 10.0)
                      ],
                    ),
                    Text(' ${gatheredInfo.bestVideoLikeCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          shadows: [
                            BoxShadow(
                                color: Colors.black,
                                spreadRadius: 20.0,
                                blurRadius: 10.0)
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
