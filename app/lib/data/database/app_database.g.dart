// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SatuansTable extends Satuans with TableInfo<$SatuansTable, Satuan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SatuansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _deskripsiMeta = const VerificationMeta(
    'deskripsi',
  );
  @override
  late final GeneratedColumn<String> deskripsi = GeneratedColumn<String>(
    'deskripsi',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nama, deskripsi, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'satuans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Satuan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('deskripsi')) {
      context.handle(
        _deskripsiMeta,
        deskripsi.isAcceptableOrUnknown(data['deskripsi']!, _deskripsiMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Satuan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Satuan(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      nama:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}nama'],
          )!,
      deskripsi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deskripsi'],
      ),
      isActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}is_active'],
          )!,
    );
  }

  @override
  $SatuansTable createAlias(String alias) {
    return $SatuansTable(attachedDatabase, alias);
  }
}

class Satuan extends DataClass implements Insertable<Satuan> {
  final int id;
  final String nama;
  final String? deskripsi;
  final int isActive;
  const Satuan({
    required this.id,
    required this.nama,
    this.deskripsi,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    if (!nullToAbsent || deskripsi != null) {
      map['deskripsi'] = Variable<String>(deskripsi);
    }
    map['is_active'] = Variable<int>(isActive);
    return map;
  }

  SatuansCompanion toCompanion(bool nullToAbsent) {
    return SatuansCompanion(
      id: Value(id),
      nama: Value(nama),
      deskripsi:
          deskripsi == null && nullToAbsent
              ? const Value.absent()
              : Value(deskripsi),
      isActive: Value(isActive),
    );
  }

  factory Satuan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Satuan(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      deskripsi: serializer.fromJson<String?>(json['deskripsi']),
      isActive: serializer.fromJson<int>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'deskripsi': serializer.toJson<String?>(deskripsi),
      'isActive': serializer.toJson<int>(isActive),
    };
  }

  Satuan copyWith({
    int? id,
    String? nama,
    Value<String?> deskripsi = const Value.absent(),
    int? isActive,
  }) => Satuan(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    deskripsi: deskripsi.present ? deskripsi.value : this.deskripsi,
    isActive: isActive ?? this.isActive,
  );
  Satuan copyWithCompanion(SatuansCompanion data) {
    return Satuan(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      deskripsi: data.deskripsi.present ? data.deskripsi.value : this.deskripsi,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Satuan(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nama, deskripsi, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Satuan &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.deskripsi == this.deskripsi &&
          other.isActive == this.isActive);
}

class SatuansCompanion extends UpdateCompanion<Satuan> {
  final Value<int> id;
  final Value<String> nama;
  final Value<String?> deskripsi;
  final Value<int> isActive;
  const SatuansCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.deskripsi = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  SatuansCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    this.deskripsi = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : nama = Value(nama);
  static Insertable<Satuan> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<String>? deskripsi,
    Expression<int>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (deskripsi != null) 'deskripsi': deskripsi,
      if (isActive != null) 'is_active': isActive,
    });
  }

  SatuansCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<String?>? deskripsi,
    Value<int>? isActive,
  }) {
    return SatuansCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      deskripsi: deskripsi ?? this.deskripsi,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (deskripsi.present) {
      map['deskripsi'] = Variable<String>(deskripsi.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SatuansCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $BarangsTable extends Barangs with TableInfo<$BarangsTable, Barang> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BarangsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _satuanIdMeta = const VerificationMeta(
    'satuanId',
  );
  @override
  late final GeneratedColumn<int> satuanId = GeneratedColumn<int>(
    'satuan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES satuans (id)',
    ),
  );
  static const VerificationMeta _hargaBeliMeta = const VerificationMeta(
    'hargaBeli',
  );
  @override
  late final GeneratedColumn<double> hargaBeli = GeneratedColumn<double>(
    'harga_beli',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hargaJualMeta = const VerificationMeta(
    'hargaJual',
  );
  @override
  late final GeneratedColumn<double> hargaJual = GeneratedColumn<double>(
    'harga_jual',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nama,
    satuanId,
    hargaBeli,
    hargaJual,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'barangs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Barang> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('satuan_id')) {
      context.handle(
        _satuanIdMeta,
        satuanId.isAcceptableOrUnknown(data['satuan_id']!, _satuanIdMeta),
      );
    } else if (isInserting) {
      context.missing(_satuanIdMeta);
    }
    if (data.containsKey('harga_beli')) {
      context.handle(
        _hargaBeliMeta,
        hargaBeli.isAcceptableOrUnknown(data['harga_beli']!, _hargaBeliMeta),
      );
    } else if (isInserting) {
      context.missing(_hargaBeliMeta);
    }
    if (data.containsKey('harga_jual')) {
      context.handle(
        _hargaJualMeta,
        hargaJual.isAcceptableOrUnknown(data['harga_jual']!, _hargaJualMeta),
      );
    } else if (isInserting) {
      context.missing(_hargaJualMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Barang map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Barang(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      nama:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}nama'],
          )!,
      satuanId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}satuan_id'],
          )!,
      hargaBeli:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}harga_beli'],
          )!,
      hargaJual:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}harga_jual'],
          )!,
    );
  }

  @override
  $BarangsTable createAlias(String alias) {
    return $BarangsTable(attachedDatabase, alias);
  }
}

