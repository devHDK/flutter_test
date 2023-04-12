import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String id;
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.detail,
    required this.price,
    required this.image,
  });

  factory ProductCard.fromModel({required RestaurantProduct model}) {
    return ProductCard(
      id: model.id,
      image: Image.network(
        'http://$ip${model.imgUrl}',
        height: 110,
        width: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8.0), child: image),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  detail,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '₩$price',
                  style: const TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
