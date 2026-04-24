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
          await dio.get('http://38.247.133.70:8037/Combustiblesrd/getPrices');
      if (response.statusCode! < 400) {
        final fuels = Fuels.fromJson(response.data);
        return fuels;
      }
      throw PlatformException(code: '${response.statusCode}', message: 'error');
    } catch (e) {
      throw Exception('error');
    }
  }

  @override
  Future<List<Fuels>> getHistory() async {
    try {
      final Dio dio = Dio();
      final response =
          await dio.get('http://38.247.133.70:8037/Combustiblesrd/getHistory');
      if (response.statusCode! >= 400) {
        throw PlatformException(code: '${response.statusCode}', message: 'error');
      }

      if (response.data is! List) {
        return [];
      }

      final historyResponse = response.data as List<dynamic>;
      return historyResponse
          .whereType<List<dynamic>>()
          .map((weekData) {
            final combustibles = weekData
                .whereType<Map>()
                .map((item) => Combustibles.fromJson(Map<String, dynamic>.from(item)))
                .toList();

            return Fuels(
              combustibles: combustibles,
              success: true,
              message: 'history',
            );
          })
          .toList();
    } catch (e) {
      throw Exception('error');
    }
  }
}