class Barang extends DataClass implements Insertable<Barang> {
  final int id;
  final String nama;
  final int satuanId;
  final double hargaBeli;
  final double hargaJual;
  const Barang({
    required this.id,
    required this.nama,
    required this.satuanId,
    required this.hargaBeli,
    required this.hargaJual,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    map['satuan_id'] = Variable<int>(satuanId);
    map['harga_beli'] = Variable<double>(hargaBeli);
    map['harga_jual'] = Variable<double>(hargaJual);
    return map;
  }

  BarangsCompanion toCompanion(bool nullToAbsent) {
    return BarangsCompanion(
      id: Value(id),
      nama: Value(nama),
      satuanId: Value(satuanId),
      hargaBeli: Value(hargaBeli),
      hargaJual: Value(hargaJual),
    );
  }

  factory Barang.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Barang(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      satuanId: serializer.fromJson<int>(json['satuanId']),
      hargaBeli: serializer.fromJson<double>(json['hargaBeli']),
      hargaJual: serializer.fromJson<double>(json['hargaJual']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'satuanId': serializer.toJson<int>(satuanId),
      'hargaBeli': serializer.toJson<double>(hargaBeli),
      'hargaJual': serializer.toJson<double>(hargaJual),
    };
  }

  Barang copyWith({
    int? id,
    String? nama,
    int? satuanId,
    double? hargaBeli,
    double? hargaJual,
  }) => Barang(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    satuanId: satuanId ?? this.satuanId,
    hargaBeli: hargaBeli ?? this.hargaBeli,
    hargaJual: hargaJual ?? this.hargaJual,
  );
  Barang copyWithCompanion(BarangsCompanion data) {
    return Barang(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      satuanId: data.satuanId.present ? data.satuanId.value : this.satuanId,
      hargaBeli: data.hargaBeli.present ? data.hargaBeli.value : this.hargaBeli,
      hargaJual: data.hargaJual.present ? data.hargaJual.value : this.hargaJual,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Barang(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('satuanId: $satuanId, ')
          ..write('hargaBeli: $hargaBeli, ')
          ..write('hargaJual: $hargaJual')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nama, satuanId, hargaBeli, hargaJual);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Barang &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.satuanId == this.satuanId &&
          other.hargaBeli == this.hargaBeli &&
          other.hargaJual == this.hargaJual);
}

class BarangsCompanion extends UpdateCompanion<Barang> {
  final Value<int> id;
  final Value<String> nama;
  final Value<int> satuanId;
  final Value<double> hargaBeli;
  final Value<double> hargaJual;
  const BarangsCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.satuanId = const Value.absent(),
    this.hargaBeli = const Value.absent(),
    this.hargaJual = const Value.absent(),
  });
  BarangsCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    required int satuanId,
    required double hargaBeli,
    required double hargaJual,
  }) : nama = Value(nama),
       satuanId = Value(satuanId),
       hargaBeli = Value(hargaBeli),
       hargaJual = Value(hargaJual);
  static Insertable<Barang> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<int>? satuanId,
    Expression<double>? hargaBeli,
    Expression<double>? hargaJual,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (satuanId != null) 'satuan_id': satuanId,
      if (hargaBeli != null) 'harga_beli': hargaBeli,
      if (hargaJual != null) 'harga_jual': hargaJual,
    });
  }

  BarangsCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<int>? satuanId,
    Value<double>? hargaBeli,
    Value<double>? hargaJual,
  }) {
    return BarangsCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      satuanId: satuanId ?? this.satuanId,
      hargaBeli: hargaBeli ?? this.hargaBeli,
      hargaJual: hargaJual ?? this.hargaJual,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (satuanId.present) {
      map['satuan_id'] = Variable<int>(satuanId.value);
    }
    if (hargaBeli.present) {
      map['harga_beli'] = Variable<double>(hargaBeli.value);
    }
    if (hargaJual.present) {
      map['harga_jual'] = Variable<double>(hargaJual.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BarangsCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('satuanId: $satuanId, ')
          ..write('hargaBeli: $hargaBeli, ')
          ..write('hargaJual: $hargaJual')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noHpMeta = const VerificationMeta('noHp');
  @override
  late final GeneratedColumn<String> noHp = GeneratedColumn<String>(
    'no_hp',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _alamatMeta = const VerificationMeta('alamat');
  @override
  late final GeneratedColumn<String> alamat = GeneratedColumn<String>(
    'alamat',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _catatanMeta = const VerificationMeta(
    'catatan',
  );
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
    'catatan',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nama, noHp, alamat, catatan];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('no_hp')) {
      context.handle(
        _noHpMeta,
        noHp.isAcceptableOrUnknown(data['no_hp']!, _noHpMeta),
      );
    }
    if (data.containsKey('alamat')) {
      context.handle(
        _alamatMeta,
        alamat.isAcceptableOrUnknown(data['alamat']!, _alamatMeta),
      );
    }
    if (data.containsKey('catatan')) {
      context.handle(
        _catatanMeta,
        catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      nama:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}nama'],
          )!,
      noHp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}no_hp'],
      ),
      alamat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alamat'],
      ),
      catatan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catatan'],
      ),
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String nama;
  final String? noHp;
  final String? alamat;
  final String? catatan;
  const Customer({
    required this.id,
    required this.nama,
    this.noHp,
    this.alamat,
    this.catatan,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    if (!nullToAbsent || noHp != null) {
      map['no_hp'] = Variable<String>(noHp);
    }
    if (!nullToAbsent || alamat != null) {
      map['alamat'] = Variable<String>(alamat);
    }
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      nama: Value(nama),
      noHp: noHp == null && nullToAbsent ? const Value.absent() : Value(noHp),
      alamat:
          alamat == null && nullToAbsent ? const Value.absent() : Value(alamat),
      catatan:
          catatan == null && nullToAbsent
              ? const Value.absent()
              : Value(catatan),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      noHp: serializer.fromJson<String?>(json['noHp']),
      alamat: serializer.fromJson<String?>(json['alamat']),
      catatan: serializer.fromJson<String?>(json['catatan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'noHp': serializer.toJson<String?>(noHp),
      'alamat': serializer.toJson<String?>(alamat),
      'catatan': serializer.toJson<String?>(catatan),
    };
  }

  Customer copyWith({
    int? id,
    String? nama,
    Value<String?> noHp = const Value.absent(),
    Value<String?> alamat = const Value.absent(),
    Value<String?> catatan = const Value.absent(),
  }) => Customer(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    noHp: noHp.present ? noHp.value : this.noHp,
    alamat: alamat.present ? alamat.value : this.alamat,
    catatan: catatan.present ? catatan.value : this.catatan,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      noHp: data.noHp.present ? data.noHp.value : this.noHp,
      alamat: data.alamat.present ? data.alamat.value : this.alamat,
      catatan: data.catatan.present ? data.catatan.value : this.catatan,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('noHp: $noHp, ')
          ..write('alamat: $alamat, ')
          ..write('catatan: $catatan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nama, noHp, alamat, catatan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.noHp == this.noHp &&
          other.alamat == this.alamat &&
          other.catatan == this.catatan);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> nama;
  final Value<String?> noHp;
  final Value<String?> alamat;
  final Value<String?> catatan;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.noHp = const Value.absent(),
    this.alamat = const Value.absent(),
    this.catatan = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    this.noHp = const Value.absent(),
    this.alamat = const Value.absent(),
    this.catatan = const Value.absent(),
  }) : nama = Value(nama);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<String>? noHp,
    Expression<String>? alamat,
    Expression<String>? catatan,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (noHp != null) 'no_hp': noHp,
      if (alamat != null) 'alamat': alamat,
      if (catatan != null) 'catatan': catatan,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<String?>? noHp,
    Value<String?>? alamat,
    Value<String?>? catatan,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      noHp: noHp ?? this.noHp,
      alamat: alamat ?? this.alamat,
      catatan: catatan ?? this.catatan,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (noHp.present) {
      map['no_hp'] = Variable<String>(noHp.value);
    }
    if (alamat.present) {
      map['alamat'] = Variable<String>(alamat.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('noHp: $noHp, ')
          ..write('alamat: $alamat, ')
          ..write('catatan: $catatan')
          ..write(')'))
        .toString();
  }
}

