// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'satuan_dao.dart';

// ignore_for_file: type=lint
mixin _$SatuanDaoMixin on DatabaseAccessor<AppDatabase> {
  $SatuansTable get satuans => attachedDatabase.satuans;
  SatuanDaoManager get managers => SatuanDaoManager(this);
}

class SatuanDaoManager {
  final _$SatuanDaoMixin _db;
  SatuanDaoManager(this._db);
  $$SatuansTableTableManager get satuans =>
      $$SatuansTableTableManager(_db.attachedDatabase, _db.satuans);
}
