import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rinsho_collect/entity/article.dart';

part 'article_state.freezed.dart';

@freezed
abstract class ArticleState implements _$ArticleState {
  factory ArticleState({
    @Default(null) List<Article> articles,
    @Default(SortOrder.ASC) SortOrder sort,
  }) = _ArticleState;

  ArticleState._();

  @late
  List<CartItem> get sortedItems =>
      itemMap.values.toList()..sort((a, b) => a.item.id.compareTo(b.item.id));

  @late
  CartSummary get summary => CartSummary(
        quantity: itemMap.values.fold<int>(
          0,
          (sum, e) => sum + e.quantity,
        ),
        totalPrice: itemMap.values.fold<int>(
          0,
          (sum, e) => sum + e.item.price * e.quantity,
        ),
      );

  CartItem cartItem(Item item) => sortedItems.firstWhere(
        (cartItem) => cartItem.item == item,
        orElse: () => null,
      );
}

enum SortOrder {
  ASC,
  DESC,
}

final _sortOrder = StateProvider.autoDispose((ref) => SortOrder.ASC);
final _articles = StateProvider.autoDispose<List<Article>>((ref) => null);

final sortedArticles = StateProvider.autoDispose((ref) {
  final List<Article> articles = ref.watch(_articles).state;
  final sortOrder = ref.watch(_sortOrder).state;

  if (sortOrder == SortOrder.ASC) {
    articles?.sort((a, b) => a.publishedAt.compareTo(b.publishedAt));
  } else {
    articles?.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }
  return articles;
});
