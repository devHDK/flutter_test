import 'package:actual/product/model/product_model.dart';
import 'package:actual/user/model/basket_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  BasketProvider() : super([]);

  Future<void> addToBasket({required ProductModel product}) async {
    //1) 아직 장바구니에 해당되는 상품이 없다면 장바구니에 상품을 추가한다.
    //2) 장바구니에 있다면 +1을 한다

    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (exists) {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count + 1) : e)
          .toList();
    } else {
      state = [
        ...state,
        BasketItemModel(count: 1, product: product),
      ];
    }
  }

  Future<void> removeFromBasket(
      {required ProductModel product, bool isDelete = false}) async {
    //1) 장바구니에 상품이 존재할때
    //  1.상품의 카운트가 1보다 크면 -1 한다.
    //  2.상품의 카운트가 1이면 삭제한다
    //2) 상품이 존재하지 않을때

    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (!exists) {
      return;
    }

    final existingProduct = state.firstWhere((e) => e.product.id == product.id);

    if (existingProduct.count == 1 || isDelete) {
      state = state.where((e) => e.product.id != product.id).toList();
    } else {
      state = state
          .map((e) =>
              e.product.id == product.id ? e.copyWith(count: e.count - 1) : e)
          .toList();
    }
  }
}
