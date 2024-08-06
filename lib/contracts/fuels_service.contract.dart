import '../models/fuels.model.dart';

abstract class FuelsServiceContract {
  Future<Fuels> getAllFuels();
  Future<List<Fuels>> getHistory();
}
