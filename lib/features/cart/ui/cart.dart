import 'package:bloc_architecture/features/cart/bloc/cart_bloc.dart';
import 'package:bloc_architecture/features/cart/ui/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvents());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Item'),
      ),
      body: BlocConsumer<CartBloc,CartState>(
          bloc: cartBloc,
          listenWhen: (previous,current) => current is CartActionState,
          buildWhen: (previous, current) => current is !CartActionState,
          listener: (context, state){},
          builder: (context,state){
            switch(state.runtimeType){
              case CartSuccessState:
                final successState = state as CartSuccessState;
                return ListView.builder(
                    itemCount: successState.cartItems.length,
                    itemBuilder: (context , index){
                      return Carttile(
                          productDataModel: successState.cartItems[index],
                          cartBloc: cartBloc
                      );
                    }
                );
              default:
            }
            return Container();
          },
      ),
    );
  }
}
