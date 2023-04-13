import 'package:actual/common/model/cursor_pagination_model.dart';
import 'package:actual/restaurant/component/restaurent_card.dart';
import 'package:actual/restaurant/provider/restaurant_provider.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurentScreen extends ConsumerStatefulWidget {
  const RestaurentScreen({super.key});

  @override
  ConsumerState<RestaurentScreen> createState() => _RestaurentScreenState();
}

class _RestaurentScreenState extends ConsumerState<RestaurentScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    //현재 위치가 최대 길이보다 조금 덜되는 위치까지 왔다면 새로운 데이터 추가 요청

    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(
            fetchMore: true,
          );
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final data = ref.watch(restaurantProvider);

    //첫로딩
    if (data is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    //error
    if (data is CursorPaginationError) {
      return Center(
        child: Text(data.message),
      );
    }

    // CursorPagination
    // CursorPaginationFetchingMore
    // CursorPaginationRefetching

    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.separated(
        itemCount: cp.data.length + 1,
        controller: controller,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10.0,
          );
        },
        itemBuilder: (context, index) {
          if (index == cp.data.length) {
            return Center(
              child: data is CursorPaginationFetchingMore
                  ? const CircularProgressIndicator()
                  : const Text('마지막 데이터 입니다.😂'),
            );
          }

          final model = cp.data[index];

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
