import 'package:actual/common/const/colors.dart';
import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  //이미지
  final Widget image;
  //레스토랑 이름
  final String name;
  //레스토랑 태그
  final List<String> tags;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;

  const RestaurantCard(
      {super.key,
      required this.image,
      required this.name,
      required this.tags,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.ratings});

  factory RestaurantCard.fromModel({required RestaurantModel model}) {
    return RestaurantCard(
      image: Image.network(
        'http://$ip${model.thumbUrl}',
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: List<String>.from(model.tags),
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: image,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
        Text(
          tags.join(' ∙ '),
          style: const TextStyle(color: BODY_TEXT_COLOR),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            IconText(icon: Icons.star, label: ratings.toString()),
            IconText(icon: Icons.receipt, label: ratingsCount.toString()),
            IconText(icon: Icons.timelapse_outlined, label: '$deliveryTime분'),
            IconText(
                icon: Icons.monetization_on,
                label: deliveryFee == 0 ? '무료' : deliveryFee.toString()),
          ],
        )
      ],
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const IconText({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14.0,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Text(
          label,
          style: const TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14.0,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          width: 16.0,
        ),
      ],
    );
  }
}
