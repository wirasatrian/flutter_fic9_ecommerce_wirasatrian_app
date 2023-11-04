import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/order_remote_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/order_detail_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_detail_bloc.freezed.dart';
part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc() : super(const _Initial()) {
    on<_GetOrderDetail>((event, emit) async {
      emit(const _Loading());
      final response = await OrderRemoteDataSouce().getOrderById(event.orderId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
