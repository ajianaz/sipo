// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barang_dao.dart';

// ignore_for_file: type=lint
mixin _$BarangDaoMixin on DatabaseAccessor<AppDatabase> {
  $SatuansTable get satuans => attachedDatabase.satuans;
  $BarangsTable get barangs => attachedDatabase.barangs;
  BarangDaoManager get managers => BarangDaoManager(this);
}

class BarangDaoManager {
  final _$BarangDaoMixin _db;
  BarangDaoManager(this._db);
  $$SatuansTableTableManager get satuans =>
      $$SatuansTableTableManager(_db.attachedDatabase, _db.satuans);
  $$BarangsTableTableManager get barangs =>
      $$BarangsTableTableManager(_db.attachedDatabase, _db.barangs);
}
