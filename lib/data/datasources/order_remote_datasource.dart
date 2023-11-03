import 'package:dartz/dartz.dart';
import 'package:fic9_ecommerce_template_app/common/constants/variables.dart';
import 'package:fic9_ecommerce_template_app/data/datasources/auth_local_datasource.dart';
import 'package:fic9_ecommerce_template_app/data/models/requests/order_request_model.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/order_response_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDataSouce {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel request) async {
    final token = await AuthLocalDatasource().getToken();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return right(OrderResponseModel.fromJson(response.body));
    } else {
      return left('Server Error');
    }
  }
}
