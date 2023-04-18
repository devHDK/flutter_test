import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/provider/pagination_provider.dart';
import 'package:actual/rating/model/rating_model.dart';
import 'package:actual/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingStatenotifier, CursorPaginationBase, String>((ref, id) {
  final repo = ref.watch(restuarantRatingRepositoryProvider(id));

  return RestaurantRatingStatenotifier(repository: repo);
});

class RestaurantRatingStatenotifier
    extends PaginationProvider<RatingModel, RestuarantRatingRepository> {
  RestaurantRatingStatenotifier({required super.repository});
}
