import '../database/daos/analitik_dao.dart';

class AnalitikRepository {
  final AnalitikDao _dao;

  AnalitikRepository(this._dao);

  Future<List<AnalitikSummary>> getSummaryByBarang({
    required String startDate,
    required String endDate,
    int? barangId,
  }) => _dao.getSummaryByBarang(
    startDate: startDate,
    endDate: endDate,
    barangId: barangId,
  );

  Future<AnalitikTotal> getTotal({
    required String startDate,
    required String endDate,
  }) => _dao.getTotal(startDate: startDate, endDate: endDate);
}
