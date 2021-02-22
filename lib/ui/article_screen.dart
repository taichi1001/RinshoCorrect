import 'package:flutter/material.dart';
import 'package:rinsho_collect/entity/term.dart';
import 'package:rinsho_collect/model/article_screen_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rinsho_collect/model/bookmark_controller.dart';
import 'package:rinsho_collect/ui/parts/term_view.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chewie/chewie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blockquote/blockquote.dart';

final id = ScopedProvider<String>(null);

class ArticleScreen extends HookWidget {
  const ArticleScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _id = useProvider(id);
    useEffect(() {
      context.read(articleScreenController).init(_id);
      return;
    }, []);

    final _article = useProvider(currentArticle).state;

    if (_article == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final controller = SheetController();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SlidingSheet(
          color: Theme.of(context).canvasColor,
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
                color: const Color(0xFFA7D0BE),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.school_outlined),
                    SizedBox(width: 8),
                    Text(
                      '専門用語解説',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
    final _article = useProvider(currentArticle).state;
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
    final _article = useProvider(currentArticle).state;
    final _isFavorite = useProvider(currentBookmark(_article.id)).state;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _Title(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(_article.author),
                    const SizedBox(width: 16),
                    Text(_article.publishedAt.toIso8601String()),
                    const SizedBox(width: 16),
                  ],
                ),
                if (_isFavorite)
                  IconButton(
                    icon: const Icon(Icons.bookmark, color: Colors.amber),
                    color: Colors.amber,
                    onPressed: () => context.read(bookmarkController).changeIsBookmark(_article.id),
                  )
                else
                  IconButton(
                    icon: const Icon(Icons.bookmark_border_outlined, color: Colors.grey),
                    color: Colors.grey,
                    onPressed: () => context.read(bookmarkController).changeIsBookmark(_article.id),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                const Icon(Icons.public),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.twitter),
                  onPressed: () {
                    launchURL(
                      _article.twitter,
                      secondUrl: 'https://twitter.com/riscait',
                    );
                  },
                ),
                const SizedBox(width: 16),
                const Icon(FontAwesomeIcons.instagram),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _Abstract(),
          const SizedBox(height: 8),
          const _ApprochTarget(),
          const SizedBox(height: 8),
          const _Video(),
          const SizedBox(height: 16),
          const _Background(),
          const SizedBox(height: 8),
          const _Document(),
          const SizedBox(height: 8),
          SizedBox(height: 56.h),
        ],
      ),
    );
  }
}

class _Title extends HookWidget {
  const _Title({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Text(
        useProvider(currentArticle).state.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
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
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFe7f2ee)),
            color: const Color(0xFFe7f2ee),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  '概要',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(thickness: 1, endIndent: 100),
            ],
          ),
        ),
        Html(data: useProvider(currentArticle).state.abstract, style: {
          'ul': Style(
            fontSize: const FontSize(14),
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
          ),
        }),
      ],
    );
  }
}

class _ApprochTarget extends HookWidget {
  const _ApprochTarget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            'アプローチ対象',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(thickness: 1, endIndent: 100),
        Html(
          data: useProvider(currentArticle).state.approchTarget,
          style: {
            'li': Style(
              fontSize: const FontSize(14),
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
            ),
          },
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
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'アプローチ動画',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(thickness: 1, endIndent: 100),
          Container(
            height: 200,
            color: Colors.black,
            child: _isLoading && _chewieController != null
                ? Chewie(
                    controller: _chewieController,
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}

class _Background extends HookWidget {
  const _Background({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'アプローチの背景',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Divider(thickness: 1, endIndent: 100),
          Html(
            data: useProvider(currentArticle).state.body,
            customRender: {
              'blockquote': (RenderContext context, Widget child, attributes, _) {
                return BlockQuote(
                  blockColor: const Color(0xFFA7D0BE),
                  childPadding: EdgeInsets.zero,
                  outerPadding: EdgeInsets.zero,
                  child: child,
                );
              },
            },
            style: {
              'p': Style(
                fontSize: const FontSize(14),
              ),
              'blockquote': Style(
                margin: const EdgeInsets.only(left: 8, right: 8),
              ),
            },
          ),
        ],
      ),
    );
  }
}

class _Document extends HookWidget {
  const _Document({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Text(
            '参考文献',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(thickness: 1, endIndent: 100),
        Html(
          data: useProvider(currentArticle).state.references,
          style: {
            'p': Style(
              fontSize: const FontSize(14),
            ),
          },
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
