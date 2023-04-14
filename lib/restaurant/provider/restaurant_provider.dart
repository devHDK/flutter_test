import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/common/model/pagination_params.dart';
import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantDetailProvider = Provider.family<RestaurantModel?, String>(
  (ref, id) {
    final state = ref.watch(restaurantProvider);

    if (state is! CursorPagination) {
      return null;
    }
    return state.data.firstWhere((element) => element.id == id);
  },
);

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>(
  // generic 필수..
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);
    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 20,
    //추가로 데이터 더 가져오기
    //true - 추가로 데이터 더 가져옴
    //false - 새로고침 (현재 상태를 덮어씌움)
    bool fetchMore = false,

    //강제로 다시 로딩하기
    //true - CursorPaginationLoading()
    bool forceRefetch = false,
  }) async {
    try {
      //5가지 경우의 수
      //state 상태
      //[상태가]
      //1)CursorPagination - 정상적으로 데이터가 있는 상태
      //2)CursorPaginationLoading - 데이터가 로딩중인 상태 (캐시 없음)
      //3)CursorPaginationError - 에러가 있는 상태
      //4)CursorPaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올때
      //5)CursorPaginationFetchingMore - 추가데이터를 paginate 해오라는 요청을 받았을때

      //바로 반환하는 상황
      //1) hasMore == false  (기존 상태에서 이미 다음데이터가 없다는 값을 들고 있다면)
      //2) 로딩중 - fetchMore == true
      //          fetchMore == false 일때 - 새로 고침의 의도가 있을수 있다.

      //1)hasMore == false
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          // 더이상 데이터가 없을때
          return;
        }
      }

      //세가지 로딩 상태
      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      //2) 반환 상황
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      //PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(count: fetchCount);

      //fetchMore
      //데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      } else {
        //데이터를 처음부터 가져오는 상황

        //만약 데이터가 있는 상황이라면
        // 기존 데이터를 보존한채로 Fetch 진행
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;
          state = CursorPaginationRefetching(
            meta: pState.meta,
            data: pState.data,
          );
        } else {
          //나머지 상황
          state = CursorPaginationLoading();
        }
      }

      final response =
          await repository.paginate(paginationParams: paginationParams);

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        state = response.copyWith(
          data: [
            ...pState.data, // 기존 데이터
            ...response.data, //추가 데이터
          ],
        );
      } else {
        state = response;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다');
    }
  }

  void getDetail({
    required String id,
  }) async {
    //만약에 아직 데이터가 하나도 없는 상태라면 (CursorPagination이 아니라면)
    if (state is! CursorPagination) {
      await paginate();
    }

    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;
    final response = await repository.getRestaurantDetail(id: id);

    state = pState.copyWith(
        //기존 state로 대체
        data: pState.data
            .map<RestaurantModel>(
              (e) => e.id == id ? response : e,
            )
            .toList());
  }
}
