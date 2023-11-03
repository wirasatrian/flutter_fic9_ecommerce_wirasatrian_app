import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/widgets/cart_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_bloc.freezed.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const _Loaded([])) {
    on<_Add>((event, emit) {
      final currentState = state as _Loaded;
      //  increment quantity by 1 if item exist on cart, else add product to cart
      final index = currentState.carts
          .indexWhere((element) => element.product.id == event.cart.product.id);
      if (index >= 0) {
        currentState.carts[index].quantity += 1;
        emit(const _Loading());
        emit(_Loaded(currentState.carts));
      } else {
        emit(_Loaded([...currentState.carts, event.cart]));
      }
    });

    on<_Remove>((event, emit) {
      final currentState = state as _Loaded;
      //  decrement quantity by 1 if item exist on cart, remove product when quantity to be 0
      final index = currentState.carts
          .indexWhere((element) => element.product.id == event.cart.product.id);
      if (index >= 0) {
        currentState.carts[index].quantity -= 1;
        if (currentState.carts[index].quantity <= 0) {
          currentState.carts.removeAt(index);
        }
        emit(const _Loading());
        emit(_Loaded(currentState.carts));
      }
    });
  }
}
