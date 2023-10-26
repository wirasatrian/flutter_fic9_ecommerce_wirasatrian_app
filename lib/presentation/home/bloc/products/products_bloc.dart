import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/product_remote_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/products_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_bloc.freezed.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      final response = await ProductRemoteDataSource().getAllProduct();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
