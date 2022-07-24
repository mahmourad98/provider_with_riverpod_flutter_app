import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled04/data/models/category/category_model.dart';
import 'package:untitled04/data/repositories/categories/categories_repository.dart';

class CategoriesListViewModel extends StateNotifier<CategoriesListState>{
  final CategoriesRepository categoriesRepository;

  CategoriesListViewModel({
    required this.categoriesRepository,
  }) : super(const CategoriesListStateLoadedSuccess(categories: [],),){
    loadCategories();
  }

  void _loadState(CategoriesListState newState,){
    this.state = newState;
  }

  void loadCategories() async{
    _loadState(const CategoriesListStateLoading(),);
    await categoriesRepository.getAllCategories().then(
      (dynamic result,){
        _loadState(CategoriesListStateLoadedSuccess(categories: (result as List<Category>),),);
      },
    ).onError(
      (error, stackTrace){
        _loadState(CategoriesListStateLoadedError(errorMessage: error.toString(),),);
      },
    );
  }
}

abstract class CategoriesListState{
  const CategoriesListState();
}

class CategoriesListStateLoading extends CategoriesListState{
  const CategoriesListStateLoading();
}

class CategoriesListStateLoadedSuccess extends CategoriesListState{
  final List<Category> categories;
  const CategoriesListStateLoadedSuccess({required this.categories,});
}

class CategoriesListStateLoadedError extends CategoriesListState{
  final String errorMessage;
  const CategoriesListStateLoadedError({required this.errorMessage,});
}