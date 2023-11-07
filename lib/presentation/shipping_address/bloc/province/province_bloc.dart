import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/province_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'province_bloc.freezed.dart';
part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  ProvinceBloc() : super(const _Initial()) {
    on<_GetProvinces>((event, emit) async {
      emit(const _Loading());
      final result = await RajaOngkirRemoteDatasource().getProvinces();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.rajaongkir.results)),
      );
    });
  }
}
