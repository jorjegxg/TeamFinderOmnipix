import 'package:dio/dio.dart';
import 'package:team_finder_app/core/exports/rest_imports.dart';
import 'package:team_finder_app/core/util/logger.dart';
import 'package:team_finder_app/core/util/secure_storage_service.dart';

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
      Logger.info(
          'GET request', 'url: $url, queryParameters: $queryParameters');

      _addBearerAuthorization();

      final response = await _dio.get(url, queryParameters: queryParameters);

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        _logSuccess('Get', response);
        return Right(response.data);
      } else {
        _logError('Get', response);
        return Left(ServerFailure(
          message: response.data['message'] ??
              'GET request returned an unexpected status code: ${response.statusCode}',
          statusCode: response.statusCode ?? 0,
        ));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 404) {
          if (T == List) {
            Logger.info('GET request', 'empty list returned');
            return Right(<T>[] as T);
          }

          return Left(
            UnexpectedFailure(
              message: e.message.toString(),
            ),
          );
        }
      }

      _logUnexpectedError('Get', e.response);
      return Left(
        UnexpectedFailure(
          message: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure<String>, T>> dioPost<T>({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      Logger.info('POST request', 'url: $url, data: $data');
      _addBearerAuthorization();

      final response = await _dio.post(url, data: data);

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        _logSuccess('Post', response);
        return Right(response.data);
      } else {
        _logError('Post', response);
        return Left(ServerFailure(
          message: response.data['message'] ??
              'POST request returned an unexpected status code: ${response.statusCode} ',
          statusCode: response.statusCode ?? 0,
        ));
      }
    } on DioException catch (e) {
      _logUnexpectedError('Post', e);
      return Left(
        UnexpectedFailure(
          message: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure<String>, T>> dioPut<T>({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      Logger.info('PUT request', 'url: $url, data: $data');

      _addBearerAuthorization();

      final response = await _dio.put(url, data: data);

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        _logSuccess('Put', response);
        return Right(response.data);
      } else {
        _logError('Put', response);
        return Left(ServerFailure(
          message: response.data['message'] ??
              'PUT request returned an unexpected status code: ${response.statusCode}',
          statusCode: response.statusCode ?? 0,
        ));
      }
    } on DioException catch (e) {
      _logUnexpectedError('Put', e);
      return Left(
        UnexpectedFailure(
          message: e.message.toString(),
        ),
      );
    }
  }

  Future<Either<Failure<String>, T>> dioDelete<T>({
    required String url,
  }) async {
    try {
      Logger.info('DELETE request', 'url: $url');
      _addBearerAuthorization();

      final response = await _dio.delete(url);

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        _logSuccess('Delete', response);
        return Right(response.data);
      } else {
        _logError('Delete', response);
        return Left(ServerFailure(
          message: response.data['message'] ??
              'DELETE request returned an unexpected status code: ${response.statusCode}',
          statusCode: response.statusCode ?? 0,
        ));
      }
    } on DioException catch (e) {
      _logUnexpectedError('Delete', e);
      return Left(
        UnexpectedFailure(
          message: e.message.toString(),
        ),
      );
    }
  }

  void _logUnexpectedError(String type, dynamic e) {
    Logger.error('Unexpected error', 'in $type request: $e');
  }

  void _logError(String type, dynamic response) {
    Logger.error(
      'Error',
      '$type request returned an unexpected status code: ${response.statusCode}',
    );
  }

  void _logSuccess(String type, dynamic response) {
    Logger.success('Success', '$type request returned: $response');
  }

  void _addBearerAuthorization() {
    final jwtToken = SecureStorageService().read(key: StorageConstants.token);
    _dio.options.headers['Authorization'] = 'Bearer $jwtToken';
  }
}
