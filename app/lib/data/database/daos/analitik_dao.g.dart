// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analitik_dao.dart';

// ignore_for_file: type=lint
mixin _$AnalitikDaoMixin on DatabaseAccessor<AppDatabase> {
  $CustomersTable get customers => attachedDatabase.customers;
  $TransaksisTable get transaksis => attachedDatabase.transaksis;
  $SatuansTable get satuans => attachedDatabase.satuans;
  $BarangsTable get barangs => attachedDatabase.barangs;
  $TransaksiDetailsTable get transaksiDetails =>
      attachedDatabase.transaksiDetails;
  AnalitikDaoManager get managers => AnalitikDaoManager(this);
}

class AnalitikDaoManager {
  final _$AnalitikDaoMixin _db;
  AnalitikDaoManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db.attachedDatabase, _db.customers);
  $$TransaksisTableTableManager get transaksis =>
      $$TransaksisTableTableManager(_db.attachedDatabase, _db.transaksis);
  $$SatuansTableTableManager get satuans =>
      $$SatuansTableTableManager(_db.attachedDatabase, _db.satuans);
  $$BarangsTableTableManager get barangs =>
      $$BarangsTableTableManager(_db.attachedDatabase, _db.barangs);
  $$TransaksiDetailsTableTableManager get transaksiDetails =>
      $$TransaksiDetailsTableTableManager(
        _db.attachedDatabase,
        _db.transaksiDetails,
      );
}
