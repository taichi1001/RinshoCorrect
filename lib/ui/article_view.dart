import 'package:flutter/material.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/entity/term.dart';
import 'package:rinsho_collect/model/article_view_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chewie/chewie.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleView extends HookWidget {
  const ArticleView({
    @required this.article,
    Key key,
  }) : super(key: key);

  final Article article;
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read(articleViewController).init(article.videoURL);
      return;
    }, []);

    final controller = SheetController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細'),
      ),
      body: SlidingSheet(
        controller: controller,
        elevation: 8,
        cornerRadius: 16,
        snapSpec: SnapSpec(
          snappings: [56.h, 300.h, 700.h],
          positioning: SnapPositioning.pixelOffset,
        ),
        headerBuilder: (context, state) {
          return GestureDetector(
            onTap: () => controller.expand(),
            child: Container(
              height: 56.h,
              color: Colors.green,
              alignment: Alignment.center,
              child: const Text('This is the header'),
            ),
          );
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => controller.collapse(),
            child: Container(
              // height: 400,
              // color: Colors.red,
              child: _Glossary(article: article),
            ),
          );
        },
        body: _Body(article: article),
      ),
    );
  }
}

class _Glossary extends HookWidget {
  const _Glossary({
    @required this.article,
    Key key,
  }) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: article.glossary.length,
      itemBuilder: (context, index) => ProviderScope(
        overrides: [
          currentTerm.overrideWithValue(article.glossary[index]),
        ],
        child: const _GlossaryTile(),
      ),
    );
  }
}

final currentTerm = ScopedProvider<Term>(null);

class _GlossaryTile extends HookWidget {
  const _GlossaryTile({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _currentTerm = useProvider(currentTerm);
    return TextButton(
      onPressed: () {
        _showAsBottomSheet(context, _currentTerm);
      },
      child: Text(_currentTerm.term),
    );
  }
}

Future _showAsBottomSheet(BuildContext context, Term term) async {
  await showSlidingBottomSheet(
    context,
    builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: SnapSpec(
          snappings: [300.h, 700.h],
          positioning: SnapPositioning.pixelOffset,
        ),
        builder: (context, state) {
          return Material(
            color: Colors.white,
            child: Container(
              height: 300.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      term.term,
                      style: const TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 16,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Html(data: term.detail),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class _Body extends HookWidget {
  const _Body({
    @required this.article,
    Key key,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    final _chewieController = useProvider(chewieController).state;
    final _isLoading = useProvider(isLoading).state;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              article.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            height: 16,
            thickness: 1,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Text(
              '概要',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Html(
              data: article.abst,
            ),
          ),
          Container(
            height: 200,
            child: _isLoading && _chewieController != null
                ? Chewie(
                    controller: _chewieController,
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Text(
              '動画解説',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Html(
              data: article.videoAbs,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Text(
              'アプローチの背景',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Html(data: article.body),
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Text(
              '文献',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Text(
              '著者',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          RaisedButton(
            onPressed: () => _launchURL(
              'https://twitter.com/shiita93781732?s=11',
              secondUrl: 'https://twitter.com/riscait',
            ),
            child: const Text('Twitterを開く'),
          ),

          SizedBox(height: 56.h),
        ],
      ),
    );
  }
}

Future _launchURL(String url, {String secondUrl}) async {
  if (await canLaunch(url)) {
    await launch(url, universalLinksOnly: true);
  } else if (secondUrl != null && await canLaunch(secondUrl)) {
    await launch(secondUrl);
  } else {
    // 任意のエラー処理
  }
}
