import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurent_card.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurentScreen extends StatelessWidget {
  const RestaurentScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final response = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );

    return response.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        child: Center(
          child: FutureBuilder(
            future: paginateRestaurant(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: PRIMARY_COLOR,
                ));
              }

              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10.0,
                  );
                },
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  final model = RestaurantModel.fromJson(item);

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetailScreen(id: model.id),
                      ));
                    },
                    child: RestaurantCard.fromModel(
                      model: model,
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
