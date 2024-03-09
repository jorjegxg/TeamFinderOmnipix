import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart'; // importați dio
import 'package:team_finder_app/core/error/failures.dart';
import 'package:team_finder_app/core/util/constants.dart';
import 'package:team_finder_app/core/util/logger.dart';

class AuthRepoImpl {
  Future<Either<Failure, String>> createOrganizationAdminAccount({
    required String name,
    required String email,
    required String password,
    required String organizationName,
    required String address,
  }) async {
    try {
      Dio dio = Dio();

      Map<String, dynamic> data = {
        "name": name,
        "email": email,
        "password": password,
        "organizationName": organizationName,
        "adress": address,
        //TODO (George Luta) : sterge , nu din front trimitem
        "url": "string"
      };

      Response response = await dio.post(
        EndpointConstants.baseUrl + EndpointConstants.createAdmin,
        data: data,
      );

      if (response.statusCode == 200) {
        return const Right('Adminul a fost creat cu succes');
      } else {
        return Left(ServerFailure(
          message: json.decode(response.data)['message'],
          statusCode: response.statusCode!,
        ));
      }
    } catch (e) {
      return Left(UnexpectedFailure(
        message: 'A apărut o eroare la crearea contului de admin',
      ));
    }
  }

}
