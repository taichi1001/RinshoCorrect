import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rinsho_collect/entity/article.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chewie/chewie.dart';
import 'package:rinsho_collect/model/article_view_model.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({
    @required this.article,
    Key key,
  }) : super(key: key);

  final Article article;
  @override
  Widget build(BuildContext context) {
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
        builder: (context, state) {
          return GestureDetector(
            onTap: () => controller.collapse(),
            child: Container(
              height: 1000.h,
              color: Colors.grey, // なぜかcolor消すと動かない
              child: const Center(
                child: Text('test'),
              ),
            ),
          );
        },
        headerBuilder: (context, state) {
          return GestureDetector(
            onTap: () => controller.collapse(),
            child: Container(
              height: 56.h,
              width: 200.h,
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                'This is the header',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Colors.white),
              ),
            ),
          );
        },
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<ArticleViewModel>(
              create: (context) => ArticleViewModel(),
              builder: (context, baz) {
                final _chewieController = context
                    .select((ArticleViewModel model) => model.chewieController);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                        article.eyecatch.toString(),
                      ),
                      Text(article.title),
                      Html(
                        data: article.abst,
                      ),
                      // Container(
                      //   height: 200,
                      //   child: Chewie(
                      //     controller: _chewieController,
                      //   ),
                      // ),
                      Html(data: article.body),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
