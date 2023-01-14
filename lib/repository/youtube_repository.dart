import 'package:dio/dio.dart';
import 'package:must_have_chap15_cf_tube/const/api.dart';
import 'package:must_have_chap15_cf_tube/model/video_model.dart';

class YoutubeRepository {
  static Future<List<VideoModel>> getvideos() async {
    final resp = await Dio().get(YOUTUBE_API_BASE_URL, queryParameters: {
      'channelId': CF_CHANNEL_ID,
      'maxResults': 50,
      'key': API_KEY,
      'part': 'snippet',
      'order': 'date',
    });
    final listWithData = resp.data["items"].where(
      (item) =>
          item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
    );
    return listWithData
        .map<VideoModel>((item) => VideoModel(
            id: item['id']['videoId'], title: item['snippet']['title']))
        .toList();
  }
}
