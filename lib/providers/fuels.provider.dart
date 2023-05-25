import 'package:flutter/material.dart';
import 'package:gasolinard/contracts/fuels_service.contract.dart';

import '../models/fuels.model.dart';

class FuelProvider with ChangeNotifier {
  FuelsServiceContract _serviceContract;

  FuelProvider(this._serviceContract);

  Future<Fuels> getAll() async {
    try {
      var result = await _serviceContract.getAllFuels();
      notifyListeners();
      return result;
    } catch (e) {
      notifyListeners();

      throw e;
    }
  }
}
