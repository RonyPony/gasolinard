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
          await dio.get("http://216.172.100.170:8037/Combustiblesrd/getPrices");
      if (response.statusCode! < 400) {
        Fuels ex = Fuels.fromJson(response.data);
        return ex;
      } else {
        throw PlatformException(
            code: "${response.statusCode}", message: "error");
      }
    } catch (e) {
      throw Exception('error');
    }
  }

  @override
  Future<List<Fuels>> getHistory() async {
    try {
      final Dio dio = Dio();
      final response = await dio
          .get("http://216.172.100.170:8037/Combustiblesrd/getHistory");
      if (response.statusCode! < 400) {
        // var ex = Fuels.fromJson(response.data);
        return [];
      } else {
        throw PlatformException(
            code: "${response.statusCode}", message: "error");
      }
    } catch (e) {
      throw Exception('error');
    }
  }
}