class $TransaksisTable extends Transaksis
    with TableInfo<$TransaksisTable, Transaksi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransaksisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tipeMeta = const VerificationMeta('tipe');
  @override
  late final GeneratedColumn<String> tipe = GeneratedColumn<String>(
    'tipe',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _tanggalMeta = const VerificationMeta(
    'tanggal',
  );
  @override
  late final GeneratedColumn<String> tanggal = GeneratedColumn<String>(
    'tanggal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalHargaMeta = const VerificationMeta(
    'totalHarga',
  );
  @override
  late final GeneratedColumn<double> totalHarga = GeneratedColumn<double>(
    'total_harga',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _catatanMeta = const VerificationMeta(
    'catatan',
  );
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
    'catatan',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tipe,
    customerId,
    tanggal,
    totalHarga,
    catatan,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaksis';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaksi> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipe')) {
      context.handle(
        _tipeMeta,
        tipe.isAcceptableOrUnknown(data['tipe']!, _tipeMeta),
      );
    } else if (isInserting) {
      context.missing(_tipeMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('tanggal')) {
      context.handle(
        _tanggalMeta,
        tanggal.isAcceptableOrUnknown(data['tanggal']!, _tanggalMeta),
      );
    } else if (isInserting) {
      context.missing(_tanggalMeta);
    }
    if (data.containsKey('total_harga')) {
      context.handle(
        _totalHargaMeta,
        totalHarga.isAcceptableOrUnknown(data['total_harga']!, _totalHargaMeta),
      );
    } else if (isInserting) {
      context.missing(_totalHargaMeta);
    }
    if (data.containsKey('catatan')) {
      context.handle(
        _catatanMeta,
        catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaksi map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaksi(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      tipe:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}tipe'],
          )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      tanggal:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}tanggal'],
          )!,
      totalHarga:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}total_harga'],
          )!,
      catatan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catatan'],
      ),
    );
  }

  @override
  $TransaksisTable createAlias(String alias) {
    return $TransaksisTable(attachedDatabase, alias);
  }
}

