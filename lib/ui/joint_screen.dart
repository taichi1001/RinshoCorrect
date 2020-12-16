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
        itemBuilder: (BuildContext context, int index) =>
            const ArticleListCard(),
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
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  color: Colors.blue,
                  height: 150.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        children: const [
                          Text(
                            'タイトル',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '概要',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '#タグ',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.favorite,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
