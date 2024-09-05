import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/components/base_view/base_view.dart';
import 'package:flutter_mvvm_riverpod/screens/search/search_view_model.dart';

class SearchScreen extends BaseView {
  const SearchScreen({super.key});

  @override
  BaseViewState<SearchScreen, SearchViewModel> createState() =>
      _SearchScreenState();
}

class _SearchScreenState extends BaseViewState<SearchScreen, SearchViewModel> {
  @override
  SearchViewModel get viewModel => throw UnimplementedError();
  
  @override
  Widget buildBody(BuildContext context) {
    return Container();
  }
}
