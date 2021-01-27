import 'package:flutter/material.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:rinsho_collect/entity/term.dart';
import 'package:rinsho_collect/model/article_screen_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rinsho_collect/ui/parts/term_view.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chewie/chewie.dart';
import 'package:url_launcher/url_launcher.dart';

final article = ScopedProvider<Article>(null);

class ArticleScreen extends HookWidget {
  const ArticleScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _article = useProvider(article);
    useEffect(() {
      context.read(articleScreenController).init(_article.videoURL);
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
              color: Colors.indigo,
              alignment: Alignment.center,
              child: const Text('This is the header'),
            ),
          );
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => controller.collapse(),
            child: const _Glossary(),
          );
        },
        body: const _Body(),
      ),
    );
  }
}

class _Glossary extends HookWidget {
  const _Glossary({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _article = useProvider(article);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _article.glossary.length,
      itemBuilder: (context, index) => ProviderScope(
        overrides: [currentTerm.overrideWithValue(_article.glossary[index])],
        child: const Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: _GlossaryTile(),
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            _showAsBottomSheet(context, _currentTerm);
          },
          child: Text(_currentTerm.term),
        ),
      ],
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
              child: ProviderScope(
                overrides: [viewTerm.overrideWithValue(term)],
                child: const TermView(),
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
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Title(),
            const SizedBox(height: 8),
            const Divider(height: 16, thickness: 1),
            const _Abstract(),
            const SizedBox(height: 8),
            const _Video(),
            const SizedBox(height: 8),
            const _Background(),
            const SizedBox(height: 8),
            const _Document(),
            const SizedBox(height: 8),
            const _Author(),
            SizedBox(height: 56.h),
          ],
        ),
      ),
    );
  }
}

class _Title extends HookWidget {
  const _Title({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      useProvider(article).title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _Abstract extends HookWidget {
  const _Abstract({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '概要',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Divider(thickness: 1, endIndent: 350),
        Html(
          data: useProvider(article).abst,
        ),
      ],
    );
  }
}

class _Video extends HookWidget {
  const _Video({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _chewieController = useProvider(chewieController).state;
    final _isLoading = useProvider(isLoading).state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          color: Colors.black,
          child: _isLoading && _chewieController != null
              ? Chewie(
                  controller: _chewieController,
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        // const Text(
        //   '動画解説',
        //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        // ),
        // Html(
        //   data: useProvider(article).videoAbs,
        // ),
      ],
    );
  }
}

class _Background extends HookWidget {
  const _Background({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'アプローチの背景',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Divider(thickness: 1, endIndent: 350),
        Html(data: useProvider(article).body),
      ],
    );
  }
}

class _Document extends HookWidget {
  const _Document({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '文献',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Divider(thickness: 1, endIndent: 350),
      ],
    );
  }
}

class _Author extends HookWidget {
  const _Author({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '著者',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Divider(thickness: 1, endIndent: 350),
        RaisedButton(
          onPressed: () => launchURL(
            'https://twitter.com/shiita93781732',
            secondUrl: 'https://twitter.com/riscait',
          ),
          child: const Text('Twitterを開く'),
        ),
      ],
    );
  }
}

Future launchURL(String url, {String secondUrl}) async {
  if (await canLaunch(url)) {
    await launch(url, universalLinksOnly: true);
  } else if (secondUrl != null && await canLaunch(secondUrl)) {
    await launch(secondUrl);
  } else {
    // 任意のエラー処理
  }
}
