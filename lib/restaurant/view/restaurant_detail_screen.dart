import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/product/component/product_card.dart';
import 'package:actual/restaurant/component/restaurent_card.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
  });

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final response = await dio.get(
      'http://$ip/restaurant/$id',
      options: Options(
        headers: {'authorization': 'Bearer $accessToken'},
      ),
    );

    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRestaurantDetail(),
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

        final item = RestaurantDetailModel.fromJson(snapshot.data!);

        return DefaultLayout(
          title: item.name,
          child: CustomScrollView(
            slivers: [
              renderTop(model: item),
              renderLabel(),
              renderProduct(products: item.products),
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
