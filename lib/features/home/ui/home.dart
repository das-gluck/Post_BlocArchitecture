import 'package:bloc_architecture/features/cart/ui/cart.dart';
import 'package:bloc_architecture/features/home/Bloc/home_bloc.dart';
import 'package:bloc_architecture/features/home/ui/product_tile_widget.dart';
import 'package:bloc_architecture/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc,HomeState>(
        bloc: homeBloc,
        listenWhen: (previous , current) => current is HomeActionState,
        buildWhen: (previous , current) => current is !HomeActionState,
        listener: (context,state){
          if(state is HomeNavigateToWishlistPageActionState){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistPage()));
          } else if(state is HomeNavigateToCartPageActionState){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
          } else if(state is HomeProductItemWishlistedActionState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product is Added in Wishlist')));
          } else if(state is HomeProductItemCartedActionState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product is Added in Cart')));
          }
        },
        builder: (context,state){

          switch(state.runtimeType) {
            case HomeLoadingState:
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            case HomeLoadedSuccessState:
              final successState = state as HomeLoadedSuccessState;
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Grocery App'),
                  backgroundColor: Colors.teal,
                  actions: [
                    IconButton(
                        onPressed: (){
                          homeBloc.add(HomeWishlistButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite_outline)
                    ),
                    IconButton(
                        onPressed: (){
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.shopping_bag_outlined)
                    ),
                  ],
                ),
                body: ListView.builder(
                    itemCount: successState.products.length,
                    itemBuilder: (context,index){
                      return ProductTileWidget(
                          productDataModel: successState.products[index], homeBloc: homeBloc);
                    }
                ),
              );
            case HomeErrorState:
              return const Scaffold(body: Center(child: Text('Error')));
            default:
              return const SizedBox();
          }
        },
    );
  }
}
