// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $JurisdictionsTable extends Jurisdictions
    with TableInfo<$JurisdictionsTable, Jurisdiction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JurisdictionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameFrMeta = const VerificationMeta('nameFr');
  @override
  late final GeneratedColumn<String> nameFr = GeneratedColumn<String>(
      'name_fr', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [code, nameEn, nameFr];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'jurisdictions';
  @override
  VerificationContext validateIntegrity(Insertable<Jurisdiction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_fr')) {
      context.handle(_nameFrMeta,
          nameFr.isAcceptableOrUnknown(data['name_fr']!, _nameFrMeta));
    } else if (isInserting) {
      context.missing(_nameFrMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  Jurisdiction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Jurisdiction(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      nameFr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_fr'])!,
    );
  }

  @override
  $JurisdictionsTable createAlias(String alias) {
    return $JurisdictionsTable(attachedDatabase, alias);
  }
}

class Jurisdiction extends DataClass implements Insertable<Jurisdiction> {
  final String code;
  final String nameEn;
  final String nameFr;
  const Jurisdiction(
      {required this.code, required this.nameEn, required this.nameFr});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name_en'] = Variable<String>(nameEn);
    map['name_fr'] = Variable<String>(nameFr);
    return map;
  }

  JurisdictionsCompanion toCompanion(bool nullToAbsent) {
    return JurisdictionsCompanion(
      code: Value(code),
      nameEn: Value(nameEn),
      nameFr: Value(nameFr),
    );
  }

  factory Jurisdiction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Jurisdiction(
      code: serializer.fromJson<String>(json['code']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameFr: serializer.fromJson<String>(json['nameFr']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameFr': serializer.toJson<String>(nameFr),
    };
  }

  Jurisdiction copyWith({String? code, String? nameEn, String? nameFr}) =>
      Jurisdiction(
        code: code ?? this.code,
        nameEn: nameEn ?? this.nameEn,
        nameFr: nameFr ?? this.nameFr,
      );
  @override
  String toString() {
    return (StringBuffer('Jurisdiction(')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameFr: $nameFr')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, nameEn, nameFr);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Jurisdiction &&
          other.code == this.code &&
          other.nameEn == this.nameEn &&
          other.nameFr == this.nameFr);
}

class JurisdictionsCompanion extends UpdateCompanion<Jurisdiction> {
  final Value<String> code;
  final Value<String> nameEn;
  final Value<String> nameFr;
  final Value<int> rowid;
  const JurisdictionsCompanion({
    this.code = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameFr = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JurisdictionsCompanion.insert({
    required String code,
    required String nameEn,
    required String nameFr,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        nameEn = Value(nameEn),
        nameFr = Value(nameFr);
  static Insertable<Jurisdiction> custom({
    Expression<String>? code,
    Expression<String>? nameEn,
    Expression<String>? nameFr,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (nameEn != null) 'name_en': nameEn,
      if (nameFr != null) 'name_fr': nameFr,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JurisdictionsCompanion copyWith(
      {Value<String>? code,
      Value<String>? nameEn,
      Value<String>? nameFr,
      Value<int>? rowid}) {
    return JurisdictionsCompanion(
      code: code ?? this.code,
      nameEn: nameEn ?? this.nameEn,
      nameFr: nameFr ?? this.nameFr,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameFr.present) {
      map['name_fr'] = Variable<String>(nameFr.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JurisdictionsCompanion(')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameFr: $nameFr, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlotsTable extends Plots with TableInfo<$PlotsTable, Plot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nfiPlotMeta =
      const VerificationMeta('nfiPlot');
  @override
  late final GeneratedColumn<int> nfiPlot = GeneratedColumn<int>(
      'nfi_plot', aliasedName, false,
      check: () =>
          nfiPlot.isBetweenValues(1, 1600000) |
          nfiPlot.isBetweenValues(2000000, 2399999),
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES plots (nfi_plot)'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES jurisdictions (code)'));
  static const VerificationMeta _lastMeasNumMeta =
      const VerificationMeta('lastMeasNum');
  @override
  late final GeneratedColumn<int> lastMeasNum = GeneratedColumn<int>(
      'last_meas_num', aliasedName, true,
      check: () => lastMeasNum.isBetweenValues(0, 999),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [nfiPlot, code, lastMeasNum];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plots';
  @override
  VerificationContext validateIntegrity(Insertable<Plot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('nfi_plot')) {
      context.handle(_nfiPlotMeta,
          nfiPlot.isAcceptableOrUnknown(data['nfi_plot']!, _nfiPlotMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('last_meas_num')) {
      context.handle(
          _lastMeasNumMeta,
          lastMeasNum.isAcceptableOrUnknown(
              data['last_meas_num']!, _lastMeasNumMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {nfiPlot};
  @override
  Plot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plot(
      nfiPlot: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}nfi_plot'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      lastMeasNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_meas_num']),
    );
  }

  @override
  $PlotsTable createAlias(String alias) {
    return $PlotsTable(attachedDatabase, alias);
  }
}

class Plot extends DataClass implements Insertable<Plot> {
  final int nfiPlot;
  final String code;
  final int? lastMeasNum;
  const Plot({required this.nfiPlot, required this.code, this.lastMeasNum});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['nfi_plot'] = Variable<int>(nfiPlot);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || lastMeasNum != null) {
      map['last_meas_num'] = Variable<int>(lastMeasNum);
    }
    return map;
  }

  PlotsCompanion toCompanion(bool nullToAbsent) {
    return PlotsCompanion(
      nfiPlot: Value(nfiPlot),
      code: Value(code),
      lastMeasNum: lastMeasNum == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMeasNum),
    );
  }

  factory Plot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plot(
      nfiPlot: serializer.fromJson<int>(json['nfiPlot']),
      code: serializer.fromJson<String>(json['code']),
      lastMeasNum: serializer.fromJson<int?>(json['lastMeasNum']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'nfiPlot': serializer.toJson<int>(nfiPlot),
      'code': serializer.toJson<String>(code),
      'lastMeasNum': serializer.toJson<int?>(lastMeasNum),
    };
  }

  Plot copyWith(
          {int? nfiPlot,
          String? code,
          Value<int?> lastMeasNum = const Value.absent()}) =>
      Plot(
        nfiPlot: nfiPlot ?? this.nfiPlot,
        code: code ?? this.code,
        lastMeasNum: lastMeasNum.present ? lastMeasNum.value : this.lastMeasNum,
      );
  @override
  String toString() {
    return (StringBuffer('Plot(')
          ..write('nfiPlot: $nfiPlot, ')
          ..write('code: $code, ')
          ..write('lastMeasNum: $lastMeasNum')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(nfiPlot, code, lastMeasNum);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plot &&
          other.nfiPlot == this.nfiPlot &&
          other.code == this.code &&
          other.lastMeasNum == this.lastMeasNum);
}

class PlotsCompanion extends UpdateCompanion<Plot> {
  final Value<int> nfiPlot;
  final Value<String> code;
  final Value<int?> lastMeasNum;
  const PlotsCompanion({
    this.nfiPlot = const Value.absent(),
    this.code = const Value.absent(),
    this.lastMeasNum = const Value.absent(),
  });
  PlotsCompanion.insert({
    this.nfiPlot = const Value.absent(),
    required String code,
    this.lastMeasNum = const Value.absent(),
  }) : code = Value(code);
  static Insertable<Plot> custom({
    Expression<int>? nfiPlot,
    Expression<String>? code,
    Expression<int>? lastMeasNum,
  }) {
    return RawValuesInsertable({
      if (nfiPlot != null) 'nfi_plot': nfiPlot,
      if (code != null) 'code': code,
      if (lastMeasNum != null) 'last_meas_num': lastMeasNum,
    });
  }

  PlotsCompanion copyWith(
      {Value<int>? nfiPlot, Value<String>? code, Value<int?>? lastMeasNum}) {
    return PlotsCompanion(
      nfiPlot: nfiPlot ?? this.nfiPlot,
      code: code ?? this.code,
      lastMeasNum: lastMeasNum ?? this.lastMeasNum,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (nfiPlot.present) {
      map['nfi_plot'] = Variable<int>(nfiPlot.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (lastMeasNum.present) {
      map['last_meas_num'] = Variable<int>(lastMeasNum.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlotsCompanion(')
          ..write('nfiPlot: $nfiPlot, ')
          ..write('code: $code, ')
          ..write('lastMeasNum: $lastMeasNum')
          ..write(')'))
        .toString();
  }
}

class $TreeGenusTable extends TreeGenus
    with TableInfo<$TreeGenusTable, TreeGenusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreeGenusTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _genusCodeMeta =
      const VerificationMeta('genusCode');
  @override
  late final GeneratedColumn<String> genusCode = GeneratedColumn<String>(
      'genus_code', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _speciesCodeMeta =
      const VerificationMeta('speciesCode');
  @override
  late final GeneratedColumn<String> speciesCode = GeneratedColumn<String>(
      'species_code', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _genusLatinNameMeta =
      const VerificationMeta('genusLatinName');
  @override
  late final GeneratedColumn<String> genusLatinName = GeneratedColumn<String>(
      'genus_latin_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _speciesLatinNameMeta =
      const VerificationMeta('speciesLatinName');
  @override
  late final GeneratedColumn<String> speciesLatinName = GeneratedColumn<String>(
      'species_latin_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _commonNameEnMeta =
      const VerificationMeta('commonNameEn');
  @override
  late final GeneratedColumn<String> commonNameEn = GeneratedColumn<String>(
      'common_name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _commonNameFrMeta =
      const VerificationMeta('commonNameFr');
  @override
  late final GeneratedColumn<String> commonNameFr = GeneratedColumn<String>(
      'common_name_fr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        genusCode,
        speciesCode,
        genusLatinName,
        speciesLatinName,
        commonNameEn,
        commonNameFr
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tree_genus';
  @override
  VerificationContext validateIntegrity(Insertable<TreeGenusData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('genus_code')) {
      context.handle(_genusCodeMeta,
          genusCode.isAcceptableOrUnknown(data['genus_code']!, _genusCodeMeta));
    } else if (isInserting) {
      context.missing(_genusCodeMeta);
    }
    if (data.containsKey('species_code')) {
      context.handle(
          _speciesCodeMeta,
          speciesCode.isAcceptableOrUnknown(
              data['species_code']!, _speciesCodeMeta));
    } else if (isInserting) {
      context.missing(_speciesCodeMeta);
    }
    if (data.containsKey('genus_latin_name')) {
      context.handle(
          _genusLatinNameMeta,
          genusLatinName.isAcceptableOrUnknown(
              data['genus_latin_name']!, _genusLatinNameMeta));
    } else if (isInserting) {
      context.missing(_genusLatinNameMeta);
    }
    if (data.containsKey('species_latin_name')) {
      context.handle(
          _speciesLatinNameMeta,
          speciesLatinName.isAcceptableOrUnknown(
              data['species_latin_name']!, _speciesLatinNameMeta));
    } else if (isInserting) {
      context.missing(_speciesLatinNameMeta);
    }
    if (data.containsKey('common_name_en')) {
      context.handle(
          _commonNameEnMeta,
          commonNameEn.isAcceptableOrUnknown(
              data['common_name_en']!, _commonNameEnMeta));
    } else if (isInserting) {
      context.missing(_commonNameEnMeta);
    }
    if (data.containsKey('common_name_fr')) {
      context.handle(
          _commonNameFrMeta,
          commonNameFr.isAcceptableOrUnknown(
              data['common_name_fr']!, _commonNameFrMeta));
    } else if (isInserting) {
      context.missing(_commonNameFrMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {genusCode, speciesCode};
  @override
  TreeGenusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TreeGenusData(
      genusCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genus_code'])!,
      speciesCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species_code'])!,
      genusLatinName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}genus_latin_name'])!,
      speciesLatinName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}species_latin_name'])!,
      commonNameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}common_name_en'])!,
      commonNameFr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}common_name_fr'])!,
    );
  }

  @override
  $TreeGenusTable createAlias(String alias) {
    return $TreeGenusTable(attachedDatabase, alias);
  }
}

class TreeGenusData extends DataClass implements Insertable<TreeGenusData> {
  final String genusCode;
  final String speciesCode;
  final String genusLatinName;
  final String speciesLatinName;
  final String commonNameEn;
  final String commonNameFr;
  const TreeGenusData(
      {required this.genusCode,
      required this.speciesCode,
      required this.genusLatinName,
      required this.speciesLatinName,
      required this.commonNameEn,
      required this.commonNameFr});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['genus_code'] = Variable<String>(genusCode);
    map['species_code'] = Variable<String>(speciesCode);
    map['genus_latin_name'] = Variable<String>(genusLatinName);
    map['species_latin_name'] = Variable<String>(speciesLatinName);
    map['common_name_en'] = Variable<String>(commonNameEn);
    map['common_name_fr'] = Variable<String>(commonNameFr);
    return map;
  }

  TreeGenusCompanion toCompanion(bool nullToAbsent) {
    return TreeGenusCompanion(
      genusCode: Value(genusCode),
      speciesCode: Value(speciesCode),
      genusLatinName: Value(genusLatinName),
      speciesLatinName: Value(speciesLatinName),
      commonNameEn: Value(commonNameEn),
      commonNameFr: Value(commonNameFr),
    );
  }

  factory TreeGenusData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TreeGenusData(
      genusCode: serializer.fromJson<String>(json['genusCode']),
      speciesCode: serializer.fromJson<String>(json['speciesCode']),
      genusLatinName: serializer.fromJson<String>(json['genusLatinName']),
      speciesLatinName: serializer.fromJson<String>(json['speciesLatinName']),
      commonNameEn: serializer.fromJson<String>(json['commonNameEn']),
      commonNameFr: serializer.fromJson<String>(json['commonNameFr']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'genusCode': serializer.toJson<String>(genusCode),
      'speciesCode': serializer.toJson<String>(speciesCode),
      'genusLatinName': serializer.toJson<String>(genusLatinName),
      'speciesLatinName': serializer.toJson<String>(speciesLatinName),
      'commonNameEn': serializer.toJson<String>(commonNameEn),
      'commonNameFr': serializer.toJson<String>(commonNameFr),
    };
  }

  TreeGenusData copyWith(
          {String? genusCode,
          String? speciesCode,
          String? genusLatinName,
          String? speciesLatinName,
          String? commonNameEn,
          String? commonNameFr}) =>
      TreeGenusData(
        genusCode: genusCode ?? this.genusCode,
        speciesCode: speciesCode ?? this.speciesCode,
        genusLatinName: genusLatinName ?? this.genusLatinName,
        speciesLatinName: speciesLatinName ?? this.speciesLatinName,
        commonNameEn: commonNameEn ?? this.commonNameEn,
        commonNameFr: commonNameFr ?? this.commonNameFr,
      );
  @override
  String toString() {
    return (StringBuffer('TreeGenusData(')
          ..write('genusCode: $genusCode, ')
          ..write('speciesCode: $speciesCode, ')
          ..write('genusLatinName: $genusLatinName, ')
          ..write('speciesLatinName: $speciesLatinName, ')
          ..write('commonNameEn: $commonNameEn, ')
          ..write('commonNameFr: $commonNameFr')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(genusCode, speciesCode, genusLatinName,
      speciesLatinName, commonNameEn, commonNameFr);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreeGenusData &&
          other.genusCode == this.genusCode &&
          other.speciesCode == this.speciesCode &&
          other.genusLatinName == this.genusLatinName &&
          other.speciesLatinName == this.speciesLatinName &&
          other.commonNameEn == this.commonNameEn &&
          other.commonNameFr == this.commonNameFr);
}

class TreeGenusCompanion extends UpdateCompanion<TreeGenusData> {
  final Value<String> genusCode;
  final Value<String> speciesCode;
  final Value<String> genusLatinName;
  final Value<String> speciesLatinName;
  final Value<String> commonNameEn;
  final Value<String> commonNameFr;
  final Value<int> rowid;
  const TreeGenusCompanion({
    this.genusCode = const Value.absent(),
    this.speciesCode = const Value.absent(),
    this.genusLatinName = const Value.absent(),
    this.speciesLatinName = const Value.absent(),
    this.commonNameEn = const Value.absent(),
    this.commonNameFr = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TreeGenusCompanion.insert({
    required String genusCode,
    required String speciesCode,
    required String genusLatinName,
    required String speciesLatinName,
    required String commonNameEn,
    required String commonNameFr,
    this.rowid = const Value.absent(),
  })  : genusCode = Value(genusCode),
        speciesCode = Value(speciesCode),
        genusLatinName = Value(genusLatinName),
        speciesLatinName = Value(speciesLatinName),
        commonNameEn = Value(commonNameEn),
        commonNameFr = Value(commonNameFr);
  static Insertable<TreeGenusData> custom({
    Expression<String>? genusCode,
    Expression<String>? speciesCode,
    Expression<String>? genusLatinName,
    Expression<String>? speciesLatinName,
    Expression<String>? commonNameEn,
    Expression<String>? commonNameFr,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (genusCode != null) 'genus_code': genusCode,
      if (speciesCode != null) 'species_code': speciesCode,
      if (genusLatinName != null) 'genus_latin_name': genusLatinName,
      if (speciesLatinName != null) 'species_latin_name': speciesLatinName,
      if (commonNameEn != null) 'common_name_en': commonNameEn,
      if (commonNameFr != null) 'common_name_fr': commonNameFr,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TreeGenusCompanion copyWith(
      {Value<String>? genusCode,
      Value<String>? speciesCode,
      Value<String>? genusLatinName,
      Value<String>? speciesLatinName,
      Value<String>? commonNameEn,
      Value<String>? commonNameFr,
      Value<int>? rowid}) {
    return TreeGenusCompanion(
      genusCode: genusCode ?? this.genusCode,
      speciesCode: speciesCode ?? this.speciesCode,
      genusLatinName: genusLatinName ?? this.genusLatinName,
      speciesLatinName: speciesLatinName ?? this.speciesLatinName,
      commonNameEn: commonNameEn ?? this.commonNameEn,
      commonNameFr: commonNameFr ?? this.commonNameFr,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (genusCode.present) {
      map['genus_code'] = Variable<String>(genusCode.value);
    }
    if (speciesCode.present) {
      map['species_code'] = Variable<String>(speciesCode.value);
    }
    if (genusLatinName.present) {
      map['genus_latin_name'] = Variable<String>(genusLatinName.value);
    }
    if (speciesLatinName.present) {
      map['species_latin_name'] = Variable<String>(speciesLatinName.value);
    }
    if (commonNameEn.present) {
      map['common_name_en'] = Variable<String>(commonNameEn.value);
    }
    if (commonNameFr.present) {
      map['common_name_fr'] = Variable<String>(commonNameFr.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreeGenusCompanion(')
          ..write('genusCode: $genusCode, ')
          ..write('speciesCode: $speciesCode, ')
          ..write('genusLatinName: $genusLatinName, ')
          ..write('speciesLatinName: $speciesLatinName, ')
          ..write('commonNameEn: $commonNameEn, ')
          ..write('commonNameFr: $commonNameFr, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubstrateTypeTable extends SubstrateType
    with TableInfo<$SubstrateTypeTable, SubstrateTypeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubstrateTypeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _typeCodeMeta =
      const VerificationMeta('typeCode');
  @override
  late final GeneratedColumn<String> typeCode = GeneratedColumn<String>(
      'type_code', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameFrMeta = const VerificationMeta('nameFr');
  @override
  late final GeneratedColumn<String> nameFr = GeneratedColumn<String>(
      'name_fr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hasDepthMeta =
      const VerificationMeta('hasDepth');
  @override
  late final GeneratedColumn<bool> hasDepth = GeneratedColumn<bool>(
      'has_depth', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_depth" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [typeCode, nameEn, nameFr, hasDepth];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'substrate_type';
  @override
  VerificationContext validateIntegrity(Insertable<SubstrateTypeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('type_code')) {
      context.handle(_typeCodeMeta,
          typeCode.isAcceptableOrUnknown(data['type_code']!, _typeCodeMeta));
    } else if (isInserting) {
      context.missing(_typeCodeMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_fr')) {
      context.handle(_nameFrMeta,
          nameFr.isAcceptableOrUnknown(data['name_fr']!, _nameFrMeta));
    } else if (isInserting) {
      context.missing(_nameFrMeta);
    }
    if (data.containsKey('has_depth')) {
      context.handle(_hasDepthMeta,
          hasDepth.isAcceptableOrUnknown(data['has_depth']!, _hasDepthMeta));
    } else if (isInserting) {
      context.missing(_hasDepthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {typeCode};
  @override
  SubstrateTypeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubstrateTypeData(
      typeCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type_code'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      nameFr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_fr'])!,
      hasDepth: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_depth'])!,
    );
  }

  @override
  $SubstrateTypeTable createAlias(String alias) {
    return $SubstrateTypeTable(attachedDatabase, alias);
  }
}

class SubstrateTypeData extends DataClass
    implements Insertable<SubstrateTypeData> {
  final String typeCode;
  final String nameEn;
  final String nameFr;
  final bool hasDepth;
  const SubstrateTypeData(
      {required this.typeCode,
      required this.nameEn,
      required this.nameFr,
      required this.hasDepth});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['type_code'] = Variable<String>(typeCode);
    map['name_en'] = Variable<String>(nameEn);
    map['name_fr'] = Variable<String>(nameFr);
    map['has_depth'] = Variable<bool>(hasDepth);
    return map;
  }

  SubstrateTypeCompanion toCompanion(bool nullToAbsent) {
    return SubstrateTypeCompanion(
      typeCode: Value(typeCode),
      nameEn: Value(nameEn),
      nameFr: Value(nameFr),
      hasDepth: Value(hasDepth),
    );
  }

  factory SubstrateTypeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubstrateTypeData(
      typeCode: serializer.fromJson<String>(json['typeCode']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameFr: serializer.fromJson<String>(json['nameFr']),
      hasDepth: serializer.fromJson<bool>(json['hasDepth']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'typeCode': serializer.toJson<String>(typeCode),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameFr': serializer.toJson<String>(nameFr),
      'hasDepth': serializer.toJson<bool>(hasDepth),
    };
  }

  SubstrateTypeData copyWith(
          {String? typeCode, String? nameEn, String? nameFr, bool? hasDepth}) =>
      SubstrateTypeData(
        typeCode: typeCode ?? this.typeCode,
        nameEn: nameEn ?? this.nameEn,
        nameFr: nameFr ?? this.nameFr,
        hasDepth: hasDepth ?? this.hasDepth,
      );
  @override
  String toString() {
    return (StringBuffer('SubstrateTypeData(')
          ..write('typeCode: $typeCode, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameFr: $nameFr, ')
          ..write('hasDepth: $hasDepth')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(typeCode, nameEn, nameFr, hasDepth);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubstrateTypeData &&
          other.typeCode == this.typeCode &&
          other.nameEn == this.nameEn &&
          other.nameFr == this.nameFr &&
          other.hasDepth == this.hasDepth);
}

class SubstrateTypeCompanion extends UpdateCompanion<SubstrateTypeData> {
  final Value<String> typeCode;
  final Value<String> nameEn;
  final Value<String> nameFr;
  final Value<bool> hasDepth;
  final Value<int> rowid;
  const SubstrateTypeCompanion({
    this.typeCode = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameFr = const Value.absent(),
    this.hasDepth = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubstrateTypeCompanion.insert({
    required String typeCode,
    required String nameEn,
    required String nameFr,
    required bool hasDepth,
    this.rowid = const Value.absent(),
  })  : typeCode = Value(typeCode),
        nameEn = Value(nameEn),
        nameFr = Value(nameFr),
        hasDepth = Value(hasDepth);
  static Insertable<SubstrateTypeData> custom({
    Expression<String>? typeCode,
    Expression<String>? nameEn,
    Expression<String>? nameFr,
    Expression<bool>? hasDepth,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (typeCode != null) 'type_code': typeCode,
      if (nameEn != null) 'name_en': nameEn,
      if (nameFr != null) 'name_fr': nameFr,
      if (hasDepth != null) 'has_depth': hasDepth,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubstrateTypeCompanion copyWith(
      {Value<String>? typeCode,
      Value<String>? nameEn,
      Value<String>? nameFr,
      Value<bool>? hasDepth,
      Value<int>? rowid}) {
    return SubstrateTypeCompanion(
      typeCode: typeCode ?? this.typeCode,
      nameEn: nameEn ?? this.nameEn,
      nameFr: nameFr ?? this.nameFr,
      hasDepth: hasDepth ?? this.hasDepth,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (typeCode.present) {
      map['type_code'] = Variable<String>(typeCode.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameFr.present) {
      map['name_fr'] = Variable<String>(nameFr.value);
    }
    if (hasDepth.present) {
      map['has_depth'] = Variable<bool>(hasDepth.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubstrateTypeCompanion(')
          ..write('typeCode: $typeCode, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameFr: $nameFr, ')
          ..write('hasDepth: $hasDepth, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SsDepthLimitTable extends SsDepthLimit
    with TableInfo<$SsDepthLimitTable, SsDepthLimitData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SsDepthLimitTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<int> code = GeneratedColumn<int>(
      'code', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameFrMeta = const VerificationMeta('nameFr');
  @override
  late final GeneratedColumn<String> nameFr = GeneratedColumn<String>(
      'name_fr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, nameEn, nameFr];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ss_depth_limit';
  @override
  VerificationContext validateIntegrity(Insertable<SsDepthLimitData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_fr')) {
      context.handle(_nameFrMeta,
          nameFr.isAcceptableOrUnknown(data['name_fr']!, _nameFrMeta));
    } else if (isInserting) {
      context.missing(_nameFrMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SsDepthLimitData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SsDepthLimitData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}code'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      nameFr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_fr'])!,
    );
  }

  @override
  $SsDepthLimitTable createAlias(String alias) {
    return $SsDepthLimitTable(attachedDatabase, alias);
  }
}

class SsDepthLimitData extends DataClass
    implements Insertable<SsDepthLimitData> {
  final int code;
  final String nameEn;
  final String nameFr;
  const SsDepthLimitData(
      {required this.code, required this.nameEn, required this.nameFr});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<int>(code);
    map['name_en'] = Variable<String>(nameEn);
    map['name_fr'] = Variable<String>(nameFr);
    return map;
  }

  SsDepthLimitCompanion toCompanion(bool nullToAbsent) {
    return SsDepthLimitCompanion(
      code: Value(code),
      nameEn: Value(nameEn),
      nameFr: Value(nameFr),
    );
  }

  factory SsDepthLimitData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SsDepthLimitData(
      code: serializer.fromJson<int>(json['code']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameFr: serializer.fromJson<String>(json['nameFr']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<int>(code),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameFr': serializer.toJson<String>(nameFr),
    };
  }

  SsDepthLimitData copyWith({int? code, String? nameEn, String? nameFr}) =>
      SsDepthLimitData(
        code: code ?? this.code,
        nameEn: nameEn ?? this.nameEn,
        nameFr: nameFr ?? this.nameFr,
      );
  @override
  String toString() {
    return (StringBuffer('SsDepthLimitData(')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameFr: $nameFr')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, nameEn, nameFr);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SsDepthLimitData &&
          other.code == this.code &&
          other.nameEn == this.nameEn &&
          other.nameFr == this.nameFr);
}

class SsDepthLimitCompanion extends UpdateCompanion<SsDepthLimitData> {
  final Value<int> code;
  final Value<String> nameEn;
  final Value<String> nameFr;
  final Value<int> rowid;
  const SsDepthLimitCompanion({
    this.code = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameFr = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SsDepthLimitCompanion.insert({
    required int code,
    required String nameEn,
    required String nameFr,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        nameEn = Value(nameEn),
        nameFr = Value(nameFr);
  static Insertable<SsDepthLimitData> custom({
    Expression<int>? code,
    Expression<String>? nameEn,
    Expression<String>? nameFr,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (nameEn != null) 'name_en': nameEn,
      if (nameFr != null) 'name_fr': nameFr,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SsDepthLimitCompanion copyWith(
      {Value<int>? code,
      Value<String>? nameEn,
      Value<String>? nameFr,
      Value<int>? rowid}) {
    return SsDepthLimitCompanion(
      code: code ?? this.code,
      nameEn: nameEn ?? this.nameEn,
      nameFr: nameFr ?? this.nameFr,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<int>(code.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameFr.present) {
      map['name_fr'] = Variable<String>(nameFr.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SsDepthLimitCompanion(')
          ..write('code: $code, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameFr: $nameFr, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EcpGenusTable extends EcpGenus
    with TableInfo<$EcpGenusTable, EcpGenusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EcpGenusTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _genusMeta = const VerificationMeta('genus');
  @override
  late final GeneratedColumn<String> genus = GeneratedColumn<String>(
      'genus', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _speciesMeta =
      const VerificationMeta('species');
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
      'species', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _varietyMeta =
      const VerificationMeta('variety');
  @override
  late final GeneratedColumn<String> variety = GeneratedColumn<String>(
      'variety', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [genus, species, variety];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ecp_genus';
  @override
  VerificationContext validateIntegrity(Insertable<EcpGenusData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('genus')) {
      context.handle(
          _genusMeta, genus.isAcceptableOrUnknown(data['genus']!, _genusMeta));
    } else if (isInserting) {
      context.missing(_genusMeta);
    }
    if (data.containsKey('species')) {
      context.handle(_speciesMeta,
          species.isAcceptableOrUnknown(data['species']!, _speciesMeta));
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('variety')) {
      context.handle(_varietyMeta,
          variety.isAcceptableOrUnknown(data['variety']!, _varietyMeta));
    } else if (isInserting) {
      context.missing(_varietyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  EcpGenusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EcpGenusData(
      genus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genus'])!,
      species: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species'])!,
      variety: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variety'])!,
    );
  }

  @override
  $EcpGenusTable createAlias(String alias) {
    return $EcpGenusTable(attachedDatabase, alias);
  }
}

class EcpGenusData extends DataClass implements Insertable<EcpGenusData> {
  final String genus;
  final String species;
  final String variety;
  const EcpGenusData(
      {required this.genus, required this.species, required this.variety});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['genus'] = Variable<String>(genus);
    map['species'] = Variable<String>(species);
    map['variety'] = Variable<String>(variety);
    return map;
  }

  EcpGenusCompanion toCompanion(bool nullToAbsent) {
    return EcpGenusCompanion(
      genus: Value(genus),
      species: Value(species),
      variety: Value(variety),
    );
  }

  factory EcpGenusData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EcpGenusData(
      genus: serializer.fromJson<String>(json['genus']),
      species: serializer.fromJson<String>(json['species']),
      variety: serializer.fromJson<String>(json['variety']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'genus': serializer.toJson<String>(genus),
      'species': serializer.toJson<String>(species),
      'variety': serializer.toJson<String>(variety),
    };
  }

  EcpGenusData copyWith({String? genus, String? species, String? variety}) =>
      EcpGenusData(
        genus: genus ?? this.genus,
        species: species ?? this.species,
        variety: variety ?? this.variety,
      );
  @override
  String toString() {
    return (StringBuffer('EcpGenusData(')
          ..write('genus: $genus, ')
          ..write('species: $species, ')
          ..write('variety: $variety')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(genus, species, variety);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcpGenusData &&
          other.genus == this.genus &&
          other.species == this.species &&
          other.variety == this.variety);
}

class EcpGenusCompanion extends UpdateCompanion<EcpGenusData> {
  final Value<String> genus;
  final Value<String> species;
  final Value<String> variety;
  final Value<int> rowid;
  const EcpGenusCompanion({
    this.genus = const Value.absent(),
    this.species = const Value.absent(),
    this.variety = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EcpGenusCompanion.insert({
    required String genus,
    required String species,
    required String variety,
    this.rowid = const Value.absent(),
  })  : genus = Value(genus),
        species = Value(species),
        variety = Value(variety);
  static Insertable<EcpGenusData> custom({
    Expression<String>? genus,
    Expression<String>? species,
    Expression<String>? variety,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (genus != null) 'genus': genus,
      if (species != null) 'species': species,
      if (variety != null) 'variety': variety,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EcpGenusCompanion copyWith(
      {Value<String>? genus,
      Value<String>? species,
      Value<String>? variety,
      Value<int>? rowid}) {
    return EcpGenusCompanion(
      genus: genus ?? this.genus,
      species: species ?? this.species,
      variety: variety ?? this.variety,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (genus.present) {
      map['genus'] = Variable<String>(genus.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (variety.present) {
      map['variety'] = Variable<String>(variety.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcpGenusCompanion(')
          ..write('genus: $genus, ')
          ..write('species: $species, ')
          ..write('variety: $variety, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EcpLayerTable extends EcpLayer
    with TableInfo<$EcpLayerTable, EcpLayerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EcpLayerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ecp_layer';
  @override
  VerificationContext validateIntegrity(Insertable<EcpLayerData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  EcpLayerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EcpLayerData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $EcpLayerTable createAlias(String alias) {
    return $EcpLayerTable(attachedDatabase, alias);
  }
}

class EcpLayerData extends DataClass implements Insertable<EcpLayerData> {
  final String code;
  final String name;
  const EcpLayerData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  EcpLayerCompanion toCompanion(bool nullToAbsent) {
    return EcpLayerCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory EcpLayerData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EcpLayerData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  EcpLayerData copyWith({String? code, String? name}) => EcpLayerData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('EcpLayerData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcpLayerData &&
          other.code == this.code &&
          other.name == this.name);
}

class EcpLayerCompanion extends UpdateCompanion<EcpLayerData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const EcpLayerCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EcpLayerCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<EcpLayerData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EcpLayerCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return EcpLayerCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcpLayerCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilPitClassificationTable extends SoilPitClassification
    with TableInfo<$SoilPitClassificationTable, SoilPitClassificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilPitClassificationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<String> order = GeneratedColumn<String>(
      'order', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _greatGroupMeta =
      const VerificationMeta('greatGroup');
  @override
  late final GeneratedColumn<String> greatGroup = GeneratedColumn<String>(
      'great_group', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subGroupMeta =
      const VerificationMeta('subGroup');
  @override
  late final GeneratedColumn<String> subGroup = GeneratedColumn<String>(
      'sub_group', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [code, order, greatGroup, subGroup];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_pit_classification';
  @override
  VerificationContext validateIntegrity(
      Insertable<SoilPitClassificationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('great_group')) {
      context.handle(
          _greatGroupMeta,
          greatGroup.isAcceptableOrUnknown(
              data['great_group']!, _greatGroupMeta));
    } else if (isInserting) {
      context.missing(_greatGroupMeta);
    }
    if (data.containsKey('sub_group')) {
      context.handle(_subGroupMeta,
          subGroup.isAcceptableOrUnknown(data['sub_group']!, _subGroupMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilPitClassificationData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilPitClassificationData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order'])!,
      greatGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}great_group'])!,
      subGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sub_group']),
    );
  }

  @override
  $SoilPitClassificationTable createAlias(String alias) {
    return $SoilPitClassificationTable(attachedDatabase, alias);
  }
}

class SoilPitClassificationData extends DataClass
    implements Insertable<SoilPitClassificationData> {
  final String code;
  final String order;
  final String greatGroup;
  final String? subGroup;
  const SoilPitClassificationData(
      {required this.code,
      required this.order,
      required this.greatGroup,
      this.subGroup});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['order'] = Variable<String>(order);
    map['great_group'] = Variable<String>(greatGroup);
    if (!nullToAbsent || subGroup != null) {
      map['sub_group'] = Variable<String>(subGroup);
    }
    return map;
  }

  SoilPitClassificationCompanion toCompanion(bool nullToAbsent) {
    return SoilPitClassificationCompanion(
      code: Value(code),
      order: Value(order),
      greatGroup: Value(greatGroup),
      subGroup: subGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(subGroup),
    );
  }

  factory SoilPitClassificationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitClassificationData(
      code: serializer.fromJson<String>(json['code']),
      order: serializer.fromJson<String>(json['order']),
      greatGroup: serializer.fromJson<String>(json['greatGroup']),
      subGroup: serializer.fromJson<String?>(json['subGroup']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'order': serializer.toJson<String>(order),
      'greatGroup': serializer.toJson<String>(greatGroup),
      'subGroup': serializer.toJson<String?>(subGroup),
    };
  }

  SoilPitClassificationData copyWith(
          {String? code,
          String? order,
          String? greatGroup,
          Value<String?> subGroup = const Value.absent()}) =>
      SoilPitClassificationData(
        code: code ?? this.code,
        order: order ?? this.order,
        greatGroup: greatGroup ?? this.greatGroup,
        subGroup: subGroup.present ? subGroup.value : this.subGroup,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitClassificationData(')
          ..write('code: $code, ')
          ..write('order: $order, ')
          ..write('greatGroup: $greatGroup, ')
          ..write('subGroup: $subGroup')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, order, greatGroup, subGroup);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilPitClassificationData &&
          other.code == this.code &&
          other.order == this.order &&
          other.greatGroup == this.greatGroup &&
          other.subGroup == this.subGroup);
}

class SoilPitClassificationCompanion
    extends UpdateCompanion<SoilPitClassificationData> {
  final Value<String> code;
  final Value<String> order;
  final Value<String> greatGroup;
  final Value<String?> subGroup;
  final Value<int> rowid;
  const SoilPitClassificationCompanion({
    this.code = const Value.absent(),
    this.order = const Value.absent(),
    this.greatGroup = const Value.absent(),
    this.subGroup = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilPitClassificationCompanion.insert({
    required String code,
    required String order,
    required String greatGroup,
    this.subGroup = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        order = Value(order),
        greatGroup = Value(greatGroup);
  static Insertable<SoilPitClassificationData> custom({
    Expression<String>? code,
    Expression<String>? order,
    Expression<String>? greatGroup,
    Expression<String>? subGroup,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (order != null) 'order': order,
      if (greatGroup != null) 'great_group': greatGroup,
      if (subGroup != null) 'sub_group': subGroup,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilPitClassificationCompanion copyWith(
      {Value<String>? code,
      Value<String>? order,
      Value<String>? greatGroup,
      Value<String?>? subGroup,
      Value<int>? rowid}) {
    return SoilPitClassificationCompanion(
      code: code ?? this.code,
      order: order ?? this.order,
      greatGroup: greatGroup ?? this.greatGroup,
      subGroup: subGroup ?? this.subGroup,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (order.present) {
      map['order'] = Variable<String>(order.value);
    }
    if (greatGroup.present) {
      map['great_group'] = Variable<String>(greatGroup.value);
    }
    if (subGroup.present) {
      map['sub_group'] = Variable<String>(subGroup.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilPitClassificationCompanion(')
          ..write('code: $code, ')
          ..write('order: $order, ')
          ..write('greatGroup: $greatGroup, ')
          ..write('subGroup: $subGroup, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilDrainageClassTable extends SoilDrainageClass
    with TableInfo<$SoilDrainageClassTable, SoilDrainageClassData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilDrainageClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<int> code = GeneratedColumn<int>(
      'code', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_drainage_class';
  @override
  VerificationContext validateIntegrity(
      Insertable<SoilDrainageClassData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilDrainageClassData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilDrainageClassData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilDrainageClassTable createAlias(String alias) {
    return $SoilDrainageClassTable(attachedDatabase, alias);
  }
}

class SoilDrainageClassData extends DataClass
    implements Insertable<SoilDrainageClassData> {
  final int code;
  final String name;
  const SoilDrainageClassData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<int>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilDrainageClassCompanion toCompanion(bool nullToAbsent) {
    return SoilDrainageClassCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilDrainageClassData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilDrainageClassData(
      code: serializer.fromJson<int>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<int>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  SoilDrainageClassData copyWith({int? code, String? name}) =>
      SoilDrainageClassData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilDrainageClassData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilDrainageClassData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilDrainageClassCompanion
    extends UpdateCompanion<SoilDrainageClassData> {
  final Value<int> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilDrainageClassCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilDrainageClassCompanion.insert({
    required int code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilDrainageClassData> custom({
    Expression<int>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilDrainageClassCompanion copyWith(
      {Value<int>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilDrainageClassCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<int>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilDrainageClassCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilMoistureClassTable extends SoilMoistureClass
    with TableInfo<$SoilMoistureClassTable, SoilMositureClassData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilMoistureClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<int> code = GeneratedColumn<int>(
      'code', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_moisture_class';
  @override
  VerificationContext validateIntegrity(
      Insertable<SoilMositureClassData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilMositureClassData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilMositureClassData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilMoistureClassTable createAlias(String alias) {
    return $SoilMoistureClassTable(attachedDatabase, alias);
  }
}

class SoilMositureClassData extends DataClass
    implements Insertable<SoilMositureClassData> {
  final int code;
  final String name;
  const SoilMositureClassData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<int>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilMoistureClassCompanion toCompanion(bool nullToAbsent) {
    return SoilMoistureClassCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilMositureClassData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilMositureClassData(
      code: serializer.fromJson<int>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<int>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  SoilMositureClassData copyWith({int? code, String? name}) =>
      SoilMositureClassData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilMositureClassData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilMositureClassData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilMoistureClassCompanion
    extends UpdateCompanion<SoilMositureClassData> {
  final Value<int> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilMoistureClassCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilMoistureClassCompanion.insert({
    required int code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilMositureClassData> custom({
    Expression<int>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilMoistureClassCompanion copyWith(
      {Value<int>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilMoistureClassCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<int>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilMoistureClassCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilDepositionTable extends SoilDeposition
    with TableInfo<$SoilDepositionTable, SoilDepositionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilDepositionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_deposition';
  @override
  VerificationContext validateIntegrity(Insertable<SoilDepositionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilDepositionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilDepositionData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilDepositionTable createAlias(String alias) {
    return $SoilDepositionTable(attachedDatabase, alias);
  }
}

class SoilDepositionData extends DataClass
    implements Insertable<SoilDepositionData> {
  final String code;
  final String name;
  const SoilDepositionData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilDepositionCompanion toCompanion(bool nullToAbsent) {
    return SoilDepositionCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilDepositionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilDepositionData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  SoilDepositionData copyWith({String? code, String? name}) =>
      SoilDepositionData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilDepositionData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilDepositionData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilDepositionCompanion extends UpdateCompanion<SoilDepositionData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilDepositionCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilDepositionCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilDepositionData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilDepositionCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilDepositionCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilDepositionCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilHumusFormTable extends SoilHumusForm
    with TableInfo<$SoilHumusFormTable, SoilHumusFormData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilHumusFormTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_humus_form';
  @override
  VerificationContext validateIntegrity(Insertable<SoilHumusFormData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilHumusFormData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilHumusFormData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilHumusFormTable createAlias(String alias) {
    return $SoilHumusFormTable(attachedDatabase, alias);
  }
}

class SoilHumusFormData extends DataClass
    implements Insertable<SoilHumusFormData> {
  final String code;
  final String name;
  const SoilHumusFormData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilHumusFormCompanion toCompanion(bool nullToAbsent) {
    return SoilHumusFormCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilHumusFormData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilHumusFormData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  SoilHumusFormData copyWith({String? code, String? name}) => SoilHumusFormData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilHumusFormData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilHumusFormData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilHumusFormCompanion extends UpdateCompanion<SoilHumusFormData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilHumusFormCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilHumusFormCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilHumusFormData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilHumusFormCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilHumusFormCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilHumusFormCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilPitCodeCompletedTable extends SoilPitCodeCompleted
    with TableInfo<$SoilPitCodeCompletedTable, SoilPitCodeCompletedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilPitCodeCompletedTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_pit_code_completed';
  @override
  VerificationContext validateIntegrity(
      Insertable<SoilPitCodeCompletedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilPitCodeCompletedData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilPitCodeCompletedData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilPitCodeCompletedTable createAlias(String alias) {
    return $SoilPitCodeCompletedTable(attachedDatabase, alias);
  }
}

class SoilPitCodeCompletedData extends DataClass
    implements Insertable<SoilPitCodeCompletedData> {
  final String code;
  final String name;
  const SoilPitCodeCompletedData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilPitCodeCompletedCompanion toCompanion(bool nullToAbsent) {
    return SoilPitCodeCompletedCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilPitCodeCompletedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitCodeCompletedData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  SoilPitCodeCompletedData copyWith({String? code, String? name}) =>
      SoilPitCodeCompletedData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitCodeCompletedData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilPitCodeCompletedData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilPitCodeCompletedCompanion
    extends UpdateCompanion<SoilPitCodeCompletedData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilPitCodeCompletedCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilPitCodeCompletedCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilPitCodeCompletedData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilPitCodeCompletedCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilPitCodeCompletedCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilPitCodeCompletedCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilPitCodeFieldTable extends SoilPitCodeField
    with TableInfo<$SoilPitCodeFieldTable, SoilPitCodeFieldData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilPitCodeFieldTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_pit_code_field';
  @override
  VerificationContext validateIntegrity(
      Insertable<SoilPitCodeFieldData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilPitCodeFieldData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilPitCodeFieldData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilPitCodeFieldTable createAlias(String alias) {
    return $SoilPitCodeFieldTable(attachedDatabase, alias);
  }
}

class SoilPitCodeFieldData extends DataClass
    implements Insertable<SoilPitCodeFieldData> {
  final String code;
  final String name;
  const SoilPitCodeFieldData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilPitCodeFieldCompanion toCompanion(bool nullToAbsent) {
    return SoilPitCodeFieldCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilPitCodeFieldData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitCodeFieldData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  SoilPitCodeFieldData copyWith({String? code, String? name}) =>
      SoilPitCodeFieldData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitCodeFieldData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilPitCodeFieldData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilPitCodeFieldCompanion extends UpdateCompanion<SoilPitCodeFieldData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilPitCodeFieldCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilPitCodeFieldCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilPitCodeFieldData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilPitCodeFieldCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilPitCodeFieldCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilPitCodeFieldCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilPitFeatureClassTable extends SoilPitFeatureClass
    with TableInfo<$SoilPitFeatureClassTable, SoilFeatureClassData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilPitFeatureClassTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_pit_feature_class';
  @override
  VerificationContext validateIntegrity(
      Insertable<SoilFeatureClassData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilFeatureClassData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilFeatureClassData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilPitFeatureClassTable createAlias(String alias) {
    return $SoilPitFeatureClassTable(attachedDatabase, alias);
  }
}

class SoilFeatureClassData extends DataClass
    implements Insertable<SoilFeatureClassData> {
  final String code;
  final String name;
  const SoilFeatureClassData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilPitFeatureClassCompanion toCompanion(bool nullToAbsent) {
    return SoilPitFeatureClassCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilFeatureClassData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilFeatureClassData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  SoilFeatureClassData copyWith({String? code, String? name}) =>
      SoilFeatureClassData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilFeatureClassData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilFeatureClassData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilPitFeatureClassCompanion
    extends UpdateCompanion<SoilFeatureClassData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilPitFeatureClassCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilPitFeatureClassCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilFeatureClassData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilPitFeatureClassCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilPitFeatureClassCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilPitFeatureClassCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilHorizonDesignationTable extends SoilHorizonDesignation
    with TableInfo<$SoilHorizonDesignationTable, SoilHorizonDesignationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilHorizonDesignationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_horizon_designation';
  @override
  VerificationContext validateIntegrity(
      Insertable<SoilHorizonDesignationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilHorizonDesignationData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilHorizonDesignationData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilHorizonDesignationTable createAlias(String alias) {
    return $SoilHorizonDesignationTable(attachedDatabase, alias);
  }
}

class SoilHorizonDesignationData extends DataClass
    implements Insertable<SoilHorizonDesignationData> {
  final String code;
  final String name;
  const SoilHorizonDesignationData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilHorizonDesignationCompanion toCompanion(bool nullToAbsent) {
    return SoilHorizonDesignationCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilHorizonDesignationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilHorizonDesignationData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  SoilHorizonDesignationData copyWith({String? code, String? name}) =>
      SoilHorizonDesignationData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilHorizonDesignationData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilHorizonDesignationData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilHorizonDesignationCompanion
    extends UpdateCompanion<SoilHorizonDesignationData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilHorizonDesignationCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilHorizonDesignationCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilHorizonDesignationData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilHorizonDesignationCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilHorizonDesignationCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilHorizonDesignationCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilColorTable extends SoilColor
    with TableInfo<$SoilColorTable, SoilColorData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilColorTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_color';
  @override
  VerificationContext validateIntegrity(Insertable<SoilColorData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilColorData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilColorData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilColorTable createAlias(String alias) {
    return $SoilColorTable(attachedDatabase, alias);
  }
}

class SoilColorData extends DataClass implements Insertable<SoilColorData> {
  final String code;
  final String name;
  const SoilColorData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilColorCompanion toCompanion(bool nullToAbsent) {
    return SoilColorCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilColorData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilColorData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  SoilColorData copyWith({String? code, String? name}) => SoilColorData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilColorData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilColorData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilColorCompanion extends UpdateCompanion<SoilColorData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilColorCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilColorCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilColorData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilColorCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilColorCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilColorCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SoilTextureTable extends SoilTexture
    with TableInfo<$SoilTextureTable, SoilTextureData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilTextureTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_texture';
  @override
  VerificationContext validateIntegrity(Insertable<SoilTextureData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SoilTextureData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilTextureData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilTextureTable createAlias(String alias) {
    return $SoilTextureTable(attachedDatabase, alias);
  }
}

class SoilTextureData extends DataClass implements Insertable<SoilTextureData> {
  final String code;
  final String name;
  const SoilTextureData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilTextureCompanion toCompanion(bool nullToAbsent) {
    return SoilTextureCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilTextureData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilTextureData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  SoilTextureData copyWith({String? code, String? name}) => SoilTextureData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilTextureData(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilTextureData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilTextureCompanion extends UpdateCompanion<SoilTextureData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilTextureCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilTextureCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilTextureData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SoilTextureCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilTextureCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilTextureCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SurveyHeadersTable extends SurveyHeaders
    with TableInfo<$SurveyHeadersTable, SurveyHeader> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurveyHeadersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nfiPlotMeta =
      const VerificationMeta('nfiPlot');
  @override
  late final GeneratedColumn<int> nfiPlot = GeneratedColumn<int>(
      'nfi_plot', aliasedName, false,
      check: () =>
          nfiPlot.isBetweenValues(1, 1600000) |
          nfiPlot.isBetweenValues(2000000, 2399999),
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES plots (nfi_plot)'));
  static const VerificationMeta _measDateMeta =
      const VerificationMeta('measDate');
  @override
  late final GeneratedColumn<DateTime> measDate = GeneratedColumn<DateTime>(
      'meas_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _measNumMeta =
      const VerificationMeta('measNum');
  @override
  late final GeneratedColumn<int> measNum = GeneratedColumn<int>(
      'meas_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _provinceMeta =
      const VerificationMeta('province');
  @override
  late final GeneratedColumn<String> province = GeneratedColumn<String>(
      'province', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES jurisdictions (code)'));
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, nfiPlot, measDate, measNum, province, complete];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'survey_headers';
  @override
  VerificationContext validateIntegrity(Insertable<SurveyHeader> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nfi_plot')) {
      context.handle(_nfiPlotMeta,
          nfiPlot.isAcceptableOrUnknown(data['nfi_plot']!, _nfiPlotMeta));
    } else if (isInserting) {
      context.missing(_nfiPlotMeta);
    }
    if (data.containsKey('meas_date')) {
      context.handle(_measDateMeta,
          measDate.isAcceptableOrUnknown(data['meas_date']!, _measDateMeta));
    } else if (isInserting) {
      context.missing(_measDateMeta);
    }
    if (data.containsKey('meas_num')) {
      context.handle(_measNumMeta,
          measNum.isAcceptableOrUnknown(data['meas_num']!, _measNumMeta));
    } else if (isInserting) {
      context.missing(_measNumMeta);
    }
    if (data.containsKey('province')) {
      context.handle(_provinceMeta,
          province.isAcceptableOrUnknown(data['province']!, _provinceMeta));
    } else if (isInserting) {
      context.missing(_provinceMeta);
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurveyHeader map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurveyHeader(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nfiPlot: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}nfi_plot'])!,
      measDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}meas_date'])!,
      measNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}meas_num'])!,
      province: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}province'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $SurveyHeadersTable createAlias(String alias) {
    return $SurveyHeadersTable(attachedDatabase, alias);
  }
}

class SurveyHeader extends DataClass implements Insertable<SurveyHeader> {
  final int id;
  final int nfiPlot;
  final DateTime measDate;
  final int measNum;
  final String province;
  final bool complete;
  const SurveyHeader(
      {required this.id,
      required this.nfiPlot,
      required this.measDate,
      required this.measNum,
      required this.province,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nfi_plot'] = Variable<int>(nfiPlot);
    map['meas_date'] = Variable<DateTime>(measDate);
    map['meas_num'] = Variable<int>(measNum);
    map['province'] = Variable<String>(province);
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  SurveyHeadersCompanion toCompanion(bool nullToAbsent) {
    return SurveyHeadersCompanion(
      id: Value(id),
      nfiPlot: Value(nfiPlot),
      measDate: Value(measDate),
      measNum: Value(measNum),
      province: Value(province),
      complete: Value(complete),
    );
  }

  factory SurveyHeader.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurveyHeader(
      id: serializer.fromJson<int>(json['id']),
      nfiPlot: serializer.fromJson<int>(json['nfiPlot']),
      measDate: serializer.fromJson<DateTime>(json['measDate']),
      measNum: serializer.fromJson<int>(json['measNum']),
      province: serializer.fromJson<String>(json['province']),
      complete: serializer.fromJson<bool>(json['complete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nfiPlot': serializer.toJson<int>(nfiPlot),
      'measDate': serializer.toJson<DateTime>(measDate),
      'measNum': serializer.toJson<int>(measNum),
      'province': serializer.toJson<String>(province),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  SurveyHeader copyWith(
          {int? id,
          int? nfiPlot,
          DateTime? measDate,
          int? measNum,
          String? province,
          bool? complete}) =>
      SurveyHeader(
        id: id ?? this.id,
        nfiPlot: nfiPlot ?? this.nfiPlot,
        measDate: measDate ?? this.measDate,
        measNum: measNum ?? this.measNum,
        province: province ?? this.province,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('SurveyHeader(')
          ..write('id: $id, ')
          ..write('nfiPlot: $nfiPlot, ')
          ..write('measDate: $measDate, ')
          ..write('measNum: $measNum, ')
          ..write('province: $province, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nfiPlot, measDate, measNum, province, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurveyHeader &&
          other.id == this.id &&
          other.nfiPlot == this.nfiPlot &&
          other.measDate == this.measDate &&
          other.measNum == this.measNum &&
          other.province == this.province &&
          other.complete == this.complete);
}

class SurveyHeadersCompanion extends UpdateCompanion<SurveyHeader> {
  final Value<int> id;
  final Value<int> nfiPlot;
  final Value<DateTime> measDate;
  final Value<int> measNum;
  final Value<String> province;
  final Value<bool> complete;
  const SurveyHeadersCompanion({
    this.id = const Value.absent(),
    this.nfiPlot = const Value.absent(),
    this.measDate = const Value.absent(),
    this.measNum = const Value.absent(),
    this.province = const Value.absent(),
    this.complete = const Value.absent(),
  });
  SurveyHeadersCompanion.insert({
    this.id = const Value.absent(),
    required int nfiPlot,
    required DateTime measDate,
    required int measNum,
    required String province,
    this.complete = const Value.absent(),
  })  : nfiPlot = Value(nfiPlot),
        measDate = Value(measDate),
        measNum = Value(measNum),
        province = Value(province);
  static Insertable<SurveyHeader> custom({
    Expression<int>? id,
    Expression<int>? nfiPlot,
    Expression<DateTime>? measDate,
    Expression<int>? measNum,
    Expression<String>? province,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nfiPlot != null) 'nfi_plot': nfiPlot,
      if (measDate != null) 'meas_date': measDate,
      if (measNum != null) 'meas_num': measNum,
      if (province != null) 'province': province,
      if (complete != null) 'complete': complete,
    });
  }

  SurveyHeadersCompanion copyWith(
      {Value<int>? id,
      Value<int>? nfiPlot,
      Value<DateTime>? measDate,
      Value<int>? measNum,
      Value<String>? province,
      Value<bool>? complete}) {
    return SurveyHeadersCompanion(
      id: id ?? this.id,
      nfiPlot: nfiPlot ?? this.nfiPlot,
      measDate: measDate ?? this.measDate,
      measNum: measNum ?? this.measNum,
      province: province ?? this.province,
      complete: complete ?? this.complete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nfiPlot.present) {
      map['nfi_plot'] = Variable<int>(nfiPlot.value);
    }
    if (measDate.present) {
      map['meas_date'] = Variable<DateTime>(measDate.value);
    }
    if (measNum.present) {
      map['meas_num'] = Variable<int>(measNum.value);
    }
    if (province.present) {
      map['province'] = Variable<String>(province.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurveyHeadersCompanion(')
          ..write('id: $id, ')
          ..write('nfiPlot: $nfiPlot, ')
          ..write('measDate: $measDate, ')
          ..write('measNum: $measNum, ')
          ..write('province: $province, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $MetaCommentTable extends MetaComment
    with TableInfo<$MetaCommentTable, MetaCommentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetaCommentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _surveyIdMeta =
      const VerificationMeta('surveyId');
  @override
  late final GeneratedColumn<int> surveyId = GeneratedColumn<int>(
      'survey_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES survey_headers (id)'));
  static const VerificationMeta _surveyCategoryMeta =
      const VerificationMeta('surveyCategory');
  @override
  late final GeneratedColumn<int> surveyCategory = GeneratedColumn<int>(
      'survey_category', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _commentTextMeta =
      const VerificationMeta('commentText');
  @override
  late final GeneratedColumn<String> commentText = GeneratedColumn<String>(
      'comment_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, surveyId, surveyCategory, commentText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meta_comment';
  @override
  VerificationContext validateIntegrity(Insertable<MetaCommentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('survey_id')) {
      context.handle(_surveyIdMeta,
          surveyId.isAcceptableOrUnknown(data['survey_id']!, _surveyIdMeta));
    } else if (isInserting) {
      context.missing(_surveyIdMeta);
    }
    if (data.containsKey('survey_category')) {
      context.handle(
          _surveyCategoryMeta,
          surveyCategory.isAcceptableOrUnknown(
              data['survey_category']!, _surveyCategoryMeta));
    } else if (isInserting) {
      context.missing(_surveyCategoryMeta);
    }
    if (data.containsKey('comment_text')) {
      context.handle(
          _commentTextMeta,
          commentText.isAcceptableOrUnknown(
              data['comment_text']!, _commentTextMeta));
    } else if (isInserting) {
      context.missing(_commentTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MetaCommentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetaCommentData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      surveyCategory: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_category'])!,
      commentText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}comment_text'])!,
    );
  }

  @override
  $MetaCommentTable createAlias(String alias) {
    return $MetaCommentTable(attachedDatabase, alias);
  }
}

class MetaCommentData extends DataClass implements Insertable<MetaCommentData> {
  final int id;
  final int surveyId;
  final int surveyCategory;
  final String commentText;
  const MetaCommentData(
      {required this.id,
      required this.surveyId,
      required this.surveyCategory,
      required this.commentText});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['survey_category'] = Variable<int>(surveyCategory);
    map['comment_text'] = Variable<String>(commentText);
    return map;
  }

  MetaCommentCompanion toCompanion(bool nullToAbsent) {
    return MetaCommentCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      surveyCategory: Value(surveyCategory),
      commentText: Value(commentText),
    );
  }

  factory MetaCommentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetaCommentData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      surveyCategory: serializer.fromJson<int>(json['surveyCategory']),
      commentText: serializer.fromJson<String>(json['commentText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<int>(surveyId),
      'surveyCategory': serializer.toJson<int>(surveyCategory),
      'commentText': serializer.toJson<String>(commentText),
    };
  }

  MetaCommentData copyWith(
          {int? id, int? surveyId, int? surveyCategory, String? commentText}) =>
      MetaCommentData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        surveyCategory: surveyCategory ?? this.surveyCategory,
        commentText: commentText ?? this.commentText,
      );
  @override
  String toString() {
    return (StringBuffer('MetaCommentData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('surveyCategory: $surveyCategory, ')
          ..write('commentText: $commentText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, surveyCategory, commentText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetaCommentData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.surveyCategory == this.surveyCategory &&
          other.commentText == this.commentText);
}

class MetaCommentCompanion extends UpdateCompanion<MetaCommentData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<int> surveyCategory;
  final Value<String> commentText;
  const MetaCommentCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.surveyCategory = const Value.absent(),
    this.commentText = const Value.absent(),
  });
  MetaCommentCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required int surveyCategory,
    required String commentText,
  })  : surveyId = Value(surveyId),
        surveyCategory = Value(surveyCategory),
        commentText = Value(commentText);
  static Insertable<MetaCommentData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<int>? surveyCategory,
    Expression<String>? commentText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (surveyCategory != null) 'survey_category': surveyCategory,
      if (commentText != null) 'comment_text': commentText,
    });
  }

  MetaCommentCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<int>? surveyCategory,
      Value<String>? commentText}) {
    return MetaCommentCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      surveyCategory: surveyCategory ?? this.surveyCategory,
      commentText: commentText ?? this.commentText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surveyId.present) {
      map['survey_id'] = Variable<int>(surveyId.value);
    }
    if (surveyCategory.present) {
      map['survey_category'] = Variable<int>(surveyCategory.value);
    }
    if (commentText.present) {
      map['comment_text'] = Variable<String>(commentText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetaCommentCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('surveyCategory: $surveyCategory, ')
          ..write('commentText: $commentText')
          ..write(')'))
        .toString();
  }
}

class $WoodyDebrisSummaryTable extends WoodyDebrisSummary
    with TableInfo<$WoodyDebrisSummaryTable, WoodyDebrisSummaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WoodyDebrisSummaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _surveyIdMeta =
      const VerificationMeta('surveyId');
  @override
  late final GeneratedColumn<int> surveyId = GeneratedColumn<int>(
      'survey_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES survey_headers (id)'));
  static const VerificationMeta _measDateMeta =
      const VerificationMeta('measDate');
  @override
  late final GeneratedColumn<DateTime> measDate = GeneratedColumn<DateTime>(
      'meas_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _numTransectsMeta =
      const VerificationMeta('numTransects');
  @override
  late final GeneratedColumn<int> numTransects = GeneratedColumn<int>(
      'num_transects', aliasedName, true,
      check: () => numTransects.isBetweenValues(1, 9),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, surveyId, measDate, numTransects, complete];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'woody_debris_summary';
  @override
  VerificationContext validateIntegrity(
      Insertable<WoodyDebrisSummaryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('survey_id')) {
      context.handle(_surveyIdMeta,
          surveyId.isAcceptableOrUnknown(data['survey_id']!, _surveyIdMeta));
    } else if (isInserting) {
      context.missing(_surveyIdMeta);
    }
    if (data.containsKey('meas_date')) {
      context.handle(_measDateMeta,
          measDate.isAcceptableOrUnknown(data['meas_date']!, _measDateMeta));
    } else if (isInserting) {
      context.missing(_measDateMeta);
    }
    if (data.containsKey('num_transects')) {
      context.handle(
          _numTransectsMeta,
          numTransects.isAcceptableOrUnknown(
              data['num_transects']!, _numTransectsMeta));
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WoodyDebrisSummaryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WoodyDebrisSummaryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      measDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}meas_date'])!,
      numTransects: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}num_transects']),
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $WoodyDebrisSummaryTable createAlias(String alias) {
    return $WoodyDebrisSummaryTable(attachedDatabase, alias);
  }
}

class WoodyDebrisSummaryData extends DataClass
    implements Insertable<WoodyDebrisSummaryData> {
  final int id;
  final int surveyId;
  final DateTime measDate;
  final int? numTransects;
  final bool complete;
  const WoodyDebrisSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      this.numTransects,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['meas_date'] = Variable<DateTime>(measDate);
    if (!nullToAbsent || numTransects != null) {
      map['num_transects'] = Variable<int>(numTransects);
    }
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  WoodyDebrisSummaryCompanion toCompanion(bool nullToAbsent) {
    return WoodyDebrisSummaryCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      measDate: Value(measDate),
      numTransects: numTransects == null && nullToAbsent
          ? const Value.absent()
          : Value(numTransects),
      complete: Value(complete),
    );
  }

  factory WoodyDebrisSummaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WoodyDebrisSummaryData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      measDate: serializer.fromJson<DateTime>(json['measDate']),
      numTransects: serializer.fromJson<int?>(json['numTransects']),
      complete: serializer.fromJson<bool>(json['complete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<int>(surveyId),
      'measDate': serializer.toJson<DateTime>(measDate),
      'numTransects': serializer.toJson<int?>(numTransects),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  WoodyDebrisSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          Value<int?> numTransects = const Value.absent(),
          bool? complete}) =>
      WoodyDebrisSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        numTransects:
            numTransects.present ? numTransects.value : this.numTransects,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('WoodyDebrisSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('numTransects: $numTransects, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surveyId, measDate, numTransects, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WoodyDebrisSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.numTransects == this.numTransects &&
          other.complete == this.complete);
}

class WoodyDebrisSummaryCompanion
    extends UpdateCompanion<WoodyDebrisSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<int?> numTransects;
  final Value<bool> complete;
  const WoodyDebrisSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.numTransects = const Value.absent(),
    this.complete = const Value.absent(),
  });
  WoodyDebrisSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    this.numTransects = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate);
  static Insertable<WoodyDebrisSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<int>? numTransects,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (numTransects != null) 'num_transects': numTransects,
      if (complete != null) 'complete': complete,
    });
  }

  WoodyDebrisSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<int?>? numTransects,
      Value<bool>? complete}) {
    return WoodyDebrisSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      numTransects: numTransects ?? this.numTransects,
      complete: complete ?? this.complete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surveyId.present) {
      map['survey_id'] = Variable<int>(surveyId.value);
    }
    if (measDate.present) {
      map['meas_date'] = Variable<DateTime>(measDate.value);
    }
    if (numTransects.present) {
      map['num_transects'] = Variable<int>(numTransects.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WoodyDebrisSummaryCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('numTransects: $numTransects, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $WoodyDebrisHeaderTable extends WoodyDebrisHeader
    with TableInfo<$WoodyDebrisHeaderTable, WoodyDebrisHeaderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WoodyDebrisHeaderTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wdIdMeta = const VerificationMeta('wdId');
  @override
  late final GeneratedColumn<int> wdId = GeneratedColumn<int>(
      'wd_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES woody_debris_summary (id)'));
  static const VerificationMeta _transNumMeta =
      const VerificationMeta('transNum');
  @override
  late final GeneratedColumn<int> transNum = GeneratedColumn<int>(
      'trans_num', aliasedName, true,
      check: () => transNum.isBetweenValues(1, 9),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  static const VerificationMeta _nomTransLenMeta =
      const VerificationMeta('nomTransLen');
  @override
  late final GeneratedColumn<double> nomTransLen = GeneratedColumn<double>(
      'nom_trans_len', aliasedName, true,
      check: () => nomTransLen.isBetweenValues(10.0, 150.0),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _transAzimuthMeta =
      const VerificationMeta('transAzimuth');
  @override
  late final GeneratedColumn<int> transAzimuth = GeneratedColumn<int>(
      'trans_azimuth', aliasedName, true,
      check: () => transAzimuth.isBetweenValues(0, 360),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  static const VerificationMeta _swdMeasLenMeta =
      const VerificationMeta('swdMeasLen');
  @override
  late final GeneratedColumn<double> swdMeasLen = GeneratedColumn<double>(
      'swd_meas_len', aliasedName, true,
      check: () => (swdMeasLen.isBetweenValues(0.0, 150.0) &
          swdMeasLen.isSmallerOrEqual(nomTransLen)),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _mcwdMeasLenMeta =
      const VerificationMeta('mcwdMeasLen');
  @override
  late final GeneratedColumn<double> mcwdMeasLen = GeneratedColumn<double>(
      'mcwd_meas_len', aliasedName, true,
      check: () => (mcwdMeasLen.isBetweenValues(0.0, 150.0) &
          mcwdMeasLen.isSmallerOrEqual(nomTransLen)),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _lcwdMeasLenMeta =
      const VerificationMeta('lcwdMeasLen');
  @override
  late final GeneratedColumn<double> lcwdMeasLen = GeneratedColumn<double>(
      'lcwd_meas_len', aliasedName, true,
      check: () => (lcwdMeasLen.isBetweenValues(0.0, 150.0) &
          lcwdMeasLen.isSmallerOrEqual(nomTransLen)),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _swdDecayClassMeta =
      const VerificationMeta('swdDecayClass');
  @override
  late final GeneratedColumn<int> swdDecayClass = GeneratedColumn<int>(
      'swd_decay_class', aliasedName, true,
      check: () => swdDecayClass.isBetweenValues(-1, 5),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        wdId,
        transNum,
        nomTransLen,
        transAzimuth,
        swdMeasLen,
        mcwdMeasLen,
        lcwdMeasLen,
        swdDecayClass,
        complete
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'woody_debris_header';
  @override
  VerificationContext validateIntegrity(
      Insertable<WoodyDebrisHeaderData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wd_id')) {
      context.handle(
          _wdIdMeta, wdId.isAcceptableOrUnknown(data['wd_id']!, _wdIdMeta));
    } else if (isInserting) {
      context.missing(_wdIdMeta);
    }
    if (data.containsKey('trans_num')) {
      context.handle(_transNumMeta,
          transNum.isAcceptableOrUnknown(data['trans_num']!, _transNumMeta));
    }
    if (data.containsKey('nom_trans_len')) {
      context.handle(
          _nomTransLenMeta,
          nomTransLen.isAcceptableOrUnknown(
              data['nom_trans_len']!, _nomTransLenMeta));
    }
    if (data.containsKey('trans_azimuth')) {
      context.handle(
          _transAzimuthMeta,
          transAzimuth.isAcceptableOrUnknown(
              data['trans_azimuth']!, _transAzimuthMeta));
    }
    if (data.containsKey('swd_meas_len')) {
      context.handle(
          _swdMeasLenMeta,
          swdMeasLen.isAcceptableOrUnknown(
              data['swd_meas_len']!, _swdMeasLenMeta));
    }
    if (data.containsKey('mcwd_meas_len')) {
      context.handle(
          _mcwdMeasLenMeta,
          mcwdMeasLen.isAcceptableOrUnknown(
              data['mcwd_meas_len']!, _mcwdMeasLenMeta));
    }
    if (data.containsKey('lcwd_meas_len')) {
      context.handle(
          _lcwdMeasLenMeta,
          lcwdMeasLen.isAcceptableOrUnknown(
              data['lcwd_meas_len']!, _lcwdMeasLenMeta));
    }
    if (data.containsKey('swd_decay_class')) {
      context.handle(
          _swdDecayClassMeta,
          swdDecayClass.isAcceptableOrUnknown(
              data['swd_decay_class']!, _swdDecayClassMeta));
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WoodyDebrisHeaderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WoodyDebrisHeaderData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wdId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wd_id'])!,
      transNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trans_num']),
      nomTransLen: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}nom_trans_len']),
      transAzimuth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trans_azimuth']),
      swdMeasLen: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}swd_meas_len']),
      mcwdMeasLen: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}mcwd_meas_len']),
      lcwdMeasLen: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}lcwd_meas_len']),
      swdDecayClass: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}swd_decay_class']),
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $WoodyDebrisHeaderTable createAlias(String alias) {
    return $WoodyDebrisHeaderTable(attachedDatabase, alias);
  }
}

class WoodyDebrisHeaderData extends DataClass
    implements Insertable<WoodyDebrisHeaderData> {
  final int id;
  final int wdId;
  final int? transNum;
  final double? nomTransLen;
  final int? transAzimuth;
  final double? swdMeasLen;
  final double? mcwdMeasLen;
  final double? lcwdMeasLen;
  final int? swdDecayClass;
  final bool complete;
  const WoodyDebrisHeaderData(
      {required this.id,
      required this.wdId,
      this.transNum,
      this.nomTransLen,
      this.transAzimuth,
      this.swdMeasLen,
      this.mcwdMeasLen,
      this.lcwdMeasLen,
      this.swdDecayClass,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wd_id'] = Variable<int>(wdId);
    if (!nullToAbsent || transNum != null) {
      map['trans_num'] = Variable<int>(transNum);
    }
    if (!nullToAbsent || nomTransLen != null) {
      map['nom_trans_len'] = Variable<double>(nomTransLen);
    }
    if (!nullToAbsent || transAzimuth != null) {
      map['trans_azimuth'] = Variable<int>(transAzimuth);
    }
    if (!nullToAbsent || swdMeasLen != null) {
      map['swd_meas_len'] = Variable<double>(swdMeasLen);
    }
    if (!nullToAbsent || mcwdMeasLen != null) {
      map['mcwd_meas_len'] = Variable<double>(mcwdMeasLen);
    }
    if (!nullToAbsent || lcwdMeasLen != null) {
      map['lcwd_meas_len'] = Variable<double>(lcwdMeasLen);
    }
    if (!nullToAbsent || swdDecayClass != null) {
      map['swd_decay_class'] = Variable<int>(swdDecayClass);
    }
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  WoodyDebrisHeaderCompanion toCompanion(bool nullToAbsent) {
    return WoodyDebrisHeaderCompanion(
      id: Value(id),
      wdId: Value(wdId),
      transNum: transNum == null && nullToAbsent
          ? const Value.absent()
          : Value(transNum),
      nomTransLen: nomTransLen == null && nullToAbsent
          ? const Value.absent()
          : Value(nomTransLen),
      transAzimuth: transAzimuth == null && nullToAbsent
          ? const Value.absent()
          : Value(transAzimuth),
      swdMeasLen: swdMeasLen == null && nullToAbsent
          ? const Value.absent()
          : Value(swdMeasLen),
      mcwdMeasLen: mcwdMeasLen == null && nullToAbsent
          ? const Value.absent()
          : Value(mcwdMeasLen),
      lcwdMeasLen: lcwdMeasLen == null && nullToAbsent
          ? const Value.absent()
          : Value(lcwdMeasLen),
      swdDecayClass: swdDecayClass == null && nullToAbsent
          ? const Value.absent()
          : Value(swdDecayClass),
      complete: Value(complete),
    );
  }

  factory WoodyDebrisHeaderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WoodyDebrisHeaderData(
      id: serializer.fromJson<int>(json['id']),
      wdId: serializer.fromJson<int>(json['wdId']),
      transNum: serializer.fromJson<int?>(json['transNum']),
      nomTransLen: serializer.fromJson<double?>(json['nomTransLen']),
      transAzimuth: serializer.fromJson<int?>(json['transAzimuth']),
      swdMeasLen: serializer.fromJson<double?>(json['swdMeasLen']),
      mcwdMeasLen: serializer.fromJson<double?>(json['mcwdMeasLen']),
      lcwdMeasLen: serializer.fromJson<double?>(json['lcwdMeasLen']),
      swdDecayClass: serializer.fromJson<int?>(json['swdDecayClass']),
      complete: serializer.fromJson<bool>(json['complete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wdId': serializer.toJson<int>(wdId),
      'transNum': serializer.toJson<int?>(transNum),
      'nomTransLen': serializer.toJson<double?>(nomTransLen),
      'transAzimuth': serializer.toJson<int?>(transAzimuth),
      'swdMeasLen': serializer.toJson<double?>(swdMeasLen),
      'mcwdMeasLen': serializer.toJson<double?>(mcwdMeasLen),
      'lcwdMeasLen': serializer.toJson<double?>(lcwdMeasLen),
      'swdDecayClass': serializer.toJson<int?>(swdDecayClass),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  WoodyDebrisHeaderData copyWith(
          {int? id,
          int? wdId,
          Value<int?> transNum = const Value.absent(),
          Value<double?> nomTransLen = const Value.absent(),
          Value<int?> transAzimuth = const Value.absent(),
          Value<double?> swdMeasLen = const Value.absent(),
          Value<double?> mcwdMeasLen = const Value.absent(),
          Value<double?> lcwdMeasLen = const Value.absent(),
          Value<int?> swdDecayClass = const Value.absent(),
          bool? complete}) =>
      WoodyDebrisHeaderData(
        id: id ?? this.id,
        wdId: wdId ?? this.wdId,
        transNum: transNum.present ? transNum.value : this.transNum,
        nomTransLen: nomTransLen.present ? nomTransLen.value : this.nomTransLen,
        transAzimuth:
            transAzimuth.present ? transAzimuth.value : this.transAzimuth,
        swdMeasLen: swdMeasLen.present ? swdMeasLen.value : this.swdMeasLen,
        mcwdMeasLen: mcwdMeasLen.present ? mcwdMeasLen.value : this.mcwdMeasLen,
        lcwdMeasLen: lcwdMeasLen.present ? lcwdMeasLen.value : this.lcwdMeasLen,
        swdDecayClass:
            swdDecayClass.present ? swdDecayClass.value : this.swdDecayClass,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('WoodyDebrisHeaderData(')
          ..write('id: $id, ')
          ..write('wdId: $wdId, ')
          ..write('transNum: $transNum, ')
          ..write('nomTransLen: $nomTransLen, ')
          ..write('transAzimuth: $transAzimuth, ')
          ..write('swdMeasLen: $swdMeasLen, ')
          ..write('mcwdMeasLen: $mcwdMeasLen, ')
          ..write('lcwdMeasLen: $lcwdMeasLen, ')
          ..write('swdDecayClass: $swdDecayClass, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wdId, transNum, nomTransLen, transAzimuth,
      swdMeasLen, mcwdMeasLen, lcwdMeasLen, swdDecayClass, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WoodyDebrisHeaderData &&
          other.id == this.id &&
          other.wdId == this.wdId &&
          other.transNum == this.transNum &&
          other.nomTransLen == this.nomTransLen &&
          other.transAzimuth == this.transAzimuth &&
          other.swdMeasLen == this.swdMeasLen &&
          other.mcwdMeasLen == this.mcwdMeasLen &&
          other.lcwdMeasLen == this.lcwdMeasLen &&
          other.swdDecayClass == this.swdDecayClass &&
          other.complete == this.complete);
}

class WoodyDebrisHeaderCompanion
    extends UpdateCompanion<WoodyDebrisHeaderData> {
  final Value<int> id;
  final Value<int> wdId;
  final Value<int?> transNum;
  final Value<double?> nomTransLen;
  final Value<int?> transAzimuth;
  final Value<double?> swdMeasLen;
  final Value<double?> mcwdMeasLen;
  final Value<double?> lcwdMeasLen;
  final Value<int?> swdDecayClass;
  final Value<bool> complete;
  const WoodyDebrisHeaderCompanion({
    this.id = const Value.absent(),
    this.wdId = const Value.absent(),
    this.transNum = const Value.absent(),
    this.nomTransLen = const Value.absent(),
    this.transAzimuth = const Value.absent(),
    this.swdMeasLen = const Value.absent(),
    this.mcwdMeasLen = const Value.absent(),
    this.lcwdMeasLen = const Value.absent(),
    this.swdDecayClass = const Value.absent(),
    this.complete = const Value.absent(),
  });
  WoodyDebrisHeaderCompanion.insert({
    this.id = const Value.absent(),
    required int wdId,
    this.transNum = const Value.absent(),
    this.nomTransLen = const Value.absent(),
    this.transAzimuth = const Value.absent(),
    this.swdMeasLen = const Value.absent(),
    this.mcwdMeasLen = const Value.absent(),
    this.lcwdMeasLen = const Value.absent(),
    this.swdDecayClass = const Value.absent(),
    this.complete = const Value.absent(),
  }) : wdId = Value(wdId);
  static Insertable<WoodyDebrisHeaderData> custom({
    Expression<int>? id,
    Expression<int>? wdId,
    Expression<int>? transNum,
    Expression<double>? nomTransLen,
    Expression<int>? transAzimuth,
    Expression<double>? swdMeasLen,
    Expression<double>? mcwdMeasLen,
    Expression<double>? lcwdMeasLen,
    Expression<int>? swdDecayClass,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wdId != null) 'wd_id': wdId,
      if (transNum != null) 'trans_num': transNum,
      if (nomTransLen != null) 'nom_trans_len': nomTransLen,
      if (transAzimuth != null) 'trans_azimuth': transAzimuth,
      if (swdMeasLen != null) 'swd_meas_len': swdMeasLen,
      if (mcwdMeasLen != null) 'mcwd_meas_len': mcwdMeasLen,
      if (lcwdMeasLen != null) 'lcwd_meas_len': lcwdMeasLen,
      if (swdDecayClass != null) 'swd_decay_class': swdDecayClass,
      if (complete != null) 'complete': complete,
    });
  }

  WoodyDebrisHeaderCompanion copyWith(
      {Value<int>? id,
      Value<int>? wdId,
      Value<int?>? transNum,
      Value<double?>? nomTransLen,
      Value<int?>? transAzimuth,
      Value<double?>? swdMeasLen,
      Value<double?>? mcwdMeasLen,
      Value<double?>? lcwdMeasLen,
      Value<int?>? swdDecayClass,
      Value<bool>? complete}) {
    return WoodyDebrisHeaderCompanion(
      id: id ?? this.id,
      wdId: wdId ?? this.wdId,
      transNum: transNum ?? this.transNum,
      nomTransLen: nomTransLen ?? this.nomTransLen,
      transAzimuth: transAzimuth ?? this.transAzimuth,
      swdMeasLen: swdMeasLen ?? this.swdMeasLen,
      mcwdMeasLen: mcwdMeasLen ?? this.mcwdMeasLen,
      lcwdMeasLen: lcwdMeasLen ?? this.lcwdMeasLen,
      swdDecayClass: swdDecayClass ?? this.swdDecayClass,
      complete: complete ?? this.complete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wdId.present) {
      map['wd_id'] = Variable<int>(wdId.value);
    }
    if (transNum.present) {
      map['trans_num'] = Variable<int>(transNum.value);
    }
    if (nomTransLen.present) {
      map['nom_trans_len'] = Variable<double>(nomTransLen.value);
    }
    if (transAzimuth.present) {
      map['trans_azimuth'] = Variable<int>(transAzimuth.value);
    }
    if (swdMeasLen.present) {
      map['swd_meas_len'] = Variable<double>(swdMeasLen.value);
    }
    if (mcwdMeasLen.present) {
      map['mcwd_meas_len'] = Variable<double>(mcwdMeasLen.value);
    }
    if (lcwdMeasLen.present) {
      map['lcwd_meas_len'] = Variable<double>(lcwdMeasLen.value);
    }
    if (swdDecayClass.present) {
      map['swd_decay_class'] = Variable<int>(swdDecayClass.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WoodyDebrisHeaderCompanion(')
          ..write('id: $id, ')
          ..write('wdId: $wdId, ')
          ..write('transNum: $transNum, ')
          ..write('nomTransLen: $nomTransLen, ')
          ..write('transAzimuth: $transAzimuth, ')
          ..write('swdMeasLen: $swdMeasLen, ')
          ..write('mcwdMeasLen: $mcwdMeasLen, ')
          ..write('lcwdMeasLen: $lcwdMeasLen, ')
          ..write('swdDecayClass: $swdDecayClass, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $WoodyDebrisSmallTable extends WoodyDebrisSmall
    with TableInfo<$WoodyDebrisSmallTable, WoodyDebrisSmallData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WoodyDebrisSmallTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wdHeaderIdMeta =
      const VerificationMeta('wdHeaderId');
  @override
  late final GeneratedColumn<int> wdHeaderId = GeneratedColumn<int>(
      'wd_header_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES woody_debris_header (id)'));
  static const VerificationMeta _swdTallySMeta =
      const VerificationMeta('swdTallyS');
  @override
  late final GeneratedColumn<int> swdTallyS = GeneratedColumn<int>(
      'swd_tally_s', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _swdTallyMMeta =
      const VerificationMeta('swdTallyM');
  @override
  late final GeneratedColumn<int> swdTallyM = GeneratedColumn<int>(
      'swd_tally_m', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _swdTallyLMeta =
      const VerificationMeta('swdTallyL');
  @override
  late final GeneratedColumn<int> swdTallyL = GeneratedColumn<int>(
      'swd_tally_l', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, wdHeaderId, swdTallyS, swdTallyM, swdTallyL];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'woody_debris_small';
  @override
  VerificationContext validateIntegrity(
      Insertable<WoodyDebrisSmallData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wd_header_id')) {
      context.handle(
          _wdHeaderIdMeta,
          wdHeaderId.isAcceptableOrUnknown(
              data['wd_header_id']!, _wdHeaderIdMeta));
    } else if (isInserting) {
      context.missing(_wdHeaderIdMeta);
    }
    if (data.containsKey('swd_tally_s')) {
      context.handle(
          _swdTallySMeta,
          swdTallyS.isAcceptableOrUnknown(
              data['swd_tally_s']!, _swdTallySMeta));
    }
    if (data.containsKey('swd_tally_m')) {
      context.handle(
          _swdTallyMMeta,
          swdTallyM.isAcceptableOrUnknown(
              data['swd_tally_m']!, _swdTallyMMeta));
    }
    if (data.containsKey('swd_tally_l')) {
      context.handle(
          _swdTallyLMeta,
          swdTallyL.isAcceptableOrUnknown(
              data['swd_tally_l']!, _swdTallyLMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WoodyDebrisSmallData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WoodyDebrisSmallData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wdHeaderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wd_header_id'])!,
      swdTallyS: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}swd_tally_s'])!,
      swdTallyM: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}swd_tally_m'])!,
      swdTallyL: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}swd_tally_l'])!,
    );
  }

  @override
  $WoodyDebrisSmallTable createAlias(String alias) {
    return $WoodyDebrisSmallTable(attachedDatabase, alias);
  }
}

class WoodyDebrisSmallData extends DataClass
    implements Insertable<WoodyDebrisSmallData> {
  final int id;
  final int wdHeaderId;
  final int swdTallyS;
  final int swdTallyM;
  final int swdTallyL;
  const WoodyDebrisSmallData(
      {required this.id,
      required this.wdHeaderId,
      required this.swdTallyS,
      required this.swdTallyM,
      required this.swdTallyL});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wd_header_id'] = Variable<int>(wdHeaderId);
    map['swd_tally_s'] = Variable<int>(swdTallyS);
    map['swd_tally_m'] = Variable<int>(swdTallyM);
    map['swd_tally_l'] = Variable<int>(swdTallyL);
    return map;
  }

  WoodyDebrisSmallCompanion toCompanion(bool nullToAbsent) {
    return WoodyDebrisSmallCompanion(
      id: Value(id),
      wdHeaderId: Value(wdHeaderId),
      swdTallyS: Value(swdTallyS),
      swdTallyM: Value(swdTallyM),
      swdTallyL: Value(swdTallyL),
    );
  }

  factory WoodyDebrisSmallData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WoodyDebrisSmallData(
      id: serializer.fromJson<int>(json['id']),
      wdHeaderId: serializer.fromJson<int>(json['wdHeaderId']),
      swdTallyS: serializer.fromJson<int>(json['swdTallyS']),
      swdTallyM: serializer.fromJson<int>(json['swdTallyM']),
      swdTallyL: serializer.fromJson<int>(json['swdTallyL']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wdHeaderId': serializer.toJson<int>(wdHeaderId),
      'swdTallyS': serializer.toJson<int>(swdTallyS),
      'swdTallyM': serializer.toJson<int>(swdTallyM),
      'swdTallyL': serializer.toJson<int>(swdTallyL),
    };
  }

  WoodyDebrisSmallData copyWith(
          {int? id,
          int? wdHeaderId,
          int? swdTallyS,
          int? swdTallyM,
          int? swdTallyL}) =>
      WoodyDebrisSmallData(
        id: id ?? this.id,
        wdHeaderId: wdHeaderId ?? this.wdHeaderId,
        swdTallyS: swdTallyS ?? this.swdTallyS,
        swdTallyM: swdTallyM ?? this.swdTallyM,
        swdTallyL: swdTallyL ?? this.swdTallyL,
      );
  @override
  String toString() {
    return (StringBuffer('WoodyDebrisSmallData(')
          ..write('id: $id, ')
          ..write('wdHeaderId: $wdHeaderId, ')
          ..write('swdTallyS: $swdTallyS, ')
          ..write('swdTallyM: $swdTallyM, ')
          ..write('swdTallyL: $swdTallyL')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, wdHeaderId, swdTallyS, swdTallyM, swdTallyL);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WoodyDebrisSmallData &&
          other.id == this.id &&
          other.wdHeaderId == this.wdHeaderId &&
          other.swdTallyS == this.swdTallyS &&
          other.swdTallyM == this.swdTallyM &&
          other.swdTallyL == this.swdTallyL);
}

class WoodyDebrisSmallCompanion extends UpdateCompanion<WoodyDebrisSmallData> {
  final Value<int> id;
  final Value<int> wdHeaderId;
  final Value<int> swdTallyS;
  final Value<int> swdTallyM;
  final Value<int> swdTallyL;
  const WoodyDebrisSmallCompanion({
    this.id = const Value.absent(),
    this.wdHeaderId = const Value.absent(),
    this.swdTallyS = const Value.absent(),
    this.swdTallyM = const Value.absent(),
    this.swdTallyL = const Value.absent(),
  });
  WoodyDebrisSmallCompanion.insert({
    this.id = const Value.absent(),
    required int wdHeaderId,
    this.swdTallyS = const Value.absent(),
    this.swdTallyM = const Value.absent(),
    this.swdTallyL = const Value.absent(),
  }) : wdHeaderId = Value(wdHeaderId);
  static Insertable<WoodyDebrisSmallData> custom({
    Expression<int>? id,
    Expression<int>? wdHeaderId,
    Expression<int>? swdTallyS,
    Expression<int>? swdTallyM,
    Expression<int>? swdTallyL,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wdHeaderId != null) 'wd_header_id': wdHeaderId,
      if (swdTallyS != null) 'swd_tally_s': swdTallyS,
      if (swdTallyM != null) 'swd_tally_m': swdTallyM,
      if (swdTallyL != null) 'swd_tally_l': swdTallyL,
    });
  }

  WoodyDebrisSmallCompanion copyWith(
      {Value<int>? id,
      Value<int>? wdHeaderId,
      Value<int>? swdTallyS,
      Value<int>? swdTallyM,
      Value<int>? swdTallyL}) {
    return WoodyDebrisSmallCompanion(
      id: id ?? this.id,
      wdHeaderId: wdHeaderId ?? this.wdHeaderId,
      swdTallyS: swdTallyS ?? this.swdTallyS,
      swdTallyM: swdTallyM ?? this.swdTallyM,
      swdTallyL: swdTallyL ?? this.swdTallyL,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wdHeaderId.present) {
      map['wd_header_id'] = Variable<int>(wdHeaderId.value);
    }
    if (swdTallyS.present) {
      map['swd_tally_s'] = Variable<int>(swdTallyS.value);
    }
    if (swdTallyM.present) {
      map['swd_tally_m'] = Variable<int>(swdTallyM.value);
    }
    if (swdTallyL.present) {
      map['swd_tally_l'] = Variable<int>(swdTallyL.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WoodyDebrisSmallCompanion(')
          ..write('id: $id, ')
          ..write('wdHeaderId: $wdHeaderId, ')
          ..write('swdTallyS: $swdTallyS, ')
          ..write('swdTallyM: $swdTallyM, ')
          ..write('swdTallyL: $swdTallyL')
          ..write(')'))
        .toString();
  }
}

class $WoodyDebrisOddTable extends WoodyDebrisOdd
    with TableInfo<$WoodyDebrisOddTable, WoodyDebrisOddData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WoodyDebrisOddTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wdHeaderIdMeta =
      const VerificationMeta('wdHeaderId');
  @override
  late final GeneratedColumn<int> wdHeaderId = GeneratedColumn<int>(
      'wd_header_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES woody_debris_header (id)'));
  static const VerificationMeta _pieceNumMeta =
      const VerificationMeta('pieceNum');
  @override
  late final GeneratedColumn<int> pieceNum = GeneratedColumn<int>(
      'piece_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _accumOddMeta =
      const VerificationMeta('accumOdd');
  @override
  late final GeneratedColumn<String> accumOdd = GeneratedColumn<String>(
      'accum_odd', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _genusMeta = const VerificationMeta('genus');
  @override
  late final GeneratedColumn<String> genus = GeneratedColumn<String>(
      'genus', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tree_genus (genus_code)'));
  static const VerificationMeta _speciesMeta =
      const VerificationMeta('species');
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
      'species', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tree_genus (species_code)'));
  static const VerificationMeta _horLengthMeta =
      const VerificationMeta('horLength');
  @override
  late final GeneratedColumn<double> horLength = GeneratedColumn<double>(
      'hor_length', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _verDepthMeta =
      const VerificationMeta('verDepth');
  @override
  late final GeneratedColumn<double> verDepth = GeneratedColumn<double>(
      'ver_depth', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _decayClassMeta =
      const VerificationMeta('decayClass');
  @override
  late final GeneratedColumn<int> decayClass = GeneratedColumn<int>(
      'decay_class', aliasedName, true,
      check: () => decayClass.isBetweenValues(-1, 5),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        wdHeaderId,
        pieceNum,
        accumOdd,
        genus,
        species,
        horLength,
        verDepth,
        decayClass
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'woody_debris_odd';
  @override
  VerificationContext validateIntegrity(Insertable<WoodyDebrisOddData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wd_header_id')) {
      context.handle(
          _wdHeaderIdMeta,
          wdHeaderId.isAcceptableOrUnknown(
              data['wd_header_id']!, _wdHeaderIdMeta));
    } else if (isInserting) {
      context.missing(_wdHeaderIdMeta);
    }
    if (data.containsKey('piece_num')) {
      context.handle(_pieceNumMeta,
          pieceNum.isAcceptableOrUnknown(data['piece_num']!, _pieceNumMeta));
    } else if (isInserting) {
      context.missing(_pieceNumMeta);
    }
    if (data.containsKey('accum_odd')) {
      context.handle(_accumOddMeta,
          accumOdd.isAcceptableOrUnknown(data['accum_odd']!, _accumOddMeta));
    } else if (isInserting) {
      context.missing(_accumOddMeta);
    }
    if (data.containsKey('genus')) {
      context.handle(
          _genusMeta, genus.isAcceptableOrUnknown(data['genus']!, _genusMeta));
    } else if (isInserting) {
      context.missing(_genusMeta);
    }
    if (data.containsKey('species')) {
      context.handle(_speciesMeta,
          species.isAcceptableOrUnknown(data['species']!, _speciesMeta));
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('hor_length')) {
      context.handle(_horLengthMeta,
          horLength.isAcceptableOrUnknown(data['hor_length']!, _horLengthMeta));
    } else if (isInserting) {
      context.missing(_horLengthMeta);
    }
    if (data.containsKey('ver_depth')) {
      context.handle(_verDepthMeta,
          verDepth.isAcceptableOrUnknown(data['ver_depth']!, _verDepthMeta));
    } else if (isInserting) {
      context.missing(_verDepthMeta);
    }
    if (data.containsKey('decay_class')) {
      context.handle(
          _decayClassMeta,
          decayClass.isAcceptableOrUnknown(
              data['decay_class']!, _decayClassMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WoodyDebrisOddData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WoodyDebrisOddData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wdHeaderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wd_header_id'])!,
      pieceNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}piece_num'])!,
      accumOdd: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}accum_odd'])!,
      genus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genus'])!,
      species: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species'])!,
      horLength: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hor_length'])!,
      verDepth: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ver_depth'])!,
      decayClass: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}decay_class']),
    );
  }

  @override
  $WoodyDebrisOddTable createAlias(String alias) {
    return $WoodyDebrisOddTable(attachedDatabase, alias);
  }
}

class WoodyDebrisOddData extends DataClass
    implements Insertable<WoodyDebrisOddData> {
  final int id;
  final int wdHeaderId;
  final int pieceNum;
  final String accumOdd;
  final String genus;
  final String species;
  final double horLength;
  final double verDepth;
  final int? decayClass;
  const WoodyDebrisOddData(
      {required this.id,
      required this.wdHeaderId,
      required this.pieceNum,
      required this.accumOdd,
      required this.genus,
      required this.species,
      required this.horLength,
      required this.verDepth,
      this.decayClass});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wd_header_id'] = Variable<int>(wdHeaderId);
    map['piece_num'] = Variable<int>(pieceNum);
    map['accum_odd'] = Variable<String>(accumOdd);
    map['genus'] = Variable<String>(genus);
    map['species'] = Variable<String>(species);
    map['hor_length'] = Variable<double>(horLength);
    map['ver_depth'] = Variable<double>(verDepth);
    if (!nullToAbsent || decayClass != null) {
      map['decay_class'] = Variable<int>(decayClass);
    }
    return map;
  }

  WoodyDebrisOddCompanion toCompanion(bool nullToAbsent) {
    return WoodyDebrisOddCompanion(
      id: Value(id),
      wdHeaderId: Value(wdHeaderId),
      pieceNum: Value(pieceNum),
      accumOdd: Value(accumOdd),
      genus: Value(genus),
      species: Value(species),
      horLength: Value(horLength),
      verDepth: Value(verDepth),
      decayClass: decayClass == null && nullToAbsent
          ? const Value.absent()
          : Value(decayClass),
    );
  }

  factory WoodyDebrisOddData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WoodyDebrisOddData(
      id: serializer.fromJson<int>(json['id']),
      wdHeaderId: serializer.fromJson<int>(json['wdHeaderId']),
      pieceNum: serializer.fromJson<int>(json['pieceNum']),
      accumOdd: serializer.fromJson<String>(json['accumOdd']),
      genus: serializer.fromJson<String>(json['genus']),
      species: serializer.fromJson<String>(json['species']),
      horLength: serializer.fromJson<double>(json['horLength']),
      verDepth: serializer.fromJson<double>(json['verDepth']),
      decayClass: serializer.fromJson<int?>(json['decayClass']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wdHeaderId': serializer.toJson<int>(wdHeaderId),
      'pieceNum': serializer.toJson<int>(pieceNum),
      'accumOdd': serializer.toJson<String>(accumOdd),
      'genus': serializer.toJson<String>(genus),
      'species': serializer.toJson<String>(species),
      'horLength': serializer.toJson<double>(horLength),
      'verDepth': serializer.toJson<double>(verDepth),
      'decayClass': serializer.toJson<int?>(decayClass),
    };
  }

  WoodyDebrisOddData copyWith(
          {int? id,
          int? wdHeaderId,
          int? pieceNum,
          String? accumOdd,
          String? genus,
          String? species,
          double? horLength,
          double? verDepth,
          Value<int?> decayClass = const Value.absent()}) =>
      WoodyDebrisOddData(
        id: id ?? this.id,
        wdHeaderId: wdHeaderId ?? this.wdHeaderId,
        pieceNum: pieceNum ?? this.pieceNum,
        accumOdd: accumOdd ?? this.accumOdd,
        genus: genus ?? this.genus,
        species: species ?? this.species,
        horLength: horLength ?? this.horLength,
        verDepth: verDepth ?? this.verDepth,
        decayClass: decayClass.present ? decayClass.value : this.decayClass,
      );
  @override
  String toString() {
    return (StringBuffer('WoodyDebrisOddData(')
          ..write('id: $id, ')
          ..write('wdHeaderId: $wdHeaderId, ')
          ..write('pieceNum: $pieceNum, ')
          ..write('accumOdd: $accumOdd, ')
          ..write('genus: $genus, ')
          ..write('species: $species, ')
          ..write('horLength: $horLength, ')
          ..write('verDepth: $verDepth, ')
          ..write('decayClass: $decayClass')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wdHeaderId, pieceNum, accumOdd, genus,
      species, horLength, verDepth, decayClass);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WoodyDebrisOddData &&
          other.id == this.id &&
          other.wdHeaderId == this.wdHeaderId &&
          other.pieceNum == this.pieceNum &&
          other.accumOdd == this.accumOdd &&
          other.genus == this.genus &&
          other.species == this.species &&
          other.horLength == this.horLength &&
          other.verDepth == this.verDepth &&
          other.decayClass == this.decayClass);
}

class WoodyDebrisOddCompanion extends UpdateCompanion<WoodyDebrisOddData> {
  final Value<int> id;
  final Value<int> wdHeaderId;
  final Value<int> pieceNum;
  final Value<String> accumOdd;
  final Value<String> genus;
  final Value<String> species;
  final Value<double> horLength;
  final Value<double> verDepth;
  final Value<int?> decayClass;
  const WoodyDebrisOddCompanion({
    this.id = const Value.absent(),
    this.wdHeaderId = const Value.absent(),
    this.pieceNum = const Value.absent(),
    this.accumOdd = const Value.absent(),
    this.genus = const Value.absent(),
    this.species = const Value.absent(),
    this.horLength = const Value.absent(),
    this.verDepth = const Value.absent(),
    this.decayClass = const Value.absent(),
  });
  WoodyDebrisOddCompanion.insert({
    this.id = const Value.absent(),
    required int wdHeaderId,
    required int pieceNum,
    required String accumOdd,
    required String genus,
    required String species,
    required double horLength,
    required double verDepth,
    this.decayClass = const Value.absent(),
  })  : wdHeaderId = Value(wdHeaderId),
        pieceNum = Value(pieceNum),
        accumOdd = Value(accumOdd),
        genus = Value(genus),
        species = Value(species),
        horLength = Value(horLength),
        verDepth = Value(verDepth);
  static Insertable<WoodyDebrisOddData> custom({
    Expression<int>? id,
    Expression<int>? wdHeaderId,
    Expression<int>? pieceNum,
    Expression<String>? accumOdd,
    Expression<String>? genus,
    Expression<String>? species,
    Expression<double>? horLength,
    Expression<double>? verDepth,
    Expression<int>? decayClass,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wdHeaderId != null) 'wd_header_id': wdHeaderId,
      if (pieceNum != null) 'piece_num': pieceNum,
      if (accumOdd != null) 'accum_odd': accumOdd,
      if (genus != null) 'genus': genus,
      if (species != null) 'species': species,
      if (horLength != null) 'hor_length': horLength,
      if (verDepth != null) 'ver_depth': verDepth,
      if (decayClass != null) 'decay_class': decayClass,
    });
  }

  WoodyDebrisOddCompanion copyWith(
      {Value<int>? id,
      Value<int>? wdHeaderId,
      Value<int>? pieceNum,
      Value<String>? accumOdd,
      Value<String>? genus,
      Value<String>? species,
      Value<double>? horLength,
      Value<double>? verDepth,
      Value<int?>? decayClass}) {
    return WoodyDebrisOddCompanion(
      id: id ?? this.id,
      wdHeaderId: wdHeaderId ?? this.wdHeaderId,
      pieceNum: pieceNum ?? this.pieceNum,
      accumOdd: accumOdd ?? this.accumOdd,
      genus: genus ?? this.genus,
      species: species ?? this.species,
      horLength: horLength ?? this.horLength,
      verDepth: verDepth ?? this.verDepth,
      decayClass: decayClass ?? this.decayClass,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wdHeaderId.present) {
      map['wd_header_id'] = Variable<int>(wdHeaderId.value);
    }
    if (pieceNum.present) {
      map['piece_num'] = Variable<int>(pieceNum.value);
    }
    if (accumOdd.present) {
      map['accum_odd'] = Variable<String>(accumOdd.value);
    }
    if (genus.present) {
      map['genus'] = Variable<String>(genus.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (horLength.present) {
      map['hor_length'] = Variable<double>(horLength.value);
    }
    if (verDepth.present) {
      map['ver_depth'] = Variable<double>(verDepth.value);
    }
    if (decayClass.present) {
      map['decay_class'] = Variable<int>(decayClass.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WoodyDebrisOddCompanion(')
          ..write('id: $id, ')
          ..write('wdHeaderId: $wdHeaderId, ')
          ..write('pieceNum: $pieceNum, ')
          ..write('accumOdd: $accumOdd, ')
          ..write('genus: $genus, ')
          ..write('species: $species, ')
          ..write('horLength: $horLength, ')
          ..write('verDepth: $verDepth, ')
          ..write('decayClass: $decayClass')
          ..write(')'))
        .toString();
  }
}

class $WoodyDebrisRoundTable extends WoodyDebrisRound
    with TableInfo<$WoodyDebrisRoundTable, WoodyDebrisRoundData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WoodyDebrisRoundTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wdHeaderIdMeta =
      const VerificationMeta('wdHeaderId');
  @override
  late final GeneratedColumn<int> wdHeaderId = GeneratedColumn<int>(
      'wd_header_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES woody_debris_header (id)'));
  static const VerificationMeta _pieceNumMeta =
      const VerificationMeta('pieceNum');
  @override
  late final GeneratedColumn<int> pieceNum = GeneratedColumn<int>(
      'piece_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _genusMeta = const VerificationMeta('genus');
  @override
  late final GeneratedColumn<String> genus = GeneratedColumn<String>(
      'genus', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tree_genus (genus_code)'));
  static const VerificationMeta _speciesMeta =
      const VerificationMeta('species');
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
      'species', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES tree_genus (species_code)'));
  static const VerificationMeta _diameterMeta =
      const VerificationMeta('diameter');
  @override
  late final GeneratedColumn<double> diameter = GeneratedColumn<double>(
      'diameter', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _tiltAngleMeta =
      const VerificationMeta('tiltAngle');
  @override
  late final GeneratedColumn<int> tiltAngle = GeneratedColumn<int>(
      'tilt_angle', aliasedName, true,
      check: () => tiltAngle.isBetweenValues(-1, 90),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  static const VerificationMeta _decayClassMeta =
      const VerificationMeta('decayClass');
  @override
  late final GeneratedColumn<int> decayClass = GeneratedColumn<int>(
      'decay_class', aliasedName, true,
      check: () => decayClass.isBetweenValues(-1, 5),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        wdHeaderId,
        pieceNum,
        genus,
        species,
        diameter,
        tiltAngle,
        decayClass
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'woody_debris_round';
  @override
  VerificationContext validateIntegrity(
      Insertable<WoodyDebrisRoundData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wd_header_id')) {
      context.handle(
          _wdHeaderIdMeta,
          wdHeaderId.isAcceptableOrUnknown(
              data['wd_header_id']!, _wdHeaderIdMeta));
    } else if (isInserting) {
      context.missing(_wdHeaderIdMeta);
    }
    if (data.containsKey('piece_num')) {
      context.handle(_pieceNumMeta,
          pieceNum.isAcceptableOrUnknown(data['piece_num']!, _pieceNumMeta));
    } else if (isInserting) {
      context.missing(_pieceNumMeta);
    }
    if (data.containsKey('genus')) {
      context.handle(
          _genusMeta, genus.isAcceptableOrUnknown(data['genus']!, _genusMeta));
    } else if (isInserting) {
      context.missing(_genusMeta);
    }
    if (data.containsKey('species')) {
      context.handle(_speciesMeta,
          species.isAcceptableOrUnknown(data['species']!, _speciesMeta));
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('diameter')) {
      context.handle(_diameterMeta,
          diameter.isAcceptableOrUnknown(data['diameter']!, _diameterMeta));
    } else if (isInserting) {
      context.missing(_diameterMeta);
    }
    if (data.containsKey('tilt_angle')) {
      context.handle(_tiltAngleMeta,
          tiltAngle.isAcceptableOrUnknown(data['tilt_angle']!, _tiltAngleMeta));
    }
    if (data.containsKey('decay_class')) {
      context.handle(
          _decayClassMeta,
          decayClass.isAcceptableOrUnknown(
              data['decay_class']!, _decayClassMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WoodyDebrisRoundData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WoodyDebrisRoundData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wdHeaderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wd_header_id'])!,
      pieceNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}piece_num'])!,
      genus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genus'])!,
      species: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species'])!,
      diameter: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}diameter'])!,
      tiltAngle: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tilt_angle']),
      decayClass: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}decay_class']),
    );
  }

  @override
  $WoodyDebrisRoundTable createAlias(String alias) {
    return $WoodyDebrisRoundTable(attachedDatabase, alias);
  }
}

class WoodyDebrisRoundData extends DataClass
    implements Insertable<WoodyDebrisRoundData> {
  final int id;
  final int wdHeaderId;
  final int pieceNum;
  final String genus;
  final String species;
  final double diameter;
  final int? tiltAngle;
  final int? decayClass;
  const WoodyDebrisRoundData(
      {required this.id,
      required this.wdHeaderId,
      required this.pieceNum,
      required this.genus,
      required this.species,
      required this.diameter,
      this.tiltAngle,
      this.decayClass});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wd_header_id'] = Variable<int>(wdHeaderId);
    map['piece_num'] = Variable<int>(pieceNum);
    map['genus'] = Variable<String>(genus);
    map['species'] = Variable<String>(species);
    map['diameter'] = Variable<double>(diameter);
    if (!nullToAbsent || tiltAngle != null) {
      map['tilt_angle'] = Variable<int>(tiltAngle);
    }
    if (!nullToAbsent || decayClass != null) {
      map['decay_class'] = Variable<int>(decayClass);
    }
    return map;
  }

  WoodyDebrisRoundCompanion toCompanion(bool nullToAbsent) {
    return WoodyDebrisRoundCompanion(
      id: Value(id),
      wdHeaderId: Value(wdHeaderId),
      pieceNum: Value(pieceNum),
      genus: Value(genus),
      species: Value(species),
      diameter: Value(diameter),
      tiltAngle: tiltAngle == null && nullToAbsent
          ? const Value.absent()
          : Value(tiltAngle),
      decayClass: decayClass == null && nullToAbsent
          ? const Value.absent()
          : Value(decayClass),
    );
  }

  factory WoodyDebrisRoundData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WoodyDebrisRoundData(
      id: serializer.fromJson<int>(json['id']),
      wdHeaderId: serializer.fromJson<int>(json['wdHeaderId']),
      pieceNum: serializer.fromJson<int>(json['pieceNum']),
      genus: serializer.fromJson<String>(json['genus']),
      species: serializer.fromJson<String>(json['species']),
      diameter: serializer.fromJson<double>(json['diameter']),
      tiltAngle: serializer.fromJson<int?>(json['tiltAngle']),
      decayClass: serializer.fromJson<int?>(json['decayClass']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wdHeaderId': serializer.toJson<int>(wdHeaderId),
      'pieceNum': serializer.toJson<int>(pieceNum),
      'genus': serializer.toJson<String>(genus),
      'species': serializer.toJson<String>(species),
      'diameter': serializer.toJson<double>(diameter),
      'tiltAngle': serializer.toJson<int?>(tiltAngle),
      'decayClass': serializer.toJson<int?>(decayClass),
    };
  }

  WoodyDebrisRoundData copyWith(
          {int? id,
          int? wdHeaderId,
          int? pieceNum,
          String? genus,
          String? species,
          double? diameter,
          Value<int?> tiltAngle = const Value.absent(),
          Value<int?> decayClass = const Value.absent()}) =>
      WoodyDebrisRoundData(
        id: id ?? this.id,
        wdHeaderId: wdHeaderId ?? this.wdHeaderId,
        pieceNum: pieceNum ?? this.pieceNum,
        genus: genus ?? this.genus,
        species: species ?? this.species,
        diameter: diameter ?? this.diameter,
        tiltAngle: tiltAngle.present ? tiltAngle.value : this.tiltAngle,
        decayClass: decayClass.present ? decayClass.value : this.decayClass,
      );
  @override
  String toString() {
    return (StringBuffer('WoodyDebrisRoundData(')
          ..write('id: $id, ')
          ..write('wdHeaderId: $wdHeaderId, ')
          ..write('pieceNum: $pieceNum, ')
          ..write('genus: $genus, ')
          ..write('species: $species, ')
          ..write('diameter: $diameter, ')
          ..write('tiltAngle: $tiltAngle, ')
          ..write('decayClass: $decayClass')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wdHeaderId, pieceNum, genus, species,
      diameter, tiltAngle, decayClass);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WoodyDebrisRoundData &&
          other.id == this.id &&
          other.wdHeaderId == this.wdHeaderId &&
          other.pieceNum == this.pieceNum &&
          other.genus == this.genus &&
          other.species == this.species &&
          other.diameter == this.diameter &&
          other.tiltAngle == this.tiltAngle &&
          other.decayClass == this.decayClass);
}

class WoodyDebrisRoundCompanion extends UpdateCompanion<WoodyDebrisRoundData> {
  final Value<int> id;
  final Value<int> wdHeaderId;
  final Value<int> pieceNum;
  final Value<String> genus;
  final Value<String> species;
  final Value<double> diameter;
  final Value<int?> tiltAngle;
  final Value<int?> decayClass;
  const WoodyDebrisRoundCompanion({
    this.id = const Value.absent(),
    this.wdHeaderId = const Value.absent(),
    this.pieceNum = const Value.absent(),
    this.genus = const Value.absent(),
    this.species = const Value.absent(),
    this.diameter = const Value.absent(),
    this.tiltAngle = const Value.absent(),
    this.decayClass = const Value.absent(),
  });
  WoodyDebrisRoundCompanion.insert({
    this.id = const Value.absent(),
    required int wdHeaderId,
    required int pieceNum,
    required String genus,
    required String species,
    required double diameter,
    this.tiltAngle = const Value.absent(),
    this.decayClass = const Value.absent(),
  })  : wdHeaderId = Value(wdHeaderId),
        pieceNum = Value(pieceNum),
        genus = Value(genus),
        species = Value(species),
        diameter = Value(diameter);
  static Insertable<WoodyDebrisRoundData> custom({
    Expression<int>? id,
    Expression<int>? wdHeaderId,
    Expression<int>? pieceNum,
    Expression<String>? genus,
    Expression<String>? species,
    Expression<double>? diameter,
    Expression<int>? tiltAngle,
    Expression<int>? decayClass,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wdHeaderId != null) 'wd_header_id': wdHeaderId,
      if (pieceNum != null) 'piece_num': pieceNum,
      if (genus != null) 'genus': genus,
      if (species != null) 'species': species,
      if (diameter != null) 'diameter': diameter,
      if (tiltAngle != null) 'tilt_angle': tiltAngle,
      if (decayClass != null) 'decay_class': decayClass,
    });
  }

  WoodyDebrisRoundCompanion copyWith(
      {Value<int>? id,
      Value<int>? wdHeaderId,
      Value<int>? pieceNum,
      Value<String>? genus,
      Value<String>? species,
      Value<double>? diameter,
      Value<int?>? tiltAngle,
      Value<int?>? decayClass}) {
    return WoodyDebrisRoundCompanion(
      id: id ?? this.id,
      wdHeaderId: wdHeaderId ?? this.wdHeaderId,
      pieceNum: pieceNum ?? this.pieceNum,
      genus: genus ?? this.genus,
      species: species ?? this.species,
      diameter: diameter ?? this.diameter,
      tiltAngle: tiltAngle ?? this.tiltAngle,
      decayClass: decayClass ?? this.decayClass,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wdHeaderId.present) {
      map['wd_header_id'] = Variable<int>(wdHeaderId.value);
    }
    if (pieceNum.present) {
      map['piece_num'] = Variable<int>(pieceNum.value);
    }
    if (genus.present) {
      map['genus'] = Variable<String>(genus.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (diameter.present) {
      map['diameter'] = Variable<double>(diameter.value);
    }
    if (tiltAngle.present) {
      map['tilt_angle'] = Variable<int>(tiltAngle.value);
    }
    if (decayClass.present) {
      map['decay_class'] = Variable<int>(decayClass.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WoodyDebrisRoundCompanion(')
          ..write('id: $id, ')
          ..write('wdHeaderId: $wdHeaderId, ')
          ..write('pieceNum: $pieceNum, ')
          ..write('genus: $genus, ')
          ..write('species: $species, ')
          ..write('diameter: $diameter, ')
          ..write('tiltAngle: $tiltAngle, ')
          ..write('decayClass: $decayClass')
          ..write(')'))
        .toString();
  }
}

class $SurfaceSubstrateSummaryTable extends SurfaceSubstrateSummary
    with TableInfo<$SurfaceSubstrateSummaryTable, SurfaceSubstrateSummaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurfaceSubstrateSummaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _surveyIdMeta =
      const VerificationMeta('surveyId');
  @override
  late final GeneratedColumn<int> surveyId = GeneratedColumn<int>(
      'survey_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES survey_headers (id)'));
  static const VerificationMeta _measDateMeta =
      const VerificationMeta('measDate');
  @override
  late final GeneratedColumn<DateTime> measDate = GeneratedColumn<DateTime>(
      'meas_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _numTransectsMeta =
      const VerificationMeta('numTransects');
  @override
  late final GeneratedColumn<int> numTransects = GeneratedColumn<int>(
      'num_transects', aliasedName, true,
      check: () => numTransects.isBetweenValues(1, 9),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, surveyId, measDate, numTransects, complete];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surface_substrate_summary';
  @override
  VerificationContext validateIntegrity(
      Insertable<SurfaceSubstrateSummaryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('survey_id')) {
      context.handle(_surveyIdMeta,
          surveyId.isAcceptableOrUnknown(data['survey_id']!, _surveyIdMeta));
    } else if (isInserting) {
      context.missing(_surveyIdMeta);
    }
    if (data.containsKey('meas_date')) {
      context.handle(_measDateMeta,
          measDate.isAcceptableOrUnknown(data['meas_date']!, _measDateMeta));
    } else if (isInserting) {
      context.missing(_measDateMeta);
    }
    if (data.containsKey('num_transects')) {
      context.handle(
          _numTransectsMeta,
          numTransects.isAcceptableOrUnknown(
              data['num_transects']!, _numTransectsMeta));
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurfaceSubstrateSummaryData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurfaceSubstrateSummaryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      measDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}meas_date'])!,
      numTransects: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}num_transects']),
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $SurfaceSubstrateSummaryTable createAlias(String alias) {
    return $SurfaceSubstrateSummaryTable(attachedDatabase, alias);
  }
}

class SurfaceSubstrateSummaryData extends DataClass
    implements Insertable<SurfaceSubstrateSummaryData> {
  final int id;
  final int surveyId;
  final DateTime measDate;
  final int? numTransects;
  final bool complete;
  const SurfaceSubstrateSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      this.numTransects,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['meas_date'] = Variable<DateTime>(measDate);
    if (!nullToAbsent || numTransects != null) {
      map['num_transects'] = Variable<int>(numTransects);
    }
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  SurfaceSubstrateSummaryCompanion toCompanion(bool nullToAbsent) {
    return SurfaceSubstrateSummaryCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      measDate: Value(measDate),
      numTransects: numTransects == null && nullToAbsent
          ? const Value.absent()
          : Value(numTransects),
      complete: Value(complete),
    );
  }

  factory SurfaceSubstrateSummaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurfaceSubstrateSummaryData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      measDate: serializer.fromJson<DateTime>(json['measDate']),
      numTransects: serializer.fromJson<int?>(json['numTransects']),
      complete: serializer.fromJson<bool>(json['complete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<int>(surveyId),
      'measDate': serializer.toJson<DateTime>(measDate),
      'numTransects': serializer.toJson<int?>(numTransects),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  SurfaceSubstrateSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          Value<int?> numTransects = const Value.absent(),
          bool? complete}) =>
      SurfaceSubstrateSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        numTransects:
            numTransects.present ? numTransects.value : this.numTransects,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('SurfaceSubstrateSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('numTransects: $numTransects, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surveyId, measDate, numTransects, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurfaceSubstrateSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.numTransects == this.numTransects &&
          other.complete == this.complete);
}

class SurfaceSubstrateSummaryCompanion
    extends UpdateCompanion<SurfaceSubstrateSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<int?> numTransects;
  final Value<bool> complete;
  const SurfaceSubstrateSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.numTransects = const Value.absent(),
    this.complete = const Value.absent(),
  });
  SurfaceSubstrateSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    this.numTransects = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate);
  static Insertable<SurfaceSubstrateSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<int>? numTransects,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (numTransects != null) 'num_transects': numTransects,
      if (complete != null) 'complete': complete,
    });
  }

  SurfaceSubstrateSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<int?>? numTransects,
      Value<bool>? complete}) {
    return SurfaceSubstrateSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      numTransects: numTransects ?? this.numTransects,
      complete: complete ?? this.complete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surveyId.present) {
      map['survey_id'] = Variable<int>(surveyId.value);
    }
    if (measDate.present) {
      map['meas_date'] = Variable<DateTime>(measDate.value);
    }
    if (numTransects.present) {
      map['num_transects'] = Variable<int>(numTransects.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurfaceSubstrateSummaryCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('numTransects: $numTransects, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $SurfaceSubstrateHeaderTable extends SurfaceSubstrateHeader
    with TableInfo<$SurfaceSubstrateHeaderTable, SurfaceSubstrateHeaderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurfaceSubstrateHeaderTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ssIdMeta = const VerificationMeta('ssId');
  @override
  late final GeneratedColumn<int> ssId = GeneratedColumn<int>(
      'ss_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES surface_substrate_summary (id)'));
  static const VerificationMeta _transNumMeta =
      const VerificationMeta('transNum');
  @override
  late final GeneratedColumn<int> transNum = GeneratedColumn<int>(
      'trans_num', aliasedName, false,
      check: () => transNum.isBetweenValues(1, 9),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _nomTransLenMeta =
      const VerificationMeta('nomTransLen');
  @override
  late final GeneratedColumn<double> nomTransLen = GeneratedColumn<double>(
      'nom_trans_len', aliasedName, true,
      check: () => nomTransLen.isBetweenValues(10.0, 150.0),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _transAzimuthMeta =
      const VerificationMeta('transAzimuth');
  @override
  late final GeneratedColumn<int> transAzimuth = GeneratedColumn<int>(
      'trans_azimuth', aliasedName, true,
      check: () => transAzimuth.isBetweenValues(0, 360),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, ssId, transNum, nomTransLen, transAzimuth, complete];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surface_substrate_header';
  @override
  VerificationContext validateIntegrity(
      Insertable<SurfaceSubstrateHeaderData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ss_id')) {
      context.handle(
          _ssIdMeta, ssId.isAcceptableOrUnknown(data['ss_id']!, _ssIdMeta));
    } else if (isInserting) {
      context.missing(_ssIdMeta);
    }
    if (data.containsKey('trans_num')) {
      context.handle(_transNumMeta,
          transNum.isAcceptableOrUnknown(data['trans_num']!, _transNumMeta));
    } else if (isInserting) {
      context.missing(_transNumMeta);
    }
    if (data.containsKey('nom_trans_len')) {
      context.handle(
          _nomTransLenMeta,
          nomTransLen.isAcceptableOrUnknown(
              data['nom_trans_len']!, _nomTransLenMeta));
    }
    if (data.containsKey('trans_azimuth')) {
      context.handle(
          _transAzimuthMeta,
          transAzimuth.isAcceptableOrUnknown(
              data['trans_azimuth']!, _transAzimuthMeta));
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurfaceSubstrateHeaderData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurfaceSubstrateHeaderData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ssId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ss_id'])!,
      transNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trans_num'])!,
      nomTransLen: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}nom_trans_len']),
      transAzimuth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}trans_azimuth']),
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $SurfaceSubstrateHeaderTable createAlias(String alias) {
    return $SurfaceSubstrateHeaderTable(attachedDatabase, alias);
  }
}

class SurfaceSubstrateHeaderData extends DataClass
    implements Insertable<SurfaceSubstrateHeaderData> {
  final int id;
  final int ssId;
  final int transNum;
  final double? nomTransLen;
  final int? transAzimuth;
  final bool complete;
  const SurfaceSubstrateHeaderData(
      {required this.id,
      required this.ssId,
      required this.transNum,
      this.nomTransLen,
      this.transAzimuth,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ss_id'] = Variable<int>(ssId);
    map['trans_num'] = Variable<int>(transNum);
    if (!nullToAbsent || nomTransLen != null) {
      map['nom_trans_len'] = Variable<double>(nomTransLen);
    }
    if (!nullToAbsent || transAzimuth != null) {
      map['trans_azimuth'] = Variable<int>(transAzimuth);
    }
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  SurfaceSubstrateHeaderCompanion toCompanion(bool nullToAbsent) {
    return SurfaceSubstrateHeaderCompanion(
      id: Value(id),
      ssId: Value(ssId),
      transNum: Value(transNum),
      nomTransLen: nomTransLen == null && nullToAbsent
          ? const Value.absent()
          : Value(nomTransLen),
      transAzimuth: transAzimuth == null && nullToAbsent
          ? const Value.absent()
          : Value(transAzimuth),
      complete: Value(complete),
    );
  }

  factory SurfaceSubstrateHeaderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurfaceSubstrateHeaderData(
      id: serializer.fromJson<int>(json['id']),
      ssId: serializer.fromJson<int>(json['ssId']),
      transNum: serializer.fromJson<int>(json['transNum']),
      nomTransLen: serializer.fromJson<double?>(json['nomTransLen']),
      transAzimuth: serializer.fromJson<int?>(json['transAzimuth']),
      complete: serializer.fromJson<bool>(json['complete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ssId': serializer.toJson<int>(ssId),
      'transNum': serializer.toJson<int>(transNum),
      'nomTransLen': serializer.toJson<double?>(nomTransLen),
      'transAzimuth': serializer.toJson<int?>(transAzimuth),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  SurfaceSubstrateHeaderData copyWith(
          {int? id,
          int? ssId,
          int? transNum,
          Value<double?> nomTransLen = const Value.absent(),
          Value<int?> transAzimuth = const Value.absent(),
          bool? complete}) =>
      SurfaceSubstrateHeaderData(
        id: id ?? this.id,
        ssId: ssId ?? this.ssId,
        transNum: transNum ?? this.transNum,
        nomTransLen: nomTransLen.present ? nomTransLen.value : this.nomTransLen,
        transAzimuth:
            transAzimuth.present ? transAzimuth.value : this.transAzimuth,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('SurfaceSubstrateHeaderData(')
          ..write('id: $id, ')
          ..write('ssId: $ssId, ')
          ..write('transNum: $transNum, ')
          ..write('nomTransLen: $nomTransLen, ')
          ..write('transAzimuth: $transAzimuth, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ssId, transNum, nomTransLen, transAzimuth, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurfaceSubstrateHeaderData &&
          other.id == this.id &&
          other.ssId == this.ssId &&
          other.transNum == this.transNum &&
          other.nomTransLen == this.nomTransLen &&
          other.transAzimuth == this.transAzimuth &&
          other.complete == this.complete);
}

class SurfaceSubstrateHeaderCompanion
    extends UpdateCompanion<SurfaceSubstrateHeaderData> {
  final Value<int> id;
  final Value<int> ssId;
  final Value<int> transNum;
  final Value<double?> nomTransLen;
  final Value<int?> transAzimuth;
  final Value<bool> complete;
  const SurfaceSubstrateHeaderCompanion({
    this.id = const Value.absent(),
    this.ssId = const Value.absent(),
    this.transNum = const Value.absent(),
    this.nomTransLen = const Value.absent(),
    this.transAzimuth = const Value.absent(),
    this.complete = const Value.absent(),
  });
  SurfaceSubstrateHeaderCompanion.insert({
    this.id = const Value.absent(),
    required int ssId,
    required int transNum,
    this.nomTransLen = const Value.absent(),
    this.transAzimuth = const Value.absent(),
    this.complete = const Value.absent(),
  })  : ssId = Value(ssId),
        transNum = Value(transNum);
  static Insertable<SurfaceSubstrateHeaderData> custom({
    Expression<int>? id,
    Expression<int>? ssId,
    Expression<int>? transNum,
    Expression<double>? nomTransLen,
    Expression<int>? transAzimuth,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ssId != null) 'ss_id': ssId,
      if (transNum != null) 'trans_num': transNum,
      if (nomTransLen != null) 'nom_trans_len': nomTransLen,
      if (transAzimuth != null) 'trans_azimuth': transAzimuth,
      if (complete != null) 'complete': complete,
    });
  }

  SurfaceSubstrateHeaderCompanion copyWith(
      {Value<int>? id,
      Value<int>? ssId,
      Value<int>? transNum,
      Value<double?>? nomTransLen,
      Value<int?>? transAzimuth,
      Value<bool>? complete}) {
    return SurfaceSubstrateHeaderCompanion(
      id: id ?? this.id,
      ssId: ssId ?? this.ssId,
      transNum: transNum ?? this.transNum,
      nomTransLen: nomTransLen ?? this.nomTransLen,
      transAzimuth: transAzimuth ?? this.transAzimuth,
      complete: complete ?? this.complete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ssId.present) {
      map['ss_id'] = Variable<int>(ssId.value);
    }
    if (transNum.present) {
      map['trans_num'] = Variable<int>(transNum.value);
    }
    if (nomTransLen.present) {
      map['nom_trans_len'] = Variable<double>(nomTransLen.value);
    }
    if (transAzimuth.present) {
      map['trans_azimuth'] = Variable<int>(transAzimuth.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurfaceSubstrateHeaderCompanion(')
          ..write('id: $id, ')
          ..write('ssId: $ssId, ')
          ..write('transNum: $transNum, ')
          ..write('nomTransLen: $nomTransLen, ')
          ..write('transAzimuth: $transAzimuth, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $SurfaceSubstrateTallyTable extends SurfaceSubstrateTally
    with TableInfo<$SurfaceSubstrateTallyTable, SurfaceSubstrateTallyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurfaceSubstrateTallyTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ssHeaderIdMeta =
      const VerificationMeta('ssHeaderId');
  @override
  late final GeneratedColumn<int> ssHeaderId = GeneratedColumn<int>(
      'ss_header_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES surface_substrate_header (id)'));
  static const VerificationMeta _stationNumMeta =
      const VerificationMeta('stationNum');
  @override
  late final GeneratedColumn<int> stationNum = GeneratedColumn<int>(
      'station_num', aliasedName, false,
      check: () => stationNum.isBetweenValues(1, 25),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _substrateTypeMeta =
      const VerificationMeta('substrateType');
  @override
  late final GeneratedColumn<String> substrateType = GeneratedColumn<String>(
      'substrate_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _depthMeta = const VerificationMeta('depth');
  @override
  late final GeneratedColumn<int> depth = GeneratedColumn<int>(
      'depth', aliasedName, false,
      check: () => depth.isBetweenValues(-9, 500),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _depthLimitMeta =
      const VerificationMeta('depthLimit');
  @override
  late final GeneratedColumn<int> depthLimit = GeneratedColumn<int>(
      'depth_limit', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ssHeaderId, stationNum, substrateType, depth, depthLimit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surface_substrate_tally';
  @override
  VerificationContext validateIntegrity(
      Insertable<SurfaceSubstrateTallyData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ss_header_id')) {
      context.handle(
          _ssHeaderIdMeta,
          ssHeaderId.isAcceptableOrUnknown(
              data['ss_header_id']!, _ssHeaderIdMeta));
    } else if (isInserting) {
      context.missing(_ssHeaderIdMeta);
    }
    if (data.containsKey('station_num')) {
      context.handle(
          _stationNumMeta,
          stationNum.isAcceptableOrUnknown(
              data['station_num']!, _stationNumMeta));
    } else if (isInserting) {
      context.missing(_stationNumMeta);
    }
    if (data.containsKey('substrate_type')) {
      context.handle(
          _substrateTypeMeta,
          substrateType.isAcceptableOrUnknown(
              data['substrate_type']!, _substrateTypeMeta));
    } else if (isInserting) {
      context.missing(_substrateTypeMeta);
    }
    if (data.containsKey('depth')) {
      context.handle(
          _depthMeta, depth.isAcceptableOrUnknown(data['depth']!, _depthMeta));
    } else if (isInserting) {
      context.missing(_depthMeta);
    }
    if (data.containsKey('depth_limit')) {
      context.handle(
          _depthLimitMeta,
          depthLimit.isAcceptableOrUnknown(
              data['depth_limit']!, _depthLimitMeta));
    } else if (isInserting) {
      context.missing(_depthLimitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurfaceSubstrateTallyData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurfaceSubstrateTallyData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ssHeaderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ss_header_id'])!,
      stationNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}station_num'])!,
      substrateType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}substrate_type'])!,
      depth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}depth'])!,
      depthLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}depth_limit'])!,
    );
  }

  @override
  $SurfaceSubstrateTallyTable createAlias(String alias) {
    return $SurfaceSubstrateTallyTable(attachedDatabase, alias);
  }
}

class SurfaceSubstrateTallyData extends DataClass
    implements Insertable<SurfaceSubstrateTallyData> {
  final int id;
  final int ssHeaderId;
  final int stationNum;
  final String substrateType;
  final int depth;
  final int depthLimit;
  const SurfaceSubstrateTallyData(
      {required this.id,
      required this.ssHeaderId,
      required this.stationNum,
      required this.substrateType,
      required this.depth,
      required this.depthLimit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ss_header_id'] = Variable<int>(ssHeaderId);
    map['station_num'] = Variable<int>(stationNum);
    map['substrate_type'] = Variable<String>(substrateType);
    map['depth'] = Variable<int>(depth);
    map['depth_limit'] = Variable<int>(depthLimit);
    return map;
  }

  SurfaceSubstrateTallyCompanion toCompanion(bool nullToAbsent) {
    return SurfaceSubstrateTallyCompanion(
      id: Value(id),
      ssHeaderId: Value(ssHeaderId),
      stationNum: Value(stationNum),
      substrateType: Value(substrateType),
      depth: Value(depth),
      depthLimit: Value(depthLimit),
    );
  }

  factory SurfaceSubstrateTallyData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurfaceSubstrateTallyData(
      id: serializer.fromJson<int>(json['id']),
      ssHeaderId: serializer.fromJson<int>(json['ssHeaderId']),
      stationNum: serializer.fromJson<int>(json['stationNum']),
      substrateType: serializer.fromJson<String>(json['substrateType']),
      depth: serializer.fromJson<int>(json['depth']),
      depthLimit: serializer.fromJson<int>(json['depthLimit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ssHeaderId': serializer.toJson<int>(ssHeaderId),
      'stationNum': serializer.toJson<int>(stationNum),
      'substrateType': serializer.toJson<String>(substrateType),
      'depth': serializer.toJson<int>(depth),
      'depthLimit': serializer.toJson<int>(depthLimit),
    };
  }

  SurfaceSubstrateTallyData copyWith(
          {int? id,
          int? ssHeaderId,
          int? stationNum,
          String? substrateType,
          int? depth,
          int? depthLimit}) =>
      SurfaceSubstrateTallyData(
        id: id ?? this.id,
        ssHeaderId: ssHeaderId ?? this.ssHeaderId,
        stationNum: stationNum ?? this.stationNum,
        substrateType: substrateType ?? this.substrateType,
        depth: depth ?? this.depth,
        depthLimit: depthLimit ?? this.depthLimit,
      );
  @override
  String toString() {
    return (StringBuffer('SurfaceSubstrateTallyData(')
          ..write('id: $id, ')
          ..write('ssHeaderId: $ssHeaderId, ')
          ..write('stationNum: $stationNum, ')
          ..write('substrateType: $substrateType, ')
          ..write('depth: $depth, ')
          ..write('depthLimit: $depthLimit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ssHeaderId, stationNum, substrateType, depth, depthLimit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurfaceSubstrateTallyData &&
          other.id == this.id &&
          other.ssHeaderId == this.ssHeaderId &&
          other.stationNum == this.stationNum &&
          other.substrateType == this.substrateType &&
          other.depth == this.depth &&
          other.depthLimit == this.depthLimit);
}

class SurfaceSubstrateTallyCompanion
    extends UpdateCompanion<SurfaceSubstrateTallyData> {
  final Value<int> id;
  final Value<int> ssHeaderId;
  final Value<int> stationNum;
  final Value<String> substrateType;
  final Value<int> depth;
  final Value<int> depthLimit;
  const SurfaceSubstrateTallyCompanion({
    this.id = const Value.absent(),
    this.ssHeaderId = const Value.absent(),
    this.stationNum = const Value.absent(),
    this.substrateType = const Value.absent(),
    this.depth = const Value.absent(),
    this.depthLimit = const Value.absent(),
  });
  SurfaceSubstrateTallyCompanion.insert({
    this.id = const Value.absent(),
    required int ssHeaderId,
    required int stationNum,
    required String substrateType,
    required int depth,
    required int depthLimit,
  })  : ssHeaderId = Value(ssHeaderId),
        stationNum = Value(stationNum),
        substrateType = Value(substrateType),
        depth = Value(depth),
        depthLimit = Value(depthLimit);
  static Insertable<SurfaceSubstrateTallyData> custom({
    Expression<int>? id,
    Expression<int>? ssHeaderId,
    Expression<int>? stationNum,
    Expression<String>? substrateType,
    Expression<int>? depth,
    Expression<int>? depthLimit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ssHeaderId != null) 'ss_header_id': ssHeaderId,
      if (stationNum != null) 'station_num': stationNum,
      if (substrateType != null) 'substrate_type': substrateType,
      if (depth != null) 'depth': depth,
      if (depthLimit != null) 'depth_limit': depthLimit,
    });
  }

  SurfaceSubstrateTallyCompanion copyWith(
      {Value<int>? id,
      Value<int>? ssHeaderId,
      Value<int>? stationNum,
      Value<String>? substrateType,
      Value<int>? depth,
      Value<int>? depthLimit}) {
    return SurfaceSubstrateTallyCompanion(
      id: id ?? this.id,
      ssHeaderId: ssHeaderId ?? this.ssHeaderId,
      stationNum: stationNum ?? this.stationNum,
      substrateType: substrateType ?? this.substrateType,
      depth: depth ?? this.depth,
      depthLimit: depthLimit ?? this.depthLimit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ssHeaderId.present) {
      map['ss_header_id'] = Variable<int>(ssHeaderId.value);
    }
    if (stationNum.present) {
      map['station_num'] = Variable<int>(stationNum.value);
    }
    if (substrateType.present) {
      map['substrate_type'] = Variable<String>(substrateType.value);
    }
    if (depth.present) {
      map['depth'] = Variable<int>(depth.value);
    }
    if (depthLimit.present) {
      map['depth_limit'] = Variable<int>(depthLimit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurfaceSubstrateTallyCompanion(')
          ..write('id: $id, ')
          ..write('ssHeaderId: $ssHeaderId, ')
          ..write('stationNum: $stationNum, ')
          ..write('substrateType: $substrateType, ')
          ..write('depth: $depth, ')
          ..write('depthLimit: $depthLimit')
          ..write(')'))
        .toString();
  }
}

class $EcpSummaryTable extends EcpSummary
    with TableInfo<$EcpSummaryTable, EcpSummaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EcpSummaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _surveyIdMeta =
      const VerificationMeta('surveyId');
  @override
  late final GeneratedColumn<int> surveyId = GeneratedColumn<int>(
      'survey_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES survey_headers (id)'));
  static const VerificationMeta _measDateMeta =
      const VerificationMeta('measDate');
  @override
  late final GeneratedColumn<DateTime> measDate = GeneratedColumn<DateTime>(
      'meas_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _numEcpsMeta =
      const VerificationMeta('numEcps');
  @override
  late final GeneratedColumn<int> numEcps = GeneratedColumn<int>(
      'num_ecps', aliasedName, true,
      check: () => numEcps.isBetweenValues(1, 9),
      type: DriftSqlType.int,
      requiredDuringInsert: false);
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, surveyId, measDate, numEcps, complete];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ecp_summary';
  @override
  VerificationContext validateIntegrity(Insertable<EcpSummaryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('survey_id')) {
      context.handle(_surveyIdMeta,
          surveyId.isAcceptableOrUnknown(data['survey_id']!, _surveyIdMeta));
    } else if (isInserting) {
      context.missing(_surveyIdMeta);
    }
    if (data.containsKey('meas_date')) {
      context.handle(_measDateMeta,
          measDate.isAcceptableOrUnknown(data['meas_date']!, _measDateMeta));
    } else if (isInserting) {
      context.missing(_measDateMeta);
    }
    if (data.containsKey('num_ecps')) {
      context.handle(_numEcpsMeta,
          numEcps.isAcceptableOrUnknown(data['num_ecps']!, _numEcpsMeta));
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EcpSummaryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EcpSummaryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      measDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}meas_date'])!,
      numEcps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}num_ecps']),
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $EcpSummaryTable createAlias(String alias) {
    return $EcpSummaryTable(attachedDatabase, alias);
  }
}

class EcpSummaryData extends DataClass implements Insertable<EcpSummaryData> {
  final int id;
  final int surveyId;
  final DateTime measDate;
  final int? numEcps;
  final bool complete;
  const EcpSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      this.numEcps,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['meas_date'] = Variable<DateTime>(measDate);
    if (!nullToAbsent || numEcps != null) {
      map['num_ecps'] = Variable<int>(numEcps);
    }
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  EcpSummaryCompanion toCompanion(bool nullToAbsent) {
    return EcpSummaryCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      measDate: Value(measDate),
      numEcps: numEcps == null && nullToAbsent
          ? const Value.absent()
          : Value(numEcps),
      complete: Value(complete),
    );
  }

  factory EcpSummaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EcpSummaryData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      measDate: serializer.fromJson<DateTime>(json['measDate']),
      numEcps: serializer.fromJson<int?>(json['numEcps']),
      complete: serializer.fromJson<bool>(json['complete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<int>(surveyId),
      'measDate': serializer.toJson<DateTime>(measDate),
      'numEcps': serializer.toJson<int?>(numEcps),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  EcpSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          Value<int?> numEcps = const Value.absent(),
          bool? complete}) =>
      EcpSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        numEcps: numEcps.present ? numEcps.value : this.numEcps,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('EcpSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('numEcps: $numEcps, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, measDate, numEcps, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcpSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.numEcps == this.numEcps &&
          other.complete == this.complete);
}

class EcpSummaryCompanion extends UpdateCompanion<EcpSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<int?> numEcps;
  final Value<bool> complete;
  const EcpSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.numEcps = const Value.absent(),
    this.complete = const Value.absent(),
  });
  EcpSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    this.numEcps = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate);
  static Insertable<EcpSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<int>? numEcps,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (numEcps != null) 'num_ecps': numEcps,
      if (complete != null) 'complete': complete,
    });
  }

  EcpSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<int?>? numEcps,
      Value<bool>? complete}) {
    return EcpSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      numEcps: numEcps ?? this.numEcps,
      complete: complete ?? this.complete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surveyId.present) {
      map['survey_id'] = Variable<int>(surveyId.value);
    }
    if (measDate.present) {
      map['meas_date'] = Variable<DateTime>(measDate.value);
    }
    if (numEcps.present) {
      map['num_ecps'] = Variable<int>(numEcps.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcpSummaryCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('numEcps: $numEcps, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $EcpHeaderTable extends EcpHeader
    with TableInfo<$EcpHeaderTable, EcpHeaderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EcpHeaderTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ecpSummaryIdMeta =
      const VerificationMeta('ecpSummaryId');
  @override
  late final GeneratedColumn<int> ecpSummaryId = GeneratedColumn<int>(
      'ecp_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ecp_summary (id)'));
  static const VerificationMeta _ecpNumMeta = const VerificationMeta('ecpNum');
  @override
  late final GeneratedColumn<int> ecpNum = GeneratedColumn<int>(
      'ecp_num', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _plotTypeMeta =
      const VerificationMeta('plotType');
  @override
  late final GeneratedColumn<String> plotType = GeneratedColumn<String>(
      'plot_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nomPlotSizeMeta =
      const VerificationMeta('nomPlotSize');
  @override
  late final GeneratedColumn<double> nomPlotSize = GeneratedColumn<double>(
      'nom_plot_size', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _measPlotSizeMeta =
      const VerificationMeta('measPlotSize');
  @override
  late final GeneratedColumn<double> measPlotSize = GeneratedColumn<double>(
      'meas_plot_size', aliasedName, true,
      check: () => measPlotSize.isBetweenValues(0.000025, 1.0),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ecpSummaryId, ecpNum, complete, plotType, nomPlotSize, measPlotSize];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ecp_header';
  @override
  VerificationContext validateIntegrity(Insertable<EcpHeaderData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ecp_summary_id')) {
      context.handle(
          _ecpSummaryIdMeta,
          ecpSummaryId.isAcceptableOrUnknown(
              data['ecp_summary_id']!, _ecpSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_ecpSummaryIdMeta);
    }
    if (data.containsKey('ecp_num')) {
      context.handle(_ecpNumMeta,
          ecpNum.isAcceptableOrUnknown(data['ecp_num']!, _ecpNumMeta));
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    if (data.containsKey('plot_type')) {
      context.handle(_plotTypeMeta,
          plotType.isAcceptableOrUnknown(data['plot_type']!, _plotTypeMeta));
    }
    if (data.containsKey('nom_plot_size')) {
      context.handle(
          _nomPlotSizeMeta,
          nomPlotSize.isAcceptableOrUnknown(
              data['nom_plot_size']!, _nomPlotSizeMeta));
    }
    if (data.containsKey('meas_plot_size')) {
      context.handle(
          _measPlotSizeMeta,
          measPlotSize.isAcceptableOrUnknown(
              data['meas_plot_size']!, _measPlotSizeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EcpHeaderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EcpHeaderData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ecpSummaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ecp_summary_id'])!,
      ecpNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ecp_num']),
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
      plotType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plot_type']),
      nomPlotSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}nom_plot_size']),
      measPlotSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}meas_plot_size']),
    );
  }

  @override
  $EcpHeaderTable createAlias(String alias) {
    return $EcpHeaderTable(attachedDatabase, alias);
  }
}

class EcpHeaderData extends DataClass implements Insertable<EcpHeaderData> {
  final int id;
  final int ecpSummaryId;
  final int? ecpNum;
  final bool complete;
  final String? plotType;
  final double? nomPlotSize;
  final double? measPlotSize;
  const EcpHeaderData(
      {required this.id,
      required this.ecpSummaryId,
      this.ecpNum,
      required this.complete,
      this.plotType,
      this.nomPlotSize,
      this.measPlotSize});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ecp_summary_id'] = Variable<int>(ecpSummaryId);
    if (!nullToAbsent || ecpNum != null) {
      map['ecp_num'] = Variable<int>(ecpNum);
    }
    map['complete'] = Variable<bool>(complete);
    if (!nullToAbsent || plotType != null) {
      map['plot_type'] = Variable<String>(plotType);
    }
    if (!nullToAbsent || nomPlotSize != null) {
      map['nom_plot_size'] = Variable<double>(nomPlotSize);
    }
    if (!nullToAbsent || measPlotSize != null) {
      map['meas_plot_size'] = Variable<double>(measPlotSize);
    }
    return map;
  }

  EcpHeaderCompanion toCompanion(bool nullToAbsent) {
    return EcpHeaderCompanion(
      id: Value(id),
      ecpSummaryId: Value(ecpSummaryId),
      ecpNum:
          ecpNum == null && nullToAbsent ? const Value.absent() : Value(ecpNum),
      complete: Value(complete),
      plotType: plotType == null && nullToAbsent
          ? const Value.absent()
          : Value(plotType),
      nomPlotSize: nomPlotSize == null && nullToAbsent
          ? const Value.absent()
          : Value(nomPlotSize),
      measPlotSize: measPlotSize == null && nullToAbsent
          ? const Value.absent()
          : Value(measPlotSize),
    );
  }

  factory EcpHeaderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EcpHeaderData(
      id: serializer.fromJson<int>(json['id']),
      ecpSummaryId: serializer.fromJson<int>(json['ecpSummaryId']),
      ecpNum: serializer.fromJson<int?>(json['ecpNum']),
      complete: serializer.fromJson<bool>(json['complete']),
      plotType: serializer.fromJson<String?>(json['plotType']),
      nomPlotSize: serializer.fromJson<double?>(json['nomPlotSize']),
      measPlotSize: serializer.fromJson<double?>(json['measPlotSize']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ecpSummaryId': serializer.toJson<int>(ecpSummaryId),
      'ecpNum': serializer.toJson<int?>(ecpNum),
      'complete': serializer.toJson<bool>(complete),
      'plotType': serializer.toJson<String?>(plotType),
      'nomPlotSize': serializer.toJson<double?>(nomPlotSize),
      'measPlotSize': serializer.toJson<double?>(measPlotSize),
    };
  }

  EcpHeaderData copyWith(
          {int? id,
          int? ecpSummaryId,
          Value<int?> ecpNum = const Value.absent(),
          bool? complete,
          Value<String?> plotType = const Value.absent(),
          Value<double?> nomPlotSize = const Value.absent(),
          Value<double?> measPlotSize = const Value.absent()}) =>
      EcpHeaderData(
        id: id ?? this.id,
        ecpSummaryId: ecpSummaryId ?? this.ecpSummaryId,
        ecpNum: ecpNum.present ? ecpNum.value : this.ecpNum,
        complete: complete ?? this.complete,
        plotType: plotType.present ? plotType.value : this.plotType,
        nomPlotSize: nomPlotSize.present ? nomPlotSize.value : this.nomPlotSize,
        measPlotSize:
            measPlotSize.present ? measPlotSize.value : this.measPlotSize,
      );
  @override
  String toString() {
    return (StringBuffer('EcpHeaderData(')
          ..write('id: $id, ')
          ..write('ecpSummaryId: $ecpSummaryId, ')
          ..write('ecpNum: $ecpNum, ')
          ..write('complete: $complete, ')
          ..write('plotType: $plotType, ')
          ..write('nomPlotSize: $nomPlotSize, ')
          ..write('measPlotSize: $measPlotSize')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, ecpSummaryId, ecpNum, complete, plotType, nomPlotSize, measPlotSize);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcpHeaderData &&
          other.id == this.id &&
          other.ecpSummaryId == this.ecpSummaryId &&
          other.ecpNum == this.ecpNum &&
          other.complete == this.complete &&
          other.plotType == this.plotType &&
          other.nomPlotSize == this.nomPlotSize &&
          other.measPlotSize == this.measPlotSize);
}

class EcpHeaderCompanion extends UpdateCompanion<EcpHeaderData> {
  final Value<int> id;
  final Value<int> ecpSummaryId;
  final Value<int?> ecpNum;
  final Value<bool> complete;
  final Value<String?> plotType;
  final Value<double?> nomPlotSize;
  final Value<double?> measPlotSize;
  const EcpHeaderCompanion({
    this.id = const Value.absent(),
    this.ecpSummaryId = const Value.absent(),
    this.ecpNum = const Value.absent(),
    this.complete = const Value.absent(),
    this.plotType = const Value.absent(),
    this.nomPlotSize = const Value.absent(),
    this.measPlotSize = const Value.absent(),
  });
  EcpHeaderCompanion.insert({
    this.id = const Value.absent(),
    required int ecpSummaryId,
    this.ecpNum = const Value.absent(),
    this.complete = const Value.absent(),
    this.plotType = const Value.absent(),
    this.nomPlotSize = const Value.absent(),
    this.measPlotSize = const Value.absent(),
  }) : ecpSummaryId = Value(ecpSummaryId);
  static Insertable<EcpHeaderData> custom({
    Expression<int>? id,
    Expression<int>? ecpSummaryId,
    Expression<int>? ecpNum,
    Expression<bool>? complete,
    Expression<String>? plotType,
    Expression<double>? nomPlotSize,
    Expression<double>? measPlotSize,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ecpSummaryId != null) 'ecp_summary_id': ecpSummaryId,
      if (ecpNum != null) 'ecp_num': ecpNum,
      if (complete != null) 'complete': complete,
      if (plotType != null) 'plot_type': plotType,
      if (nomPlotSize != null) 'nom_plot_size': nomPlotSize,
      if (measPlotSize != null) 'meas_plot_size': measPlotSize,
    });
  }

  EcpHeaderCompanion copyWith(
      {Value<int>? id,
      Value<int>? ecpSummaryId,
      Value<int?>? ecpNum,
      Value<bool>? complete,
      Value<String?>? plotType,
      Value<double?>? nomPlotSize,
      Value<double?>? measPlotSize}) {
    return EcpHeaderCompanion(
      id: id ?? this.id,
      ecpSummaryId: ecpSummaryId ?? this.ecpSummaryId,
      ecpNum: ecpNum ?? this.ecpNum,
      complete: complete ?? this.complete,
      plotType: plotType ?? this.plotType,
      nomPlotSize: nomPlotSize ?? this.nomPlotSize,
      measPlotSize: measPlotSize ?? this.measPlotSize,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ecpSummaryId.present) {
      map['ecp_summary_id'] = Variable<int>(ecpSummaryId.value);
    }
    if (ecpNum.present) {
      map['ecp_num'] = Variable<int>(ecpNum.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    if (plotType.present) {
      map['plot_type'] = Variable<String>(plotType.value);
    }
    if (nomPlotSize.present) {
      map['nom_plot_size'] = Variable<double>(nomPlotSize.value);
    }
    if (measPlotSize.present) {
      map['meas_plot_size'] = Variable<double>(measPlotSize.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcpHeaderCompanion(')
          ..write('id: $id, ')
          ..write('ecpSummaryId: $ecpSummaryId, ')
          ..write('ecpNum: $ecpNum, ')
          ..write('complete: $complete, ')
          ..write('plotType: $plotType, ')
          ..write('nomPlotSize: $nomPlotSize, ')
          ..write('measPlotSize: $measPlotSize')
          ..write(')'))
        .toString();
  }
}

class $EcpSpeciesTable extends EcpSpecies
    with TableInfo<$EcpSpeciesTable, EcpSpeciesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EcpSpeciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ecpHeaderIdMeta =
      const VerificationMeta('ecpHeaderId');
  @override
  late final GeneratedColumn<int> ecpHeaderId = GeneratedColumn<int>(
      'ecp_header_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ecp_header (id)'));
  static const VerificationMeta _speciesNumMeta =
      const VerificationMeta('speciesNum');
  @override
  late final GeneratedColumn<int> speciesNum = GeneratedColumn<int>(
      'species_num', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _layerIdMeta =
      const VerificationMeta('layerId');
  @override
  late final GeneratedColumn<String> layerId = GeneratedColumn<String>(
      'layer_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genusMeta = const VerificationMeta('genus');
  @override
  late final GeneratedColumn<String> genus = GeneratedColumn<String>(
      'genus', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _speciesMeta =
      const VerificationMeta('species');
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
      'species', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _varietyMeta =
      const VerificationMeta('variety');
  @override
  late final GeneratedColumn<String> variety = GeneratedColumn<String>(
      'variety', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _speciesPctMeta =
      const VerificationMeta('speciesPct');
  @override
  late final GeneratedColumn<double> speciesPct = GeneratedColumn<double>(
      'species_pct', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _commentIdMeta =
      const VerificationMeta('commentId');
  @override
  late final GeneratedColumn<int> commentId = GeneratedColumn<int>(
      'comment_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES meta_comment (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        ecpHeaderId,
        speciesNum,
        layerId,
        genus,
        species,
        variety,
        speciesPct,
        commentId
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ecp_species';
  @override
  VerificationContext validateIntegrity(Insertable<EcpSpeciesData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ecp_header_id')) {
      context.handle(
          _ecpHeaderIdMeta,
          ecpHeaderId.isAcceptableOrUnknown(
              data['ecp_header_id']!, _ecpHeaderIdMeta));
    } else if (isInserting) {
      context.missing(_ecpHeaderIdMeta);
    }
    if (data.containsKey('species_num')) {
      context.handle(
          _speciesNumMeta,
          speciesNum.isAcceptableOrUnknown(
              data['species_num']!, _speciesNumMeta));
    } else if (isInserting) {
      context.missing(_speciesNumMeta);
    }
    if (data.containsKey('layer_id')) {
      context.handle(_layerIdMeta,
          layerId.isAcceptableOrUnknown(data['layer_id']!, _layerIdMeta));
    } else if (isInserting) {
      context.missing(_layerIdMeta);
    }
    if (data.containsKey('genus')) {
      context.handle(
          _genusMeta, genus.isAcceptableOrUnknown(data['genus']!, _genusMeta));
    } else if (isInserting) {
      context.missing(_genusMeta);
    }
    if (data.containsKey('species')) {
      context.handle(_speciesMeta,
          species.isAcceptableOrUnknown(data['species']!, _speciesMeta));
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('variety')) {
      context.handle(_varietyMeta,
          variety.isAcceptableOrUnknown(data['variety']!, _varietyMeta));
    }
    if (data.containsKey('species_pct')) {
      context.handle(
          _speciesPctMeta,
          speciesPct.isAcceptableOrUnknown(
              data['species_pct']!, _speciesPctMeta));
    } else if (isInserting) {
      context.missing(_speciesPctMeta);
    }
    if (data.containsKey('comment_id')) {
      context.handle(_commentIdMeta,
          commentId.isAcceptableOrUnknown(data['comment_id']!, _commentIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EcpSpeciesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EcpSpeciesData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ecpHeaderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ecp_header_id'])!,
      speciesNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}species_num'])!,
      layerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}layer_id'])!,
      genus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genus'])!,
      species: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species'])!,
      variety: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variety']),
      speciesPct: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}species_pct'])!,
      commentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}comment_id']),
    );
  }

  @override
  $EcpSpeciesTable createAlias(String alias) {
    return $EcpSpeciesTable(attachedDatabase, alias);
  }
}

class EcpSpeciesData extends DataClass implements Insertable<EcpSpeciesData> {
  final int id;
  final int ecpHeaderId;
  final int speciesNum;
  final String layerId;
  final String genus;
  final String species;
  final String? variety;
  final double speciesPct;
  final int? commentId;
  const EcpSpeciesData(
      {required this.id,
      required this.ecpHeaderId,
      required this.speciesNum,
      required this.layerId,
      required this.genus,
      required this.species,
      this.variety,
      required this.speciesPct,
      this.commentId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ecp_header_id'] = Variable<int>(ecpHeaderId);
    map['species_num'] = Variable<int>(speciesNum);
    map['layer_id'] = Variable<String>(layerId);
    map['genus'] = Variable<String>(genus);
    map['species'] = Variable<String>(species);
    if (!nullToAbsent || variety != null) {
      map['variety'] = Variable<String>(variety);
    }
    map['species_pct'] = Variable<double>(speciesPct);
    if (!nullToAbsent || commentId != null) {
      map['comment_id'] = Variable<int>(commentId);
    }
    return map;
  }

  EcpSpeciesCompanion toCompanion(bool nullToAbsent) {
    return EcpSpeciesCompanion(
      id: Value(id),
      ecpHeaderId: Value(ecpHeaderId),
      speciesNum: Value(speciesNum),
      layerId: Value(layerId),
      genus: Value(genus),
      species: Value(species),
      variety: variety == null && nullToAbsent
          ? const Value.absent()
          : Value(variety),
      speciesPct: Value(speciesPct),
      commentId: commentId == null && nullToAbsent
          ? const Value.absent()
          : Value(commentId),
    );
  }

  factory EcpSpeciesData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EcpSpeciesData(
      id: serializer.fromJson<int>(json['id']),
      ecpHeaderId: serializer.fromJson<int>(json['ecpHeaderId']),
      speciesNum: serializer.fromJson<int>(json['speciesNum']),
      layerId: serializer.fromJson<String>(json['layerId']),
      genus: serializer.fromJson<String>(json['genus']),
      species: serializer.fromJson<String>(json['species']),
      variety: serializer.fromJson<String?>(json['variety']),
      speciesPct: serializer.fromJson<double>(json['speciesPct']),
      commentId: serializer.fromJson<int?>(json['commentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ecpHeaderId': serializer.toJson<int>(ecpHeaderId),
      'speciesNum': serializer.toJson<int>(speciesNum),
      'layerId': serializer.toJson<String>(layerId),
      'genus': serializer.toJson<String>(genus),
      'species': serializer.toJson<String>(species),
      'variety': serializer.toJson<String?>(variety),
      'speciesPct': serializer.toJson<double>(speciesPct),
      'commentId': serializer.toJson<int?>(commentId),
    };
  }

  EcpSpeciesData copyWith(
          {int? id,
          int? ecpHeaderId,
          int? speciesNum,
          String? layerId,
          String? genus,
          String? species,
          Value<String?> variety = const Value.absent(),
          double? speciesPct,
          Value<int?> commentId = const Value.absent()}) =>
      EcpSpeciesData(
        id: id ?? this.id,
        ecpHeaderId: ecpHeaderId ?? this.ecpHeaderId,
        speciesNum: speciesNum ?? this.speciesNum,
        layerId: layerId ?? this.layerId,
        genus: genus ?? this.genus,
        species: species ?? this.species,
        variety: variety.present ? variety.value : this.variety,
        speciesPct: speciesPct ?? this.speciesPct,
        commentId: commentId.present ? commentId.value : this.commentId,
      );
  @override
  String toString() {
    return (StringBuffer('EcpSpeciesData(')
          ..write('id: $id, ')
          ..write('ecpHeaderId: $ecpHeaderId, ')
          ..write('speciesNum: $speciesNum, ')
          ..write('layerId: $layerId, ')
          ..write('genus: $genus, ')
          ..write('species: $species, ')
          ..write('variety: $variety, ')
          ..write('speciesPct: $speciesPct, ')
          ..write('commentId: $commentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ecpHeaderId, speciesNum, layerId, genus,
      species, variety, speciesPct, commentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcpSpeciesData &&
          other.id == this.id &&
          other.ecpHeaderId == this.ecpHeaderId &&
          other.speciesNum == this.speciesNum &&
          other.layerId == this.layerId &&
          other.genus == this.genus &&
          other.species == this.species &&
          other.variety == this.variety &&
          other.speciesPct == this.speciesPct &&
          other.commentId == this.commentId);
}

class EcpSpeciesCompanion extends UpdateCompanion<EcpSpeciesData> {
  final Value<int> id;
  final Value<int> ecpHeaderId;
  final Value<int> speciesNum;
  final Value<String> layerId;
  final Value<String> genus;
  final Value<String> species;
  final Value<String?> variety;
  final Value<double> speciesPct;
  final Value<int?> commentId;
  const EcpSpeciesCompanion({
    this.id = const Value.absent(),
    this.ecpHeaderId = const Value.absent(),
    this.speciesNum = const Value.absent(),
    this.layerId = const Value.absent(),
    this.genus = const Value.absent(),
    this.species = const Value.absent(),
    this.variety = const Value.absent(),
    this.speciesPct = const Value.absent(),
    this.commentId = const Value.absent(),
  });
  EcpSpeciesCompanion.insert({
    this.id = const Value.absent(),
    required int ecpHeaderId,
    required int speciesNum,
    required String layerId,
    required String genus,
    required String species,
    this.variety = const Value.absent(),
    required double speciesPct,
    this.commentId = const Value.absent(),
  })  : ecpHeaderId = Value(ecpHeaderId),
        speciesNum = Value(speciesNum),
        layerId = Value(layerId),
        genus = Value(genus),
        species = Value(species),
        speciesPct = Value(speciesPct);
  static Insertable<EcpSpeciesData> custom({
    Expression<int>? id,
    Expression<int>? ecpHeaderId,
    Expression<int>? speciesNum,
    Expression<String>? layerId,
    Expression<String>? genus,
    Expression<String>? species,
    Expression<String>? variety,
    Expression<double>? speciesPct,
    Expression<int>? commentId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ecpHeaderId != null) 'ecp_header_id': ecpHeaderId,
      if (speciesNum != null) 'species_num': speciesNum,
      if (layerId != null) 'layer_id': layerId,
      if (genus != null) 'genus': genus,
      if (species != null) 'species': species,
      if (variety != null) 'variety': variety,
      if (speciesPct != null) 'species_pct': speciesPct,
      if (commentId != null) 'comment_id': commentId,
    });
  }

  EcpSpeciesCompanion copyWith(
      {Value<int>? id,
      Value<int>? ecpHeaderId,
      Value<int>? speciesNum,
      Value<String>? layerId,
      Value<String>? genus,
      Value<String>? species,
      Value<String?>? variety,
      Value<double>? speciesPct,
      Value<int?>? commentId}) {
    return EcpSpeciesCompanion(
      id: id ?? this.id,
      ecpHeaderId: ecpHeaderId ?? this.ecpHeaderId,
      speciesNum: speciesNum ?? this.speciesNum,
      layerId: layerId ?? this.layerId,
      genus: genus ?? this.genus,
      species: species ?? this.species,
      variety: variety ?? this.variety,
      speciesPct: speciesPct ?? this.speciesPct,
      commentId: commentId ?? this.commentId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ecpHeaderId.present) {
      map['ecp_header_id'] = Variable<int>(ecpHeaderId.value);
    }
    if (speciesNum.present) {
      map['species_num'] = Variable<int>(speciesNum.value);
    }
    if (layerId.present) {
      map['layer_id'] = Variable<String>(layerId.value);
    }
    if (genus.present) {
      map['genus'] = Variable<String>(genus.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (variety.present) {
      map['variety'] = Variable<String>(variety.value);
    }
    if (speciesPct.present) {
      map['species_pct'] = Variable<double>(speciesPct.value);
    }
    if (commentId.present) {
      map['comment_id'] = Variable<int>(commentId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EcpSpeciesCompanion(')
          ..write('id: $id, ')
          ..write('ecpHeaderId: $ecpHeaderId, ')
          ..write('speciesNum: $speciesNum, ')
          ..write('layerId: $layerId, ')
          ..write('genus: $genus, ')
          ..write('species: $species, ')
          ..write('variety: $variety, ')
          ..write('speciesPct: $speciesPct, ')
          ..write('commentId: $commentId')
          ..write(')'))
        .toString();
  }
}

class $SoilPitSummaryTable extends SoilPitSummary
    with TableInfo<$SoilPitSummaryTable, SoilPitSummaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilPitSummaryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _surveyIdMeta =
      const VerificationMeta('surveyId');
  @override
  late final GeneratedColumn<int> surveyId = GeneratedColumn<int>(
      'survey_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES survey_headers (id)'));
  static const VerificationMeta _measDateMeta =
      const VerificationMeta('measDate');
  @override
  late final GeneratedColumn<DateTime> measDate = GeneratedColumn<DateTime>(
      'meas_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _completeMeta =
      const VerificationMeta('complete');
  @override
  late final GeneratedColumn<bool> complete = GeneratedColumn<bool>(
      'complete', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("complete" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, surveyId, measDate, complete];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_pit_summary';
  @override
  VerificationContext validateIntegrity(Insertable<SoilPitSummaryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('survey_id')) {
      context.handle(_surveyIdMeta,
          surveyId.isAcceptableOrUnknown(data['survey_id']!, _surveyIdMeta));
    } else if (isInserting) {
      context.missing(_surveyIdMeta);
    }
    if (data.containsKey('meas_date')) {
      context.handle(_measDateMeta,
          measDate.isAcceptableOrUnknown(data['meas_date']!, _measDateMeta));
    } else if (isInserting) {
      context.missing(_measDateMeta);
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SoilPitSummaryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilPitSummaryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      measDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}meas_date'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $SoilPitSummaryTable createAlias(String alias) {
    return $SoilPitSummaryTable(attachedDatabase, alias);
  }
}

class SoilPitSummaryData extends DataClass
    implements Insertable<SoilPitSummaryData> {
  final int id;
  final int surveyId;
  final DateTime measDate;
  final bool complete;
  const SoilPitSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['meas_date'] = Variable<DateTime>(measDate);
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  SoilPitSummaryCompanion toCompanion(bool nullToAbsent) {
    return SoilPitSummaryCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      measDate: Value(measDate),
      complete: Value(complete),
    );
  }

  factory SoilPitSummaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitSummaryData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      measDate: serializer.fromJson<DateTime>(json['measDate']),
      complete: serializer.fromJson<bool>(json['complete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<int>(surveyId),
      'measDate': serializer.toJson<DateTime>(measDate),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  SoilPitSummaryData copyWith(
          {int? id, int? surveyId, DateTime? measDate, bool? complete}) =>
      SoilPitSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, measDate, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilPitSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.complete == this.complete);
}

class SoilPitSummaryCompanion extends UpdateCompanion<SoilPitSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<bool> complete;
  const SoilPitSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.complete = const Value.absent(),
  });
  SoilPitSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate);
  static Insertable<SoilPitSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (complete != null) 'complete': complete,
    });
  }

  SoilPitSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<bool>? complete}) {
    return SoilPitSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      complete: complete ?? this.complete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surveyId.present) {
      map['survey_id'] = Variable<int>(surveyId.value);
    }
    if (measDate.present) {
      map['meas_date'] = Variable<DateTime>(measDate.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilPitSummaryCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $SoilSiteInfoTable extends SoilSiteInfo
    with TableInfo<$SoilSiteInfoTable, SoilSiteInfoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilSiteInfoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _soilPitSummaryIdMeta =
      const VerificationMeta('soilPitSummaryId');
  @override
  late final GeneratedColumn<int> soilPitSummaryId = GeneratedColumn<int>(
      'soil_pit_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES soil_pit_summary (id)'));
  static const VerificationMeta _soilClassMeta =
      const VerificationMeta('soilClass');
  @override
  late final GeneratedColumn<String> soilClass = GeneratedColumn<String>(
      'soil_class', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 9),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _profileDepthMeta =
      const VerificationMeta('profileDepth');
  @override
  late final GeneratedColumn<int> profileDepth = GeneratedColumn<int>(
      'profile_depth', aliasedName, false,
      check: () => profileDepth.isBetweenValues(-1, 250),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _drainageMeta =
      const VerificationMeta('drainage');
  @override
  late final GeneratedColumn<int> drainage = GeneratedColumn<int>(
      'drainage', aliasedName, false,
      check: () => drainage.isBetweenValues(-9, 7),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _moistureMeta =
      const VerificationMeta('moisture');
  @override
  late final GeneratedColumn<int> moisture = GeneratedColumn<int>(
      'moisture', aliasedName, false,
      check: () => moisture.isBetweenValues(-9, 3),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _depositionMeta =
      const VerificationMeta('deposition');
  @override
  late final GeneratedColumn<String> deposition = GeneratedColumn<String>(
      'deposition', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _humusFormMeta =
      const VerificationMeta('humusForm');
  @override
  late final GeneratedColumn<String> humusForm = GeneratedColumn<String>(
      'humus_form', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        soilPitSummaryId,
        soilClass,
        profileDepth,
        drainage,
        moisture,
        deposition,
        humusForm
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_site_info';
  @override
  VerificationContext validateIntegrity(Insertable<SoilSiteInfoData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('soil_pit_summary_id')) {
      context.handle(
          _soilPitSummaryIdMeta,
          soilPitSummaryId.isAcceptableOrUnknown(
              data['soil_pit_summary_id']!, _soilPitSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_soilPitSummaryIdMeta);
    }
    if (data.containsKey('soil_class')) {
      context.handle(_soilClassMeta,
          soilClass.isAcceptableOrUnknown(data['soil_class']!, _soilClassMeta));
    } else if (isInserting) {
      context.missing(_soilClassMeta);
    }
    if (data.containsKey('profile_depth')) {
      context.handle(
          _profileDepthMeta,
          profileDepth.isAcceptableOrUnknown(
              data['profile_depth']!, _profileDepthMeta));
    } else if (isInserting) {
      context.missing(_profileDepthMeta);
    }
    if (data.containsKey('drainage')) {
      context.handle(_drainageMeta,
          drainage.isAcceptableOrUnknown(data['drainage']!, _drainageMeta));
    } else if (isInserting) {
      context.missing(_drainageMeta);
    }
    if (data.containsKey('moisture')) {
      context.handle(_moistureMeta,
          moisture.isAcceptableOrUnknown(data['moisture']!, _moistureMeta));
    } else if (isInserting) {
      context.missing(_moistureMeta);
    }
    if (data.containsKey('deposition')) {
      context.handle(
          _depositionMeta,
          deposition.isAcceptableOrUnknown(
              data['deposition']!, _depositionMeta));
    } else if (isInserting) {
      context.missing(_depositionMeta);
    }
    if (data.containsKey('humus_form')) {
      context.handle(_humusFormMeta,
          humusForm.isAcceptableOrUnknown(data['humus_form']!, _humusFormMeta));
    } else if (isInserting) {
      context.missing(_humusFormMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SoilSiteInfoData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilSiteInfoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      soilPitSummaryId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}soil_pit_summary_id'])!,
      soilClass: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}soil_class'])!,
      profileDepth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}profile_depth'])!,
      drainage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}drainage'])!,
      moisture: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}moisture'])!,
      deposition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deposition'])!,
      humusForm: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}humus_form'])!,
    );
  }

  @override
  $SoilSiteInfoTable createAlias(String alias) {
    return $SoilSiteInfoTable(attachedDatabase, alias);
  }
}

class SoilSiteInfoData extends DataClass
    implements Insertable<SoilSiteInfoData> {
  final int id;
  final int soilPitSummaryId;
  final String soilClass;
  final int profileDepth;
  final int drainage;
  final int moisture;
  final String deposition;
  final String humusForm;
  const SoilSiteInfoData(
      {required this.id,
      required this.soilPitSummaryId,
      required this.soilClass,
      required this.profileDepth,
      required this.drainage,
      required this.moisture,
      required this.deposition,
      required this.humusForm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['soil_pit_summary_id'] = Variable<int>(soilPitSummaryId);
    map['soil_class'] = Variable<String>(soilClass);
    map['profile_depth'] = Variable<int>(profileDepth);
    map['drainage'] = Variable<int>(drainage);
    map['moisture'] = Variable<int>(moisture);
    map['deposition'] = Variable<String>(deposition);
    map['humus_form'] = Variable<String>(humusForm);
    return map;
  }

  SoilSiteInfoCompanion toCompanion(bool nullToAbsent) {
    return SoilSiteInfoCompanion(
      id: Value(id),
      soilPitSummaryId: Value(soilPitSummaryId),
      soilClass: Value(soilClass),
      profileDepth: Value(profileDepth),
      drainage: Value(drainage),
      moisture: Value(moisture),
      deposition: Value(deposition),
      humusForm: Value(humusForm),
    );
  }

  factory SoilSiteInfoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilSiteInfoData(
      id: serializer.fromJson<int>(json['id']),
      soilPitSummaryId: serializer.fromJson<int>(json['soilPitSummaryId']),
      soilClass: serializer.fromJson<String>(json['soilClass']),
      profileDepth: serializer.fromJson<int>(json['profileDepth']),
      drainage: serializer.fromJson<int>(json['drainage']),
      moisture: serializer.fromJson<int>(json['moisture']),
      deposition: serializer.fromJson<String>(json['deposition']),
      humusForm: serializer.fromJson<String>(json['humusForm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soilPitSummaryId': serializer.toJson<int>(soilPitSummaryId),
      'soilClass': serializer.toJson<String>(soilClass),
      'profileDepth': serializer.toJson<int>(profileDepth),
      'drainage': serializer.toJson<int>(drainage),
      'moisture': serializer.toJson<int>(moisture),
      'deposition': serializer.toJson<String>(deposition),
      'humusForm': serializer.toJson<String>(humusForm),
    };
  }

  SoilSiteInfoData copyWith(
          {int? id,
          int? soilPitSummaryId,
          String? soilClass,
          int? profileDepth,
          int? drainage,
          int? moisture,
          String? deposition,
          String? humusForm}) =>
      SoilSiteInfoData(
        id: id ?? this.id,
        soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
        soilClass: soilClass ?? this.soilClass,
        profileDepth: profileDepth ?? this.profileDepth,
        drainage: drainage ?? this.drainage,
        moisture: moisture ?? this.moisture,
        deposition: deposition ?? this.deposition,
        humusForm: humusForm ?? this.humusForm,
      );
  @override
  String toString() {
    return (StringBuffer('SoilSiteInfoData(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilClass: $soilClass, ')
          ..write('profileDepth: $profileDepth, ')
          ..write('drainage: $drainage, ')
          ..write('moisture: $moisture, ')
          ..write('deposition: $deposition, ')
          ..write('humusForm: $humusForm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, soilPitSummaryId, soilClass, profileDepth,
      drainage, moisture, deposition, humusForm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilSiteInfoData &&
          other.id == this.id &&
          other.soilPitSummaryId == this.soilPitSummaryId &&
          other.soilClass == this.soilClass &&
          other.profileDepth == this.profileDepth &&
          other.drainage == this.drainage &&
          other.moisture == this.moisture &&
          other.deposition == this.deposition &&
          other.humusForm == this.humusForm);
}

class SoilSiteInfoCompanion extends UpdateCompanion<SoilSiteInfoData> {
  final Value<int> id;
  final Value<int> soilPitSummaryId;
  final Value<String> soilClass;
  final Value<int> profileDepth;
  final Value<int> drainage;
  final Value<int> moisture;
  final Value<String> deposition;
  final Value<String> humusForm;
  const SoilSiteInfoCompanion({
    this.id = const Value.absent(),
    this.soilPitSummaryId = const Value.absent(),
    this.soilClass = const Value.absent(),
    this.profileDepth = const Value.absent(),
    this.drainage = const Value.absent(),
    this.moisture = const Value.absent(),
    this.deposition = const Value.absent(),
    this.humusForm = const Value.absent(),
  });
  SoilSiteInfoCompanion.insert({
    this.id = const Value.absent(),
    required int soilPitSummaryId,
    required String soilClass,
    required int profileDepth,
    required int drainage,
    required int moisture,
    required String deposition,
    required String humusForm,
  })  : soilPitSummaryId = Value(soilPitSummaryId),
        soilClass = Value(soilClass),
        profileDepth = Value(profileDepth),
        drainage = Value(drainage),
        moisture = Value(moisture),
        deposition = Value(deposition),
        humusForm = Value(humusForm);
  static Insertable<SoilSiteInfoData> custom({
    Expression<int>? id,
    Expression<int>? soilPitSummaryId,
    Expression<String>? soilClass,
    Expression<int>? profileDepth,
    Expression<int>? drainage,
    Expression<int>? moisture,
    Expression<String>? deposition,
    Expression<String>? humusForm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soilPitSummaryId != null) 'soil_pit_summary_id': soilPitSummaryId,
      if (soilClass != null) 'soil_class': soilClass,
      if (profileDepth != null) 'profile_depth': profileDepth,
      if (drainage != null) 'drainage': drainage,
      if (moisture != null) 'moisture': moisture,
      if (deposition != null) 'deposition': deposition,
      if (humusForm != null) 'humus_form': humusForm,
    });
  }

  SoilSiteInfoCompanion copyWith(
      {Value<int>? id,
      Value<int>? soilPitSummaryId,
      Value<String>? soilClass,
      Value<int>? profileDepth,
      Value<int>? drainage,
      Value<int>? moisture,
      Value<String>? deposition,
      Value<String>? humusForm}) {
    return SoilSiteInfoCompanion(
      id: id ?? this.id,
      soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
      soilClass: soilClass ?? this.soilClass,
      profileDepth: profileDepth ?? this.profileDepth,
      drainage: drainage ?? this.drainage,
      moisture: moisture ?? this.moisture,
      deposition: deposition ?? this.deposition,
      humusForm: humusForm ?? this.humusForm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (soilPitSummaryId.present) {
      map['soil_pit_summary_id'] = Variable<int>(soilPitSummaryId.value);
    }
    if (soilClass.present) {
      map['soil_class'] = Variable<String>(soilClass.value);
    }
    if (profileDepth.present) {
      map['profile_depth'] = Variable<int>(profileDepth.value);
    }
    if (drainage.present) {
      map['drainage'] = Variable<int>(drainage.value);
    }
    if (moisture.present) {
      map['moisture'] = Variable<int>(moisture.value);
    }
    if (deposition.present) {
      map['deposition'] = Variable<String>(deposition.value);
    }
    if (humusForm.present) {
      map['humus_form'] = Variable<String>(humusForm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilSiteInfoCompanion(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilClass: $soilClass, ')
          ..write('profileDepth: $profileDepth, ')
          ..write('drainage: $drainage, ')
          ..write('moisture: $moisture, ')
          ..write('deposition: $deposition, ')
          ..write('humusForm: $humusForm')
          ..write(')'))
        .toString();
  }
}

class $SoilPitDepthTable extends SoilPitDepth
    with TableInfo<$SoilPitDepthTable, SoilPitDepthData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilPitDepthTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _soilPitSummaryIdMeta =
      const VerificationMeta('soilPitSummaryId');
  @override
  late final GeneratedColumn<int> soilPitSummaryId = GeneratedColumn<int>(
      'soil_pit_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES soil_pit_summary (id)'));
  static const VerificationMeta _soilPitCodeCompleteMeta =
      const VerificationMeta('soilPitCodeComplete');
  @override
  late final GeneratedColumn<String> soilPitCodeComplete =
      GeneratedColumn<String>('soil_pit_code_complete', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 3),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _depthMinMeta =
      const VerificationMeta('depthMin');
  @override
  late final GeneratedColumn<double> depthMin = GeneratedColumn<double>(
      'depth_min', aliasedName, false,
      check: () => depthMin.isBetweenValues(0.0, 999.9),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _depthOrgMeta =
      const VerificationMeta('depthOrg');
  @override
  late final GeneratedColumn<double> depthOrg = GeneratedColumn<double>(
      'depth_org', aliasedName, false,
      check: () => depthMin.isBetweenValues(0.0, 999.9),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, soilPitSummaryId, soilPitCodeComplete, depthMin, depthOrg];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_pit_depth';
  @override
  VerificationContext validateIntegrity(Insertable<SoilPitDepthData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('soil_pit_summary_id')) {
      context.handle(
          _soilPitSummaryIdMeta,
          soilPitSummaryId.isAcceptableOrUnknown(
              data['soil_pit_summary_id']!, _soilPitSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_soilPitSummaryIdMeta);
    }
    if (data.containsKey('soil_pit_code_complete')) {
      context.handle(
          _soilPitCodeCompleteMeta,
          soilPitCodeComplete.isAcceptableOrUnknown(
              data['soil_pit_code_complete']!, _soilPitCodeCompleteMeta));
    } else if (isInserting) {
      context.missing(_soilPitCodeCompleteMeta);
    }
    if (data.containsKey('depth_min')) {
      context.handle(_depthMinMeta,
          depthMin.isAcceptableOrUnknown(data['depth_min']!, _depthMinMeta));
    } else if (isInserting) {
      context.missing(_depthMinMeta);
    }
    if (data.containsKey('depth_org')) {
      context.handle(_depthOrgMeta,
          depthOrg.isAcceptableOrUnknown(data['depth_org']!, _depthOrgMeta));
    } else if (isInserting) {
      context.missing(_depthOrgMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SoilPitDepthData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilPitDepthData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      soilPitSummaryId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}soil_pit_summary_id'])!,
      soilPitCodeComplete: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}soil_pit_code_complete'])!,
      depthMin: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}depth_min'])!,
      depthOrg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}depth_org'])!,
    );
  }

  @override
  $SoilPitDepthTable createAlias(String alias) {
    return $SoilPitDepthTable(attachedDatabase, alias);
  }
}

class SoilPitDepthData extends DataClass
    implements Insertable<SoilPitDepthData> {
  final int id;
  final int soilPitSummaryId;
  final String soilPitCodeComplete;
  final double depthMin;
  final double depthOrg;
  const SoilPitDepthData(
      {required this.id,
      required this.soilPitSummaryId,
      required this.soilPitCodeComplete,
      required this.depthMin,
      required this.depthOrg});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['soil_pit_summary_id'] = Variable<int>(soilPitSummaryId);
    map['soil_pit_code_complete'] = Variable<String>(soilPitCodeComplete);
    map['depth_min'] = Variable<double>(depthMin);
    map['depth_org'] = Variable<double>(depthOrg);
    return map;
  }

  SoilPitDepthCompanion toCompanion(bool nullToAbsent) {
    return SoilPitDepthCompanion(
      id: Value(id),
      soilPitSummaryId: Value(soilPitSummaryId),
      soilPitCodeComplete: Value(soilPitCodeComplete),
      depthMin: Value(depthMin),
      depthOrg: Value(depthOrg),
    );
  }

  factory SoilPitDepthData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitDepthData(
      id: serializer.fromJson<int>(json['id']),
      soilPitSummaryId: serializer.fromJson<int>(json['soilPitSummaryId']),
      soilPitCodeComplete:
          serializer.fromJson<String>(json['soilPitCodeComplete']),
      depthMin: serializer.fromJson<double>(json['depthMin']),
      depthOrg: serializer.fromJson<double>(json['depthOrg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soilPitSummaryId': serializer.toJson<int>(soilPitSummaryId),
      'soilPitCodeComplete': serializer.toJson<String>(soilPitCodeComplete),
      'depthMin': serializer.toJson<double>(depthMin),
      'depthOrg': serializer.toJson<double>(depthOrg),
    };
  }

  SoilPitDepthData copyWith(
          {int? id,
          int? soilPitSummaryId,
          String? soilPitCodeComplete,
          double? depthMin,
          double? depthOrg}) =>
      SoilPitDepthData(
        id: id ?? this.id,
        soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
        soilPitCodeComplete: soilPitCodeComplete ?? this.soilPitCodeComplete,
        depthMin: depthMin ?? this.depthMin,
        depthOrg: depthOrg ?? this.depthOrg,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitDepthData(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilPitCodeComplete: $soilPitCodeComplete, ')
          ..write('depthMin: $depthMin, ')
          ..write('depthOrg: $depthOrg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, soilPitSummaryId, soilPitCodeComplete, depthMin, depthOrg);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilPitDepthData &&
          other.id == this.id &&
          other.soilPitSummaryId == this.soilPitSummaryId &&
          other.soilPitCodeComplete == this.soilPitCodeComplete &&
          other.depthMin == this.depthMin &&
          other.depthOrg == this.depthOrg);
}

class SoilPitDepthCompanion extends UpdateCompanion<SoilPitDepthData> {
  final Value<int> id;
  final Value<int> soilPitSummaryId;
  final Value<String> soilPitCodeComplete;
  final Value<double> depthMin;
  final Value<double> depthOrg;
  const SoilPitDepthCompanion({
    this.id = const Value.absent(),
    this.soilPitSummaryId = const Value.absent(),
    this.soilPitCodeComplete = const Value.absent(),
    this.depthMin = const Value.absent(),
    this.depthOrg = const Value.absent(),
  });
  SoilPitDepthCompanion.insert({
    this.id = const Value.absent(),
    required int soilPitSummaryId,
    required String soilPitCodeComplete,
    required double depthMin,
    required double depthOrg,
  })  : soilPitSummaryId = Value(soilPitSummaryId),
        soilPitCodeComplete = Value(soilPitCodeComplete),
        depthMin = Value(depthMin),
        depthOrg = Value(depthOrg);
  static Insertable<SoilPitDepthData> custom({
    Expression<int>? id,
    Expression<int>? soilPitSummaryId,
    Expression<String>? soilPitCodeComplete,
    Expression<double>? depthMin,
    Expression<double>? depthOrg,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soilPitSummaryId != null) 'soil_pit_summary_id': soilPitSummaryId,
      if (soilPitCodeComplete != null)
        'soil_pit_code_complete': soilPitCodeComplete,
      if (depthMin != null) 'depth_min': depthMin,
      if (depthOrg != null) 'depth_org': depthOrg,
    });
  }

  SoilPitDepthCompanion copyWith(
      {Value<int>? id,
      Value<int>? soilPitSummaryId,
      Value<String>? soilPitCodeComplete,
      Value<double>? depthMin,
      Value<double>? depthOrg}) {
    return SoilPitDepthCompanion(
      id: id ?? this.id,
      soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
      soilPitCodeComplete: soilPitCodeComplete ?? this.soilPitCodeComplete,
      depthMin: depthMin ?? this.depthMin,
      depthOrg: depthOrg ?? this.depthOrg,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (soilPitSummaryId.present) {
      map['soil_pit_summary_id'] = Variable<int>(soilPitSummaryId.value);
    }
    if (soilPitCodeComplete.present) {
      map['soil_pit_code_complete'] =
          Variable<String>(soilPitCodeComplete.value);
    }
    if (depthMin.present) {
      map['depth_min'] = Variable<double>(depthMin.value);
    }
    if (depthOrg.present) {
      map['depth_org'] = Variable<double>(depthOrg.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilPitDepthCompanion(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilPitCodeComplete: $soilPitCodeComplete, ')
          ..write('depthMin: $depthMin, ')
          ..write('depthOrg: $depthOrg')
          ..write(')'))
        .toString();
  }
}

class $SoilPitFeatureTable extends SoilPitFeature
    with TableInfo<$SoilPitFeatureTable, SoilPitFeatureData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilPitFeatureTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _soilPitSummaryIdMeta =
      const VerificationMeta('soilPitSummaryId');
  @override
  late final GeneratedColumn<int> soilPitSummaryId = GeneratedColumn<int>(
      'soil_pit_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES soil_pit_summary (id)'));
  static const VerificationMeta _soilPitCodeFieldMeta =
      const VerificationMeta('soilPitCodeField');
  @override
  late final GeneratedColumn<String> soilPitCodeField = GeneratedColumn<String>(
      'soil_pit_code_field', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _depthFeatureMeta =
      const VerificationMeta('depthFeature');
  @override
  late final GeneratedColumn<int> depthFeature = GeneratedColumn<int>(
      'depth_feature', aliasedName, false,
      check: () => depthFeature.isBetweenValues(-9, 200),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, soilPitSummaryId, soilPitCodeField, depthFeature];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_pit_feature';
  @override
  VerificationContext validateIntegrity(Insertable<SoilPitFeatureData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('soil_pit_summary_id')) {
      context.handle(
          _soilPitSummaryIdMeta,
          soilPitSummaryId.isAcceptableOrUnknown(
              data['soil_pit_summary_id']!, _soilPitSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_soilPitSummaryIdMeta);
    }
    if (data.containsKey('soil_pit_code_field')) {
      context.handle(
          _soilPitCodeFieldMeta,
          soilPitCodeField.isAcceptableOrUnknown(
              data['soil_pit_code_field']!, _soilPitCodeFieldMeta));
    } else if (isInserting) {
      context.missing(_soilPitCodeFieldMeta);
    }
    if (data.containsKey('depth_feature')) {
      context.handle(
          _depthFeatureMeta,
          depthFeature.isAcceptableOrUnknown(
              data['depth_feature']!, _depthFeatureMeta));
    } else if (isInserting) {
      context.missing(_depthFeatureMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SoilPitFeatureData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilPitFeatureData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      soilPitSummaryId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}soil_pit_summary_id'])!,
      soilPitCodeField: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}soil_pit_code_field'])!,
      depthFeature: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}depth_feature'])!,
    );
  }

  @override
  $SoilPitFeatureTable createAlias(String alias) {
    return $SoilPitFeatureTable(attachedDatabase, alias);
  }
}

class SoilPitFeatureData extends DataClass
    implements Insertable<SoilPitFeatureData> {
  final int id;
  final int soilPitSummaryId;
  final String soilPitCodeField;
  final int depthFeature;
  const SoilPitFeatureData(
      {required this.id,
      required this.soilPitSummaryId,
      required this.soilPitCodeField,
      required this.depthFeature});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['soil_pit_summary_id'] = Variable<int>(soilPitSummaryId);
    map['soil_pit_code_field'] = Variable<String>(soilPitCodeField);
    map['depth_feature'] = Variable<int>(depthFeature);
    return map;
  }

  SoilPitFeatureCompanion toCompanion(bool nullToAbsent) {
    return SoilPitFeatureCompanion(
      id: Value(id),
      soilPitSummaryId: Value(soilPitSummaryId),
      soilPitCodeField: Value(soilPitCodeField),
      depthFeature: Value(depthFeature),
    );
  }

  factory SoilPitFeatureData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitFeatureData(
      id: serializer.fromJson<int>(json['id']),
      soilPitSummaryId: serializer.fromJson<int>(json['soilPitSummaryId']),
      soilPitCodeField: serializer.fromJson<String>(json['soilPitCodeField']),
      depthFeature: serializer.fromJson<int>(json['depthFeature']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soilPitSummaryId': serializer.toJson<int>(soilPitSummaryId),
      'soilPitCodeField': serializer.toJson<String>(soilPitCodeField),
      'depthFeature': serializer.toJson<int>(depthFeature),
    };
  }

  SoilPitFeatureData copyWith(
          {int? id,
          int? soilPitSummaryId,
          String? soilPitCodeField,
          int? depthFeature}) =>
      SoilPitFeatureData(
        id: id ?? this.id,
        soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
        soilPitCodeField: soilPitCodeField ?? this.soilPitCodeField,
        depthFeature: depthFeature ?? this.depthFeature,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitFeatureData(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilPitCodeField: $soilPitCodeField, ')
          ..write('depthFeature: $depthFeature')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, soilPitSummaryId, soilPitCodeField, depthFeature);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilPitFeatureData &&
          other.id == this.id &&
          other.soilPitSummaryId == this.soilPitSummaryId &&
          other.soilPitCodeField == this.soilPitCodeField &&
          other.depthFeature == this.depthFeature);
}

class SoilPitFeatureCompanion extends UpdateCompanion<SoilPitFeatureData> {
  final Value<int> id;
  final Value<int> soilPitSummaryId;
  final Value<String> soilPitCodeField;
  final Value<int> depthFeature;
  const SoilPitFeatureCompanion({
    this.id = const Value.absent(),
    this.soilPitSummaryId = const Value.absent(),
    this.soilPitCodeField = const Value.absent(),
    this.depthFeature = const Value.absent(),
  });
  SoilPitFeatureCompanion.insert({
    this.id = const Value.absent(),
    required int soilPitSummaryId,
    required String soilPitCodeField,
    required int depthFeature,
  })  : soilPitSummaryId = Value(soilPitSummaryId),
        soilPitCodeField = Value(soilPitCodeField),
        depthFeature = Value(depthFeature);
  static Insertable<SoilPitFeatureData> custom({
    Expression<int>? id,
    Expression<int>? soilPitSummaryId,
    Expression<String>? soilPitCodeField,
    Expression<int>? depthFeature,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soilPitSummaryId != null) 'soil_pit_summary_id': soilPitSummaryId,
      if (soilPitCodeField != null) 'soil_pit_code_field': soilPitCodeField,
      if (depthFeature != null) 'depth_feature': depthFeature,
    });
  }

  SoilPitFeatureCompanion copyWith(
      {Value<int>? id,
      Value<int>? soilPitSummaryId,
      Value<String>? soilPitCodeField,
      Value<int>? depthFeature}) {
    return SoilPitFeatureCompanion(
      id: id ?? this.id,
      soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
      soilPitCodeField: soilPitCodeField ?? this.soilPitCodeField,
      depthFeature: depthFeature ?? this.depthFeature,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (soilPitSummaryId.present) {
      map['soil_pit_summary_id'] = Variable<int>(soilPitSummaryId.value);
    }
    if (soilPitCodeField.present) {
      map['soil_pit_code_field'] = Variable<String>(soilPitCodeField.value);
    }
    if (depthFeature.present) {
      map['depth_feature'] = Variable<int>(depthFeature.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilPitFeatureCompanion(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilPitCodeField: $soilPitCodeField, ')
          ..write('depthFeature: $depthFeature')
          ..write(')'))
        .toString();
  }
}

class $SoilPitHorizonDescriptionTable extends SoilPitHorizonDescription
    with
        TableInfo<$SoilPitHorizonDescriptionTable,
            SoilPitHorizonDescriptionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilPitHorizonDescriptionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _soilPitSummaryIdMeta =
      const VerificationMeta('soilPitSummaryId');
  @override
  late final GeneratedColumn<int> soilPitSummaryId = GeneratedColumn<int>(
      'soil_pit_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES soil_pit_summary (id)'));
  static const VerificationMeta _soilPitCodeCompleteMeta =
      const VerificationMeta('soilPitCodeComplete');
  @override
  late final GeneratedColumn<String> soilPitCodeComplete =
      GeneratedColumn<String>('soil_pit_code_complete', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 3),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  static const VerificationMeta _horizonNumMeta =
      const VerificationMeta('horizonNum');
  @override
  late final GeneratedColumn<int> horizonNum = GeneratedColumn<int>(
      'horizon_num', aliasedName, false,
      check: () => horizonNum.isBetweenValues(1, 99),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _horizonMeta =
      const VerificationMeta('horizon');
  @override
  late final GeneratedColumn<String> horizon = GeneratedColumn<String>(
      'horizon', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 6),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _horizonUpperMeta =
      const VerificationMeta('horizonUpper');
  @override
  late final GeneratedColumn<double> horizonUpper = GeneratedColumn<double>(
      'horizon_upper', aliasedName, false,
      check: () => horizonUpper.isBetweenValues(-1, 200.0),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _thicknessMeta =
      const VerificationMeta('thickness');
  @override
  late final GeneratedColumn<double> thickness = GeneratedColumn<double>(
      'thickness', aliasedName, false,
      check: () => thickness.isBetweenValues(-1, 300.0),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _textureMeta =
      const VerificationMeta('texture');
  @override
  late final GeneratedColumn<String> texture = GeneratedColumn<String>(
      'texture', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 5),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        soilPitSummaryId,
        soilPitCodeComplete,
        horizonNum,
        horizon,
        horizonUpper,
        thickness,
        color,
        texture
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'soil_pit_horizon_description';
  @override
  VerificationContext validateIntegrity(
      Insertable<SoilPitHorizonDescriptionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('soil_pit_summary_id')) {
      context.handle(
          _soilPitSummaryIdMeta,
          soilPitSummaryId.isAcceptableOrUnknown(
              data['soil_pit_summary_id']!, _soilPitSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_soilPitSummaryIdMeta);
    }
    if (data.containsKey('soil_pit_code_complete')) {
      context.handle(
          _soilPitCodeCompleteMeta,
          soilPitCodeComplete.isAcceptableOrUnknown(
              data['soil_pit_code_complete']!, _soilPitCodeCompleteMeta));
    } else if (isInserting) {
      context.missing(_soilPitCodeCompleteMeta);
    }
    if (data.containsKey('horizon_num')) {
      context.handle(
          _horizonNumMeta,
          horizonNum.isAcceptableOrUnknown(
              data['horizon_num']!, _horizonNumMeta));
    } else if (isInserting) {
      context.missing(_horizonNumMeta);
    }
    if (data.containsKey('horizon')) {
      context.handle(_horizonMeta,
          horizon.isAcceptableOrUnknown(data['horizon']!, _horizonMeta));
    } else if (isInserting) {
      context.missing(_horizonMeta);
    }
    if (data.containsKey('horizon_upper')) {
      context.handle(
          _horizonUpperMeta,
          horizonUpper.isAcceptableOrUnknown(
              data['horizon_upper']!, _horizonUpperMeta));
    } else if (isInserting) {
      context.missing(_horizonUpperMeta);
    }
    if (data.containsKey('thickness')) {
      context.handle(_thicknessMeta,
          thickness.isAcceptableOrUnknown(data['thickness']!, _thicknessMeta));
    } else if (isInserting) {
      context.missing(_thicknessMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('texture')) {
      context.handle(_textureMeta,
          texture.isAcceptableOrUnknown(data['texture']!, _textureMeta));
    } else if (isInserting) {
      context.missing(_textureMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SoilPitHorizonDescriptionData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilPitHorizonDescriptionData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      soilPitSummaryId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}soil_pit_summary_id'])!,
      soilPitCodeComplete: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}soil_pit_code_complete'])!,
      horizonNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}horizon_num'])!,
      horizon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}horizon'])!,
      horizonUpper: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}horizon_upper'])!,
      thickness: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}thickness'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      texture: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}texture'])!,
    );
  }

  @override
  $SoilPitHorizonDescriptionTable createAlias(String alias) {
    return $SoilPitHorizonDescriptionTable(attachedDatabase, alias);
  }
}

class SoilPitHorizonDescriptionData extends DataClass
    implements Insertable<SoilPitHorizonDescriptionData> {
  final int id;
  final int soilPitSummaryId;
  final String soilPitCodeComplete;
  final int horizonNum;
  final String horizon;
  final double horizonUpper;
  final double thickness;
  final String color;
  final String texture;
  const SoilPitHorizonDescriptionData(
      {required this.id,
      required this.soilPitSummaryId,
      required this.soilPitCodeComplete,
      required this.horizonNum,
      required this.horizon,
      required this.horizonUpper,
      required this.thickness,
      required this.color,
      required this.texture});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['soil_pit_summary_id'] = Variable<int>(soilPitSummaryId);
    map['soil_pit_code_complete'] = Variable<String>(soilPitCodeComplete);
    map['horizon_num'] = Variable<int>(horizonNum);
    map['horizon'] = Variable<String>(horizon);
    map['horizon_upper'] = Variable<double>(horizonUpper);
    map['thickness'] = Variable<double>(thickness);
    map['color'] = Variable<String>(color);
    map['texture'] = Variable<String>(texture);
    return map;
  }

  SoilPitHorizonDescriptionCompanion toCompanion(bool nullToAbsent) {
    return SoilPitHorizonDescriptionCompanion(
      id: Value(id),
      soilPitSummaryId: Value(soilPitSummaryId),
      soilPitCodeComplete: Value(soilPitCodeComplete),
      horizonNum: Value(horizonNum),
      horizon: Value(horizon),
      horizonUpper: Value(horizonUpper),
      thickness: Value(thickness),
      color: Value(color),
      texture: Value(texture),
    );
  }

  factory SoilPitHorizonDescriptionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitHorizonDescriptionData(
      id: serializer.fromJson<int>(json['id']),
      soilPitSummaryId: serializer.fromJson<int>(json['soilPitSummaryId']),
      soilPitCodeComplete:
          serializer.fromJson<String>(json['soilPitCodeComplete']),
      horizonNum: serializer.fromJson<int>(json['horizonNum']),
      horizon: serializer.fromJson<String>(json['horizon']),
      horizonUpper: serializer.fromJson<double>(json['horizonUpper']),
      thickness: serializer.fromJson<double>(json['thickness']),
      color: serializer.fromJson<String>(json['color']),
      texture: serializer.fromJson<String>(json['texture']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soilPitSummaryId': serializer.toJson<int>(soilPitSummaryId),
      'soilPitCodeComplete': serializer.toJson<String>(soilPitCodeComplete),
      'horizonNum': serializer.toJson<int>(horizonNum),
      'horizon': serializer.toJson<String>(horizon),
      'horizonUpper': serializer.toJson<double>(horizonUpper),
      'thickness': serializer.toJson<double>(thickness),
      'color': serializer.toJson<String>(color),
      'texture': serializer.toJson<String>(texture),
    };
  }

  SoilPitHorizonDescriptionData copyWith(
          {int? id,
          int? soilPitSummaryId,
          String? soilPitCodeComplete,
          int? horizonNum,
          String? horizon,
          double? horizonUpper,
          double? thickness,
          String? color,
          String? texture}) =>
      SoilPitHorizonDescriptionData(
        id: id ?? this.id,
        soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
        soilPitCodeComplete: soilPitCodeComplete ?? this.soilPitCodeComplete,
        horizonNum: horizonNum ?? this.horizonNum,
        horizon: horizon ?? this.horizon,
        horizonUpper: horizonUpper ?? this.horizonUpper,
        thickness: thickness ?? this.thickness,
        color: color ?? this.color,
        texture: texture ?? this.texture,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitHorizonDescriptionData(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilPitCodeComplete: $soilPitCodeComplete, ')
          ..write('horizonNum: $horizonNum, ')
          ..write('horizon: $horizon, ')
          ..write('horizonUpper: $horizonUpper, ')
          ..write('thickness: $thickness, ')
          ..write('color: $color, ')
          ..write('texture: $texture')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, soilPitSummaryId, soilPitCodeComplete,
      horizonNum, horizon, horizonUpper, thickness, color, texture);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilPitHorizonDescriptionData &&
          other.id == this.id &&
          other.soilPitSummaryId == this.soilPitSummaryId &&
          other.soilPitCodeComplete == this.soilPitCodeComplete &&
          other.horizonNum == this.horizonNum &&
          other.horizon == this.horizon &&
          other.horizonUpper == this.horizonUpper &&
          other.thickness == this.thickness &&
          other.color == this.color &&
          other.texture == this.texture);
}

class SoilPitHorizonDescriptionCompanion
    extends UpdateCompanion<SoilPitHorizonDescriptionData> {
  final Value<int> id;
  final Value<int> soilPitSummaryId;
  final Value<String> soilPitCodeComplete;
  final Value<int> horizonNum;
  final Value<String> horizon;
  final Value<double> horizonUpper;
  final Value<double> thickness;
  final Value<String> color;
  final Value<String> texture;
  const SoilPitHorizonDescriptionCompanion({
    this.id = const Value.absent(),
    this.soilPitSummaryId = const Value.absent(),
    this.soilPitCodeComplete = const Value.absent(),
    this.horizonNum = const Value.absent(),
    this.horizon = const Value.absent(),
    this.horizonUpper = const Value.absent(),
    this.thickness = const Value.absent(),
    this.color = const Value.absent(),
    this.texture = const Value.absent(),
  });
  SoilPitHorizonDescriptionCompanion.insert({
    this.id = const Value.absent(),
    required int soilPitSummaryId,
    required String soilPitCodeComplete,
    required int horizonNum,
    required String horizon,
    required double horizonUpper,
    required double thickness,
    required String color,
    required String texture,
  })  : soilPitSummaryId = Value(soilPitSummaryId),
        soilPitCodeComplete = Value(soilPitCodeComplete),
        horizonNum = Value(horizonNum),
        horizon = Value(horizon),
        horizonUpper = Value(horizonUpper),
        thickness = Value(thickness),
        color = Value(color),
        texture = Value(texture);
  static Insertable<SoilPitHorizonDescriptionData> custom({
    Expression<int>? id,
    Expression<int>? soilPitSummaryId,
    Expression<String>? soilPitCodeComplete,
    Expression<int>? horizonNum,
    Expression<String>? horizon,
    Expression<double>? horizonUpper,
    Expression<double>? thickness,
    Expression<String>? color,
    Expression<String>? texture,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soilPitSummaryId != null) 'soil_pit_summary_id': soilPitSummaryId,
      if (soilPitCodeComplete != null)
        'soil_pit_code_complete': soilPitCodeComplete,
      if (horizonNum != null) 'horizon_num': horizonNum,
      if (horizon != null) 'horizon': horizon,
      if (horizonUpper != null) 'horizon_upper': horizonUpper,
      if (thickness != null) 'thickness': thickness,
      if (color != null) 'color': color,
      if (texture != null) 'texture': texture,
    });
  }

  SoilPitHorizonDescriptionCompanion copyWith(
      {Value<int>? id,
      Value<int>? soilPitSummaryId,
      Value<String>? soilPitCodeComplete,
      Value<int>? horizonNum,
      Value<String>? horizon,
      Value<double>? horizonUpper,
      Value<double>? thickness,
      Value<String>? color,
      Value<String>? texture}) {
    return SoilPitHorizonDescriptionCompanion(
      id: id ?? this.id,
      soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
      soilPitCodeComplete: soilPitCodeComplete ?? this.soilPitCodeComplete,
      horizonNum: horizonNum ?? this.horizonNum,
      horizon: horizon ?? this.horizon,
      horizonUpper: horizonUpper ?? this.horizonUpper,
      thickness: thickness ?? this.thickness,
      color: color ?? this.color,
      texture: texture ?? this.texture,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (soilPitSummaryId.present) {
      map['soil_pit_summary_id'] = Variable<int>(soilPitSummaryId.value);
    }
    if (soilPitCodeComplete.present) {
      map['soil_pit_code_complete'] =
          Variable<String>(soilPitCodeComplete.value);
    }
    if (horizonNum.present) {
      map['horizon_num'] = Variable<int>(horizonNum.value);
    }
    if (horizon.present) {
      map['horizon'] = Variable<String>(horizon.value);
    }
    if (horizonUpper.present) {
      map['horizon_upper'] = Variable<double>(horizonUpper.value);
    }
    if (thickness.present) {
      map['thickness'] = Variable<double>(thickness.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (texture.present) {
      map['texture'] = Variable<String>(texture.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilPitHorizonDescriptionCompanion(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilPitCodeComplete: $soilPitCodeComplete, ')
          ..write('horizonNum: $horizonNum, ')
          ..write('horizon: $horizon, ')
          ..write('horizonUpper: $horizonUpper, ')
          ..write('thickness: $thickness, ')
          ..write('color: $color, ')
          ..write('texture: $texture')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $JurisdictionsTable jurisdictions = $JurisdictionsTable(this);
  late final $PlotsTable plots = $PlotsTable(this);
  late final $TreeGenusTable treeGenus = $TreeGenusTable(this);
  late final $SubstrateTypeTable substrateType = $SubstrateTypeTable(this);
  late final $SsDepthLimitTable ssDepthLimit = $SsDepthLimitTable(this);
  late final $EcpGenusTable ecpGenus = $EcpGenusTable(this);
  late final $EcpLayerTable ecpLayer = $EcpLayerTable(this);
  late final $SoilPitClassificationTable soilPitClassification =
      $SoilPitClassificationTable(this);
  late final $SoilDrainageClassTable soilDrainageClass =
      $SoilDrainageClassTable(this);
  late final $SoilMoistureClassTable soilMoistureClass =
      $SoilMoistureClassTable(this);
  late final $SoilDepositionTable soilDeposition = $SoilDepositionTable(this);
  late final $SoilHumusFormTable soilHumusForm = $SoilHumusFormTable(this);
  late final $SoilPitCodeCompletedTable soilPitCodeCompleted =
      $SoilPitCodeCompletedTable(this);
  late final $SoilPitCodeFieldTable soilPitCodeField =
      $SoilPitCodeFieldTable(this);
  late final $SoilPitFeatureClassTable soilPitFeatureClass =
      $SoilPitFeatureClassTable(this);
  late final $SoilHorizonDesignationTable soilHorizonDesignation =
      $SoilHorizonDesignationTable(this);
  late final $SoilColorTable soilColor = $SoilColorTable(this);
  late final $SoilTextureTable soilTexture = $SoilTextureTable(this);
  late final $SurveyHeadersTable surveyHeaders = $SurveyHeadersTable(this);
  late final $MetaCommentTable metaComment = $MetaCommentTable(this);
  late final $WoodyDebrisSummaryTable woodyDebrisSummary =
      $WoodyDebrisSummaryTable(this);
  late final $WoodyDebrisHeaderTable woodyDebrisHeader =
      $WoodyDebrisHeaderTable(this);
  late final $WoodyDebrisSmallTable woodyDebrisSmall =
      $WoodyDebrisSmallTable(this);
  late final $WoodyDebrisOddTable woodyDebrisOdd = $WoodyDebrisOddTable(this);
  late final $WoodyDebrisRoundTable woodyDebrisRound =
      $WoodyDebrisRoundTable(this);
  late final $SurfaceSubstrateSummaryTable surfaceSubstrateSummary =
      $SurfaceSubstrateSummaryTable(this);
  late final $SurfaceSubstrateHeaderTable surfaceSubstrateHeader =
      $SurfaceSubstrateHeaderTable(this);
  late final $SurfaceSubstrateTallyTable surfaceSubstrateTally =
      $SurfaceSubstrateTallyTable(this);
  late final $EcpSummaryTable ecpSummary = $EcpSummaryTable(this);
  late final $EcpHeaderTable ecpHeader = $EcpHeaderTable(this);
  late final $EcpSpeciesTable ecpSpecies = $EcpSpeciesTable(this);
  late final $SoilPitSummaryTable soilPitSummary = $SoilPitSummaryTable(this);
  late final $SoilSiteInfoTable soilSiteInfo = $SoilSiteInfoTable(this);
  late final $SoilPitDepthTable soilPitDepth = $SoilPitDepthTable(this);
  late final $SoilPitFeatureTable soilPitFeature = $SoilPitFeatureTable(this);
  late final $SoilPitHorizonDescriptionTable soilPitHorizonDescription =
      $SoilPitHorizonDescriptionTable(this);
  late final ReferenceTablesDao referenceTablesDao =
      ReferenceTablesDao(this as Database);
  late final SurveyInfoTablesDao surveyInfoTablesDao =
      SurveyInfoTablesDao(this as Database);
  late final WoodyDebrisTablesDao woodyDebrisTablesDao =
      WoodyDebrisTablesDao(this as Database);
  late final SurfaceSubstrateTablesDao surfaceSubstrateTablesDao =
      SurfaceSubstrateTablesDao(this as Database);
  late final EcologicalPlotTablesDao ecologicalPlotTablesDao =
      EcologicalPlotTablesDao(this as Database);
  late final SoilPitTablesDao soilPitTablesDao =
      SoilPitTablesDao(this as Database);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        jurisdictions,
        plots,
        treeGenus,
        substrateType,
        ssDepthLimit,
        ecpGenus,
        ecpLayer,
        soilPitClassification,
        soilDrainageClass,
        soilMoistureClass,
        soilDeposition,
        soilHumusForm,
        soilPitCodeCompleted,
        soilPitCodeField,
        soilPitFeatureClass,
        soilHorizonDesignation,
        soilColor,
        soilTexture,
        surveyHeaders,
        metaComment,
        woodyDebrisSummary,
        woodyDebrisHeader,
        woodyDebrisSmall,
        woodyDebrisOdd,
        woodyDebrisRound,
        surfaceSubstrateSummary,
        surfaceSubstrateHeader,
        surfaceSubstrateTally,
        ecpSummary,
        ecpHeader,
        ecpSpecies,
        soilPitSummary,
        soilSiteInfo,
        soilPitDepth,
        soilPitFeature,
        soilPitHorizonDescription
      ];
}
