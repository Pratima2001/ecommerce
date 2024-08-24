
import '../models/productModule.dart';

class SearchState {
  final bool isLoading;
  final List<Product> results;
  final String error;

  SearchState({
    this.isLoading = false,
    this.results = const [],
    this.error = '',
  });

  SearchState copyWith({
    bool? isLoading,
    List<Product>? results,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      error: error ?? this.error,
    );
  }
}
