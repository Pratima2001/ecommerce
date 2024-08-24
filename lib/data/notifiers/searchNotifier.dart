import 'dart:async';

import 'package:ecommerce1/data/models/productModule.dart';
import 'package:ecommerce1/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/search.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState());

  Timer? _debounce;

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) return;

      state = state.copyWith(isLoading: true, error: '');
      try {
        // Replace with your API call
        final results = await fetchResults(query);
        state = state.copyWith(isLoading: false, results: results);
      } catch (e) {
        state = state.copyWith(isLoading: false, error: e.toString());
      }
    });
  }

  Future<List<Product>> fetchResults(String query) async {
    // Simulate API call
    return getSearchResult(query);
  }
}
