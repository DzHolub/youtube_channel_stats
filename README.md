# youtube_channel_stats

Fetch information from desired youtube channel and pass it into the home screen widget. 
Supported data:
* total channel views
* number of subscribers
* total number of uploaded videos
* latest uploaded video data (title, views, likes)
* the most viewed uploaded video data (title, views, likes)

<img src="https://user-images.githubusercontent.com/110247723/193867202-f38965e2-c932-4e4f-ba84-7b65adde6029.png" width="30%"><img src="https://user-images.githubusercontent.com/110247723/193867502-9e65f0bb-8ece-4b6d-ba9d-9cb76d40e8d7.png" width="30%">

## Getting Started

1. Create keys.dart in the lib folder.
2. Create google API key and activate YouTube Data API v3. Manual is here: https://developers.google.com/maps/documentation/javascript/get-api-key 
3. Inside keys.dart add 
const String apiKey = '[put your google API key here]';
const String channelId = '[put desired youtbe channel's ID here]';
4. after installation just add app's widget on your home screen.
5. Tap on the widget in order to refresh data or enter the app
