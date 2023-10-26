import 'package:dartz/dartz.dart';
import 'package:fic9_ecommerce_template_app/common/constants/variables.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/products_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDataSource {
  Future<Either<String, ProductsResponseModel>> getAllProduct() async {
    final response = await http
        .get(Uri.parse('${Variables.baseUrl}/api/products?populate=*'));
    if (response.statusCode == 200) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return const Left('Server Error');
    }
  }
}

// mixin ProductsResponseModel {}
