import 'package:dio/dio.dart';
import '../../models/product.dart';
import '../failture/network_failure.dart';
import '../interceptors/logging_interceptors.dart';


class DioNetwork {
  static final DioNetwork _instance = DioNetwork._();

  DioNetwork._() {
    _dio = Dio(BaseOptions());

    _dio.interceptors.add(LoggingInterCeptors());
  }

  factory DioNetwork() => _instance;

  late Dio _dio;

  Future<List<Product>?>? getProducts() async {
    try {
      final response = await _dio.get('https://f209d6ea-77b0-46f6-8d46-67bdd3b4bd86.mock.pstmn.io/shop_app');

      if (response.statusCode == 200) {
        List<Product> products =
        List<Map<String, dynamic>>.from(response.data['result']).map((e) => Product.fromJson(e)).toList();

        return products;
      }
      throw NetworkFailure('something went wrong', response.statusCode);
    } catch (e) {
      print(e);
      if (e is DioException) {
        throw NetworkFailure('connection refused', 99);
      } else if (e is NetworkFailure) {
        rethrow;
      } else {
        throw NetworkFailure('internal error', 101);
      }
    }
  }
}


