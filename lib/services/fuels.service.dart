import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:gasolinard/contracts/fuels_service.contract.dart';
import 'package:gasolinard/models/fuels.model.dart';

class FuelService implements FuelsServiceContract {
  @override
  Future<Fuels> getAllFuels() async {
    try {
      final Dio dio = Dio();
      final response =
          await dio.get("https://api.digital.gob.do/v1/fuels?date=2021-12-12");

      if (response.statusCode! < 400) {
        Fuels ex = Fuels.fromJson(response.data);
        return ex;
      } else {
        throw PlatformException(
            code: "${response.statusCode}", message: "invalidEmail");
      }
    } catch (e) {
      throw Exception('error');
    }
  }
}
