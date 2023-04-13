import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/component/product_card.dart';
import 'package:actual/restaurant/component/restaurent_card.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future:
          ref.watch(restaurantRepositoryProvider).getRestaurantDetail(id: id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.white,
            child: const Center(
                child: CircularProgressIndicator(
              color: PRIMARY_COLOR,
            )),
          );
        }

        return DefaultLayout(
          title: snapshot.data!.name,
          child: CustomScrollView(
            slivers: [
              renderTop(model: snapshot.data!),
              renderLabel(),
              renderProduct(products: snapshot.data!.products),
            ],
          ),
        );
      },
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  renderProduct({required List<RestaurantProduct> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(model: model),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
