import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JointScreen extends StatelessWidget {
  const JointScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) => ArticleListCard(),
      ),
    );
  }
}

class ArticleListCard extends StatelessWidget {
  const ArticleListCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            Container(
              width: 200.w,
              height: 100.h,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text('タイトル'),
                    Text('概要'),
                    Text('#タグ'),
                  ],
                ),
                Icon(
                  Icons.favorite,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
