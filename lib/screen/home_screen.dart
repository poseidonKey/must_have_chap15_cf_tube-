import 'package:flutter/material.dart';
import 'package:must_have_chap15_cf_tube/component/custom_youtube_player.dart';
import 'package:must_have_chap15_cf_tube/model/video_model.dart';
import 'package:must_have_chap15_cf_tube/repository/youtube_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // 제목 가운데 정렬
        title: const Text(
          '코팩튜브',
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: YoutubeRepository.getvideos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // 에러가 있을 경우 에러 화면에 표시하기
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (!snapshot.hasData) {
            // 로딩 중일 때 로딩위젯 보여주기
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: snapshot.data!
                  .map((e) => CustomYoutubePlayer(videoModel: e))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
