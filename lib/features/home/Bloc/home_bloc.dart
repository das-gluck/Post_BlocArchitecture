import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_architecture/Data/cart_item.dart';
import 'package:bloc_architecture/Data/grocery_data.dart';
import 'package:bloc_architecture/Data/wishlist_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent,HomeState>{
    HomeBloc() : super(HomeInitial()) {
      on<HomeInitialEvent>(homeInitialEvent);
      on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
      on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
      on<HomeProductWishlistButtonClickedEvent>(homeProductWishlistButtonClickedEvent);
      on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    }

    FutureOr<void> homeInitialEvent(
        HomeInitialEvent event, Emitter<HomeState> emit) async {
      emit(HomeLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      emit(HomeLoadedSuccessState(
          products: GroceryData.groceryProducts.map((e) => ProductDataModel(
                  id: e['id'],
                  description: e['description'],
                  name: e['name'],
                  price: e['price'],
                  imageUrl: e['imageUrl'])).toList()));
    }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event,
      Emitter<HomeState> emit) {
      print('wishlisht button clicked');
      emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event,
      Emitter<HomeState> emit) {
      print('cart button clickes');
      emit(HomeNavigateToCartPageActionState());
  }



  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
      print('wishlist product clicked');
      wishlistItems.add(event.clickedProduct);
      emit(HomeProductItemWishlistedActionState());
  }


  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('cart product clicked');
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemCartedActionState());
  }
}
