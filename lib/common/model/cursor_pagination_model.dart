import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> {
  CursorPaginationMeta meta;
  List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  int count;
  bool hasMore;

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}
