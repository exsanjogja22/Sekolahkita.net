import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smkn1contoh/app/config/app_colors.dart';
import 'package:smkn1contoh/app/modules/detail_status/views/detail_status_view.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeHelperView extends StatefulWidget {
  const YoutubeHelperView(
      {Key? key,
      this.idYoutube,
      this.judul,
      this.keterangan,
      this.id,
      this.title})
      : super(key: key);
  final String? idYoutube;
  final String? judul;
  final String? keterangan;
  final String? id;
  final String? title;

  @override
  State<YoutubeHelperView> createState() => _YoutubeHelperViewState();
}

class _YoutubeHelperViewState extends State<YoutubeHelperView> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  bool _isPlayerReady = false;
  File? _file;
  ScreenshotController screenshotController = ScreenshotController();

  _takescreenshot() async {
    _file = null;
    screenshotController
        .capture(delay: const Duration(microseconds: 10), pixelRatio: 2.0)
        .then((Uint8List? imageBytes) async {
      final directory = (await getApplicationDocumentsDirectory()).path;

      _file = await File('$directory/image.jpg').writeAsBytes(imageBytes!);
      Share.shareXFiles([XFile(_file!.path)], text: 'Great picture');
      _controller.pause();
    }).catchError((e) {
      if (kDebugMode) {
        print(e.toString());
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.idYoutube!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: YoutubePlayerBuilder(
        onExitFullScreen: () {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: SystemUiOverlay.values);
        },
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: AppColors.appBarColors,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(
              isExpanded: true,
              colors: const ProgressBarColors(
                playedColor: AppColors.appBarColors,
                handleColor: AppColors.appBarColors,
              ),
            )
          ],
          topActions: <Widget>[
            SizedBox(width: 8.0.w),
            Expanded(
              child: Text(
                widget.title!.toTitleCase(),
                style: GoogleFonts.quicksand(
                  color: Colors.white,
                  fontSize: 18.0.sp,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 25.0,
              ),
              onPressed: () {},
            ),
          ],
          onReady: () {
            _isPlayerReady = true;
          },
        ),
        builder: (context, player) => Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appBarColors,
            centerTitle: true,
            title: Text(
              widget.judul!.toTitleCase(),
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18.sp,
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15.w,
                child: InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.help,
                    size: 15.w,
                    color: AppColors.appGreenlight,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              CircleAvatar(
                radius: 15.w,
                backgroundColor: Colors.white,
                child: InkWell(
                  onTap: () async {
                    _controller.pause();
                    await Share.shareWithResult(
                        'chttps://smk1contoh.sekolahkita.net/app/student/elearning/detail_materi/${widget.id}');
                  },
                  child: Icon(
                    Icons.share,
                    size: 15.w,
                    color: AppColors.appGreenlight,
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
            ],
            leading: Padding(
              padding: EdgeInsets.all(10.w),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 15.w,
                    color: AppColors.appGreenlight,
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              player,
              Container(
                height: 40.h,
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        TextButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              "assets/icons/disagreements.png",
                              width: 15.w,
                              height: 15.h,
                              color: Colors.grey,
                            ),
                            label: Text("(1)",
                                style: GoogleFonts.quicksand(
                                  fontSize: 10.sp,
                                ))),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            "assets/icons/disagreementz.png",
                            width: 15.h,
                            height: 15.h,
                            color: Colors.grey,
                          ),
                          label: Text(
                            "(0)",
                            style: GoogleFonts.quicksand(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                      onPressed: _isPlayerReady
                          ? () {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                              setState(() {});
                            }
                          : null,
                    ),
                    IconButton(
                        icon: const Icon(
                          Icons.screenshot,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onPressed: () {
                          _takescreenshot();
                        }),
                    FullScreenButton(
                      controller: _controller,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: DefaultTabController(
                        length: 2,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            TabBar(
                              labelColor: Colors.black,
                              labelStyle: GoogleFonts.quicksand(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              indicatorColor: const Color(0xff20bfcc),
                              tabs: const [
                                Tab(
                                  text: 'Keterangan',
                                ),
                                Tab(
                                  text: 'Panduan',
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: <Widget>[
                                  ListView(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 15.h),
                                        child: HtmlWidget(
                                          widget.keterangan!,
                                          textStyle: GoogleFonts.quicksand(
                                            fontSize: 12.sp,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Center(
                                    child: Text(
                                      'Belum Ada Panduan ..',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
