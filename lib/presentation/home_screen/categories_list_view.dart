import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import '../../data/repositories/categories/categories_repository.dart';
import 'categories_list_view_model.dart';

class CategoriesListView extends ConsumerWidget{
  final void Function() onTap;
  StateNotifierProvider<CategoriesListViewModel, CategoriesListState>? _categoriesListViewModel;
  CategoriesListView({Key? key, required this.onTap,}) : super(key: key,);

  @override
  Widget build(BuildContext context, WidgetRef ref,) {
    log("we were built", name:'build/CategoriesListView',);
    _categoriesListViewModel ??= StateNotifierProvider<CategoriesListViewModel, CategoriesListState>(
      (ref,) => CategoriesListViewModel(categoriesRepository: context.read<CategoriesRepository>(),)
        ..loadCategories(),
    );
    //ref.listen(_categoriesListViewModel!, (previous, next) { });
    final state = ref.watch(_categoriesListViewModel!);
    if(state is CategoriesListStateLoadedSuccess){
      return ListView.builder(
        shrinkWrap: true,
        primary: true,
        scrollDirection: Axis.vertical,
        itemCount: state.categories.length,
        itemBuilder: (buildContext, itemIndex,){
          return SizedBox(
            height: 32,
            child: ListTile(
              title: Text(
                state.categories[itemIndex].categoryName!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              contentPadding: const EdgeInsetsDirectional.only(
                start: 16.0,
              ),
              style: ListTileStyle.list,
              onTap: (){
                Navigator.of(context,).pop();
              },
            ),
          );
        },
      );
    }
    else if(state is CategoriesListStateLoadedError){
      return Center(child: Text(state.errorMessage,),);
    }
    else{
      return const Center(child: CircularProgressIndicator(),);
    }
  }

}