class Transaksi extends DataClass implements Insertable<Transaksi> {
  final int id;
  final String tipe;
  final int? customerId;
  final String tanggal;
  final double totalHarga;
  final String? catatan;
  const Transaksi({
    required this.id,
    required this.tipe,
    this.customerId,
    required this.tanggal,
    required this.totalHarga,
    this.catatan,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tipe'] = Variable<String>(tipe);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['tanggal'] = Variable<String>(tanggal);
    map['total_harga'] = Variable<double>(totalHarga);
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    return map;
  }

  TransaksisCompanion toCompanion(bool nullToAbsent) {
    return TransaksisCompanion(
      id: Value(id),
      tipe: Value(tipe),
      customerId:
          customerId == null && nullToAbsent
              ? const Value.absent()
              : Value(customerId),
      tanggal: Value(tanggal),
      totalHarga: Value(totalHarga),
      catatan:
          catatan == null && nullToAbsent
              ? const Value.absent()
              : Value(catatan),
    );
  }

  factory Transaksi.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaksi(
      id: serializer.fromJson<int>(json['id']),
      tipe: serializer.fromJson<String>(json['tipe']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      tanggal: serializer.fromJson<String>(json['tanggal']),
      totalHarga: serializer.fromJson<double>(json['totalHarga']),
      catatan: serializer.fromJson<String?>(json['catatan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipe': serializer.toJson<String>(tipe),
      'customerId': serializer.toJson<int?>(customerId),
      'tanggal': serializer.toJson<String>(tanggal),
      'totalHarga': serializer.toJson<double>(totalHarga),
      'catatan': serializer.toJson<String?>(catatan),
    };
  }

  Transaksi copyWith({
    int? id,
    String? tipe,
    Value<int?> customerId = const Value.absent(),
    String? tanggal,
    double? totalHarga,
    Value<String?> catatan = const Value.absent(),
  }) => Transaksi(
    id: id ?? this.id,
    tipe: tipe ?? this.tipe,
    customerId: customerId.present ? customerId.value : this.customerId,
    tanggal: tanggal ?? this.tanggal,
    totalHarga: totalHarga ?? this.totalHarga,
    catatan: catatan.present ? catatan.value : this.catatan,
  );
  Transaksi copyWithCompanion(TransaksisCompanion data) {
    return Transaksi(
      id: data.id.present ? data.id.value : this.id,
      tipe: data.tipe.present ? data.tipe.value : this.tipe,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      tanggal: data.tanggal.present ? data.tanggal.value : this.tanggal,
      totalHarga:
          data.totalHarga.present ? data.totalHarga.value : this.totalHarga,
      catatan: data.catatan.present ? data.catatan.value : this.catatan,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaksi(')
          ..write('id: $id, ')
          ..write('tipe: $tipe, ')
          ..write('customerId: $customerId, ')
          ..write('tanggal: $tanggal, ')
          ..write('totalHarga: $totalHarga, ')
          ..write('catatan: $catatan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tipe, customerId, tanggal, totalHarga, catatan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaksi &&
          other.id == this.id &&
          other.tipe == this.tipe &&
          other.customerId == this.customerId &&
          other.tanggal == this.tanggal &&
          other.totalHarga == this.totalHarga &&
          other.catatan == this.catatan);
}

class TransaksisCompanion extends UpdateCompanion<Transaksi> {
  final Value<int> id;
  final Value<String> tipe;
  final Value<int?> customerId;
  final Value<String> tanggal;
  final Value<double> totalHarga;
  final Value<String?> catatan;
  const TransaksisCompanion({
    this.id = const Value.absent(),
    this.tipe = const Value.absent(),
    this.customerId = const Value.absent(),
    this.tanggal = const Value.absent(),
    this.totalHarga = const Value.absent(),
    this.catatan = const Value.absent(),
  });
  TransaksisCompanion.insert({
    this.id = const Value.absent(),
    required String tipe,
    this.customerId = const Value.absent(),
    required String tanggal,
    required double totalHarga,
    this.catatan = const Value.absent(),
  }) : tipe = Value(tipe),
       tanggal = Value(tanggal),
       totalHarga = Value(totalHarga);
  static Insertable<Transaksi> custom({
    Expression<int>? id,
    Expression<String>? tipe,
    Expression<int>? customerId,
    Expression<String>? tanggal,
    Expression<double>? totalHarga,
    Expression<String>? catatan,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipe != null) 'tipe': tipe,
      if (customerId != null) 'customer_id': customerId,
      if (tanggal != null) 'tanggal': tanggal,
      if (totalHarga != null) 'total_harga': totalHarga,
      if (catatan != null) 'catatan': catatan,
    });
  }

  TransaksisCompanion copyWith({
    Value<int>? id,
    Value<String>? tipe,
    Value<int?>? customerId,
    Value<String>? tanggal,
    Value<double>? totalHarga,
    Value<String?>? catatan,
  }) {
    return TransaksisCompanion(
      id: id ?? this.id,
      tipe: tipe ?? this.tipe,
      customerId: customerId ?? this.customerId,
      tanggal: tanggal ?? this.tanggal,
      totalHarga: totalHarga ?? this.totalHarga,
      catatan: catatan ?? this.catatan,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipe.present) {
      map['tipe'] = Variable<String>(tipe.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (tanggal.present) {
      map['tanggal'] = Variable<String>(tanggal.value);
    }
    if (totalHarga.present) {
      map['total_harga'] = Variable<double>(totalHarga.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransaksisCompanion(')
          ..write('id: $id, ')
          ..write('tipe: $tipe, ')
          ..write('customerId: $customerId, ')
          ..write('tanggal: $tanggal, ')
          ..write('totalHarga: $totalHarga, ')
          ..write('catatan: $catatan')
          ..write(')'))
        .toString();
  }
}

class $TransaksiDetailsTable extends TransaksiDetails
    with TableInfo<$TransaksiDetailsTable, TransaksiDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransaksiDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _transaksiIdMeta = const VerificationMeta(
    'transaksiId',
  );
  @override
  late final GeneratedColumn<int> transaksiId = GeneratedColumn<int>(
    'transaksi_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transaksis (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _barangIdMeta = const VerificationMeta(
    'barangId',
  );
  @override
  late final GeneratedColumn<int> barangId = GeneratedColumn<int>(
    'barang_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES barangs (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _jumlahMeta = const VerificationMeta('jumlah');
  @override
  late final GeneratedColumn<double> jumlah = GeneratedColumn<double>(
    'jumlah',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hargaSatuanMeta = const VerificationMeta(
    'hargaSatuan',
  );
  @override
  late final GeneratedColumn<double> hargaSatuan = GeneratedColumn<double>(
    'harga_satuan',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    transaksiId,
    barangId,
    jumlah,
    hargaSatuan,
    subtotal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaksi_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransaksiDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaksi_id')) {
      context.handle(
        _transaksiIdMeta,
        transaksiId.isAcceptableOrUnknown(
          data['transaksi_id']!,
          _transaksiIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transaksiIdMeta);
    }
    if (data.containsKey('barang_id')) {
      context.handle(
        _barangIdMeta,
        barangId.isAcceptableOrUnknown(data['barang_id']!, _barangIdMeta),
      );
    } else if (isInserting) {
      context.missing(_barangIdMeta);
    }
    if (data.containsKey('jumlah')) {
      context.handle(
        _jumlahMeta,
        jumlah.isAcceptableOrUnknown(data['jumlah']!, _jumlahMeta),
      );
    } else if (isInserting) {
      context.missing(_jumlahMeta);
    }
    if (data.containsKey('harga_satuan')) {
      context.handle(
        _hargaSatuanMeta,
        hargaSatuan.isAcceptableOrUnknown(
          data['harga_satuan']!,
          _hargaSatuanMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hargaSatuanMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransaksiDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransaksiDetail(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      transaksiId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}transaksi_id'],
          )!,
      barangId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}barang_id'],
          )!,
      jumlah:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}jumlah'],
          )!,
      hargaSatuan:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}harga_satuan'],
          )!,
      subtotal:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}subtotal'],
          )!,
    );
  }

  @override
  $TransaksiDetailsTable createAlias(String alias) {
    return $TransaksiDetailsTable(attachedDatabase, alias);
  }
}

class TransaksiDetail extends DataClass implements Insertable<TransaksiDetail> {
  final int id;
  final int transaksiId;
  final int barangId;
  final double jumlah;
  final double hargaSatuan;
  final double subtotal;
  const TransaksiDetail({
    required this.id,
    required this.transaksiId,
    required this.barangId,
    required this.jumlah,
    required this.hargaSatuan,
    required this.subtotal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transaksi_id'] = Variable<int>(transaksiId);
    map['barang_id'] = Variable<int>(barangId);
    map['jumlah'] = Variable<double>(jumlah);
    map['harga_satuan'] = Variable<double>(hargaSatuan);
    map['subtotal'] = Variable<double>(subtotal);
    return map;
  }

  TransaksiDetailsCompanion toCompanion(bool nullToAbsent) {
    return TransaksiDetailsCompanion(
      id: Value(id),
      transaksiId: Value(transaksiId),
      barangId: Value(barangId),
      jumlah: Value(jumlah),
      hargaSatuan: Value(hargaSatuan),
      subtotal: Value(subtotal),
    );
  }

  factory TransaksiDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransaksiDetail(
      id: serializer.fromJson<int>(json['id']),
      transaksiId: serializer.fromJson<int>(json['transaksiId']),
      barangId: serializer.fromJson<int>(json['barangId']),
      jumlah: serializer.fromJson<double>(json['jumlah']),
      hargaSatuan: serializer.fromJson<double>(json['hargaSatuan']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transaksiId': serializer.toJson<int>(transaksiId),
      'barangId': serializer.toJson<int>(barangId),
      'jumlah': serializer.toJson<double>(jumlah),
      'hargaSatuan': serializer.toJson<double>(hargaSatuan),
      'subtotal': serializer.toJson<double>(subtotal),
    };
  }

  TransaksiDetail copyWith({
    int? id,
    int? transaksiId,
    int? barangId,
    double? jumlah,
    double? hargaSatuan,
    double? subtotal,
  }) => TransaksiDetail(
    id: id ?? this.id,
    transaksiId: transaksiId ?? this.transaksiId,
    barangId: barangId ?? this.barangId,
    jumlah: jumlah ?? this.jumlah,
    hargaSatuan: hargaSatuan ?? this.hargaSatuan,
    subtotal: subtotal ?? this.subtotal,
  );
  TransaksiDetail copyWithCompanion(TransaksiDetailsCompanion data) {
    return TransaksiDetail(
      id: data.id.present ? data.id.value : this.id,
      transaksiId:
          data.transaksiId.present ? data.transaksiId.value : this.transaksiId,
      barangId: data.barangId.present ? data.barangId.value : this.barangId,
      jumlah: data.jumlah.present ? data.jumlah.value : this.jumlah,
      hargaSatuan:
          data.hargaSatuan.present ? data.hargaSatuan.value : this.hargaSatuan,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransaksiDetail(')
          ..write('id: $id, ')
          ..write('transaksiId: $transaksiId, ')
          ..write('barangId: $barangId, ')
          ..write('jumlah: $jumlah, ')
          ..write('hargaSatuan: $hargaSatuan, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, transaksiId, barangId, jumlah, hargaSatuan, subtotal);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransaksiDetail &&
          other.id == this.id &&
          other.transaksiId == this.transaksiId &&
          other.barangId == this.barangId &&
          other.jumlah == this.jumlah &&
          other.hargaSatuan == this.hargaSatuan &&
          other.subtotal == this.subtotal);
}

class TransaksiDetailsCompanion extends UpdateCompanion<TransaksiDetail> {
  final Value<int> id;
  final Value<int> transaksiId;
  final Value<int> barangId;
  final Value<double> jumlah;
  final Value<double> hargaSatuan;
  final Value<double> subtotal;
  const TransaksiDetailsCompanion({
    this.id = const Value.absent(),
    this.transaksiId = const Value.absent(),
    this.barangId = const Value.absent(),
    this.jumlah = const Value.absent(),
    this.hargaSatuan = const Value.absent(),
    this.subtotal = const Value.absent(),
  });
  TransaksiDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int transaksiId,
    required int barangId,
    required double jumlah,
    required double hargaSatuan,
    required double subtotal,
  }) : transaksiId = Value(transaksiId),
       barangId = Value(barangId),
       jumlah = Value(jumlah),
       hargaSatuan = Value(hargaSatuan),
       subtotal = Value(subtotal);
  static Insertable<TransaksiDetail> custom({
    Expression<int>? id,
    Expression<int>? transaksiId,
    Expression<int>? barangId,
    Expression<double>? jumlah,
    Expression<double>? hargaSatuan,
    Expression<double>? subtotal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transaksiId != null) 'transaksi_id': transaksiId,
      if (barangId != null) 'barang_id': barangId,
      if (jumlah != null) 'jumlah': jumlah,
      if (hargaSatuan != null) 'harga_satuan': hargaSatuan,
      if (subtotal != null) 'subtotal': subtotal,
    });
  }

  TransaksiDetailsCompanion copyWith({
    Value<int>? id,
    Value<int>? transaksiId,
    Value<int>? barangId,
    Value<double>? jumlah,
    Value<double>? hargaSatuan,
    Value<double>? subtotal,
  }) {
    return TransaksiDetailsCompanion(
      id: id ?? this.id,
      transaksiId: transaksiId ?? this.transaksiId,
      barangId: barangId ?? this.barangId,
      jumlah: jumlah ?? this.jumlah,
      hargaSatuan: hargaSatuan ?? this.hargaSatuan,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transaksiId.present) {
      map['transaksi_id'] = Variable<int>(transaksiId.value);
    }
    if (barangId.present) {
      map['barang_id'] = Variable<int>(barangId.value);
    }
    if (jumlah.present) {
      map['jumlah'] = Variable<double>(jumlah.value);
    }
    if (hargaSatuan.present) {
      map['harga_satuan'] = Variable<double>(hargaSatuan.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransaksiDetailsCompanion(')
          ..write('id: $id, ')
          ..write('transaksiId: $transaksiId, ')
          ..write('barangId: $barangId, ')
          ..write('jumlah: $jumlah, ')
          ..write('hargaSatuan: $hargaSatuan, ')
          ..write('subtotal: $subtotal')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SatuansTable satuans = $SatuansTable(this);
  late final $BarangsTable barangs = $BarangsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $TransaksisTable transaksis = $TransaksisTable(this);
  late final $TransaksiDetailsTable transaksiDetails = $TransaksiDetailsTable(
    this,
  );
  late final SatuanDao satuanDao = SatuanDao(this as AppDatabase);
  late final BarangDao barangDao = BarangDao(this as AppDatabase);
  late final CustomerDao customerDao = CustomerDao(this as AppDatabase);
  late final TransaksiDao transaksiDao = TransaksiDao(this as AppDatabase);
  late final AnalitikDao analitikDao = AnalitikDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    satuans,
    barangs,
    customers,
    transaksis,
    transaksiDetails,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transaksis',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transaksi_details', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SatuansTableCreateCompanionBuilder =
    SatuansCompanion Function({
      Value<int> id,
      required String nama,
      Value<String?> deskripsi,
      Value<int> isActive,
    });
typedef $$SatuansTableUpdateCompanionBuilder =
    SatuansCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<String?> deskripsi,
      Value<int> isActive,
    });

final class $$SatuansTableReferences
    extends BaseReferences<_$AppDatabase, $SatuansTable, Satuan> {
  $$SatuansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BarangsTable, List<Barang>> _barangsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.barangs,
    aliasName: 'satuans__id__barangs__satuan_id',
  );

  $$BarangsTableProcessedTableManager get barangsRefs {
    final manager = $$BarangsTableTableManager(
      $_db,
      $_db.barangs,
    ).filter((f) => f.satuanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_barangsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SatuansTableFilterComposer
    extends Composer<_$AppDatabase, $SatuansTable> {
  $$SatuansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deskripsi => $composableBuilder(
    column: $table.deskripsi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> barangsRefs(
    Expression<bool> Function($$BarangsTableFilterComposer f) f,
  ) {
    final $$BarangsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.barangs,
      getReferencedColumn: (t) => t.satuanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarangsTableFilterComposer(
            $db: $db,
            $table: $db.barangs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SatuansTableOrderingComposer
    extends Composer<_$AppDatabase, $SatuansTable> {
  $$SatuansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deskripsi => $composableBuilder(
    column: $table.deskripsi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SatuansTableAnnotationComposer
    extends Composer<_$AppDatabase, $SatuansTable> {
  $$SatuansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get deskripsi =>
      $composableBuilder(column: $table.deskripsi, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> barangsRefs<T extends Object>(
    Expression<T> Function($$BarangsTableAnnotationComposer a) f,
  ) {
    final $$BarangsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.barangs,
      getReferencedColumn: (t) => t.satuanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarangsTableAnnotationComposer(
            $db: $db,
            $table: $db.barangs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SatuansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SatuansTable,
          Satuan,
          $$SatuansTableFilterComposer,
          $$SatuansTableOrderingComposer,
          $$SatuansTableAnnotationComposer,
          $$SatuansTableCreateCompanionBuilder,
          $$SatuansTableUpdateCompanionBuilder,
          (Satuan, $$SatuansTableReferences),
          Satuan,
          PrefetchHooks Function({bool barangsRefs})
        > {
  $$SatuansTableTableManager(_$AppDatabase db, $SatuansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SatuansTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SatuansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SatuansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String?> deskripsi = const Value.absent(),
                Value<int> isActive = const Value.absent(),
              }) => SatuansCompanion(
                id: id,
                nama: nama,
                deskripsi: deskripsi,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                Value<String?> deskripsi = const Value.absent(),
                Value<int> isActive = const Value.absent(),
              }) => SatuansCompanion.insert(
                id: id,
                nama: nama,
                deskripsi: deskripsi,
                isActive: isActive,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SatuansTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({barangsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (barangsRefs) db.barangs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (barangsRefs)
                    await $_getPrefetchedData<Satuan, $SatuansTable, Barang>(
                      currentTable: table,
                      referencedTable: $$SatuansTableReferences
                          ._barangsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$SatuansTableReferences(
                                db,
                                table,
                                p0,
                              ).barangsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.satuanId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SatuansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SatuansTable,
      Satuan,
      $$SatuansTableFilterComposer,
      $$SatuansTableOrderingComposer,
      $$SatuansTableAnnotationComposer,
      $$SatuansTableCreateCompanionBuilder,
      $$SatuansTableUpdateCompanionBuilder,
      (Satuan, $$SatuansTableReferences),
      Satuan,
      PrefetchHooks Function({bool barangsRefs})
    >;
typedef $$BarangsTableCreateCompanionBuilder =
    BarangsCompanion Function({
      Value<int> id,
      required String nama,
      required int satuanId,
      required double hargaBeli,
      required double hargaJual,
    });
typedef $$BarangsTableUpdateCompanionBuilder =
    BarangsCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<int> satuanId,
      Value<double> hargaBeli,
      Value<double> hargaJual,
    });

final class $$BarangsTableReferences
    extends BaseReferences<_$AppDatabase, $BarangsTable, Barang> {
  $$BarangsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SatuansTable _satuanIdTable(_$AppDatabase db) =>
      db.satuans.createAlias('barangs__satuan_id__satuans__id');

  $$SatuansTableProcessedTableManager get satuanId {
    final $_column = $_itemColumn<int>('satuan_id')!;

    final manager = $$SatuansTableTableManager(
      $_db,
      $_db.satuans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_satuanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransaksiDetailsTable, List<TransaksiDetail>>
  _transaksiDetailsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transaksiDetails,
    aliasName: 'barangs__id__transaksi_details__barang_id',
  );

  $$TransaksiDetailsTableProcessedTableManager get transaksiDetailsRefs {
    final manager = $$TransaksiDetailsTableTableManager(
      $_db,
      $_db.transaksiDetails,
    ).filter((f) => f.barangId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transaksiDetailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BarangsTableFilterComposer
    extends Composer<_$AppDatabase, $BarangsTable> {
  $$BarangsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hargaBeli => $composableBuilder(
    column: $table.hargaBeli,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hargaJual => $composableBuilder(
    column: $table.hargaJual,
    builder: (column) => ColumnFilters(column),
  );

  $$SatuansTableFilterComposer get satuanId {
    final $$SatuansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.satuanId,
      referencedTable: $db.satuans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SatuansTableFilterComposer(
            $db: $db,
            $table: $db.satuans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transaksiDetailsRefs(
    Expression<bool> Function($$TransaksiDetailsTableFilterComposer f) f,
  ) {
    final $$TransaksiDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transaksiDetails,
      getReferencedColumn: (t) => t.barangId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaksiDetailsTableFilterComposer(
            $db: $db,
            $table: $db.transaksiDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BarangsTableOrderingComposer
    extends Composer<_$AppDatabase, $BarangsTable> {
  $$BarangsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hargaBeli => $composableBuilder(
    column: $table.hargaBeli,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hargaJual => $composableBuilder(
    column: $table.hargaJual,
    builder: (column) => ColumnOrderings(column),
  );

  $$SatuansTableOrderingComposer get satuanId {
    final $$SatuansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.satuanId,
      referencedTable: $db.satuans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SatuansTableOrderingComposer(
            $db: $db,
            $table: $db.satuans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BarangsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BarangsTable> {
  $$BarangsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<double> get hargaBeli =>
      $composableBuilder(column: $table.hargaBeli, builder: (column) => column);

  GeneratedColumn<double> get hargaJual =>
      $composableBuilder(column: $table.hargaJual, builder: (column) => column);

  $$SatuansTableAnnotationComposer get satuanId {
    final $$SatuansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.satuanId,
      referencedTable: $db.satuans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SatuansTableAnnotationComposer(
            $db: $db,
            $table: $db.satuans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transaksiDetailsRefs<T extends Object>(
    Expression<T> Function($$TransaksiDetailsTableAnnotationComposer a) f,
  ) {
    final $$TransaksiDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transaksiDetails,
      getReferencedColumn: (t) => t.barangId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaksiDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.transaksiDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BarangsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BarangsTable,
          Barang,
          $$BarangsTableFilterComposer,
          $$BarangsTableOrderingComposer,
          $$BarangsTableAnnotationComposer,
          $$BarangsTableCreateCompanionBuilder,
          $$BarangsTableUpdateCompanionBuilder,
          (Barang, $$BarangsTableReferences),
          Barang,
          PrefetchHooks Function({bool satuanId, bool transaksiDetailsRefs})
        > {
  $$BarangsTableTableManager(_$AppDatabase db, $BarangsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BarangsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BarangsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BarangsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<int> satuanId = const Value.absent(),
                Value<double> hargaBeli = const Value.absent(),
                Value<double> hargaJual = const Value.absent(),
              }) => BarangsCompanion(
                id: id,
                nama: nama,
                satuanId: satuanId,
                hargaBeli: hargaBeli,
                hargaJual: hargaJual,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                required int satuanId,
                required double hargaBeli,
                required double hargaJual,
              }) => BarangsCompanion.insert(
                id: id,
                nama: nama,
                satuanId: satuanId,
                hargaBeli: hargaBeli,
                hargaJual: hargaJual,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$BarangsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            satuanId = false,
            transaksiDetailsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transaksiDetailsRefs) db.transaksiDetails,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (satuanId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.satuanId,
                            referencedTable: $$BarangsTableReferences
                                ._satuanIdTable(db),
                            referencedColumn:
                                $$BarangsTableReferences._satuanIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transaksiDetailsRefs)
                    await $_getPrefetchedData<
                      Barang,
                      $BarangsTable,
                      TransaksiDetail
                    >(
                      currentTable: table,
                      referencedTable: $$BarangsTableReferences
                          ._transaksiDetailsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$BarangsTableReferences(
                                db,
                                table,
                                p0,
                              ).transaksiDetailsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.barangId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BarangsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BarangsTable,
      Barang,
      $$BarangsTableFilterComposer,
      $$BarangsTableOrderingComposer,
      $$BarangsTableAnnotationComposer,
      $$BarangsTableCreateCompanionBuilder,
      $$BarangsTableUpdateCompanionBuilder,
      (Barang, $$BarangsTableReferences),
      Barang,
      PrefetchHooks Function({bool satuanId, bool transaksiDetailsRefs})
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String nama,
      Value<String?> noHp,
      Value<String?> alamat,
      Value<String?> catatan,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<String?> noHp,
      Value<String?> alamat,
      Value<String?> catatan,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransaksisTable, List<Transaksi>>
  _transaksisRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transaksis,
    aliasName: 'customers__id__transaksis__customer_id',
  );

  $$TransaksisTableProcessedTableManager get transaksisRefs {
    final manager = $$TransaksisTableTableManager(
      $_db,
      $_db.transaksis,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transaksisRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noHp => $composableBuilder(
    column: $table.noHp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alamat => $composableBuilder(
    column: $table.alamat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transaksisRefs(
    Expression<bool> Function($$TransaksisTableFilterComposer f) f,
  ) {
    final $$TransaksisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transaksis,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaksisTableFilterComposer(
            $db: $db,
            $table: $db.transaksis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noHp => $composableBuilder(
    column: $table.noHp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alamat => $composableBuilder(
    column: $table.alamat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get noHp =>
      $composableBuilder(column: $table.noHp, builder: (column) => column);

  GeneratedColumn<String> get alamat =>
      $composableBuilder(column: $table.alamat, builder: (column) => column);

  GeneratedColumn<String> get catatan =>
      $composableBuilder(column: $table.catatan, builder: (column) => column);

  Expression<T> transaksisRefs<T extends Object>(
    Expression<T> Function($$TransaksisTableAnnotationComposer a) f,
  ) {
    final $$TransaksisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transaksis,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaksisTableAnnotationComposer(
            $db: $db,
            $table: $db.transaksis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({bool transaksisRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String?> noHp = const Value.absent(),
                Value<String?> alamat = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                nama: nama,
                noHp: noHp,
                alamat: alamat,
                catatan: catatan,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                Value<String?> noHp = const Value.absent(),
                Value<String?> alamat = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                nama: nama,
                noHp: noHp,
                alamat: alamat,
                catatan: catatan,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$CustomersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({transaksisRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transaksisRefs) db.transaksis],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transaksisRefs)
                    await $_getPrefetchedData<
                      Customer,
                      $CustomersTable,
                      Transaksi
                    >(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._transaksisRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).transaksisRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.customerId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({bool transaksisRefs})
    >;
typedef $$TransaksisTableCreateCompanionBuilder =
    TransaksisCompanion Function({
      Value<int> id,
      required String tipe,
      Value<int?> customerId,
      required String tanggal,
      required double totalHarga,
      Value<String?> catatan,
    });
typedef $$TransaksisTableUpdateCompanionBuilder =
    TransaksisCompanion Function({
      Value<int> id,
      Value<String> tipe,
      Value<int?> customerId,
      Value<String> tanggal,
      Value<double> totalHarga,
      Value<String?> catatan,
    });

final class $$TransaksisTableReferences
    extends BaseReferences<_$AppDatabase, $TransaksisTable, Transaksi> {
  $$TransaksisTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias('transaksis__customer_id__customers__id');

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransaksiDetailsTable, List<TransaksiDetail>>
  _transaksiDetailsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transaksiDetails,
    aliasName: 'transaksis__id__transaksi_details__transaksi_id',
  );

  $$TransaksiDetailsTableProcessedTableManager get transaksiDetailsRefs {
    final manager = $$TransaksiDetailsTableTableManager(
      $_db,
      $_db.transaksiDetails,
    ).filter((f) => f.transaksiId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transaksiDetailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransaksisTableFilterComposer
    extends Composer<_$AppDatabase, $TransaksisTable> {
  $$TransaksisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipe => $composableBuilder(
    column: $table.tipe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalHarga => $composableBuilder(
    column: $table.totalHarga,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transaksiDetailsRefs(
    Expression<bool> Function($$TransaksiDetailsTableFilterComposer f) f,
  ) {
    final $$TransaksiDetailsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transaksiDetails,
      getReferencedColumn: (t) => t.transaksiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaksiDetailsTableFilterComposer(
            $db: $db,
            $table: $db.transaksiDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransaksisTableOrderingComposer
    extends Composer<_$AppDatabase, $TransaksisTable> {
  $$TransaksisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipe => $composableBuilder(
    column: $table.tipe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tanggal => $composableBuilder(
    column: $table.tanggal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalHarga => $composableBuilder(
    column: $table.totalHarga,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransaksisTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransaksisTable> {
  $$TransaksisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipe =>
      $composableBuilder(column: $table.tipe, builder: (column) => column);

  GeneratedColumn<String> get tanggal =>
      $composableBuilder(column: $table.tanggal, builder: (column) => column);

  GeneratedColumn<double> get totalHarga => $composableBuilder(
    column: $table.totalHarga,
    builder: (column) => column,
  );

  GeneratedColumn<String> get catatan =>
      $composableBuilder(column: $table.catatan, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transaksiDetailsRefs<T extends Object>(
    Expression<T> Function($$TransaksiDetailsTableAnnotationComposer a) f,
  ) {
    final $$TransaksiDetailsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transaksiDetails,
      getReferencedColumn: (t) => t.transaksiId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaksiDetailsTableAnnotationComposer(
            $db: $db,
            $table: $db.transaksiDetails,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TransaksisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransaksisTable,
          Transaksi,
          $$TransaksisTableFilterComposer,
          $$TransaksisTableOrderingComposer,
          $$TransaksisTableAnnotationComposer,
          $$TransaksisTableCreateCompanionBuilder,
          $$TransaksisTableUpdateCompanionBuilder,
          (Transaksi, $$TransaksisTableReferences),
          Transaksi,
          PrefetchHooks Function({bool customerId, bool transaksiDetailsRefs})
        > {
  $$TransaksisTableTableManager(_$AppDatabase db, $TransaksisTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TransaksisTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TransaksisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TransaksisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tipe = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String> tanggal = const Value.absent(),
                Value<double> totalHarga = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
              }) => TransaksisCompanion(
                id: id,
                tipe: tipe,
                customerId: customerId,
                tanggal: tanggal,
                totalHarga: totalHarga,
                catatan: catatan,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tipe,
                Value<int?> customerId = const Value.absent(),
                required String tanggal,
                required double totalHarga,
                Value<String?> catatan = const Value.absent(),
              }) => TransaksisCompanion.insert(
                id: id,
                tipe: tipe,
                customerId: customerId,
                tanggal: tanggal,
                totalHarga: totalHarga,
                catatan: catatan,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$TransaksisTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            customerId = false,
            transaksiDetailsRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transaksiDetailsRefs) db.transaksiDetails,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (customerId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.customerId,
                            referencedTable: $$TransaksisTableReferences
                                ._customerIdTable(db),
                            referencedColumn:
                                $$TransaksisTableReferences
                                    ._customerIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transaksiDetailsRefs)
                    await $_getPrefetchedData<
                      Transaksi,
                      $TransaksisTable,
                      TransaksiDetail
                    >(
                      currentTable: table,
                      referencedTable: $$TransaksisTableReferences
                          ._transaksiDetailsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$TransaksisTableReferences(
                                db,
                                table,
                                p0,
                              ).transaksiDetailsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.transaksiId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TransaksisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransaksisTable,
      Transaksi,
      $$TransaksisTableFilterComposer,
      $$TransaksisTableOrderingComposer,
      $$TransaksisTableAnnotationComposer,
      $$TransaksisTableCreateCompanionBuilder,
      $$TransaksisTableUpdateCompanionBuilder,
      (Transaksi, $$TransaksisTableReferences),
      Transaksi,
      PrefetchHooks Function({bool customerId, bool transaksiDetailsRefs})
    >;
typedef $$TransaksiDetailsTableCreateCompanionBuilder =
    TransaksiDetailsCompanion Function({
      Value<int> id,
      required int transaksiId,
      required int barangId,
      required double jumlah,
      required double hargaSatuan,
      required double subtotal,
    });
typedef $$TransaksiDetailsTableUpdateCompanionBuilder =
    TransaksiDetailsCompanion Function({
      Value<int> id,
      Value<int> transaksiId,
      Value<int> barangId,
      Value<double> jumlah,
      Value<double> hargaSatuan,
      Value<double> subtotal,
    });

final class $$TransaksiDetailsTableReferences
    extends
        BaseReferences<_$AppDatabase, $TransaksiDetailsTable, TransaksiDetail> {
  $$TransaksiDetailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TransaksisTable _transaksiIdTable(_$AppDatabase db) => db.transaksis
      .createAlias('transaksi_details__transaksi_id__transaksis__id');

  $$TransaksisTableProcessedTableManager get transaksiId {
    final $_column = $_itemColumn<int>('transaksi_id')!;

    final manager = $$TransaksisTableTableManager(
      $_db,
      $_db.transaksis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transaksiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BarangsTable _barangIdTable(_$AppDatabase db) =>
      db.barangs.createAlias('transaksi_details__barang_id__barangs__id');

  $$BarangsTableProcessedTableManager get barangId {
    final $_column = $_itemColumn<int>('barang_id')!;

    final manager = $$BarangsTableTableManager(
      $_db,
      $_db.barangs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_barangIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransaksiDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $TransaksiDetailsTable> {
  $$TransaksiDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get jumlah => $composableBuilder(
    column: $table.jumlah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hargaSatuan => $composableBuilder(
    column: $table.hargaSatuan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  $$TransaksisTableFilterComposer get transaksiId {
    final $$TransaksisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transaksiId,
      referencedTable: $db.transaksis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaksisTableFilterComposer(
            $db: $db,
            $table: $db.transaksis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BarangsTableFilterComposer get barangId {
    final $$BarangsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.barangId,
      referencedTable: $db.barangs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarangsTableFilterComposer(
            $db: $db,
            $table: $db.barangs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransaksiDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransaksiDetailsTable> {
  $$TransaksiDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get jumlah => $composableBuilder(
    column: $table.jumlah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hargaSatuan => $composableBuilder(
    column: $table.hargaSatuan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  $$TransaksisTableOrderingComposer get transaksiId {
    final $$TransaksisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transaksiId,
      referencedTable: $db.transaksis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaksisTableOrderingComposer(
            $db: $db,
            $table: $db.transaksis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BarangsTableOrderingComposer get barangId {
    final $$BarangsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.barangId,
      referencedTable: $db.barangs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarangsTableOrderingComposer(
            $db: $db,
            $table: $db.barangs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransaksiDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransaksiDetailsTable> {
  $$TransaksiDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get jumlah =>
      $composableBuilder(column: $table.jumlah, builder: (column) => column);

  GeneratedColumn<double> get hargaSatuan => $composableBuilder(
    column: $table.hargaSatuan,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  $$TransaksisTableAnnotationComposer get transaksiId {
    final $$TransaksisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transaksiId,
      referencedTable: $db.transaksis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransaksisTableAnnotationComposer(
            $db: $db,
            $table: $db.transaksis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BarangsTableAnnotationComposer get barangId {
    final $$BarangsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.barangId,
      referencedTable: $db.barangs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BarangsTableAnnotationComposer(
            $db: $db,
            $table: $db.barangs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransaksiDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransaksiDetailsTable,
          TransaksiDetail,
          $$TransaksiDetailsTableFilterComposer,
          $$TransaksiDetailsTableOrderingComposer,
          $$TransaksiDetailsTableAnnotationComposer,
          $$TransaksiDetailsTableCreateCompanionBuilder,
          $$TransaksiDetailsTableUpdateCompanionBuilder,
          (TransaksiDetail, $$TransaksiDetailsTableReferences),
          TransaksiDetail,
          PrefetchHooks Function({bool transaksiId, bool barangId})
        > {
  $$TransaksiDetailsTableTableManager(
    _$AppDatabase db,
    $TransaksiDetailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$TransaksiDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TransaksiDetailsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$TransaksiDetailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> transaksiId = const Value.absent(),
                Value<int> barangId = const Value.absent(),
                Value<double> jumlah = const Value.absent(),
                Value<double> hargaSatuan = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
              }) => TransaksiDetailsCompanion(
                id: id,
                transaksiId: transaksiId,
                barangId: barangId,
                jumlah: jumlah,
                hargaSatuan: hargaSatuan,
                subtotal: subtotal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int transaksiId,
                required int barangId,
                required double jumlah,
                required double hargaSatuan,
                required double subtotal,
              }) => TransaksiDetailsCompanion.insert(
                id: id,
                transaksiId: transaksiId,
                barangId: barangId,
                jumlah: jumlah,
                hargaSatuan: hargaSatuan,
                subtotal: subtotal,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$TransaksiDetailsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({transaksiId = false, barangId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (transaksiId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.transaksiId,
                            referencedTable: $$TransaksiDetailsTableReferences
                                ._transaksiIdTable(db),
                            referencedColumn:
                                $$TransaksiDetailsTableReferences
                                    ._transaksiIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (barangId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.barangId,
                            referencedTable: $$TransaksiDetailsTableReferences
                                ._barangIdTable(db),
                            referencedColumn:
                                $$TransaksiDetailsTableReferences
                                    ._barangIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransaksiDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransaksiDetailsTable,
      TransaksiDetail,
      $$TransaksiDetailsTableFilterComposer,
      $$TransaksiDetailsTableOrderingComposer,
      $$TransaksiDetailsTableAnnotationComposer,
      $$TransaksiDetailsTableCreateCompanionBuilder,
      $$TransaksiDetailsTableUpdateCompanionBuilder,
      (TransaksiDetail, $$TransaksiDetailsTableReferences),
      TransaksiDetail,
      PrefetchHooks Function({bool transaksiId, bool barangId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SatuansTableTableManager get satuans =>
      $$SatuansTableTableManager(_db, _db.satuans);
  $$BarangsTableTableManager get barangs =>
      $$BarangsTableTableManager(_db, _db.barangs);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$TransaksisTableTableManager get transaksis =>
      $$TransaksisTableTableManager(_db, _db.transaksis);
  $$TransaksiDetailsTableTableManager get transaksiDetails =>
      $$TransaksiDetailsTableTableManager(_db, _db.transaksiDetails);
}
