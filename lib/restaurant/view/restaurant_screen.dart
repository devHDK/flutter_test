import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/restaurant/component/restaurent_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurentScreen extends ConsumerWidget {
  const RestaurentScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final dio = ref.watch(dioProvider);

    final response =
        await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
            .paginate();

    return response.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.separated(
        itemCount: data.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10.0,
          );
        },
        itemBuilder: (context, index) {
          final model = data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RestaurantDetailScreen(id: model.id),
              ));
            },
            child: RestaurantCard.fromModel(
              model: model,
            ),
          );
        },
      ),
    );
  }
}
