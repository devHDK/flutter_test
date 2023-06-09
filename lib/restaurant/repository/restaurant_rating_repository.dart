import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/model/pagination_params.dart';
import 'package:actual/common/repository/base_pagination_repository.dart';
import 'package:actual/rating/model/rating_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_rating_repository.g.dart';

final restuarantRatingRepositoryProvider =
    Provider.family<RestuarantRatingRepository, String>((ref, id) {
  final dio = ref.watch(dioProvider);

  return RestuarantRatingRepository(dio,
      baseUrl: 'http://$ip/restaurant/$id/rating');
});

@RestApi()
abstract class RestuarantRatingRepository
    implements IBasePaginationRepository<RatingModel> {
  factory RestuarantRatingRepository(Dio dio, {String baseUrl}) =
      _RestuarantRatingRepository;

  //http://$ip/restaurant/:rid/rating
  @override
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
