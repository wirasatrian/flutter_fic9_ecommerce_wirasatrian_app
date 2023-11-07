import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/city_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_bloc.freezed.dart';
part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(const _Initial()) {
    on<_GetCitiesByProvinceId>((event, emit) async {
      emit(const _Loading());
      final result =
          await RajaOngkirRemoteDatasource().getCities(event.provinceId);

      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.rajaongkir.results)),
      ); 
    });
  }
}
