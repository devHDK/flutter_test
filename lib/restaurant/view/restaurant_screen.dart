import 'package:actual/common/component/pagination_list_view.dart';
import 'package:actual/restaurant/component/restaurent_card.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';

class RestaurentScreen extends StatelessWidget {
  const RestaurentScreen({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(context, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RestaurantDetailScreen(
                id: model.id,
              ),
            ));
          },
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
    );
  }
}
