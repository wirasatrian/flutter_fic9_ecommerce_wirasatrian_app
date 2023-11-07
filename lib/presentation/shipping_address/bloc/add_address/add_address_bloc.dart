import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/order_remote_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/requests/add_address_request_model.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/add_address_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_address_bloc.freezed.dart';
part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(const _Initial()) {
    on<_AddAddress>((event, emit) async {
      emit(const _Loading());
      final response = await OrderRemoteDataSouce().addAddress(
        AddAddressRequestModel(
          data: AddAddress(
              name: event.name,
              address:
                  '${event.address}, ${event.subdistrictName}, ${event.cityName}, ${event.provinceName}, ${event.posCode}',
              phone: event.phone,
              provId: event.provId,
              cityId: event.cityId,
              subdistrictId: event.subdistrictId,
              posCode: event.posCode,
              userId: event.userId,
              isDefault: event.isDefault),
        ),
      );

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
