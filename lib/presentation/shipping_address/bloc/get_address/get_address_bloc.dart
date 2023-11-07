import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/order_remote_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/get_address_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_address_bloc.freezed.dart';
part 'get_address_event.dart';
part 'get_address_state.dart';

class GetAddressBloc extends Bloc<GetAddressEvent, GetAddressState> {
  GetAddressBloc() : super(const _Initial()) {
    on<_GetAddress>((event, emit) async {
      emit(const _Loading());
      final response = await OrderRemoteDataSouce().getAddressByUserId();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
