import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/logger.dart';

class ApiService {
  late Dio _dio;

  // Singleton pattern
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal() {
    _dio = Dio();
  }

  Future<Either<Failure<String>, T>> dioGet<T>({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        _logSuccess('Get', response);
        return Right(response.data);
      } else {
        _logError('Get', response);
        return Left(ServerFailure(
          message:
              'GET request returned an unexpected status code: ${response.statusCode}',
          statusCode: response.statusCode ?? 0,
        ));
      }
    } catch (e) {
      _logUnexpectedError('Get', e);
      return Left(
        UnexpectedFailure(
          message: 'Error in GET request: $e',
        ),
      );
    }
  }

  Future<Either<Failure<String>, T>> dioPost<T>({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(url, data: data);

      if (response.statusCode == 200) {
        _logSuccess('Post', response);
        return Right(response.data);
      } else {
        _logError('Post', response);
        return Left(ServerFailure(
          message:
              'POST request returned an unexpected status code: ${response.statusCode}',
          statusCode: response.statusCode ?? 0,
        ));
      }
    } catch (e) {
      _logUnexpectedError('Post', e);
      return Left(
        UnexpectedFailure(
          message: 'Error in POST request: $e',
        ),
      );
    }
  }

  Future<Either<Failure<String>, T>> dioPut<T>({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.put(url, data: data);

      if (response.statusCode == 200) {
        _logSuccess('Put', response);
        return Right(response.data);
      } else {
        _logError('Put', response);
        return Left(ServerFailure(
          message:
              'PUT request returned an unexpected status code: ${response.statusCode}',
          statusCode: response.statusCode ?? 0,
        ));
      }
    } catch (e) {
      _logUnexpectedError('Put', e);
      return Left(
        UnexpectedFailure(
          message: 'Error in PUT request: $e',
        ),
      );
    }
  }

  void _logUnexpectedError(String type, Object e) {
    Logger.error('Error', 'Error in $type request: $e');
  }

  void _logError(String type, Response<dynamic> response) {
    Logger.error(
      'Error',
      '$type request returned an unexpected status code: ${response.statusCode}',
    );
  }

  void _logSuccess(String type, Response<dynamic> response) {
    Logger.success('Success', '$type request returned: ${response.data}');
  }
}
