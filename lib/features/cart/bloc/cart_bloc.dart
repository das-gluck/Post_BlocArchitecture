


import 'dart:async';

import 'package:bloc_architecture/Data/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/models/home_product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  CartBloc() : super(CartInitial()){
    on<CartInitialEvents>(cartInitialEvents);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);

  }

  FutureOr<void> cartInitialEvents(
      CartInitialEvents event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    emit(CartSuccessState(cartItems: cartItems));
  }
}