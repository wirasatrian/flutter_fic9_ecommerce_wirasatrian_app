import 'package:bloc/bloc.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/subdistrict_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subdistrict_bloc.freezed.dart';
part 'subdistrict_event.dart';
part 'subdistrict_state.dart';

class SubdistrictBloc extends Bloc<SubdistrictEvent, SubdistrictState> {
  SubdistrictBloc() : super(const _Initial()) {
    on<_GetSubDistrictByCityId>(
      (event, emit) async {
        emit(const _Loading());
        final result =
            await RajaOngkirRemoteDatasource().getSubDistrict(event.CityId);

        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Loaded(r.rajaongkir.results)),
        );
      },
    );
  }
}
