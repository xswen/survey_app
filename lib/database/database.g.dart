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

class $EcpPlotTypeTable extends EcpPlotType
    with TableInfo<$EcpPlotTypeTable, EcpPlotTypeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EcpPlotTypeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ecp_plot_type';
  @override
  VerificationContext validateIntegrity(Insertable<EcpPlotTypeData> instance,
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
  EcpPlotTypeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EcpPlotTypeData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $EcpPlotTypeTable createAlias(String alias) {
    return $EcpPlotTypeTable(attachedDatabase, alias);
  }
}

class EcpPlotTypeData extends DataClass implements Insertable<EcpPlotTypeData> {
  final String code;
  final String name;
  const EcpPlotTypeData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  EcpPlotTypeCompanion toCompanion(bool nullToAbsent) {
    return EcpPlotTypeCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory EcpPlotTypeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EcpPlotTypeData(
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

  EcpPlotTypeData copyWith({String? code, String? name}) => EcpPlotTypeData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('EcpPlotTypeData(')
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
      (other is EcpPlotTypeData &&
          other.code == this.code &&
          other.name == this.name);
}

class EcpPlotTypeCompanion extends UpdateCompanion<EcpPlotTypeData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const EcpPlotTypeCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EcpPlotTypeCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<EcpPlotTypeData> custom({
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

  EcpPlotTypeCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return EcpPlotTypeCompanion(
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
    return (StringBuffer('EcpPlotTypeCompanion(')
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
      'sub_group', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
    } else if (isInserting) {
      context.missing(_subGroupMeta);
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
          .read(DriftSqlType.string, data['${effectivePrefix}sub_group'])!,
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
  final String subGroup;
  const SoilPitClassificationData(
      {required this.code,
      required this.order,
      required this.greatGroup,
      required this.subGroup});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['order'] = Variable<String>(order);
    map['great_group'] = Variable<String>(greatGroup);
    map['sub_group'] = Variable<String>(subGroup);
    return map;
  }

  SoilPitClassificationCompanion toCompanion(bool nullToAbsent) {
    return SoilPitClassificationCompanion(
      code: Value(code),
      order: Value(order),
      greatGroup: Value(greatGroup),
      subGroup: Value(subGroup),
    );
  }

  factory SoilPitClassificationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitClassificationData(
      code: serializer.fromJson<String>(json['code']),
      order: serializer.fromJson<String>(json['order']),
      greatGroup: serializer.fromJson<String>(json['greatGroup']),
      subGroup: serializer.fromJson<String>(json['subGroup']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'order': serializer.toJson<String>(order),
      'greatGroup': serializer.toJson<String>(greatGroup),
      'subGroup': serializer.toJson<String>(subGroup),
    };
  }

  SoilPitClassificationData copyWith(
          {String? code,
          String? order,
          String? greatGroup,
          String? subGroup}) =>
      SoilPitClassificationData(
        code: code ?? this.code,
        order: order ?? this.order,
        greatGroup: greatGroup ?? this.greatGroup,
        subGroup: subGroup ?? this.subGroup,
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
  final Value<String> subGroup;
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
    required String subGroup,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        order = Value(order),
        greatGroup = Value(greatGroup),
        subGroup = Value(subGroup);
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
      Value<String>? subGroup,
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

class $SoilPitCodeTable extends SoilPitCode
    with TableInfo<$SoilPitCodeTable, SoilPitCodeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SoilPitCodeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'soil_pit_code';
  @override
  VerificationContext validateIntegrity(Insertable<SoilPitCodeData> instance,
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
  SoilPitCodeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SoilPitCodeData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $SoilPitCodeTable createAlias(String alias) {
    return $SoilPitCodeTable(attachedDatabase, alias);
  }
}

class SoilPitCodeData extends DataClass implements Insertable<SoilPitCodeData> {
  final String code;
  final String name;
  const SoilPitCodeData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  SoilPitCodeCompanion toCompanion(bool nullToAbsent) {
    return SoilPitCodeCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory SoilPitCodeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitCodeData(
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

  SoilPitCodeData copyWith({String? code, String? name}) => SoilPitCodeData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitCodeData(')
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
      (other is SoilPitCodeData &&
          other.code == this.code &&
          other.name == this.name);
}

class SoilPitCodeCompanion extends UpdateCompanion<SoilPitCodeData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const SoilPitCodeCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SoilPitCodeCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<SoilPitCodeData> custom({
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

  SoilPitCodeCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return SoilPitCodeCompanion(
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
    return (StringBuffer('SoilPitCodeCompanion(')
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

class $StpTypeTable extends StpType with TableInfo<$StpTypeTable, StpTypeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StpTypeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'stp_type';
  @override
  VerificationContext validateIntegrity(Insertable<StpTypeData> instance,
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
  StpTypeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StpTypeData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $StpTypeTable createAlias(String alias) {
    return $StpTypeTable(attachedDatabase, alias);
  }
}

class StpTypeData extends DataClass implements Insertable<StpTypeData> {
  final String code;
  final String name;
  const StpTypeData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  StpTypeCompanion toCompanion(bool nullToAbsent) {
    return StpTypeCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory StpTypeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StpTypeData(
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

  StpTypeData copyWith({String? code, String? name}) => StpTypeData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('StpTypeData(')
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
      (other is StpTypeData &&
          other.code == this.code &&
          other.name == this.name);
}

class StpTypeCompanion extends UpdateCompanion<StpTypeData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const StpTypeCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StpTypeCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<StpTypeData> custom({
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

  StpTypeCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return StpTypeCompanion(
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
    return (StringBuffer('StpTypeCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StpOrigPlotAreaTable extends StpOrigPlotArea
    with TableInfo<$StpOrigPlotAreaTable, StpOrigPlotAreaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StpOrigPlotAreaTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'stp_orig_plot_area';
  @override
  VerificationContext validateIntegrity(
      Insertable<StpOrigPlotAreaData> instance,
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
  StpOrigPlotAreaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StpOrigPlotAreaData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $StpOrigPlotAreaTable createAlias(String alias) {
    return $StpOrigPlotAreaTable(attachedDatabase, alias);
  }
}

class StpOrigPlotAreaData extends DataClass
    implements Insertable<StpOrigPlotAreaData> {
  final String code;
  final String name;
  const StpOrigPlotAreaData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  StpOrigPlotAreaCompanion toCompanion(bool nullToAbsent) {
    return StpOrigPlotAreaCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory StpOrigPlotAreaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StpOrigPlotAreaData(
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

  StpOrigPlotAreaData copyWith({String? code, String? name}) =>
      StpOrigPlotAreaData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('StpOrigPlotAreaData(')
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
      (other is StpOrigPlotAreaData &&
          other.code == this.code &&
          other.name == this.name);
}

class StpOrigPlotAreaCompanion extends UpdateCompanion<StpOrigPlotAreaData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const StpOrigPlotAreaCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StpOrigPlotAreaCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<StpOrigPlotAreaData> custom({
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

  StpOrigPlotAreaCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return StpOrigPlotAreaCompanion(
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
    return (StringBuffer('StpOrigPlotAreaCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StpStatusFieldTable extends StpStatusField
    with TableInfo<$StpStatusFieldTable, StpStatusFieldData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StpStatusFieldTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stp_status_field';
  @override
  VerificationContext validateIntegrity(Insertable<StpStatusFieldData> instance,
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
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  StpStatusFieldData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StpStatusFieldData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $StpStatusFieldTable createAlias(String alias) {
    return $StpStatusFieldTable(attachedDatabase, alias);
  }
}

class StpStatusFieldData extends DataClass
    implements Insertable<StpStatusFieldData> {
  final String code;
  final String name;
  final String description;
  const StpStatusFieldData(
      {required this.code, required this.name, required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    return map;
  }

  StpStatusFieldCompanion toCompanion(bool nullToAbsent) {
    return StpStatusFieldCompanion(
      code: Value(code),
      name: Value(name),
      description: Value(description),
    );
  }

  factory StpStatusFieldData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StpStatusFieldData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  StpStatusFieldData copyWith(
          {String? code, String? name, String? description}) =>
      StpStatusFieldData(
        code: code ?? this.code,
        name: name ?? this.name,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('StpStatusFieldData(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StpStatusFieldData &&
          other.code == this.code &&
          other.name == this.name &&
          other.description == this.description);
}

class StpStatusFieldCompanion extends UpdateCompanion<StpStatusFieldData> {
  final Value<String> code;
  final Value<String> name;
  final Value<String> description;
  final Value<int> rowid;
  const StpStatusFieldCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StpStatusFieldCompanion.insert({
    required String code,
    required String name,
    required String description,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name),
        description = Value(description);
  static Insertable<StpStatusFieldData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StpStatusFieldCompanion copyWith(
      {Value<String>? code,
      Value<String>? name,
      Value<String>? description,
      Value<int>? rowid}) {
    return StpStatusFieldCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StpStatusFieldCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StpHeightTable extends StpHeight
    with TableInfo<$StpHeightTable, StpHeightData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StpHeightTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'stp_height';
  @override
  VerificationContext validateIntegrity(Insertable<StpHeightData> instance,
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
  StpHeightData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StpHeightData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $StpHeightTable createAlias(String alias) {
    return $StpHeightTable(attachedDatabase, alias);
  }
}

class StpHeightData extends DataClass implements Insertable<StpHeightData> {
  final String code;
  final String name;
  const StpHeightData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  StpHeightCompanion toCompanion(bool nullToAbsent) {
    return StpHeightCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory StpHeightData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StpHeightData(
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

  StpHeightData copyWith({String? code, String? name}) => StpHeightData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('StpHeightData(')
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
      (other is StpHeightData &&
          other.code == this.code &&
          other.name == this.name);
}

class StpHeightCompanion extends UpdateCompanion<StpHeightData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const StpHeightCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StpHeightCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<StpHeightData> custom({
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

  StpHeightCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return StpHeightCompanion(
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
    return (StringBuffer('StpHeightCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StpStemConditionTable extends StpStemCondition
    with TableInfo<$StpStemConditionTable, StpStemConditionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StpStemConditionTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'stp_stem_condition';
  @override
  VerificationContext validateIntegrity(
      Insertable<StpStemConditionData> instance,
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
  StpStemConditionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StpStemConditionData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $StpStemConditionTable createAlias(String alias) {
    return $StpStemConditionTable(attachedDatabase, alias);
  }
}

class StpStemConditionData extends DataClass
    implements Insertable<StpStemConditionData> {
  final String code;
  final String name;
  const StpStemConditionData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  StpStemConditionCompanion toCompanion(bool nullToAbsent) {
    return StpStemConditionCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory StpStemConditionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StpStemConditionData(
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

  StpStemConditionData copyWith({String? code, String? name}) =>
      StpStemConditionData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('StpStemConditionData(')
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
      (other is StpStemConditionData &&
          other.code == this.code &&
          other.name == this.name);
}

class StpStemConditionCompanion extends UpdateCompanion<StpStemConditionData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const StpStemConditionCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StpStemConditionCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<StpStemConditionData> custom({
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

  StpStemConditionCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return StpStemConditionCompanion(
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
    return (StringBuffer('StpStemConditionCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShrubPlotTypeTable extends ShrubPlotType
    with TableInfo<$ShrubPlotTypeTable, ShrubPlotTypeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShrubPlotTypeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'shrub_plot_type';
  @override
  VerificationContext validateIntegrity(Insertable<ShrubPlotTypeData> instance,
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
  ShrubPlotTypeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShrubPlotTypeData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ShrubPlotTypeTable createAlias(String alias) {
    return $ShrubPlotTypeTable(attachedDatabase, alias);
  }
}

class ShrubPlotTypeData extends DataClass
    implements Insertable<ShrubPlotTypeData> {
  final String code;
  final String name;
  const ShrubPlotTypeData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  ShrubPlotTypeCompanion toCompanion(bool nullToAbsent) {
    return ShrubPlotTypeCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory ShrubPlotTypeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShrubPlotTypeData(
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

  ShrubPlotTypeData copyWith({String? code, String? name}) => ShrubPlotTypeData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('ShrubPlotTypeData(')
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
      (other is ShrubPlotTypeData &&
          other.code == this.code &&
          other.name == this.name);
}

class ShrubPlotTypeCompanion extends UpdateCompanion<ShrubPlotTypeData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const ShrubPlotTypeCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShrubPlotTypeCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<ShrubPlotTypeData> custom({
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

  ShrubPlotTypeCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return ShrubPlotTypeCompanion(
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
    return (StringBuffer('ShrubPlotTypeCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShrubStatusFieldTable extends ShrubStatusField
    with TableInfo<$ShrubStatusFieldTable, ShrubStatusFieldData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShrubStatusFieldTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'shrub_status_field';
  @override
  VerificationContext validateIntegrity(
      Insertable<ShrubStatusFieldData> instance,
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
  ShrubStatusFieldData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShrubStatusFieldData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ShrubStatusFieldTable createAlias(String alias) {
    return $ShrubStatusFieldTable(attachedDatabase, alias);
  }
}

class ShrubStatusFieldData extends DataClass
    implements Insertable<ShrubStatusFieldData> {
  final String code;
  final String name;
  const ShrubStatusFieldData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  ShrubStatusFieldCompanion toCompanion(bool nullToAbsent) {
    return ShrubStatusFieldCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory ShrubStatusFieldData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShrubStatusFieldData(
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

  ShrubStatusFieldData copyWith({String? code, String? name}) =>
      ShrubStatusFieldData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('ShrubStatusFieldData(')
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
      (other is ShrubStatusFieldData &&
          other.code == this.code &&
          other.name == this.name);
}

class ShrubStatusFieldCompanion extends UpdateCompanion<ShrubStatusFieldData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const ShrubStatusFieldCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShrubStatusFieldCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<ShrubStatusFieldData> custom({
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

  ShrubStatusFieldCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return ShrubStatusFieldCompanion(
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
    return (StringBuffer('ShrubStatusFieldCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShrubBasalDiameterTable extends ShrubBasalDiameter
    with TableInfo<$ShrubBasalDiameterTable, ShrubBasalDiameterData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShrubBasalDiameterTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'shrub_basal_diameter';
  @override
  VerificationContext validateIntegrity(
      Insertable<ShrubBasalDiameterData> instance,
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
  ShrubBasalDiameterData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShrubBasalDiameterData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ShrubBasalDiameterTable createAlias(String alias) {
    return $ShrubBasalDiameterTable(attachedDatabase, alias);
  }
}

class ShrubBasalDiameterData extends DataClass
    implements Insertable<ShrubBasalDiameterData> {
  final String code;
  final String name;
  const ShrubBasalDiameterData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  ShrubBasalDiameterCompanion toCompanion(bool nullToAbsent) {
    return ShrubBasalDiameterCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory ShrubBasalDiameterData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShrubBasalDiameterData(
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

  ShrubBasalDiameterData copyWith({String? code, String? name}) =>
      ShrubBasalDiameterData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('ShrubBasalDiameterData(')
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
      (other is ShrubBasalDiameterData &&
          other.code == this.code &&
          other.name == this.name);
}

class ShrubBasalDiameterCompanion
    extends UpdateCompanion<ShrubBasalDiameterData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const ShrubBasalDiameterCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShrubBasalDiameterCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<ShrubBasalDiameterData> custom({
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

  ShrubBasalDiameterCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return ShrubBasalDiameterCompanion(
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
    return (StringBuffer('ShrubBasalDiameterCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StumpPlotTypeTable extends StumpPlotType
    with TableInfo<$StumpPlotTypeTable, StumpPlotTypeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StumpPlotTypeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'stump_plot_type';
  @override
  VerificationContext validateIntegrity(Insertable<StumpPlotTypeData> instance,
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
  StumpPlotTypeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StumpPlotTypeData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $StumpPlotTypeTable createAlias(String alias) {
    return $StumpPlotTypeTable(attachedDatabase, alias);
  }
}

class StumpPlotTypeData extends DataClass
    implements Insertable<StumpPlotTypeData> {
  final String code;
  final String name;
  const StumpPlotTypeData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  StumpPlotTypeCompanion toCompanion(bool nullToAbsent) {
    return StumpPlotTypeCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory StumpPlotTypeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StumpPlotTypeData(
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

  StumpPlotTypeData copyWith({String? code, String? name}) => StumpPlotTypeData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('StumpPlotTypeData(')
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
      (other is StumpPlotTypeData &&
          other.code == this.code &&
          other.name == this.name);
}

class StumpPlotTypeCompanion extends UpdateCompanion<StumpPlotTypeData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const StumpPlotTypeCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StumpPlotTypeCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<StumpPlotTypeData> custom({
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

  StumpPlotTypeCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return StumpPlotTypeCompanion(
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
    return (StringBuffer('StumpPlotTypeCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StumpOrigPlotAreaTable extends StumpOrigPlotArea
    with TableInfo<$StumpOrigPlotAreaTable, StumpOrigPlotAreaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StumpOrigPlotAreaTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'stump_orig_plot_area';
  @override
  VerificationContext validateIntegrity(
      Insertable<StumpOrigPlotAreaData> instance,
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
  StumpOrigPlotAreaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StumpOrigPlotAreaData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $StumpOrigPlotAreaTable createAlias(String alias) {
    return $StumpOrigPlotAreaTable(attachedDatabase, alias);
  }
}

class StumpOrigPlotAreaData extends DataClass
    implements Insertable<StumpOrigPlotAreaData> {
  final String code;
  final String name;
  const StumpOrigPlotAreaData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  StumpOrigPlotAreaCompanion toCompanion(bool nullToAbsent) {
    return StumpOrigPlotAreaCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory StumpOrigPlotAreaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StumpOrigPlotAreaData(
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

  StumpOrigPlotAreaData copyWith({String? code, String? name}) =>
      StumpOrigPlotAreaData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('StumpOrigPlotAreaData(')
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
      (other is StumpOrigPlotAreaData &&
          other.code == this.code &&
          other.name == this.name);
}

class StumpOrigPlotAreaCompanion
    extends UpdateCompanion<StumpOrigPlotAreaData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const StumpOrigPlotAreaCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StumpOrigPlotAreaCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<StumpOrigPlotAreaData> custom({
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

  StumpOrigPlotAreaCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return StumpOrigPlotAreaCompanion(
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
    return (StringBuffer('StumpOrigPlotAreaCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpPlotTypeTable extends LtpPlotType
    with TableInfo<$LtpPlotTypeTable, LtpPlotTypeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpPlotTypeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_plot_type';
  @override
  VerificationContext validateIntegrity(Insertable<LtpPlotTypeData> instance,
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
  LtpPlotTypeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpPlotTypeData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpPlotTypeTable createAlias(String alias) {
    return $LtpPlotTypeTable(attachedDatabase, alias);
  }
}

class LtpPlotTypeData extends DataClass implements Insertable<LtpPlotTypeData> {
  final String code;
  final String name;
  const LtpPlotTypeData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpPlotTypeCompanion toCompanion(bool nullToAbsent) {
    return LtpPlotTypeCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpPlotTypeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpPlotTypeData(
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

  LtpPlotTypeData copyWith({String? code, String? name}) => LtpPlotTypeData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpPlotTypeData(')
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
      (other is LtpPlotTypeData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpPlotTypeCompanion extends UpdateCompanion<LtpPlotTypeData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpPlotTypeCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpPlotTypeCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpPlotTypeData> custom({
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

  LtpPlotTypeCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpPlotTypeCompanion(
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
    return (StringBuffer('LtpPlotTypeCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpPlotSplitTable extends LtpPlotSplit
    with TableInfo<$LtpPlotSplitTable, LtpPlotSplitData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpPlotSplitTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_plot_split';
  @override
  VerificationContext validateIntegrity(Insertable<LtpPlotSplitData> instance,
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
  LtpPlotSplitData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpPlotSplitData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpPlotSplitTable createAlias(String alias) {
    return $LtpPlotSplitTable(attachedDatabase, alias);
  }
}

class LtpPlotSplitData extends DataClass
    implements Insertable<LtpPlotSplitData> {
  final String code;
  final String name;
  const LtpPlotSplitData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpPlotSplitCompanion toCompanion(bool nullToAbsent) {
    return LtpPlotSplitCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpPlotSplitData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpPlotSplitData(
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

  LtpPlotSplitData copyWith({String? code, String? name}) => LtpPlotSplitData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpPlotSplitData(')
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
      (other is LtpPlotSplitData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpPlotSplitCompanion extends UpdateCompanion<LtpPlotSplitData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpPlotSplitCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpPlotSplitCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpPlotSplitData> custom({
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

  LtpPlotSplitCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpPlotSplitCompanion(
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
    return (StringBuffer('LtpPlotSplitCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpOrigPlotAreaTable extends LtpOrigPlotArea
    with TableInfo<$LtpOrigPlotAreaTable, LtpOrigPlotAreaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpOrigPlotAreaTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_orig_plot_area';
  @override
  VerificationContext validateIntegrity(
      Insertable<LtpOrigPlotAreaData> instance,
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
  LtpOrigPlotAreaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpOrigPlotAreaData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpOrigPlotAreaTable createAlias(String alias) {
    return $LtpOrigPlotAreaTable(attachedDatabase, alias);
  }
}

class LtpOrigPlotAreaData extends DataClass
    implements Insertable<LtpOrigPlotAreaData> {
  final String code;
  final String name;
  const LtpOrigPlotAreaData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpOrigPlotAreaCompanion toCompanion(bool nullToAbsent) {
    return LtpOrigPlotAreaCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpOrigPlotAreaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpOrigPlotAreaData(
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

  LtpOrigPlotAreaData copyWith({String? code, String? name}) =>
      LtpOrigPlotAreaData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpOrigPlotAreaData(')
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
      (other is LtpOrigPlotAreaData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpOrigPlotAreaCompanion extends UpdateCompanion<LtpOrigPlotAreaData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpOrigPlotAreaCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpOrigPlotAreaCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpOrigPlotAreaData> custom({
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

  LtpOrigPlotAreaCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpOrigPlotAreaCompanion(
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
    return (StringBuffer('LtpOrigPlotAreaCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpStatusFieldTable extends LtpStatusField
    with TableInfo<$LtpStatusFieldTable, LtpStatusFieldData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpStatusFieldTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [code, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ltp_status_field';
  @override
  VerificationContext validateIntegrity(Insertable<LtpStatusFieldData> instance,
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
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LtpStatusFieldData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpStatusFieldData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $LtpStatusFieldTable createAlias(String alias) {
    return $LtpStatusFieldTable(attachedDatabase, alias);
  }
}

class LtpStatusFieldData extends DataClass
    implements Insertable<LtpStatusFieldData> {
  final String code;
  final String name;
  final String description;
  const LtpStatusFieldData(
      {required this.code, required this.name, required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    return map;
  }

  LtpStatusFieldCompanion toCompanion(bool nullToAbsent) {
    return LtpStatusFieldCompanion(
      code: Value(code),
      name: Value(name),
      description: Value(description),
    );
  }

  factory LtpStatusFieldData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpStatusFieldData(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
    };
  }

  LtpStatusFieldData copyWith(
          {String? code, String? name, String? description}) =>
      LtpStatusFieldData(
        code: code ?? this.code,
        name: name ?? this.name,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('LtpStatusFieldData(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LtpStatusFieldData &&
          other.code == this.code &&
          other.name == this.name &&
          other.description == this.description);
}

class LtpStatusFieldCompanion extends UpdateCompanion<LtpStatusFieldData> {
  final Value<String> code;
  final Value<String> name;
  final Value<String> description;
  final Value<int> rowid;
  const LtpStatusFieldCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpStatusFieldCompanion.insert({
    required String code,
    required String name,
    required String description,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name),
        description = Value(description);
  static Insertable<LtpStatusFieldData> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LtpStatusFieldCompanion copyWith(
      {Value<String>? code,
      Value<String>? name,
      Value<String>? description,
      Value<int>? rowid}) {
    return LtpStatusFieldCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LtpStatusFieldCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpGenusTable extends LtpGenus
    with TableInfo<$LtpGenusTable, LtpGenusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpGenusTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _varietyLatinNameMeta =
      const VerificationMeta('varietyLatinName');
  @override
  late final GeneratedColumn<String> varietyLatinName = GeneratedColumn<String>(
      'variety_latin_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genusCodeMeta =
      const VerificationMeta('genusCode');
  @override
  late final GeneratedColumn<String> genusCode = GeneratedColumn<String>(
      'genus_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _speciesCodeMeta =
      const VerificationMeta('speciesCode');
  @override
  late final GeneratedColumn<String> speciesCode = GeneratedColumn<String>(
      'species_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _varietyCodeMeta =
      const VerificationMeta('varietyCode');
  @override
  late final GeneratedColumn<String> varietyCode = GeneratedColumn<String>(
      'variety_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        genusLatinName,
        speciesLatinName,
        varietyLatinName,
        genusCode,
        speciesCode,
        varietyCode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ltp_genus';
  @override
  VerificationContext validateIntegrity(Insertable<LtpGenusData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('variety_latin_name')) {
      context.handle(
          _varietyLatinNameMeta,
          varietyLatinName.isAcceptableOrUnknown(
              data['variety_latin_name']!, _varietyLatinNameMeta));
    } else if (isInserting) {
      context.missing(_varietyLatinNameMeta);
    }
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
    if (data.containsKey('variety_code')) {
      context.handle(
          _varietyCodeMeta,
          varietyCode.isAcceptableOrUnknown(
              data['variety_code']!, _varietyCodeMeta));
    } else if (isInserting) {
      context.missing(_varietyCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  LtpGenusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpGenusData(
      genusLatinName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}genus_latin_name'])!,
      speciesLatinName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}species_latin_name'])!,
      varietyLatinName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}variety_latin_name'])!,
      genusCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genus_code'])!,
      speciesCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species_code'])!,
      varietyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variety_code'])!,
    );
  }

  @override
  $LtpGenusTable createAlias(String alias) {
    return $LtpGenusTable(attachedDatabase, alias);
  }
}

class LtpGenusData extends DataClass implements Insertable<LtpGenusData> {
  final String genusLatinName;
  final String speciesLatinName;
  final String varietyLatinName;
  final String genusCode;
  final String speciesCode;
  final String varietyCode;
  const LtpGenusData(
      {required this.genusLatinName,
      required this.speciesLatinName,
      required this.varietyLatinName,
      required this.genusCode,
      required this.speciesCode,
      required this.varietyCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['genus_latin_name'] = Variable<String>(genusLatinName);
    map['species_latin_name'] = Variable<String>(speciesLatinName);
    map['variety_latin_name'] = Variable<String>(varietyLatinName);
    map['genus_code'] = Variable<String>(genusCode);
    map['species_code'] = Variable<String>(speciesCode);
    map['variety_code'] = Variable<String>(varietyCode);
    return map;
  }

  LtpGenusCompanion toCompanion(bool nullToAbsent) {
    return LtpGenusCompanion(
      genusLatinName: Value(genusLatinName),
      speciesLatinName: Value(speciesLatinName),
      varietyLatinName: Value(varietyLatinName),
      genusCode: Value(genusCode),
      speciesCode: Value(speciesCode),
      varietyCode: Value(varietyCode),
    );
  }

  factory LtpGenusData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpGenusData(
      genusLatinName: serializer.fromJson<String>(json['genusLatinName']),
      speciesLatinName: serializer.fromJson<String>(json['speciesLatinName']),
      varietyLatinName: serializer.fromJson<String>(json['varietyLatinName']),
      genusCode: serializer.fromJson<String>(json['genusCode']),
      speciesCode: serializer.fromJson<String>(json['speciesCode']),
      varietyCode: serializer.fromJson<String>(json['varietyCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'genusLatinName': serializer.toJson<String>(genusLatinName),
      'speciesLatinName': serializer.toJson<String>(speciesLatinName),
      'varietyLatinName': serializer.toJson<String>(varietyLatinName),
      'genusCode': serializer.toJson<String>(genusCode),
      'speciesCode': serializer.toJson<String>(speciesCode),
      'varietyCode': serializer.toJson<String>(varietyCode),
    };
  }

  LtpGenusData copyWith(
          {String? genusLatinName,
          String? speciesLatinName,
          String? varietyLatinName,
          String? genusCode,
          String? speciesCode,
          String? varietyCode}) =>
      LtpGenusData(
        genusLatinName: genusLatinName ?? this.genusLatinName,
        speciesLatinName: speciesLatinName ?? this.speciesLatinName,
        varietyLatinName: varietyLatinName ?? this.varietyLatinName,
        genusCode: genusCode ?? this.genusCode,
        speciesCode: speciesCode ?? this.speciesCode,
        varietyCode: varietyCode ?? this.varietyCode,
      );
  @override
  String toString() {
    return (StringBuffer('LtpGenusData(')
          ..write('genusLatinName: $genusLatinName, ')
          ..write('speciesLatinName: $speciesLatinName, ')
          ..write('varietyLatinName: $varietyLatinName, ')
          ..write('genusCode: $genusCode, ')
          ..write('speciesCode: $speciesCode, ')
          ..write('varietyCode: $varietyCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(genusLatinName, speciesLatinName,
      varietyLatinName, genusCode, speciesCode, varietyCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LtpGenusData &&
          other.genusLatinName == this.genusLatinName &&
          other.speciesLatinName == this.speciesLatinName &&
          other.varietyLatinName == this.varietyLatinName &&
          other.genusCode == this.genusCode &&
          other.speciesCode == this.speciesCode &&
          other.varietyCode == this.varietyCode);
}

class LtpGenusCompanion extends UpdateCompanion<LtpGenusData> {
  final Value<String> genusLatinName;
  final Value<String> speciesLatinName;
  final Value<String> varietyLatinName;
  final Value<String> genusCode;
  final Value<String> speciesCode;
  final Value<String> varietyCode;
  final Value<int> rowid;
  const LtpGenusCompanion({
    this.genusLatinName = const Value.absent(),
    this.speciesLatinName = const Value.absent(),
    this.varietyLatinName = const Value.absent(),
    this.genusCode = const Value.absent(),
    this.speciesCode = const Value.absent(),
    this.varietyCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpGenusCompanion.insert({
    required String genusLatinName,
    required String speciesLatinName,
    required String varietyLatinName,
    required String genusCode,
    required String speciesCode,
    required String varietyCode,
    this.rowid = const Value.absent(),
  })  : genusLatinName = Value(genusLatinName),
        speciesLatinName = Value(speciesLatinName),
        varietyLatinName = Value(varietyLatinName),
        genusCode = Value(genusCode),
        speciesCode = Value(speciesCode),
        varietyCode = Value(varietyCode);
  static Insertable<LtpGenusData> custom({
    Expression<String>? genusLatinName,
    Expression<String>? speciesLatinName,
    Expression<String>? varietyLatinName,
    Expression<String>? genusCode,
    Expression<String>? speciesCode,
    Expression<String>? varietyCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (genusLatinName != null) 'genus_latin_name': genusLatinName,
      if (speciesLatinName != null) 'species_latin_name': speciesLatinName,
      if (varietyLatinName != null) 'variety_latin_name': varietyLatinName,
      if (genusCode != null) 'genus_code': genusCode,
      if (speciesCode != null) 'species_code': speciesCode,
      if (varietyCode != null) 'variety_code': varietyCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LtpGenusCompanion copyWith(
      {Value<String>? genusLatinName,
      Value<String>? speciesLatinName,
      Value<String>? varietyLatinName,
      Value<String>? genusCode,
      Value<String>? speciesCode,
      Value<String>? varietyCode,
      Value<int>? rowid}) {
    return LtpGenusCompanion(
      genusLatinName: genusLatinName ?? this.genusLatinName,
      speciesLatinName: speciesLatinName ?? this.speciesLatinName,
      varietyLatinName: varietyLatinName ?? this.varietyLatinName,
      genusCode: genusCode ?? this.genusCode,
      speciesCode: speciesCode ?? this.speciesCode,
      varietyCode: varietyCode ?? this.varietyCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (genusLatinName.present) {
      map['genus_latin_name'] = Variable<String>(genusLatinName.value);
    }
    if (speciesLatinName.present) {
      map['species_latin_name'] = Variable<String>(speciesLatinName.value);
    }
    if (varietyLatinName.present) {
      map['variety_latin_name'] = Variable<String>(varietyLatinName.value);
    }
    if (genusCode.present) {
      map['genus_code'] = Variable<String>(genusCode.value);
    }
    if (speciesCode.present) {
      map['species_code'] = Variable<String>(speciesCode.value);
    }
    if (varietyCode.present) {
      map['variety_code'] = Variable<String>(varietyCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LtpGenusCompanion(')
          ..write('genusLatinName: $genusLatinName, ')
          ..write('speciesLatinName: $speciesLatinName, ')
          ..write('varietyLatinName: $varietyLatinName, ')
          ..write('genusCode: $genusCode, ')
          ..write('speciesCode: $speciesCode, ')
          ..write('varietyCode: $varietyCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpCrownClassFieldTable extends LtpCrownClassField
    with TableInfo<$LtpCrownClassFieldTable, LtpCrownClassFieldData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpCrownClassFieldTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_crown_class_field';
  @override
  VerificationContext validateIntegrity(
      Insertable<LtpCrownClassFieldData> instance,
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
  LtpCrownClassFieldData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpCrownClassFieldData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpCrownClassFieldTable createAlias(String alias) {
    return $LtpCrownClassFieldTable(attachedDatabase, alias);
  }
}

class LtpCrownClassFieldData extends DataClass
    implements Insertable<LtpCrownClassFieldData> {
  final String code;
  final String name;
  const LtpCrownClassFieldData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpCrownClassFieldCompanion toCompanion(bool nullToAbsent) {
    return LtpCrownClassFieldCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpCrownClassFieldData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpCrownClassFieldData(
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

  LtpCrownClassFieldData copyWith({String? code, String? name}) =>
      LtpCrownClassFieldData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpCrownClassFieldData(')
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
      (other is LtpCrownClassFieldData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpCrownClassFieldCompanion
    extends UpdateCompanion<LtpCrownClassFieldData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpCrownClassFieldCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpCrownClassFieldCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpCrownClassFieldData> custom({
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

  LtpCrownClassFieldCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpCrownClassFieldCompanion(
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
    return (StringBuffer('LtpCrownClassFieldCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpBarkConditionTable extends LtpBarkCondition
    with TableInfo<$LtpBarkConditionTable, LtpBarkConditionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpBarkConditionTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_bark_condition';
  @override
  VerificationContext validateIntegrity(
      Insertable<LtpBarkConditionData> instance,
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
  LtpBarkConditionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpBarkConditionData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpBarkConditionTable createAlias(String alias) {
    return $LtpBarkConditionTable(attachedDatabase, alias);
  }
}

class LtpBarkConditionData extends DataClass
    implements Insertable<LtpBarkConditionData> {
  final String code;
  final String name;
  const LtpBarkConditionData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpBarkConditionCompanion toCompanion(bool nullToAbsent) {
    return LtpBarkConditionCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpBarkConditionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpBarkConditionData(
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

  LtpBarkConditionData copyWith({String? code, String? name}) =>
      LtpBarkConditionData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpBarkConditionData(')
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
      (other is LtpBarkConditionData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpBarkConditionCompanion extends UpdateCompanion<LtpBarkConditionData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpBarkConditionCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpBarkConditionCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpBarkConditionData> custom({
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

  LtpBarkConditionCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpBarkConditionCompanion(
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
    return (StringBuffer('LtpBarkConditionCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpCrownConditionTable extends LtpCrownCondition
    with TableInfo<$LtpCrownConditionTable, LtpCrownConditionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpCrownConditionTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_crown_condition';
  @override
  VerificationContext validateIntegrity(
      Insertable<LtpCrownConditionData> instance,
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
  LtpCrownConditionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpCrownConditionData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpCrownConditionTable createAlias(String alias) {
    return $LtpCrownConditionTable(attachedDatabase, alias);
  }
}

class LtpCrownConditionData extends DataClass
    implements Insertable<LtpCrownConditionData> {
  final String code;
  final String name;
  const LtpCrownConditionData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpCrownConditionCompanion toCompanion(bool nullToAbsent) {
    return LtpCrownConditionCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpCrownConditionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpCrownConditionData(
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

  LtpCrownConditionData copyWith({String? code, String? name}) =>
      LtpCrownConditionData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpCrownConditionData(')
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
      (other is LtpCrownConditionData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpCrownConditionCompanion
    extends UpdateCompanion<LtpCrownConditionData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpCrownConditionCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpCrownConditionCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpCrownConditionData> custom({
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

  LtpCrownConditionCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpCrownConditionCompanion(
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
    return (StringBuffer('LtpCrownConditionCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpStemConditionTable extends LtpStemCondition
    with TableInfo<$LtpStemConditionTable, LtpStemConditionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpStemConditionTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_stem_condition';
  @override
  VerificationContext validateIntegrity(
      Insertable<LtpStemConditionData> instance,
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
  LtpStemConditionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpStemConditionData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpStemConditionTable createAlias(String alias) {
    return $LtpStemConditionTable(attachedDatabase, alias);
  }
}

class LtpStemConditionData extends DataClass
    implements Insertable<LtpStemConditionData> {
  final String code;
  final String name;
  const LtpStemConditionData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpStemConditionCompanion toCompanion(bool nullToAbsent) {
    return LtpStemConditionCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpStemConditionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpStemConditionData(
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

  LtpStemConditionData copyWith({String? code, String? name}) =>
      LtpStemConditionData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpStemConditionData(')
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
      (other is LtpStemConditionData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpStemConditionCompanion extends UpdateCompanion<LtpStemConditionData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpStemConditionCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpStemConditionCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpStemConditionData> custom({
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

  LtpStemConditionCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpStemConditionCompanion(
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
    return (StringBuffer('LtpStemConditionCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpWoodConditionTable extends LtpWoodCondition
    with TableInfo<$LtpWoodConditionTable, LtpWoodConditionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpWoodConditionTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_wood_condition';
  @override
  VerificationContext validateIntegrity(
      Insertable<LtpWoodConditionData> instance,
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
  LtpWoodConditionData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpWoodConditionData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpWoodConditionTable createAlias(String alias) {
    return $LtpWoodConditionTable(attachedDatabase, alias);
  }
}

class LtpWoodConditionData extends DataClass
    implements Insertable<LtpWoodConditionData> {
  final String code;
  final String name;
  const LtpWoodConditionData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpWoodConditionCompanion toCompanion(bool nullToAbsent) {
    return LtpWoodConditionCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpWoodConditionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpWoodConditionData(
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

  LtpWoodConditionData copyWith({String? code, String? name}) =>
      LtpWoodConditionData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpWoodConditionData(')
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
      (other is LtpWoodConditionData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpWoodConditionCompanion extends UpdateCompanion<LtpWoodConditionData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpWoodConditionCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpWoodConditionCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpWoodConditionData> custom({
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

  LtpWoodConditionCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpWoodConditionCompanion(
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
    return (StringBuffer('LtpWoodConditionCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpQuadrantTable extends LtpQuadrant
    with TableInfo<$LtpQuadrantTable, LtpQuadrantData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpQuadrantTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_quadrant';
  @override
  VerificationContext validateIntegrity(Insertable<LtpQuadrantData> instance,
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
  LtpQuadrantData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpQuadrantData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpQuadrantTable createAlias(String alias) {
    return $LtpQuadrantTable(attachedDatabase, alias);
  }
}

class LtpQuadrantData extends DataClass implements Insertable<LtpQuadrantData> {
  final String code;
  final String name;
  const LtpQuadrantData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpQuadrantCompanion toCompanion(bool nullToAbsent) {
    return LtpQuadrantCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpQuadrantData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpQuadrantData(
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

  LtpQuadrantData copyWith({String? code, String? name}) => LtpQuadrantData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpQuadrantData(')
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
      (other is LtpQuadrantData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpQuadrantCompanion extends UpdateCompanion<LtpQuadrantData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpQuadrantCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpQuadrantCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpQuadrantData> custom({
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

  LtpQuadrantCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpQuadrantCompanion(
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
    return (StringBuffer('LtpQuadrantCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpTreeTypeTable extends LtpTreeType
    with TableInfo<$LtpTreeTypeTable, LtpTreeTypeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpTreeTypeTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_tree_type';
  @override
  VerificationContext validateIntegrity(Insertable<LtpTreeTypeData> instance,
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
  LtpTreeTypeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpTreeTypeData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpTreeTypeTable createAlias(String alias) {
    return $LtpTreeTypeTable(attachedDatabase, alias);
  }
}

class LtpTreeTypeData extends DataClass implements Insertable<LtpTreeTypeData> {
  final String code;
  final String name;
  const LtpTreeTypeData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpTreeTypeCompanion toCompanion(bool nullToAbsent) {
    return LtpTreeTypeCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpTreeTypeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpTreeTypeData(
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

  LtpTreeTypeData copyWith({String? code, String? name}) => LtpTreeTypeData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpTreeTypeData(')
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
      (other is LtpTreeTypeData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpTreeTypeCompanion extends UpdateCompanion<LtpTreeTypeData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpTreeTypeCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpTreeTypeCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpTreeTypeData> custom({
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

  LtpTreeTypeCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpTreeTypeCompanion(
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
    return (StringBuffer('LtpTreeTypeCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpSiteHeightSuitabilityTable extends LtpSiteHeightSuitability
    with
        TableInfo<$LtpSiteHeightSuitabilityTable,
            LtpSiteHeightSuitabilityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpSiteHeightSuitabilityTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_site_height_suitability';
  @override
  VerificationContext validateIntegrity(
      Insertable<LtpSiteHeightSuitabilityData> instance,
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
  LtpSiteHeightSuitabilityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpSiteHeightSuitabilityData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpSiteHeightSuitabilityTable createAlias(String alias) {
    return $LtpSiteHeightSuitabilityTable(attachedDatabase, alias);
  }
}

class LtpSiteHeightSuitabilityData extends DataClass
    implements Insertable<LtpSiteHeightSuitabilityData> {
  final String code;
  final String name;
  const LtpSiteHeightSuitabilityData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpSiteHeightSuitabilityCompanion toCompanion(bool nullToAbsent) {
    return LtpSiteHeightSuitabilityCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpSiteHeightSuitabilityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpSiteHeightSuitabilityData(
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

  LtpSiteHeightSuitabilityData copyWith({String? code, String? name}) =>
      LtpSiteHeightSuitabilityData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpSiteHeightSuitabilityData(')
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
      (other is LtpSiteHeightSuitabilityData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpSiteHeightSuitabilityCompanion
    extends UpdateCompanion<LtpSiteHeightSuitabilityData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpSiteHeightSuitabilityCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpSiteHeightSuitabilityCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpSiteHeightSuitabilityData> custom({
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

  LtpSiteHeightSuitabilityCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpSiteHeightSuitabilityCompanion(
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
    return (StringBuffer('LtpSiteHeightSuitabilityCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpSiteAgeSuitabilityTable extends LtpSiteAgeSuitability
    with TableInfo<$LtpSiteAgeSuitabilityTable, LtpSiteAgeSuitabilityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpSiteAgeSuitabilityTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_site_age_suitability';
  @override
  VerificationContext validateIntegrity(
      Insertable<LtpSiteAgeSuitabilityData> instance,
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
  LtpSiteAgeSuitabilityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpSiteAgeSuitabilityData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpSiteAgeSuitabilityTable createAlias(String alias) {
    return $LtpSiteAgeSuitabilityTable(attachedDatabase, alias);
  }
}

class LtpSiteAgeSuitabilityData extends DataClass
    implements Insertable<LtpSiteAgeSuitabilityData> {
  final String code;
  final String name;
  const LtpSiteAgeSuitabilityData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpSiteAgeSuitabilityCompanion toCompanion(bool nullToAbsent) {
    return LtpSiteAgeSuitabilityCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpSiteAgeSuitabilityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpSiteAgeSuitabilityData(
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

  LtpSiteAgeSuitabilityData copyWith({String? code, String? name}) =>
      LtpSiteAgeSuitabilityData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpSiteAgeSuitabilityData(')
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
      (other is LtpSiteAgeSuitabilityData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpSiteAgeSuitabilityCompanion
    extends UpdateCompanion<LtpSiteAgeSuitabilityData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpSiteAgeSuitabilityCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpSiteAgeSuitabilityCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpSiteAgeSuitabilityData> custom({
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

  LtpSiteAgeSuitabilityCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpSiteAgeSuitabilityCompanion(
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
    return (StringBuffer('LtpSiteAgeSuitabilityCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LtpProrateTable extends LtpProrate
    with TableInfo<$LtpProrateTable, LtpProrateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpProrateTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'ltp_prorate';
  @override
  VerificationContext validateIntegrity(Insertable<LtpProrateData> instance,
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
  LtpProrateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpProrateData(
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $LtpProrateTable createAlias(String alias) {
    return $LtpProrateTable(attachedDatabase, alias);
  }
}

class LtpProrateData extends DataClass implements Insertable<LtpProrateData> {
  final String code;
  final String name;
  const LtpProrateData({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  LtpProrateCompanion toCompanion(bool nullToAbsent) {
    return LtpProrateCompanion(
      code: Value(code),
      name: Value(name),
    );
  }

  factory LtpProrateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpProrateData(
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

  LtpProrateData copyWith({String? code, String? name}) => LtpProrateData(
        code: code ?? this.code,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('LtpProrateData(')
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
      (other is LtpProrateData &&
          other.code == this.code &&
          other.name == this.name);
}

class LtpProrateCompanion extends UpdateCompanion<LtpProrateData> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const LtpProrateCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LtpProrateCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  })  : code = Value(code),
        name = Value(name);
  static Insertable<LtpProrateData> custom({
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

  LtpProrateCompanion copyWith(
      {Value<String>? code, Value<String>? name, Value<int>? rowid}) {
    return LtpProrateCompanion(
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
    return (StringBuffer('LtpProrateCompanion(')
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

class $SurveySummaryTable extends SurveySummary
    with TableInfo<$SurveySummaryTable, SurveySummaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurveySummaryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _notAssessedMeta =
      const VerificationMeta('notAssessed');
  @override
  late final GeneratedColumn<bool> notAssessed = GeneratedColumn<bool>(
      'not_assessed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("not_assessed" IN (0, 1))'),
      defaultValue: const Constant(false));
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
  static const VerificationMeta _referenceTreeMeta =
      const VerificationMeta('referenceTree');
  @override
  late final GeneratedColumn<int> referenceTree = GeneratedColumn<int>(
      'reference_tree', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _crewOneMeta =
      const VerificationMeta('crewOne');
  @override
  late final GeneratedColumn<String> crewOne = GeneratedColumn<String>(
      'crew_one', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _crewTwoMeta =
      const VerificationMeta('crewTwo');
  @override
  late final GeneratedColumn<String> crewTwo = GeneratedColumn<String>(
      'crew_two', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _crewThreeMeta =
      const VerificationMeta('crewThree');
  @override
  late final GeneratedColumn<String> crewThree = GeneratedColumn<String>(
      'crew_three', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _numberPhotosMeta =
      const VerificationMeta('numberPhotos');
  @override
  late final GeneratedColumn<int> numberPhotos = GeneratedColumn<int>(
      'number_photos', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        surveyId,
        notAssessed,
        complete,
        referenceTree,
        crewOne,
        crewTwo,
        crewThree,
        numberPhotos
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'survey_summary';
  @override
  VerificationContext validateIntegrity(Insertable<SurveySummaryData> instance,
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
    if (data.containsKey('not_assessed')) {
      context.handle(
          _notAssessedMeta,
          notAssessed.isAcceptableOrUnknown(
              data['not_assessed']!, _notAssessedMeta));
    }
    if (data.containsKey('complete')) {
      context.handle(_completeMeta,
          complete.isAcceptableOrUnknown(data['complete']!, _completeMeta));
    }
    if (data.containsKey('reference_tree')) {
      context.handle(
          _referenceTreeMeta,
          referenceTree.isAcceptableOrUnknown(
              data['reference_tree']!, _referenceTreeMeta));
    }
    if (data.containsKey('crew_one')) {
      context.handle(_crewOneMeta,
          crewOne.isAcceptableOrUnknown(data['crew_one']!, _crewOneMeta));
    }
    if (data.containsKey('crew_two')) {
      context.handle(_crewTwoMeta,
          crewTwo.isAcceptableOrUnknown(data['crew_two']!, _crewTwoMeta));
    }
    if (data.containsKey('crew_three')) {
      context.handle(_crewThreeMeta,
          crewThree.isAcceptableOrUnknown(data['crew_three']!, _crewThreeMeta));
    }
    if (data.containsKey('number_photos')) {
      context.handle(
          _numberPhotosMeta,
          numberPhotos.isAcceptableOrUnknown(
              data['number_photos']!, _numberPhotosMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurveySummaryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurveySummaryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      notAssessed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}not_assessed'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
      referenceTree: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reference_tree']),
      crewOne: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crew_one']),
      crewTwo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crew_two']),
      crewThree: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crew_three']),
      numberPhotos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}number_photos']),
    );
  }

  @override
  $SurveySummaryTable createAlias(String alias) {
    return $SurveySummaryTable(attachedDatabase, alias);
  }
}

class SurveySummaryData extends DataClass
    implements Insertable<SurveySummaryData> {
  final int id;
  final int surveyId;
  final bool notAssessed;
  final bool complete;
  final int? referenceTree;
  final String? crewOne;
  final String? crewTwo;
  final String? crewThree;
  final int? numberPhotos;
  const SurveySummaryData(
      {required this.id,
      required this.surveyId,
      required this.notAssessed,
      required this.complete,
      this.referenceTree,
      this.crewOne,
      this.crewTwo,
      this.crewThree,
      this.numberPhotos});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['not_assessed'] = Variable<bool>(notAssessed);
    map['complete'] = Variable<bool>(complete);
    if (!nullToAbsent || referenceTree != null) {
      map['reference_tree'] = Variable<int>(referenceTree);
    }
    if (!nullToAbsent || crewOne != null) {
      map['crew_one'] = Variable<String>(crewOne);
    }
    if (!nullToAbsent || crewTwo != null) {
      map['crew_two'] = Variable<String>(crewTwo);
    }
    if (!nullToAbsent || crewThree != null) {
      map['crew_three'] = Variable<String>(crewThree);
    }
    if (!nullToAbsent || numberPhotos != null) {
      map['number_photos'] = Variable<int>(numberPhotos);
    }
    return map;
  }

  SurveySummaryCompanion toCompanion(bool nullToAbsent) {
    return SurveySummaryCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      notAssessed: Value(notAssessed),
      complete: Value(complete),
      referenceTree: referenceTree == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceTree),
      crewOne: crewOne == null && nullToAbsent
          ? const Value.absent()
          : Value(crewOne),
      crewTwo: crewTwo == null && nullToAbsent
          ? const Value.absent()
          : Value(crewTwo),
      crewThree: crewThree == null && nullToAbsent
          ? const Value.absent()
          : Value(crewThree),
      numberPhotos: numberPhotos == null && nullToAbsent
          ? const Value.absent()
          : Value(numberPhotos),
    );
  }

  factory SurveySummaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurveySummaryData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      notAssessed: serializer.fromJson<bool>(json['notAssessed']),
      complete: serializer.fromJson<bool>(json['complete']),
      referenceTree: serializer.fromJson<int?>(json['referenceTree']),
      crewOne: serializer.fromJson<String?>(json['crewOne']),
      crewTwo: serializer.fromJson<String?>(json['crewTwo']),
      crewThree: serializer.fromJson<String?>(json['crewThree']),
      numberPhotos: serializer.fromJson<int?>(json['numberPhotos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<int>(surveyId),
      'notAssessed': serializer.toJson<bool>(notAssessed),
      'complete': serializer.toJson<bool>(complete),
      'referenceTree': serializer.toJson<int?>(referenceTree),
      'crewOne': serializer.toJson<String?>(crewOne),
      'crewTwo': serializer.toJson<String?>(crewTwo),
      'crewThree': serializer.toJson<String?>(crewThree),
      'numberPhotos': serializer.toJson<int?>(numberPhotos),
    };
  }

  SurveySummaryData copyWith(
          {int? id,
          int? surveyId,
          bool? notAssessed,
          bool? complete,
          Value<int?> referenceTree = const Value.absent(),
          Value<String?> crewOne = const Value.absent(),
          Value<String?> crewTwo = const Value.absent(),
          Value<String?> crewThree = const Value.absent(),
          Value<int?> numberPhotos = const Value.absent()}) =>
      SurveySummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        notAssessed: notAssessed ?? this.notAssessed,
        complete: complete ?? this.complete,
        referenceTree:
            referenceTree.present ? referenceTree.value : this.referenceTree,
        crewOne: crewOne.present ? crewOne.value : this.crewOne,
        crewTwo: crewTwo.present ? crewTwo.value : this.crewTwo,
        crewThree: crewThree.present ? crewThree.value : this.crewThree,
        numberPhotos:
            numberPhotos.present ? numberPhotos.value : this.numberPhotos,
      );
  @override
  String toString() {
    return (StringBuffer('SurveySummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete, ')
          ..write('referenceTree: $referenceTree, ')
          ..write('crewOne: $crewOne, ')
          ..write('crewTwo: $crewTwo, ')
          ..write('crewThree: $crewThree, ')
          ..write('numberPhotos: $numberPhotos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, notAssessed, complete,
      referenceTree, crewOne, crewTwo, crewThree, numberPhotos);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurveySummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.notAssessed == this.notAssessed &&
          other.complete == this.complete &&
          other.referenceTree == this.referenceTree &&
          other.crewOne == this.crewOne &&
          other.crewTwo == this.crewTwo &&
          other.crewThree == this.crewThree &&
          other.numberPhotos == this.numberPhotos);
}

class SurveySummaryCompanion extends UpdateCompanion<SurveySummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<bool> notAssessed;
  final Value<bool> complete;
  final Value<int?> referenceTree;
  final Value<String?> crewOne;
  final Value<String?> crewTwo;
  final Value<String?> crewThree;
  final Value<int?> numberPhotos;
  const SurveySummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
    this.referenceTree = const Value.absent(),
    this.crewOne = const Value.absent(),
    this.crewTwo = const Value.absent(),
    this.crewThree = const Value.absent(),
    this.numberPhotos = const Value.absent(),
  });
  SurveySummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
    this.referenceTree = const Value.absent(),
    this.crewOne = const Value.absent(),
    this.crewTwo = const Value.absent(),
    this.crewThree = const Value.absent(),
    this.numberPhotos = const Value.absent(),
  }) : surveyId = Value(surveyId);
  static Insertable<SurveySummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<bool>? notAssessed,
    Expression<bool>? complete,
    Expression<int>? referenceTree,
    Expression<String>? crewOne,
    Expression<String>? crewTwo,
    Expression<String>? crewThree,
    Expression<int>? numberPhotos,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (notAssessed != null) 'not_assessed': notAssessed,
      if (complete != null) 'complete': complete,
      if (referenceTree != null) 'reference_tree': referenceTree,
      if (crewOne != null) 'crew_one': crewOne,
      if (crewTwo != null) 'crew_two': crewTwo,
      if (crewThree != null) 'crew_three': crewThree,
      if (numberPhotos != null) 'number_photos': numberPhotos,
    });
  }

  SurveySummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<bool>? notAssessed,
      Value<bool>? complete,
      Value<int?>? referenceTree,
      Value<String?>? crewOne,
      Value<String?>? crewTwo,
      Value<String?>? crewThree,
      Value<int?>? numberPhotos}) {
    return SurveySummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      notAssessed: notAssessed ?? this.notAssessed,
      complete: complete ?? this.complete,
      referenceTree: referenceTree ?? this.referenceTree,
      crewOne: crewOne ?? this.crewOne,
      crewTwo: crewTwo ?? this.crewTwo,
      crewThree: crewThree ?? this.crewThree,
      numberPhotos: numberPhotos ?? this.numberPhotos,
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
    if (notAssessed.present) {
      map['not_assessed'] = Variable<bool>(notAssessed.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    if (referenceTree.present) {
      map['reference_tree'] = Variable<int>(referenceTree.value);
    }
    if (crewOne.present) {
      map['crew_one'] = Variable<String>(crewOne.value);
    }
    if (crewTwo.present) {
      map['crew_two'] = Variable<String>(crewTwo.value);
    }
    if (crewThree.present) {
      map['crew_three'] = Variable<String>(crewThree.value);
    }
    if (numberPhotos.present) {
      map['number_photos'] = Variable<int>(numberPhotos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurveySummaryCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete, ')
          ..write('referenceTree: $referenceTree, ')
          ..write('crewOne: $crewOne, ')
          ..write('crewTwo: $crewTwo, ')
          ..write('crewThree: $crewThree, ')
          ..write('numberPhotos: $numberPhotos')
          ..write(')'))
        .toString();
  }
}

class $SurveyHeaderGroundPhotoTable extends SurveyHeaderGroundPhoto
    with TableInfo<$SurveyHeaderGroundPhotoTable, SurveyHeaderGroundPhotoData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurveyHeaderGroundPhotoTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _plotPinMeta =
      const VerificationMeta('plotPin');
  @override
  late final GeneratedColumn<bool> plotPin = GeneratedColumn<bool>(
      'plot_pin', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("plot_pin" IN (0, 1))'));
  static const VerificationMeta _transectOneFifteenUnderMeta =
      const VerificationMeta('transectOneFifteenUnder');
  @override
  late final GeneratedColumn<bool> transectOneFifteenUnder =
      GeneratedColumn<bool>('transect_one_fifteen_under', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("transect_one_fifteen_under" IN (0, 1))'));
  static const VerificationMeta _transectOneFifteenOverMeta =
      const VerificationMeta('transectOneFifteenOver');
  @override
  late final GeneratedColumn<bool> transectOneFifteenOver =
      GeneratedColumn<bool>('transect_one_fifteen_over', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("transect_one_fifteen_over" IN (0, 1))'));
  static const VerificationMeta _transectTwoFifteenUnderMeta =
      const VerificationMeta('transectTwoFifteenUnder');
  @override
  late final GeneratedColumn<bool> transectTwoFifteenUnder =
      GeneratedColumn<bool>('transect_two_fifteen_under', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("transect_two_fifteen_under" IN (0, 1))'));
  static const VerificationMeta _transectTwoFifteenOverMeta =
      const VerificationMeta('transectTwoFifteenOver');
  @override
  late final GeneratedColumn<bool> transectTwoFifteenOver =
      GeneratedColumn<bool>('transect_two_fifteen_over', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("transect_two_fifteen_over" IN (0, 1))'));
  static const VerificationMeta _horizontalMeta =
      const VerificationMeta('horizontal');
  @override
  late final GeneratedColumn<bool> horizontal = GeneratedColumn<bool>(
      'horizontal', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("horizontal" IN (0, 1))'));
  static const VerificationMeta _canopyMeta = const VerificationMeta('canopy');
  @override
  late final GeneratedColumn<bool> canopy = GeneratedColumn<bool>(
      'canopy', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("canopy" IN (0, 1))'));
  static const VerificationMeta _soilProfileMeta =
      const VerificationMeta('soilProfile');
  @override
  late final GeneratedColumn<bool> soilProfile = GeneratedColumn<bool>(
      'soil_profile', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("soil_profile" IN (0, 1))'));
  static const VerificationMeta _otherOneMeta =
      const VerificationMeta('otherOne');
  @override
  late final GeneratedColumn<bool> otherOne = GeneratedColumn<bool>(
      'other_one', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("other_one" IN (0, 1))'));
  static const VerificationMeta _otherTwoMeta =
      const VerificationMeta('otherTwo');
  @override
  late final GeneratedColumn<bool> otherTwo = GeneratedColumn<bool>(
      'other_two', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("other_two" IN (0, 1))'));
  static const VerificationMeta _otherThreeMeta =
      const VerificationMeta('otherThree');
  @override
  late final GeneratedColumn<bool> otherThree = GeneratedColumn<bool>(
      'other_three', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("other_three" IN (0, 1))'));
  static const VerificationMeta _otherFourMeta =
      const VerificationMeta('otherFour');
  @override
  late final GeneratedColumn<bool> otherFour = GeneratedColumn<bool>(
      'other_four', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("other_four" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        surveyId,
        plotPin,
        transectOneFifteenUnder,
        transectOneFifteenOver,
        transectTwoFifteenUnder,
        transectTwoFifteenOver,
        horizontal,
        canopy,
        soilProfile,
        otherOne,
        otherTwo,
        otherThree,
        otherFour
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'survey_header_ground_photo';
  @override
  VerificationContext validateIntegrity(
      Insertable<SurveyHeaderGroundPhotoData> instance,
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
    if (data.containsKey('plot_pin')) {
      context.handle(_plotPinMeta,
          plotPin.isAcceptableOrUnknown(data['plot_pin']!, _plotPinMeta));
    }
    if (data.containsKey('transect_one_fifteen_under')) {
      context.handle(
          _transectOneFifteenUnderMeta,
          transectOneFifteenUnder.isAcceptableOrUnknown(
              data['transect_one_fifteen_under']!,
              _transectOneFifteenUnderMeta));
    }
    if (data.containsKey('transect_one_fifteen_over')) {
      context.handle(
          _transectOneFifteenOverMeta,
          transectOneFifteenOver.isAcceptableOrUnknown(
              data['transect_one_fifteen_over']!, _transectOneFifteenOverMeta));
    }
    if (data.containsKey('transect_two_fifteen_under')) {
      context.handle(
          _transectTwoFifteenUnderMeta,
          transectTwoFifteenUnder.isAcceptableOrUnknown(
              data['transect_two_fifteen_under']!,
              _transectTwoFifteenUnderMeta));
    }
    if (data.containsKey('transect_two_fifteen_over')) {
      context.handle(
          _transectTwoFifteenOverMeta,
          transectTwoFifteenOver.isAcceptableOrUnknown(
              data['transect_two_fifteen_over']!, _transectTwoFifteenOverMeta));
    }
    if (data.containsKey('horizontal')) {
      context.handle(
          _horizontalMeta,
          horizontal.isAcceptableOrUnknown(
              data['horizontal']!, _horizontalMeta));
    }
    if (data.containsKey('canopy')) {
      context.handle(_canopyMeta,
          canopy.isAcceptableOrUnknown(data['canopy']!, _canopyMeta));
    }
    if (data.containsKey('soil_profile')) {
      context.handle(
          _soilProfileMeta,
          soilProfile.isAcceptableOrUnknown(
              data['soil_profile']!, _soilProfileMeta));
    }
    if (data.containsKey('other_one')) {
      context.handle(_otherOneMeta,
          otherOne.isAcceptableOrUnknown(data['other_one']!, _otherOneMeta));
    }
    if (data.containsKey('other_two')) {
      context.handle(_otherTwoMeta,
          otherTwo.isAcceptableOrUnknown(data['other_two']!, _otherTwoMeta));
    }
    if (data.containsKey('other_three')) {
      context.handle(
          _otherThreeMeta,
          otherThree.isAcceptableOrUnknown(
              data['other_three']!, _otherThreeMeta));
    }
    if (data.containsKey('other_four')) {
      context.handle(_otherFourMeta,
          otherFour.isAcceptableOrUnknown(data['other_four']!, _otherFourMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurveyHeaderGroundPhotoData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurveyHeaderGroundPhotoData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      plotPin: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}plot_pin']),
      transectOneFifteenUnder: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}transect_one_fifteen_under']),
      transectOneFifteenOver: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}transect_one_fifteen_over']),
      transectTwoFifteenUnder: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}transect_two_fifteen_under']),
      transectTwoFifteenOver: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}transect_two_fifteen_over']),
      horizontal: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}horizontal']),
      canopy: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}canopy']),
      soilProfile: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}soil_profile']),
      otherOne: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}other_one']),
      otherTwo: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}other_two']),
      otherThree: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}other_three']),
      otherFour: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}other_four']),
    );
  }

  @override
  $SurveyHeaderGroundPhotoTable createAlias(String alias) {
    return $SurveyHeaderGroundPhotoTable(attachedDatabase, alias);
  }
}

class SurveyHeaderGroundPhotoData extends DataClass
    implements Insertable<SurveyHeaderGroundPhotoData> {
  final int id;
  final int surveyId;
  final bool? plotPin;
  final bool? transectOneFifteenUnder;
  final bool? transectOneFifteenOver;
  final bool? transectTwoFifteenUnder;
  final bool? transectTwoFifteenOver;
  final bool? horizontal;
  final bool? canopy;
  final bool? soilProfile;
  final bool? otherOne;
  final bool? otherTwo;
  final bool? otherThree;
  final bool? otherFour;
  const SurveyHeaderGroundPhotoData(
      {required this.id,
      required this.surveyId,
      this.plotPin,
      this.transectOneFifteenUnder,
      this.transectOneFifteenOver,
      this.transectTwoFifteenUnder,
      this.transectTwoFifteenOver,
      this.horizontal,
      this.canopy,
      this.soilProfile,
      this.otherOne,
      this.otherTwo,
      this.otherThree,
      this.otherFour});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    if (!nullToAbsent || plotPin != null) {
      map['plot_pin'] = Variable<bool>(plotPin);
    }
    if (!nullToAbsent || transectOneFifteenUnder != null) {
      map['transect_one_fifteen_under'] =
          Variable<bool>(transectOneFifteenUnder);
    }
    if (!nullToAbsent || transectOneFifteenOver != null) {
      map['transect_one_fifteen_over'] = Variable<bool>(transectOneFifteenOver);
    }
    if (!nullToAbsent || transectTwoFifteenUnder != null) {
      map['transect_two_fifteen_under'] =
          Variable<bool>(transectTwoFifteenUnder);
    }
    if (!nullToAbsent || transectTwoFifteenOver != null) {
      map['transect_two_fifteen_over'] = Variable<bool>(transectTwoFifteenOver);
    }
    if (!nullToAbsent || horizontal != null) {
      map['horizontal'] = Variable<bool>(horizontal);
    }
    if (!nullToAbsent || canopy != null) {
      map['canopy'] = Variable<bool>(canopy);
    }
    if (!nullToAbsent || soilProfile != null) {
      map['soil_profile'] = Variable<bool>(soilProfile);
    }
    if (!nullToAbsent || otherOne != null) {
      map['other_one'] = Variable<bool>(otherOne);
    }
    if (!nullToAbsent || otherTwo != null) {
      map['other_two'] = Variable<bool>(otherTwo);
    }
    if (!nullToAbsent || otherThree != null) {
      map['other_three'] = Variable<bool>(otherThree);
    }
    if (!nullToAbsent || otherFour != null) {
      map['other_four'] = Variable<bool>(otherFour);
    }
    return map;
  }

  SurveyHeaderGroundPhotoCompanion toCompanion(bool nullToAbsent) {
    return SurveyHeaderGroundPhotoCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      plotPin: plotPin == null && nullToAbsent
          ? const Value.absent()
          : Value(plotPin),
      transectOneFifteenUnder: transectOneFifteenUnder == null && nullToAbsent
          ? const Value.absent()
          : Value(transectOneFifteenUnder),
      transectOneFifteenOver: transectOneFifteenOver == null && nullToAbsent
          ? const Value.absent()
          : Value(transectOneFifteenOver),
      transectTwoFifteenUnder: transectTwoFifteenUnder == null && nullToAbsent
          ? const Value.absent()
          : Value(transectTwoFifteenUnder),
      transectTwoFifteenOver: transectTwoFifteenOver == null && nullToAbsent
          ? const Value.absent()
          : Value(transectTwoFifteenOver),
      horizontal: horizontal == null && nullToAbsent
          ? const Value.absent()
          : Value(horizontal),
      canopy:
          canopy == null && nullToAbsent ? const Value.absent() : Value(canopy),
      soilProfile: soilProfile == null && nullToAbsent
          ? const Value.absent()
          : Value(soilProfile),
      otherOne: otherOne == null && nullToAbsent
          ? const Value.absent()
          : Value(otherOne),
      otherTwo: otherTwo == null && nullToAbsent
          ? const Value.absent()
          : Value(otherTwo),
      otherThree: otherThree == null && nullToAbsent
          ? const Value.absent()
          : Value(otherThree),
      otherFour: otherFour == null && nullToAbsent
          ? const Value.absent()
          : Value(otherFour),
    );
  }

  factory SurveyHeaderGroundPhotoData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurveyHeaderGroundPhotoData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      plotPin: serializer.fromJson<bool?>(json['plotPin']),
      transectOneFifteenUnder:
          serializer.fromJson<bool?>(json['transectOneFifteenUnder']),
      transectOneFifteenOver:
          serializer.fromJson<bool?>(json['transectOneFifteenOver']),
      transectTwoFifteenUnder:
          serializer.fromJson<bool?>(json['transectTwoFifteenUnder']),
      transectTwoFifteenOver:
          serializer.fromJson<bool?>(json['transectTwoFifteenOver']),
      horizontal: serializer.fromJson<bool?>(json['horizontal']),
      canopy: serializer.fromJson<bool?>(json['canopy']),
      soilProfile: serializer.fromJson<bool?>(json['soilProfile']),
      otherOne: serializer.fromJson<bool?>(json['otherOne']),
      otherTwo: serializer.fromJson<bool?>(json['otherTwo']),
      otherThree: serializer.fromJson<bool?>(json['otherThree']),
      otherFour: serializer.fromJson<bool?>(json['otherFour']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<int>(surveyId),
      'plotPin': serializer.toJson<bool?>(plotPin),
      'transectOneFifteenUnder':
          serializer.toJson<bool?>(transectOneFifteenUnder),
      'transectOneFifteenOver':
          serializer.toJson<bool?>(transectOneFifteenOver),
      'transectTwoFifteenUnder':
          serializer.toJson<bool?>(transectTwoFifteenUnder),
      'transectTwoFifteenOver':
          serializer.toJson<bool?>(transectTwoFifteenOver),
      'horizontal': serializer.toJson<bool?>(horizontal),
      'canopy': serializer.toJson<bool?>(canopy),
      'soilProfile': serializer.toJson<bool?>(soilProfile),
      'otherOne': serializer.toJson<bool?>(otherOne),
      'otherTwo': serializer.toJson<bool?>(otherTwo),
      'otherThree': serializer.toJson<bool?>(otherThree),
      'otherFour': serializer.toJson<bool?>(otherFour),
    };
  }

  SurveyHeaderGroundPhotoData copyWith(
          {int? id,
          int? surveyId,
          Value<bool?> plotPin = const Value.absent(),
          Value<bool?> transectOneFifteenUnder = const Value.absent(),
          Value<bool?> transectOneFifteenOver = const Value.absent(),
          Value<bool?> transectTwoFifteenUnder = const Value.absent(),
          Value<bool?> transectTwoFifteenOver = const Value.absent(),
          Value<bool?> horizontal = const Value.absent(),
          Value<bool?> canopy = const Value.absent(),
          Value<bool?> soilProfile = const Value.absent(),
          Value<bool?> otherOne = const Value.absent(),
          Value<bool?> otherTwo = const Value.absent(),
          Value<bool?> otherThree = const Value.absent(),
          Value<bool?> otherFour = const Value.absent()}) =>
      SurveyHeaderGroundPhotoData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        plotPin: plotPin.present ? plotPin.value : this.plotPin,
        transectOneFifteenUnder: transectOneFifteenUnder.present
            ? transectOneFifteenUnder.value
            : this.transectOneFifteenUnder,
        transectOneFifteenOver: transectOneFifteenOver.present
            ? transectOneFifteenOver.value
            : this.transectOneFifteenOver,
        transectTwoFifteenUnder: transectTwoFifteenUnder.present
            ? transectTwoFifteenUnder.value
            : this.transectTwoFifteenUnder,
        transectTwoFifteenOver: transectTwoFifteenOver.present
            ? transectTwoFifteenOver.value
            : this.transectTwoFifteenOver,
        horizontal: horizontal.present ? horizontal.value : this.horizontal,
        canopy: canopy.present ? canopy.value : this.canopy,
        soilProfile: soilProfile.present ? soilProfile.value : this.soilProfile,
        otherOne: otherOne.present ? otherOne.value : this.otherOne,
        otherTwo: otherTwo.present ? otherTwo.value : this.otherTwo,
        otherThree: otherThree.present ? otherThree.value : this.otherThree,
        otherFour: otherFour.present ? otherFour.value : this.otherFour,
      );
  @override
  String toString() {
    return (StringBuffer('SurveyHeaderGroundPhotoData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('plotPin: $plotPin, ')
          ..write('transectOneFifteenUnder: $transectOneFifteenUnder, ')
          ..write('transectOneFifteenOver: $transectOneFifteenOver, ')
          ..write('transectTwoFifteenUnder: $transectTwoFifteenUnder, ')
          ..write('transectTwoFifteenOver: $transectTwoFifteenOver, ')
          ..write('horizontal: $horizontal, ')
          ..write('canopy: $canopy, ')
          ..write('soilProfile: $soilProfile, ')
          ..write('otherOne: $otherOne, ')
          ..write('otherTwo: $otherTwo, ')
          ..write('otherThree: $otherThree, ')
          ..write('otherFour: $otherFour')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      surveyId,
      plotPin,
      transectOneFifteenUnder,
      transectOneFifteenOver,
      transectTwoFifteenUnder,
      transectTwoFifteenOver,
      horizontal,
      canopy,
      soilProfile,
      otherOne,
      otherTwo,
      otherThree,
      otherFour);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurveyHeaderGroundPhotoData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.plotPin == this.plotPin &&
          other.transectOneFifteenUnder == this.transectOneFifteenUnder &&
          other.transectOneFifteenOver == this.transectOneFifteenOver &&
          other.transectTwoFifteenUnder == this.transectTwoFifteenUnder &&
          other.transectTwoFifteenOver == this.transectTwoFifteenOver &&
          other.horizontal == this.horizontal &&
          other.canopy == this.canopy &&
          other.soilProfile == this.soilProfile &&
          other.otherOne == this.otherOne &&
          other.otherTwo == this.otherTwo &&
          other.otherThree == this.otherThree &&
          other.otherFour == this.otherFour);
}

class SurveyHeaderGroundPhotoCompanion
    extends UpdateCompanion<SurveyHeaderGroundPhotoData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<bool?> plotPin;
  final Value<bool?> transectOneFifteenUnder;
  final Value<bool?> transectOneFifteenOver;
  final Value<bool?> transectTwoFifteenUnder;
  final Value<bool?> transectTwoFifteenOver;
  final Value<bool?> horizontal;
  final Value<bool?> canopy;
  final Value<bool?> soilProfile;
  final Value<bool?> otherOne;
  final Value<bool?> otherTwo;
  final Value<bool?> otherThree;
  final Value<bool?> otherFour;
  const SurveyHeaderGroundPhotoCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.plotPin = const Value.absent(),
    this.transectOneFifteenUnder = const Value.absent(),
    this.transectOneFifteenOver = const Value.absent(),
    this.transectTwoFifteenUnder = const Value.absent(),
    this.transectTwoFifteenOver = const Value.absent(),
    this.horizontal = const Value.absent(),
    this.canopy = const Value.absent(),
    this.soilProfile = const Value.absent(),
    this.otherOne = const Value.absent(),
    this.otherTwo = const Value.absent(),
    this.otherThree = const Value.absent(),
    this.otherFour = const Value.absent(),
  });
  SurveyHeaderGroundPhotoCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    this.plotPin = const Value.absent(),
    this.transectOneFifteenUnder = const Value.absent(),
    this.transectOneFifteenOver = const Value.absent(),
    this.transectTwoFifteenUnder = const Value.absent(),
    this.transectTwoFifteenOver = const Value.absent(),
    this.horizontal = const Value.absent(),
    this.canopy = const Value.absent(),
    this.soilProfile = const Value.absent(),
    this.otherOne = const Value.absent(),
    this.otherTwo = const Value.absent(),
    this.otherThree = const Value.absent(),
    this.otherFour = const Value.absent(),
  }) : surveyId = Value(surveyId);
  static Insertable<SurveyHeaderGroundPhotoData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<bool>? plotPin,
    Expression<bool>? transectOneFifteenUnder,
    Expression<bool>? transectOneFifteenOver,
    Expression<bool>? transectTwoFifteenUnder,
    Expression<bool>? transectTwoFifteenOver,
    Expression<bool>? horizontal,
    Expression<bool>? canopy,
    Expression<bool>? soilProfile,
    Expression<bool>? otherOne,
    Expression<bool>? otherTwo,
    Expression<bool>? otherThree,
    Expression<bool>? otherFour,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (plotPin != null) 'plot_pin': plotPin,
      if (transectOneFifteenUnder != null)
        'transect_one_fifteen_under': transectOneFifteenUnder,
      if (transectOneFifteenOver != null)
        'transect_one_fifteen_over': transectOneFifteenOver,
      if (transectTwoFifteenUnder != null)
        'transect_two_fifteen_under': transectTwoFifteenUnder,
      if (transectTwoFifteenOver != null)
        'transect_two_fifteen_over': transectTwoFifteenOver,
      if (horizontal != null) 'horizontal': horizontal,
      if (canopy != null) 'canopy': canopy,
      if (soilProfile != null) 'soil_profile': soilProfile,
      if (otherOne != null) 'other_one': otherOne,
      if (otherTwo != null) 'other_two': otherTwo,
      if (otherThree != null) 'other_three': otherThree,
      if (otherFour != null) 'other_four': otherFour,
    });
  }

  SurveyHeaderGroundPhotoCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<bool?>? plotPin,
      Value<bool?>? transectOneFifteenUnder,
      Value<bool?>? transectOneFifteenOver,
      Value<bool?>? transectTwoFifteenUnder,
      Value<bool?>? transectTwoFifteenOver,
      Value<bool?>? horizontal,
      Value<bool?>? canopy,
      Value<bool?>? soilProfile,
      Value<bool?>? otherOne,
      Value<bool?>? otherTwo,
      Value<bool?>? otherThree,
      Value<bool?>? otherFour}) {
    return SurveyHeaderGroundPhotoCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      plotPin: plotPin ?? this.plotPin,
      transectOneFifteenUnder:
          transectOneFifteenUnder ?? this.transectOneFifteenUnder,
      transectOneFifteenOver:
          transectOneFifteenOver ?? this.transectOneFifteenOver,
      transectTwoFifteenUnder:
          transectTwoFifteenUnder ?? this.transectTwoFifteenUnder,
      transectTwoFifteenOver:
          transectTwoFifteenOver ?? this.transectTwoFifteenOver,
      horizontal: horizontal ?? this.horizontal,
      canopy: canopy ?? this.canopy,
      soilProfile: soilProfile ?? this.soilProfile,
      otherOne: otherOne ?? this.otherOne,
      otherTwo: otherTwo ?? this.otherTwo,
      otherThree: otherThree ?? this.otherThree,
      otherFour: otherFour ?? this.otherFour,
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
    if (plotPin.present) {
      map['plot_pin'] = Variable<bool>(plotPin.value);
    }
    if (transectOneFifteenUnder.present) {
      map['transect_one_fifteen_under'] =
          Variable<bool>(transectOneFifteenUnder.value);
    }
    if (transectOneFifteenOver.present) {
      map['transect_one_fifteen_over'] =
          Variable<bool>(transectOneFifteenOver.value);
    }
    if (transectTwoFifteenUnder.present) {
      map['transect_two_fifteen_under'] =
          Variable<bool>(transectTwoFifteenUnder.value);
    }
    if (transectTwoFifteenOver.present) {
      map['transect_two_fifteen_over'] =
          Variable<bool>(transectTwoFifteenOver.value);
    }
    if (horizontal.present) {
      map['horizontal'] = Variable<bool>(horizontal.value);
    }
    if (canopy.present) {
      map['canopy'] = Variable<bool>(canopy.value);
    }
    if (soilProfile.present) {
      map['soil_profile'] = Variable<bool>(soilProfile.value);
    }
    if (otherOne.present) {
      map['other_one'] = Variable<bool>(otherOne.value);
    }
    if (otherTwo.present) {
      map['other_two'] = Variable<bool>(otherTwo.value);
    }
    if (otherThree.present) {
      map['other_three'] = Variable<bool>(otherThree.value);
    }
    if (otherFour.present) {
      map['other_four'] = Variable<bool>(otherFour.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurveyHeaderGroundPhotoCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('plotPin: $plotPin, ')
          ..write('transectOneFifteenUnder: $transectOneFifteenUnder, ')
          ..write('transectOneFifteenOver: $transectOneFifteenOver, ')
          ..write('transectTwoFifteenUnder: $transectTwoFifteenUnder, ')
          ..write('transectTwoFifteenOver: $transectTwoFifteenOver, ')
          ..write('horizontal: $horizontal, ')
          ..write('canopy: $canopy, ')
          ..write('soilProfile: $soilProfile, ')
          ..write('otherOne: $otherOne, ')
          ..write('otherTwo: $otherTwo, ')
          ..write('otherThree: $otherThree, ')
          ..write('otherFour: $otherFour')
          ..write(')'))
        .toString();
  }
}

class $SurveyHeaderTreeTable extends SurveyHeaderTree
    with TableInfo<$SurveyHeaderTreeTable, SurveyHeaderTreeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurveyHeaderTreeTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fieldResponsibilityMeta =
      const VerificationMeta('fieldResponsibility');
  @override
  late final GeneratedColumn<String> fieldResponsibility =
      GeneratedColumn<String>('field_responsibility', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fieldCheckByMeta =
      const VerificationMeta('fieldCheckBy');
  @override
  late final GeneratedColumn<String> fieldCheckBy = GeneratedColumn<String>(
      'field_check_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fieldDateMeta =
      const VerificationMeta('fieldDate');
  @override
  late final GeneratedColumn<DateTime> fieldDate = GeneratedColumn<DateTime>(
      'field_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _officeCheckByMeta =
      const VerificationMeta('officeCheckBy');
  @override
  late final GeneratedColumn<String> officeCheckBy = GeneratedColumn<String>(
      'office_check_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _officeDateMeta =
      const VerificationMeta('officeDate');
  @override
  late final GeneratedColumn<DateTime> officeDate = GeneratedColumn<DateTime>(
      'office_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        surveyId,
        fieldResponsibility,
        fieldCheckBy,
        fieldDate,
        officeCheckBy,
        officeDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'survey_header_tree';
  @override
  VerificationContext validateIntegrity(
      Insertable<SurveyHeaderTreeData> instance,
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
    if (data.containsKey('field_responsibility')) {
      context.handle(
          _fieldResponsibilityMeta,
          fieldResponsibility.isAcceptableOrUnknown(
              data['field_responsibility']!, _fieldResponsibilityMeta));
    }
    if (data.containsKey('field_check_by')) {
      context.handle(
          _fieldCheckByMeta,
          fieldCheckBy.isAcceptableOrUnknown(
              data['field_check_by']!, _fieldCheckByMeta));
    }
    if (data.containsKey('field_date')) {
      context.handle(_fieldDateMeta,
          fieldDate.isAcceptableOrUnknown(data['field_date']!, _fieldDateMeta));
    }
    if (data.containsKey('office_check_by')) {
      context.handle(
          _officeCheckByMeta,
          officeCheckBy.isAcceptableOrUnknown(
              data['office_check_by']!, _officeCheckByMeta));
    }
    if (data.containsKey('office_date')) {
      context.handle(
          _officeDateMeta,
          officeDate.isAcceptableOrUnknown(
              data['office_date']!, _officeDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurveyHeaderTreeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurveyHeaderTreeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      fieldResponsibility: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}field_responsibility']),
      fieldCheckBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}field_check_by']),
      fieldDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}field_date']),
      officeCheckBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}office_check_by']),
      officeDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}office_date']),
    );
  }

  @override
  $SurveyHeaderTreeTable createAlias(String alias) {
    return $SurveyHeaderTreeTable(attachedDatabase, alias);
  }
}

class SurveyHeaderTreeData extends DataClass
    implements Insertable<SurveyHeaderTreeData> {
  final int id;
  final int surveyId;
  final String? fieldResponsibility;
  final String? fieldCheckBy;
  final DateTime? fieldDate;
  final String? officeCheckBy;
  final DateTime? officeDate;
  const SurveyHeaderTreeData(
      {required this.id,
      required this.surveyId,
      this.fieldResponsibility,
      this.fieldCheckBy,
      this.fieldDate,
      this.officeCheckBy,
      this.officeDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    if (!nullToAbsent || fieldResponsibility != null) {
      map['field_responsibility'] = Variable<String>(fieldResponsibility);
    }
    if (!nullToAbsent || fieldCheckBy != null) {
      map['field_check_by'] = Variable<String>(fieldCheckBy);
    }
    if (!nullToAbsent || fieldDate != null) {
      map['field_date'] = Variable<DateTime>(fieldDate);
    }
    if (!nullToAbsent || officeCheckBy != null) {
      map['office_check_by'] = Variable<String>(officeCheckBy);
    }
    if (!nullToAbsent || officeDate != null) {
      map['office_date'] = Variable<DateTime>(officeDate);
    }
    return map;
  }

  SurveyHeaderTreeCompanion toCompanion(bool nullToAbsent) {
    return SurveyHeaderTreeCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      fieldResponsibility: fieldResponsibility == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldResponsibility),
      fieldCheckBy: fieldCheckBy == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldCheckBy),
      fieldDate: fieldDate == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldDate),
      officeCheckBy: officeCheckBy == null && nullToAbsent
          ? const Value.absent()
          : Value(officeCheckBy),
      officeDate: officeDate == null && nullToAbsent
          ? const Value.absent()
          : Value(officeDate),
    );
  }

  factory SurveyHeaderTreeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurveyHeaderTreeData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      fieldResponsibility:
          serializer.fromJson<String?>(json['fieldResponsibility']),
      fieldCheckBy: serializer.fromJson<String?>(json['fieldCheckBy']),
      fieldDate: serializer.fromJson<DateTime?>(json['fieldDate']),
      officeCheckBy: serializer.fromJson<String?>(json['officeCheckBy']),
      officeDate: serializer.fromJson<DateTime?>(json['officeDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<int>(surveyId),
      'fieldResponsibility': serializer.toJson<String?>(fieldResponsibility),
      'fieldCheckBy': serializer.toJson<String?>(fieldCheckBy),
      'fieldDate': serializer.toJson<DateTime?>(fieldDate),
      'officeCheckBy': serializer.toJson<String?>(officeCheckBy),
      'officeDate': serializer.toJson<DateTime?>(officeDate),
    };
  }

  SurveyHeaderTreeData copyWith(
          {int? id,
          int? surveyId,
          Value<String?> fieldResponsibility = const Value.absent(),
          Value<String?> fieldCheckBy = const Value.absent(),
          Value<DateTime?> fieldDate = const Value.absent(),
          Value<String?> officeCheckBy = const Value.absent(),
          Value<DateTime?> officeDate = const Value.absent()}) =>
      SurveyHeaderTreeData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        fieldResponsibility: fieldResponsibility.present
            ? fieldResponsibility.value
            : this.fieldResponsibility,
        fieldCheckBy:
            fieldCheckBy.present ? fieldCheckBy.value : this.fieldCheckBy,
        fieldDate: fieldDate.present ? fieldDate.value : this.fieldDate,
        officeCheckBy:
            officeCheckBy.present ? officeCheckBy.value : this.officeCheckBy,
        officeDate: officeDate.present ? officeDate.value : this.officeDate,
      );
  @override
  String toString() {
    return (StringBuffer('SurveyHeaderTreeData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('fieldResponsibility: $fieldResponsibility, ')
          ..write('fieldCheckBy: $fieldCheckBy, ')
          ..write('fieldDate: $fieldDate, ')
          ..write('officeCheckBy: $officeCheckBy, ')
          ..write('officeDate: $officeDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, fieldResponsibility,
      fieldCheckBy, fieldDate, officeCheckBy, officeDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurveyHeaderTreeData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.fieldResponsibility == this.fieldResponsibility &&
          other.fieldCheckBy == this.fieldCheckBy &&
          other.fieldDate == this.fieldDate &&
          other.officeCheckBy == this.officeCheckBy &&
          other.officeDate == this.officeDate);
}

class SurveyHeaderTreeCompanion extends UpdateCompanion<SurveyHeaderTreeData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<String?> fieldResponsibility;
  final Value<String?> fieldCheckBy;
  final Value<DateTime?> fieldDate;
  final Value<String?> officeCheckBy;
  final Value<DateTime?> officeDate;
  const SurveyHeaderTreeCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.fieldResponsibility = const Value.absent(),
    this.fieldCheckBy = const Value.absent(),
    this.fieldDate = const Value.absent(),
    this.officeCheckBy = const Value.absent(),
    this.officeDate = const Value.absent(),
  });
  SurveyHeaderTreeCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    this.fieldResponsibility = const Value.absent(),
    this.fieldCheckBy = const Value.absent(),
    this.fieldDate = const Value.absent(),
    this.officeCheckBy = const Value.absent(),
    this.officeDate = const Value.absent(),
  }) : surveyId = Value(surveyId);
  static Insertable<SurveyHeaderTreeData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<String>? fieldResponsibility,
    Expression<String>? fieldCheckBy,
    Expression<DateTime>? fieldDate,
    Expression<String>? officeCheckBy,
    Expression<DateTime>? officeDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (fieldResponsibility != null)
        'field_responsibility': fieldResponsibility,
      if (fieldCheckBy != null) 'field_check_by': fieldCheckBy,
      if (fieldDate != null) 'field_date': fieldDate,
      if (officeCheckBy != null) 'office_check_by': officeCheckBy,
      if (officeDate != null) 'office_date': officeDate,
    });
  }

  SurveyHeaderTreeCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<String?>? fieldResponsibility,
      Value<String?>? fieldCheckBy,
      Value<DateTime?>? fieldDate,
      Value<String?>? officeCheckBy,
      Value<DateTime?>? officeDate}) {
    return SurveyHeaderTreeCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      fieldResponsibility: fieldResponsibility ?? this.fieldResponsibility,
      fieldCheckBy: fieldCheckBy ?? this.fieldCheckBy,
      fieldDate: fieldDate ?? this.fieldDate,
      officeCheckBy: officeCheckBy ?? this.officeCheckBy,
      officeDate: officeDate ?? this.officeDate,
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
    if (fieldResponsibility.present) {
      map['field_responsibility'] = Variable<String>(fieldResponsibility.value);
    }
    if (fieldCheckBy.present) {
      map['field_check_by'] = Variable<String>(fieldCheckBy.value);
    }
    if (fieldDate.present) {
      map['field_date'] = Variable<DateTime>(fieldDate.value);
    }
    if (officeCheckBy.present) {
      map['office_check_by'] = Variable<String>(officeCheckBy.value);
    }
    if (officeDate.present) {
      map['office_date'] = Variable<DateTime>(officeDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurveyHeaderTreeCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('fieldResponsibility: $fieldResponsibility, ')
          ..write('fieldCheckBy: $fieldCheckBy, ')
          ..write('fieldDate: $fieldDate, ')
          ..write('officeCheckBy: $officeCheckBy, ')
          ..write('officeDate: $officeDate')
          ..write(')'))
        .toString();
  }
}

class $SurveyHeaderEcologicalTable extends SurveyHeaderEcological
    with TableInfo<$SurveyHeaderEcologicalTable, SurveyHeaderEcologicalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurveyHeaderEcologicalTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fieldResponsibilityMeta =
      const VerificationMeta('fieldResponsibility');
  @override
  late final GeneratedColumn<String> fieldResponsibility =
      GeneratedColumn<String>('field_responsibility', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fieldCheckByMeta =
      const VerificationMeta('fieldCheckBy');
  @override
  late final GeneratedColumn<String> fieldCheckBy = GeneratedColumn<String>(
      'field_check_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fieldDateMeta =
      const VerificationMeta('fieldDate');
  @override
  late final GeneratedColumn<DateTime> fieldDate = GeneratedColumn<DateTime>(
      'field_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _officeCheckByMeta =
      const VerificationMeta('officeCheckBy');
  @override
  late final GeneratedColumn<String> officeCheckBy = GeneratedColumn<String>(
      'office_check_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _officeDateMeta =
      const VerificationMeta('officeDate');
  @override
  late final GeneratedColumn<DateTime> officeDate = GeneratedColumn<DateTime>(
      'office_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        surveyId,
        fieldResponsibility,
        fieldCheckBy,
        fieldDate,
        officeCheckBy,
        officeDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'survey_header_ecological';
  @override
  VerificationContext validateIntegrity(
      Insertable<SurveyHeaderEcologicalData> instance,
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
    if (data.containsKey('field_responsibility')) {
      context.handle(
          _fieldResponsibilityMeta,
          fieldResponsibility.isAcceptableOrUnknown(
              data['field_responsibility']!, _fieldResponsibilityMeta));
    }
    if (data.containsKey('field_check_by')) {
      context.handle(
          _fieldCheckByMeta,
          fieldCheckBy.isAcceptableOrUnknown(
              data['field_check_by']!, _fieldCheckByMeta));
    }
    if (data.containsKey('field_date')) {
      context.handle(_fieldDateMeta,
          fieldDate.isAcceptableOrUnknown(data['field_date']!, _fieldDateMeta));
    }
    if (data.containsKey('office_check_by')) {
      context.handle(
          _officeCheckByMeta,
          officeCheckBy.isAcceptableOrUnknown(
              data['office_check_by']!, _officeCheckByMeta));
    }
    if (data.containsKey('office_date')) {
      context.handle(
          _officeDateMeta,
          officeDate.isAcceptableOrUnknown(
              data['office_date']!, _officeDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurveyHeaderEcologicalData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurveyHeaderEcologicalData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      fieldResponsibility: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}field_responsibility']),
      fieldCheckBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}field_check_by']),
      fieldDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}field_date']),
      officeCheckBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}office_check_by']),
      officeDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}office_date']),
    );
  }

  @override
  $SurveyHeaderEcologicalTable createAlias(String alias) {
    return $SurveyHeaderEcologicalTable(attachedDatabase, alias);
  }
}

class SurveyHeaderEcologicalData extends DataClass
    implements Insertable<SurveyHeaderEcologicalData> {
  final int id;
  final int surveyId;
  final String? fieldResponsibility;
  final String? fieldCheckBy;
  final DateTime? fieldDate;
  final String? officeCheckBy;
  final DateTime? officeDate;
  const SurveyHeaderEcologicalData(
      {required this.id,
      required this.surveyId,
      this.fieldResponsibility,
      this.fieldCheckBy,
      this.fieldDate,
      this.officeCheckBy,
      this.officeDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    if (!nullToAbsent || fieldResponsibility != null) {
      map['field_responsibility'] = Variable<String>(fieldResponsibility);
    }
    if (!nullToAbsent || fieldCheckBy != null) {
      map['field_check_by'] = Variable<String>(fieldCheckBy);
    }
    if (!nullToAbsent || fieldDate != null) {
      map['field_date'] = Variable<DateTime>(fieldDate);
    }
    if (!nullToAbsent || officeCheckBy != null) {
      map['office_check_by'] = Variable<String>(officeCheckBy);
    }
    if (!nullToAbsent || officeDate != null) {
      map['office_date'] = Variable<DateTime>(officeDate);
    }
    return map;
  }

  SurveyHeaderEcologicalCompanion toCompanion(bool nullToAbsent) {
    return SurveyHeaderEcologicalCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      fieldResponsibility: fieldResponsibility == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldResponsibility),
      fieldCheckBy: fieldCheckBy == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldCheckBy),
      fieldDate: fieldDate == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldDate),
      officeCheckBy: officeCheckBy == null && nullToAbsent
          ? const Value.absent()
          : Value(officeCheckBy),
      officeDate: officeDate == null && nullToAbsent
          ? const Value.absent()
          : Value(officeDate),
    );
  }

  factory SurveyHeaderEcologicalData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurveyHeaderEcologicalData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      fieldResponsibility:
          serializer.fromJson<String?>(json['fieldResponsibility']),
      fieldCheckBy: serializer.fromJson<String?>(json['fieldCheckBy']),
      fieldDate: serializer.fromJson<DateTime?>(json['fieldDate']),
      officeCheckBy: serializer.fromJson<String?>(json['officeCheckBy']),
      officeDate: serializer.fromJson<DateTime?>(json['officeDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<int>(surveyId),
      'fieldResponsibility': serializer.toJson<String?>(fieldResponsibility),
      'fieldCheckBy': serializer.toJson<String?>(fieldCheckBy),
      'fieldDate': serializer.toJson<DateTime?>(fieldDate),
      'officeCheckBy': serializer.toJson<String?>(officeCheckBy),
      'officeDate': serializer.toJson<DateTime?>(officeDate),
    };
  }

  SurveyHeaderEcologicalData copyWith(
          {int? id,
          int? surveyId,
          Value<String?> fieldResponsibility = const Value.absent(),
          Value<String?> fieldCheckBy = const Value.absent(),
          Value<DateTime?> fieldDate = const Value.absent(),
          Value<String?> officeCheckBy = const Value.absent(),
          Value<DateTime?> officeDate = const Value.absent()}) =>
      SurveyHeaderEcologicalData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        fieldResponsibility: fieldResponsibility.present
            ? fieldResponsibility.value
            : this.fieldResponsibility,
        fieldCheckBy:
            fieldCheckBy.present ? fieldCheckBy.value : this.fieldCheckBy,
        fieldDate: fieldDate.present ? fieldDate.value : this.fieldDate,
        officeCheckBy:
            officeCheckBy.present ? officeCheckBy.value : this.officeCheckBy,
        officeDate: officeDate.present ? officeDate.value : this.officeDate,
      );
  @override
  String toString() {
    return (StringBuffer('SurveyHeaderEcologicalData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('fieldResponsibility: $fieldResponsibility, ')
          ..write('fieldCheckBy: $fieldCheckBy, ')
          ..write('fieldDate: $fieldDate, ')
          ..write('officeCheckBy: $officeCheckBy, ')
          ..write('officeDate: $officeDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, fieldResponsibility,
      fieldCheckBy, fieldDate, officeCheckBy, officeDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurveyHeaderEcologicalData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.fieldResponsibility == this.fieldResponsibility &&
          other.fieldCheckBy == this.fieldCheckBy &&
          other.fieldDate == this.fieldDate &&
          other.officeCheckBy == this.officeCheckBy &&
          other.officeDate == this.officeDate);
}

class SurveyHeaderEcologicalCompanion
    extends UpdateCompanion<SurveyHeaderEcologicalData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<String?> fieldResponsibility;
  final Value<String?> fieldCheckBy;
  final Value<DateTime?> fieldDate;
  final Value<String?> officeCheckBy;
  final Value<DateTime?> officeDate;
  const SurveyHeaderEcologicalCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.fieldResponsibility = const Value.absent(),
    this.fieldCheckBy = const Value.absent(),
    this.fieldDate = const Value.absent(),
    this.officeCheckBy = const Value.absent(),
    this.officeDate = const Value.absent(),
  });
  SurveyHeaderEcologicalCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    this.fieldResponsibility = const Value.absent(),
    this.fieldCheckBy = const Value.absent(),
    this.fieldDate = const Value.absent(),
    this.officeCheckBy = const Value.absent(),
    this.officeDate = const Value.absent(),
  }) : surveyId = Value(surveyId);
  static Insertable<SurveyHeaderEcologicalData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<String>? fieldResponsibility,
    Expression<String>? fieldCheckBy,
    Expression<DateTime>? fieldDate,
    Expression<String>? officeCheckBy,
    Expression<DateTime>? officeDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (fieldResponsibility != null)
        'field_responsibility': fieldResponsibility,
      if (fieldCheckBy != null) 'field_check_by': fieldCheckBy,
      if (fieldDate != null) 'field_date': fieldDate,
      if (officeCheckBy != null) 'office_check_by': officeCheckBy,
      if (officeDate != null) 'office_date': officeDate,
    });
  }

  SurveyHeaderEcologicalCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<String?>? fieldResponsibility,
      Value<String?>? fieldCheckBy,
      Value<DateTime?>? fieldDate,
      Value<String?>? officeCheckBy,
      Value<DateTime?>? officeDate}) {
    return SurveyHeaderEcologicalCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      fieldResponsibility: fieldResponsibility ?? this.fieldResponsibility,
      fieldCheckBy: fieldCheckBy ?? this.fieldCheckBy,
      fieldDate: fieldDate ?? this.fieldDate,
      officeCheckBy: officeCheckBy ?? this.officeCheckBy,
      officeDate: officeDate ?? this.officeDate,
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
    if (fieldResponsibility.present) {
      map['field_responsibility'] = Variable<String>(fieldResponsibility.value);
    }
    if (fieldCheckBy.present) {
      map['field_check_by'] = Variable<String>(fieldCheckBy.value);
    }
    if (fieldDate.present) {
      map['field_date'] = Variable<DateTime>(fieldDate.value);
    }
    if (officeCheckBy.present) {
      map['office_check_by'] = Variable<String>(officeCheckBy.value);
    }
    if (officeDate.present) {
      map['office_date'] = Variable<DateTime>(officeDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurveyHeaderEcologicalCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('fieldResponsibility: $fieldResponsibility, ')
          ..write('fieldCheckBy: $fieldCheckBy, ')
          ..write('fieldDate: $fieldDate, ')
          ..write('officeCheckBy: $officeCheckBy, ')
          ..write('officeDate: $officeDate')
          ..write(')'))
        .toString();
  }
}

class $SurveyHeaderSoilTable extends SurveyHeaderSoil
    with TableInfo<$SurveyHeaderSoilTable, SurveyHeaderSoilData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurveyHeaderSoilTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fieldResponsibilityMeta =
      const VerificationMeta('fieldResponsibility');
  @override
  late final GeneratedColumn<String> fieldResponsibility =
      GeneratedColumn<String>('field_responsibility', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fieldCheckByMeta =
      const VerificationMeta('fieldCheckBy');
  @override
  late final GeneratedColumn<String> fieldCheckBy = GeneratedColumn<String>(
      'field_check_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fieldDateMeta =
      const VerificationMeta('fieldDate');
  @override
  late final GeneratedColumn<DateTime> fieldDate = GeneratedColumn<DateTime>(
      'field_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _officeCheckByMeta =
      const VerificationMeta('officeCheckBy');
  @override
  late final GeneratedColumn<String> officeCheckBy = GeneratedColumn<String>(
      'office_check_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _officeDateMeta =
      const VerificationMeta('officeDate');
  @override
  late final GeneratedColumn<DateTime> officeDate = GeneratedColumn<DateTime>(
      'office_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        surveyId,
        fieldResponsibility,
        fieldCheckBy,
        fieldDate,
        officeCheckBy,
        officeDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'survey_header_soil';
  @override
  VerificationContext validateIntegrity(
      Insertable<SurveyHeaderSoilData> instance,
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
    if (data.containsKey('field_responsibility')) {
      context.handle(
          _fieldResponsibilityMeta,
          fieldResponsibility.isAcceptableOrUnknown(
              data['field_responsibility']!, _fieldResponsibilityMeta));
    }
    if (data.containsKey('field_check_by')) {
      context.handle(
          _fieldCheckByMeta,
          fieldCheckBy.isAcceptableOrUnknown(
              data['field_check_by']!, _fieldCheckByMeta));
    }
    if (data.containsKey('field_date')) {
      context.handle(_fieldDateMeta,
          fieldDate.isAcceptableOrUnknown(data['field_date']!, _fieldDateMeta));
    }
    if (data.containsKey('office_check_by')) {
      context.handle(
          _officeCheckByMeta,
          officeCheckBy.isAcceptableOrUnknown(
              data['office_check_by']!, _officeCheckByMeta));
    }
    if (data.containsKey('office_date')) {
      context.handle(
          _officeDateMeta,
          officeDate.isAcceptableOrUnknown(
              data['office_date']!, _officeDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SurveyHeaderSoilData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SurveyHeaderSoilData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      fieldResponsibility: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}field_responsibility']),
      fieldCheckBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}field_check_by']),
      fieldDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}field_date']),
      officeCheckBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}office_check_by']),
      officeDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}office_date']),
    );
  }

  @override
  $SurveyHeaderSoilTable createAlias(String alias) {
    return $SurveyHeaderSoilTable(attachedDatabase, alias);
  }
}

class SurveyHeaderSoilData extends DataClass
    implements Insertable<SurveyHeaderSoilData> {
  final int id;
  final int surveyId;
  final String? fieldResponsibility;
  final String? fieldCheckBy;
  final DateTime? fieldDate;
  final String? officeCheckBy;
  final DateTime? officeDate;
  const SurveyHeaderSoilData(
      {required this.id,
      required this.surveyId,
      this.fieldResponsibility,
      this.fieldCheckBy,
      this.fieldDate,
      this.officeCheckBy,
      this.officeDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    if (!nullToAbsent || fieldResponsibility != null) {
      map['field_responsibility'] = Variable<String>(fieldResponsibility);
    }
    if (!nullToAbsent || fieldCheckBy != null) {
      map['field_check_by'] = Variable<String>(fieldCheckBy);
    }
    if (!nullToAbsent || fieldDate != null) {
      map['field_date'] = Variable<DateTime>(fieldDate);
    }
    if (!nullToAbsent || officeCheckBy != null) {
      map['office_check_by'] = Variable<String>(officeCheckBy);
    }
    if (!nullToAbsent || officeDate != null) {
      map['office_date'] = Variable<DateTime>(officeDate);
    }
    return map;
  }

  SurveyHeaderSoilCompanion toCompanion(bool nullToAbsent) {
    return SurveyHeaderSoilCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      fieldResponsibility: fieldResponsibility == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldResponsibility),
      fieldCheckBy: fieldCheckBy == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldCheckBy),
      fieldDate: fieldDate == null && nullToAbsent
          ? const Value.absent()
          : Value(fieldDate),
      officeCheckBy: officeCheckBy == null && nullToAbsent
          ? const Value.absent()
          : Value(officeCheckBy),
      officeDate: officeDate == null && nullToAbsent
          ? const Value.absent()
          : Value(officeDate),
    );
  }

  factory SurveyHeaderSoilData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SurveyHeaderSoilData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      fieldResponsibility:
          serializer.fromJson<String?>(json['fieldResponsibility']),
      fieldCheckBy: serializer.fromJson<String?>(json['fieldCheckBy']),
      fieldDate: serializer.fromJson<DateTime?>(json['fieldDate']),
      officeCheckBy: serializer.fromJson<String?>(json['officeCheckBy']),
      officeDate: serializer.fromJson<DateTime?>(json['officeDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surveyId': serializer.toJson<int>(surveyId),
      'fieldResponsibility': serializer.toJson<String?>(fieldResponsibility),
      'fieldCheckBy': serializer.toJson<String?>(fieldCheckBy),
      'fieldDate': serializer.toJson<DateTime?>(fieldDate),
      'officeCheckBy': serializer.toJson<String?>(officeCheckBy),
      'officeDate': serializer.toJson<DateTime?>(officeDate),
    };
  }

  SurveyHeaderSoilData copyWith(
          {int? id,
          int? surveyId,
          Value<String?> fieldResponsibility = const Value.absent(),
          Value<String?> fieldCheckBy = const Value.absent(),
          Value<DateTime?> fieldDate = const Value.absent(),
          Value<String?> officeCheckBy = const Value.absent(),
          Value<DateTime?> officeDate = const Value.absent()}) =>
      SurveyHeaderSoilData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        fieldResponsibility: fieldResponsibility.present
            ? fieldResponsibility.value
            : this.fieldResponsibility,
        fieldCheckBy:
            fieldCheckBy.present ? fieldCheckBy.value : this.fieldCheckBy,
        fieldDate: fieldDate.present ? fieldDate.value : this.fieldDate,
        officeCheckBy:
            officeCheckBy.present ? officeCheckBy.value : this.officeCheckBy,
        officeDate: officeDate.present ? officeDate.value : this.officeDate,
      );
  @override
  String toString() {
    return (StringBuffer('SurveyHeaderSoilData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('fieldResponsibility: $fieldResponsibility, ')
          ..write('fieldCheckBy: $fieldCheckBy, ')
          ..write('fieldDate: $fieldDate, ')
          ..write('officeCheckBy: $officeCheckBy, ')
          ..write('officeDate: $officeDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, fieldResponsibility,
      fieldCheckBy, fieldDate, officeCheckBy, officeDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurveyHeaderSoilData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.fieldResponsibility == this.fieldResponsibility &&
          other.fieldCheckBy == this.fieldCheckBy &&
          other.fieldDate == this.fieldDate &&
          other.officeCheckBy == this.officeCheckBy &&
          other.officeDate == this.officeDate);
}

class SurveyHeaderSoilCompanion extends UpdateCompanion<SurveyHeaderSoilData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<String?> fieldResponsibility;
  final Value<String?> fieldCheckBy;
  final Value<DateTime?> fieldDate;
  final Value<String?> officeCheckBy;
  final Value<DateTime?> officeDate;
  const SurveyHeaderSoilCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.fieldResponsibility = const Value.absent(),
    this.fieldCheckBy = const Value.absent(),
    this.fieldDate = const Value.absent(),
    this.officeCheckBy = const Value.absent(),
    this.officeDate = const Value.absent(),
  });
  SurveyHeaderSoilCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    this.fieldResponsibility = const Value.absent(),
    this.fieldCheckBy = const Value.absent(),
    this.fieldDate = const Value.absent(),
    this.officeCheckBy = const Value.absent(),
    this.officeDate = const Value.absent(),
  }) : surveyId = Value(surveyId);
  static Insertable<SurveyHeaderSoilData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<String>? fieldResponsibility,
    Expression<String>? fieldCheckBy,
    Expression<DateTime>? fieldDate,
    Expression<String>? officeCheckBy,
    Expression<DateTime>? officeDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (fieldResponsibility != null)
        'field_responsibility': fieldResponsibility,
      if (fieldCheckBy != null) 'field_check_by': fieldCheckBy,
      if (fieldDate != null) 'field_date': fieldDate,
      if (officeCheckBy != null) 'office_check_by': officeCheckBy,
      if (officeDate != null) 'office_date': officeDate,
    });
  }

  SurveyHeaderSoilCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<String?>? fieldResponsibility,
      Value<String?>? fieldCheckBy,
      Value<DateTime?>? fieldDate,
      Value<String?>? officeCheckBy,
      Value<DateTime?>? officeDate}) {
    return SurveyHeaderSoilCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      fieldResponsibility: fieldResponsibility ?? this.fieldResponsibility,
      fieldCheckBy: fieldCheckBy ?? this.fieldCheckBy,
      fieldDate: fieldDate ?? this.fieldDate,
      officeCheckBy: officeCheckBy ?? this.officeCheckBy,
      officeDate: officeDate ?? this.officeDate,
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
    if (fieldResponsibility.present) {
      map['field_responsibility'] = Variable<String>(fieldResponsibility.value);
    }
    if (fieldCheckBy.present) {
      map['field_check_by'] = Variable<String>(fieldCheckBy.value);
    }
    if (fieldDate.present) {
      map['field_date'] = Variable<DateTime>(fieldDate.value);
    }
    if (officeCheckBy.present) {
      map['office_check_by'] = Variable<String>(officeCheckBy.value);
    }
    if (officeDate.present) {
      map['office_date'] = Variable<DateTime>(officeDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurveyHeaderSoilCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('fieldResponsibility: $fieldResponsibility, ')
          ..write('fieldCheckBy: $fieldCheckBy, ')
          ..write('fieldDate: $fieldDate, ')
          ..write('officeCheckBy: $officeCheckBy, ')
          ..write('officeDate: $officeDate')
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
  static const VerificationMeta _notAssessedMeta =
      const VerificationMeta('notAssessed');
  @override
  late final GeneratedColumn<bool> notAssessed = GeneratedColumn<bool>(
      'not_assessed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("not_assessed" IN (0, 1))'),
      defaultValue: const Constant(false));
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
      [id, surveyId, measDate, numTransects, notAssessed, complete];
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
    if (data.containsKey('not_assessed')) {
      context.handle(
          _notAssessedMeta,
          notAssessed.isAcceptableOrUnknown(
              data['not_assessed']!, _notAssessedMeta));
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
      notAssessed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}not_assessed'])!,
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
  final bool notAssessed;
  final bool complete;
  const WoodyDebrisSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      this.numTransects,
      required this.notAssessed,
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
    map['not_assessed'] = Variable<bool>(notAssessed);
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
      notAssessed: Value(notAssessed),
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
      notAssessed: serializer.fromJson<bool>(json['notAssessed']),
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
      'notAssessed': serializer.toJson<bool>(notAssessed),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  WoodyDebrisSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          Value<int?> numTransects = const Value.absent(),
          bool? notAssessed,
          bool? complete}) =>
      WoodyDebrisSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        numTransects:
            numTransects.present ? numTransects.value : this.numTransects,
        notAssessed: notAssessed ?? this.notAssessed,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('WoodyDebrisSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('numTransects: $numTransects, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surveyId, measDate, numTransects, notAssessed, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WoodyDebrisSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.numTransects == this.numTransects &&
          other.notAssessed == this.notAssessed &&
          other.complete == this.complete);
}

class WoodyDebrisSummaryCompanion
    extends UpdateCompanion<WoodyDebrisSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<int?> numTransects;
  final Value<bool> notAssessed;
  final Value<bool> complete;
  const WoodyDebrisSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.numTransects = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  });
  WoodyDebrisSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    this.numTransects = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate);
  static Insertable<WoodyDebrisSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<int>? numTransects,
    Expression<bool>? notAssessed,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (numTransects != null) 'num_transects': numTransects,
      if (notAssessed != null) 'not_assessed': notAssessed,
      if (complete != null) 'complete': complete,
    });
  }

  WoodyDebrisSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<int?>? numTransects,
      Value<bool>? notAssessed,
      Value<bool>? complete}) {
    return WoodyDebrisSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      numTransects: numTransects ?? this.numTransects,
      notAssessed: notAssessed ?? this.notAssessed,
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
    if (notAssessed.present) {
      map['not_assessed'] = Variable<bool>(notAssessed.value);
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
          ..write('notAssessed: $notAssessed, ')
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
  static const VerificationMeta _notAssessedMeta =
      const VerificationMeta('notAssessed');
  @override
  late final GeneratedColumn<bool> notAssessed = GeneratedColumn<bool>(
      'not_assessed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("not_assessed" IN (0, 1))'),
      defaultValue: const Constant(false));
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
      [id, surveyId, measDate, numTransects, notAssessed, complete];
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
    if (data.containsKey('not_assessed')) {
      context.handle(
          _notAssessedMeta,
          notAssessed.isAcceptableOrUnknown(
              data['not_assessed']!, _notAssessedMeta));
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
      notAssessed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}not_assessed'])!,
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
  final bool notAssessed;
  final bool complete;
  const SurfaceSubstrateSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      this.numTransects,
      required this.notAssessed,
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
    map['not_assessed'] = Variable<bool>(notAssessed);
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
      notAssessed: Value(notAssessed),
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
      notAssessed: serializer.fromJson<bool>(json['notAssessed']),
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
      'notAssessed': serializer.toJson<bool>(notAssessed),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  SurfaceSubstrateSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          Value<int?> numTransects = const Value.absent(),
          bool? notAssessed,
          bool? complete}) =>
      SurfaceSubstrateSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        numTransects:
            numTransects.present ? numTransects.value : this.numTransects,
        notAssessed: notAssessed ?? this.notAssessed,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('SurfaceSubstrateSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('numTransects: $numTransects, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surveyId, measDate, numTransects, notAssessed, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SurfaceSubstrateSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.numTransects == this.numTransects &&
          other.notAssessed == this.notAssessed &&
          other.complete == this.complete);
}

class SurfaceSubstrateSummaryCompanion
    extends UpdateCompanion<SurfaceSubstrateSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<int?> numTransects;
  final Value<bool> notAssessed;
  final Value<bool> complete;
  const SurfaceSubstrateSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.numTransects = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  });
  SurfaceSubstrateSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    this.numTransects = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate);
  static Insertable<SurfaceSubstrateSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<int>? numTransects,
    Expression<bool>? notAssessed,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (numTransects != null) 'num_transects': numTransects,
      if (notAssessed != null) 'not_assessed': notAssessed,
      if (complete != null) 'complete': complete,
    });
  }

  SurfaceSubstrateSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<int?>? numTransects,
      Value<bool>? notAssessed,
      Value<bool>? complete}) {
    return SurfaceSubstrateSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      numTransects: numTransects ?? this.numTransects,
      notAssessed: notAssessed ?? this.notAssessed,
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
    if (notAssessed.present) {
      map['not_assessed'] = Variable<bool>(notAssessed.value);
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
          ..write('notAssessed: $notAssessed, ')
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
  static const VerificationMeta _notAssessedMeta =
      const VerificationMeta('notAssessed');
  @override
  late final GeneratedColumn<bool> notAssessed = GeneratedColumn<bool>(
      'not_assessed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("not_assessed" IN (0, 1))'),
      defaultValue: const Constant(false));
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
      [id, surveyId, measDate, numEcps, notAssessed, complete];
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
    if (data.containsKey('not_assessed')) {
      context.handle(
          _notAssessedMeta,
          notAssessed.isAcceptableOrUnknown(
              data['not_assessed']!, _notAssessedMeta));
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
      notAssessed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}not_assessed'])!,
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
  final bool notAssessed;
  final bool complete;
  const EcpSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      this.numEcps,
      required this.notAssessed,
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
    map['not_assessed'] = Variable<bool>(notAssessed);
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
      notAssessed: Value(notAssessed),
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
      notAssessed: serializer.fromJson<bool>(json['notAssessed']),
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
      'notAssessed': serializer.toJson<bool>(notAssessed),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  EcpSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          Value<int?> numEcps = const Value.absent(),
          bool? notAssessed,
          bool? complete}) =>
      EcpSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        numEcps: numEcps.present ? numEcps.value : this.numEcps,
        notAssessed: notAssessed ?? this.notAssessed,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('EcpSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('numEcps: $numEcps, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surveyId, measDate, numEcps, notAssessed, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EcpSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.numEcps == this.numEcps &&
          other.notAssessed == this.notAssessed &&
          other.complete == this.complete);
}

class EcpSummaryCompanion extends UpdateCompanion<EcpSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<int?> numEcps;
  final Value<bool> notAssessed;
  final Value<bool> complete;
  const EcpSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.numEcps = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  });
  EcpSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    this.numEcps = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate);
  static Insertable<EcpSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<int>? numEcps,
    Expression<bool>? notAssessed,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (numEcps != null) 'num_ecps': numEcps,
      if (notAssessed != null) 'not_assessed': notAssessed,
      if (complete != null) 'complete': complete,
    });
  }

  EcpSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<int?>? numEcps,
      Value<bool>? notAssessed,
      Value<bool>? complete}) {
    return EcpSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      numEcps: numEcps ?? this.numEcps,
      notAssessed: notAssessed ?? this.notAssessed,
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
    if (notAssessed.present) {
      map['not_assessed'] = Variable<bool>(notAssessed.value);
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
          ..write('notAssessed: $notAssessed, ')
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
  static const VerificationMeta _notAssessedMeta =
      const VerificationMeta('notAssessed');
  @override
  late final GeneratedColumn<bool> notAssessed = GeneratedColumn<bool>(
      'not_assessed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("not_assessed" IN (0, 1))'),
      defaultValue: const Constant(false));
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
      [id, surveyId, measDate, notAssessed, complete];
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
    if (data.containsKey('not_assessed')) {
      context.handle(
          _notAssessedMeta,
          notAssessed.isAcceptableOrUnknown(
              data['not_assessed']!, _notAssessedMeta));
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
      notAssessed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}not_assessed'])!,
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
  final bool notAssessed;
  final bool complete;
  const SoilPitSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      required this.notAssessed,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['meas_date'] = Variable<DateTime>(measDate);
    map['not_assessed'] = Variable<bool>(notAssessed);
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  SoilPitSummaryCompanion toCompanion(bool nullToAbsent) {
    return SoilPitSummaryCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      measDate: Value(measDate),
      notAssessed: Value(notAssessed),
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
      notAssessed: serializer.fromJson<bool>(json['notAssessed']),
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
      'notAssessed': serializer.toJson<bool>(notAssessed),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  SoilPitSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          bool? notAssessed,
          bool? complete}) =>
      SoilPitSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        notAssessed: notAssessed ?? this.notAssessed,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surveyId, measDate, notAssessed, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilPitSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.notAssessed == this.notAssessed &&
          other.complete == this.complete);
}

class SoilPitSummaryCompanion extends UpdateCompanion<SoilPitSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<bool> notAssessed;
  final Value<bool> complete;
  const SoilPitSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  });
  SoilPitSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate);
  static Insertable<SoilPitSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<bool>? notAssessed,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (notAssessed != null) 'not_assessed': notAssessed,
      if (complete != null) 'complete': complete,
    });
  }

  SoilPitSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<bool>? notAssessed,
      Value<bool>? complete}) {
    return SoilPitSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      notAssessed: notAssessed ?? this.notAssessed,
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
    if (notAssessed.present) {
      map['not_assessed'] = Variable<bool>(notAssessed.value);
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
          ..write('notAssessed: $notAssessed, ')
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
  static const VerificationMeta _soilClassOrderMeta =
      const VerificationMeta('soilClassOrder');
  @override
  late final GeneratedColumn<String> soilClassOrder = GeneratedColumn<String>(
      'soil_class_order', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _soilClassGreatGroupMeta =
      const VerificationMeta('soilClassGreatGroup');
  @override
  late final GeneratedColumn<String> soilClassGreatGroup =
      GeneratedColumn<String>('soil_class_great_group', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _soilClassSubGroupMeta =
      const VerificationMeta('soilClassSubGroup');
  @override
  late final GeneratedColumn<String> soilClassSubGroup =
      GeneratedColumn<String>('soil_class_sub_group', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
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
  late final GeneratedColumn<double> profileDepth = GeneratedColumn<double>(
      'profile_depth', aliasedName, false,
      check: () => profileDepth.isBetweenValues(-1, 250),
      type: DriftSqlType.double,
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
        soilClassOrder,
        soilClassGreatGroup,
        soilClassSubGroup,
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
    if (data.containsKey('soil_class_order')) {
      context.handle(
          _soilClassOrderMeta,
          soilClassOrder.isAcceptableOrUnknown(
              data['soil_class_order']!, _soilClassOrderMeta));
    } else if (isInserting) {
      context.missing(_soilClassOrderMeta);
    }
    if (data.containsKey('soil_class_great_group')) {
      context.handle(
          _soilClassGreatGroupMeta,
          soilClassGreatGroup.isAcceptableOrUnknown(
              data['soil_class_great_group']!, _soilClassGreatGroupMeta));
    } else if (isInserting) {
      context.missing(_soilClassGreatGroupMeta);
    }
    if (data.containsKey('soil_class_sub_group')) {
      context.handle(
          _soilClassSubGroupMeta,
          soilClassSubGroup.isAcceptableOrUnknown(
              data['soil_class_sub_group']!, _soilClassSubGroupMeta));
    } else if (isInserting) {
      context.missing(_soilClassSubGroupMeta);
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
      soilClassOrder: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}soil_class_order'])!,
      soilClassGreatGroup: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}soil_class_great_group'])!,
      soilClassSubGroup: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}soil_class_sub_group'])!,
      soilClass: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}soil_class'])!,
      profileDepth: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}profile_depth'])!,
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
  final String soilClassOrder;
  final String soilClassGreatGroup;
  final String soilClassSubGroup;
  final String soilClass;
  final double profileDepth;
  final int drainage;
  final int moisture;
  final String deposition;
  final String humusForm;
  const SoilSiteInfoData(
      {required this.id,
      required this.soilPitSummaryId,
      required this.soilClassOrder,
      required this.soilClassGreatGroup,
      required this.soilClassSubGroup,
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
    map['soil_class_order'] = Variable<String>(soilClassOrder);
    map['soil_class_great_group'] = Variable<String>(soilClassGreatGroup);
    map['soil_class_sub_group'] = Variable<String>(soilClassSubGroup);
    map['soil_class'] = Variable<String>(soilClass);
    map['profile_depth'] = Variable<double>(profileDepth);
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
      soilClassOrder: Value(soilClassOrder),
      soilClassGreatGroup: Value(soilClassGreatGroup),
      soilClassSubGroup: Value(soilClassSubGroup),
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
      soilClassOrder: serializer.fromJson<String>(json['soilClassOrder']),
      soilClassGreatGroup:
          serializer.fromJson<String>(json['soilClassGreatGroup']),
      soilClassSubGroup: serializer.fromJson<String>(json['soilClassSubGroup']),
      soilClass: serializer.fromJson<String>(json['soilClass']),
      profileDepth: serializer.fromJson<double>(json['profileDepth']),
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
      'soilClassOrder': serializer.toJson<String>(soilClassOrder),
      'soilClassGreatGroup': serializer.toJson<String>(soilClassGreatGroup),
      'soilClassSubGroup': serializer.toJson<String>(soilClassSubGroup),
      'soilClass': serializer.toJson<String>(soilClass),
      'profileDepth': serializer.toJson<double>(profileDepth),
      'drainage': serializer.toJson<int>(drainage),
      'moisture': serializer.toJson<int>(moisture),
      'deposition': serializer.toJson<String>(deposition),
      'humusForm': serializer.toJson<String>(humusForm),
    };
  }

  SoilSiteInfoData copyWith(
          {int? id,
          int? soilPitSummaryId,
          String? soilClassOrder,
          String? soilClassGreatGroup,
          String? soilClassSubGroup,
          String? soilClass,
          double? profileDepth,
          int? drainage,
          int? moisture,
          String? deposition,
          String? humusForm}) =>
      SoilSiteInfoData(
        id: id ?? this.id,
        soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
        soilClassOrder: soilClassOrder ?? this.soilClassOrder,
        soilClassGreatGroup: soilClassGreatGroup ?? this.soilClassGreatGroup,
        soilClassSubGroup: soilClassSubGroup ?? this.soilClassSubGroup,
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
          ..write('soilClassOrder: $soilClassOrder, ')
          ..write('soilClassGreatGroup: $soilClassGreatGroup, ')
          ..write('soilClassSubGroup: $soilClassSubGroup, ')
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
  int get hashCode => Object.hash(
      id,
      soilPitSummaryId,
      soilClassOrder,
      soilClassGreatGroup,
      soilClassSubGroup,
      soilClass,
      profileDepth,
      drainage,
      moisture,
      deposition,
      humusForm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilSiteInfoData &&
          other.id == this.id &&
          other.soilPitSummaryId == this.soilPitSummaryId &&
          other.soilClassOrder == this.soilClassOrder &&
          other.soilClassGreatGroup == this.soilClassGreatGroup &&
          other.soilClassSubGroup == this.soilClassSubGroup &&
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
  final Value<String> soilClassOrder;
  final Value<String> soilClassGreatGroup;
  final Value<String> soilClassSubGroup;
  final Value<String> soilClass;
  final Value<double> profileDepth;
  final Value<int> drainage;
  final Value<int> moisture;
  final Value<String> deposition;
  final Value<String> humusForm;
  const SoilSiteInfoCompanion({
    this.id = const Value.absent(),
    this.soilPitSummaryId = const Value.absent(),
    this.soilClassOrder = const Value.absent(),
    this.soilClassGreatGroup = const Value.absent(),
    this.soilClassSubGroup = const Value.absent(),
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
    required String soilClassOrder,
    required String soilClassGreatGroup,
    required String soilClassSubGroup,
    required String soilClass,
    required double profileDepth,
    required int drainage,
    required int moisture,
    required String deposition,
    required String humusForm,
  })  : soilPitSummaryId = Value(soilPitSummaryId),
        soilClassOrder = Value(soilClassOrder),
        soilClassGreatGroup = Value(soilClassGreatGroup),
        soilClassSubGroup = Value(soilClassSubGroup),
        soilClass = Value(soilClass),
        profileDepth = Value(profileDepth),
        drainage = Value(drainage),
        moisture = Value(moisture),
        deposition = Value(deposition),
        humusForm = Value(humusForm);
  static Insertable<SoilSiteInfoData> custom({
    Expression<int>? id,
    Expression<int>? soilPitSummaryId,
    Expression<String>? soilClassOrder,
    Expression<String>? soilClassGreatGroup,
    Expression<String>? soilClassSubGroup,
    Expression<String>? soilClass,
    Expression<double>? profileDepth,
    Expression<int>? drainage,
    Expression<int>? moisture,
    Expression<String>? deposition,
    Expression<String>? humusForm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soilPitSummaryId != null) 'soil_pit_summary_id': soilPitSummaryId,
      if (soilClassOrder != null) 'soil_class_order': soilClassOrder,
      if (soilClassGreatGroup != null)
        'soil_class_great_group': soilClassGreatGroup,
      if (soilClassSubGroup != null) 'soil_class_sub_group': soilClassSubGroup,
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
      Value<String>? soilClassOrder,
      Value<String>? soilClassGreatGroup,
      Value<String>? soilClassSubGroup,
      Value<String>? soilClass,
      Value<double>? profileDepth,
      Value<int>? drainage,
      Value<int>? moisture,
      Value<String>? deposition,
      Value<String>? humusForm}) {
    return SoilSiteInfoCompanion(
      id: id ?? this.id,
      soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
      soilClassOrder: soilClassOrder ?? this.soilClassOrder,
      soilClassGreatGroup: soilClassGreatGroup ?? this.soilClassGreatGroup,
      soilClassSubGroup: soilClassSubGroup ?? this.soilClassSubGroup,
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
    if (soilClassOrder.present) {
      map['soil_class_order'] = Variable<String>(soilClassOrder.value);
    }
    if (soilClassGreatGroup.present) {
      map['soil_class_great_group'] =
          Variable<String>(soilClassGreatGroup.value);
    }
    if (soilClassSubGroup.present) {
      map['soil_class_sub_group'] = Variable<String>(soilClassSubGroup.value);
    }
    if (soilClass.present) {
      map['soil_class'] = Variable<String>(soilClass.value);
    }
    if (profileDepth.present) {
      map['profile_depth'] = Variable<double>(profileDepth.value);
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
          ..write('soilClassOrder: $soilClassOrder, ')
          ..write('soilClassGreatGroup: $soilClassGreatGroup, ')
          ..write('soilClassSubGroup: $soilClassSubGroup, ')
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
          'REFERENCES soil_pit_summary (id)'));
  static const VerificationMeta _soilPitCodeMeta =
      const VerificationMeta('soilPitCode');
  @override
  late final GeneratedColumn<String> soilPitCode = GeneratedColumn<String>(
      'soil_pit_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _soilFeatureMeta =
      const VerificationMeta('soilFeature');
  @override
  late final GeneratedColumn<String> soilFeature = GeneratedColumn<String>(
      'soil_feature', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1),
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
      [id, soilPitSummaryId, soilPitCode, soilFeature, depthFeature];
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
    if (data.containsKey('soil_pit_code')) {
      context.handle(
          _soilPitCodeMeta,
          soilPitCode.isAcceptableOrUnknown(
              data['soil_pit_code']!, _soilPitCodeMeta));
    } else if (isInserting) {
      context.missing(_soilPitCodeMeta);
    }
    if (data.containsKey('soil_feature')) {
      context.handle(
          _soilFeatureMeta,
          soilFeature.isAcceptableOrUnknown(
              data['soil_feature']!, _soilFeatureMeta));
    } else if (isInserting) {
      context.missing(_soilFeatureMeta);
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
      soilPitCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}soil_pit_code'])!,
      soilFeature: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}soil_feature'])!,
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
  final String soilPitCode;
  final String soilFeature;
  final int depthFeature;
  const SoilPitFeatureData(
      {required this.id,
      required this.soilPitSummaryId,
      required this.soilPitCode,
      required this.soilFeature,
      required this.depthFeature});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['soil_pit_summary_id'] = Variable<int>(soilPitSummaryId);
    map['soil_pit_code'] = Variable<String>(soilPitCode);
    map['soil_feature'] = Variable<String>(soilFeature);
    map['depth_feature'] = Variable<int>(depthFeature);
    return map;
  }

  SoilPitFeatureCompanion toCompanion(bool nullToAbsent) {
    return SoilPitFeatureCompanion(
      id: Value(id),
      soilPitSummaryId: Value(soilPitSummaryId),
      soilPitCode: Value(soilPitCode),
      soilFeature: Value(soilFeature),
      depthFeature: Value(depthFeature),
    );
  }

  factory SoilPitFeatureData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitFeatureData(
      id: serializer.fromJson<int>(json['id']),
      soilPitSummaryId: serializer.fromJson<int>(json['soilPitSummaryId']),
      soilPitCode: serializer.fromJson<String>(json['soilPitCode']),
      soilFeature: serializer.fromJson<String>(json['soilFeature']),
      depthFeature: serializer.fromJson<int>(json['depthFeature']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soilPitSummaryId': serializer.toJson<int>(soilPitSummaryId),
      'soilPitCode': serializer.toJson<String>(soilPitCode),
      'soilFeature': serializer.toJson<String>(soilFeature),
      'depthFeature': serializer.toJson<int>(depthFeature),
    };
  }

  SoilPitFeatureData copyWith(
          {int? id,
          int? soilPitSummaryId,
          String? soilPitCode,
          String? soilFeature,
          int? depthFeature}) =>
      SoilPitFeatureData(
        id: id ?? this.id,
        soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
        soilPitCode: soilPitCode ?? this.soilPitCode,
        soilFeature: soilFeature ?? this.soilFeature,
        depthFeature: depthFeature ?? this.depthFeature,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitFeatureData(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilPitCode: $soilPitCode, ')
          ..write('soilFeature: $soilFeature, ')
          ..write('depthFeature: $depthFeature')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, soilPitSummaryId, soilPitCode, soilFeature, depthFeature);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilPitFeatureData &&
          other.id == this.id &&
          other.soilPitSummaryId == this.soilPitSummaryId &&
          other.soilPitCode == this.soilPitCode &&
          other.soilFeature == this.soilFeature &&
          other.depthFeature == this.depthFeature);
}

class SoilPitFeatureCompanion extends UpdateCompanion<SoilPitFeatureData> {
  final Value<int> id;
  final Value<int> soilPitSummaryId;
  final Value<String> soilPitCode;
  final Value<String> soilFeature;
  final Value<int> depthFeature;
  const SoilPitFeatureCompanion({
    this.id = const Value.absent(),
    this.soilPitSummaryId = const Value.absent(),
    this.soilPitCode = const Value.absent(),
    this.soilFeature = const Value.absent(),
    this.depthFeature = const Value.absent(),
  });
  SoilPitFeatureCompanion.insert({
    this.id = const Value.absent(),
    required int soilPitSummaryId,
    required String soilPitCode,
    required String soilFeature,
    required int depthFeature,
  })  : soilPitSummaryId = Value(soilPitSummaryId),
        soilPitCode = Value(soilPitCode),
        soilFeature = Value(soilFeature),
        depthFeature = Value(depthFeature);
  static Insertable<SoilPitFeatureData> custom({
    Expression<int>? id,
    Expression<int>? soilPitSummaryId,
    Expression<String>? soilPitCode,
    Expression<String>? soilFeature,
    Expression<int>? depthFeature,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soilPitSummaryId != null) 'soil_pit_summary_id': soilPitSummaryId,
      if (soilPitCode != null) 'soil_pit_code': soilPitCode,
      if (soilFeature != null) 'soil_feature': soilFeature,
      if (depthFeature != null) 'depth_feature': depthFeature,
    });
  }

  SoilPitFeatureCompanion copyWith(
      {Value<int>? id,
      Value<int>? soilPitSummaryId,
      Value<String>? soilPitCode,
      Value<String>? soilFeature,
      Value<int>? depthFeature}) {
    return SoilPitFeatureCompanion(
      id: id ?? this.id,
      soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
      soilPitCode: soilPitCode ?? this.soilPitCode,
      soilFeature: soilFeature ?? this.soilFeature,
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
    if (soilPitCode.present) {
      map['soil_pit_code'] = Variable<String>(soilPitCode.value);
    }
    if (soilFeature.present) {
      map['soil_feature'] = Variable<String>(soilFeature.value);
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
          ..write('soilPitCode: $soilPitCode, ')
          ..write('soilFeature: $soilFeature, ')
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
          'REFERENCES soil_pit_summary (id)'));
  static const VerificationMeta _soilPitCodeFieldMeta =
      const VerificationMeta('soilPitCodeField');
  @override
  late final GeneratedColumn<String> soilPitCodeField = GeneratedColumn<String>(
      'soil_pit_code_field', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
  static const VerificationMeta _mineralTypeMeta =
      const VerificationMeta('mineralType');
  @override
  late final GeneratedColumn<String> mineralType = GeneratedColumn<String>(
      'mineral_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _textureMeta =
      const VerificationMeta('texture');
  @override
  late final GeneratedColumn<String> texture = GeneratedColumn<String>(
      'texture', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 5),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cfGravMeta = const VerificationMeta('cfGrav');
  @override
  late final GeneratedColumn<int> cfGrav = GeneratedColumn<int>(
      'cf_grav', aliasedName, false,
      check: () => cfGrav.isBetweenValues(-9, 100),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _cfCobbMeta = const VerificationMeta('cfCobb');
  @override
  late final GeneratedColumn<int> cfCobb = GeneratedColumn<int>(
      'cf_cobb', aliasedName, false,
      check: () => cfCobb.isBetweenValues(-9, 100),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _cfStoneMeta =
      const VerificationMeta('cfStone');
  @override
  late final GeneratedColumn<int> cfStone = GeneratedColumn<int>(
      'cf_stone', aliasedName, false,
      check: () => cfStone.isBetweenValues(-9, 100),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        soilPitSummaryId,
        soilPitCodeField,
        horizonNum,
        horizon,
        horizonUpper,
        thickness,
        color,
        mineralType,
        texture,
        cfGrav,
        cfCobb,
        cfStone
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
    if (data.containsKey('soil_pit_code_field')) {
      context.handle(
          _soilPitCodeFieldMeta,
          soilPitCodeField.isAcceptableOrUnknown(
              data['soil_pit_code_field']!, _soilPitCodeFieldMeta));
    } else if (isInserting) {
      context.missing(_soilPitCodeFieldMeta);
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
    if (data.containsKey('mineral_type')) {
      context.handle(
          _mineralTypeMeta,
          mineralType.isAcceptableOrUnknown(
              data['mineral_type']!, _mineralTypeMeta));
    } else if (isInserting) {
      context.missing(_mineralTypeMeta);
    }
    if (data.containsKey('texture')) {
      context.handle(_textureMeta,
          texture.isAcceptableOrUnknown(data['texture']!, _textureMeta));
    } else if (isInserting) {
      context.missing(_textureMeta);
    }
    if (data.containsKey('cf_grav')) {
      context.handle(_cfGravMeta,
          cfGrav.isAcceptableOrUnknown(data['cf_grav']!, _cfGravMeta));
    } else if (isInserting) {
      context.missing(_cfGravMeta);
    }
    if (data.containsKey('cf_cobb')) {
      context.handle(_cfCobbMeta,
          cfCobb.isAcceptableOrUnknown(data['cf_cobb']!, _cfCobbMeta));
    } else if (isInserting) {
      context.missing(_cfCobbMeta);
    }
    if (data.containsKey('cf_stone')) {
      context.handle(_cfStoneMeta,
          cfStone.isAcceptableOrUnknown(data['cf_stone']!, _cfStoneMeta));
    } else if (isInserting) {
      context.missing(_cfStoneMeta);
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
      soilPitCodeField: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}soil_pit_code_field'])!,
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
      mineralType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mineral_type'])!,
      texture: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}texture'])!,
      cfGrav: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cf_grav'])!,
      cfCobb: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cf_cobb'])!,
      cfStone: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cf_stone'])!,
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
  final String soilPitCodeField;
  final int horizonNum;
  final String horizon;
  final double horizonUpper;
  final double thickness;
  final String color;
  final String mineralType;
  final String texture;
  final int cfGrav;
  final int cfCobb;
  final int cfStone;
  const SoilPitHorizonDescriptionData(
      {required this.id,
      required this.soilPitSummaryId,
      required this.soilPitCodeField,
      required this.horizonNum,
      required this.horizon,
      required this.horizonUpper,
      required this.thickness,
      required this.color,
      required this.mineralType,
      required this.texture,
      required this.cfGrav,
      required this.cfCobb,
      required this.cfStone});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['soil_pit_summary_id'] = Variable<int>(soilPitSummaryId);
    map['soil_pit_code_field'] = Variable<String>(soilPitCodeField);
    map['horizon_num'] = Variable<int>(horizonNum);
    map['horizon'] = Variable<String>(horizon);
    map['horizon_upper'] = Variable<double>(horizonUpper);
    map['thickness'] = Variable<double>(thickness);
    map['color'] = Variable<String>(color);
    map['mineral_type'] = Variable<String>(mineralType);
    map['texture'] = Variable<String>(texture);
    map['cf_grav'] = Variable<int>(cfGrav);
    map['cf_cobb'] = Variable<int>(cfCobb);
    map['cf_stone'] = Variable<int>(cfStone);
    return map;
  }

  SoilPitHorizonDescriptionCompanion toCompanion(bool nullToAbsent) {
    return SoilPitHorizonDescriptionCompanion(
      id: Value(id),
      soilPitSummaryId: Value(soilPitSummaryId),
      soilPitCodeField: Value(soilPitCodeField),
      horizonNum: Value(horizonNum),
      horizon: Value(horizon),
      horizonUpper: Value(horizonUpper),
      thickness: Value(thickness),
      color: Value(color),
      mineralType: Value(mineralType),
      texture: Value(texture),
      cfGrav: Value(cfGrav),
      cfCobb: Value(cfCobb),
      cfStone: Value(cfStone),
    );
  }

  factory SoilPitHorizonDescriptionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SoilPitHorizonDescriptionData(
      id: serializer.fromJson<int>(json['id']),
      soilPitSummaryId: serializer.fromJson<int>(json['soilPitSummaryId']),
      soilPitCodeField: serializer.fromJson<String>(json['soilPitCodeField']),
      horizonNum: serializer.fromJson<int>(json['horizonNum']),
      horizon: serializer.fromJson<String>(json['horizon']),
      horizonUpper: serializer.fromJson<double>(json['horizonUpper']),
      thickness: serializer.fromJson<double>(json['thickness']),
      color: serializer.fromJson<String>(json['color']),
      mineralType: serializer.fromJson<String>(json['mineralType']),
      texture: serializer.fromJson<String>(json['texture']),
      cfGrav: serializer.fromJson<int>(json['cfGrav']),
      cfCobb: serializer.fromJson<int>(json['cfCobb']),
      cfStone: serializer.fromJson<int>(json['cfStone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'soilPitSummaryId': serializer.toJson<int>(soilPitSummaryId),
      'soilPitCodeField': serializer.toJson<String>(soilPitCodeField),
      'horizonNum': serializer.toJson<int>(horizonNum),
      'horizon': serializer.toJson<String>(horizon),
      'horizonUpper': serializer.toJson<double>(horizonUpper),
      'thickness': serializer.toJson<double>(thickness),
      'color': serializer.toJson<String>(color),
      'mineralType': serializer.toJson<String>(mineralType),
      'texture': serializer.toJson<String>(texture),
      'cfGrav': serializer.toJson<int>(cfGrav),
      'cfCobb': serializer.toJson<int>(cfCobb),
      'cfStone': serializer.toJson<int>(cfStone),
    };
  }

  SoilPitHorizonDescriptionData copyWith(
          {int? id,
          int? soilPitSummaryId,
          String? soilPitCodeField,
          int? horizonNum,
          String? horizon,
          double? horizonUpper,
          double? thickness,
          String? color,
          String? mineralType,
          String? texture,
          int? cfGrav,
          int? cfCobb,
          int? cfStone}) =>
      SoilPitHorizonDescriptionData(
        id: id ?? this.id,
        soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
        soilPitCodeField: soilPitCodeField ?? this.soilPitCodeField,
        horizonNum: horizonNum ?? this.horizonNum,
        horizon: horizon ?? this.horizon,
        horizonUpper: horizonUpper ?? this.horizonUpper,
        thickness: thickness ?? this.thickness,
        color: color ?? this.color,
        mineralType: mineralType ?? this.mineralType,
        texture: texture ?? this.texture,
        cfGrav: cfGrav ?? this.cfGrav,
        cfCobb: cfCobb ?? this.cfCobb,
        cfStone: cfStone ?? this.cfStone,
      );
  @override
  String toString() {
    return (StringBuffer('SoilPitHorizonDescriptionData(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilPitCodeField: $soilPitCodeField, ')
          ..write('horizonNum: $horizonNum, ')
          ..write('horizon: $horizon, ')
          ..write('horizonUpper: $horizonUpper, ')
          ..write('thickness: $thickness, ')
          ..write('color: $color, ')
          ..write('mineralType: $mineralType, ')
          ..write('texture: $texture, ')
          ..write('cfGrav: $cfGrav, ')
          ..write('cfCobb: $cfCobb, ')
          ..write('cfStone: $cfStone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      soilPitSummaryId,
      soilPitCodeField,
      horizonNum,
      horizon,
      horizonUpper,
      thickness,
      color,
      mineralType,
      texture,
      cfGrav,
      cfCobb,
      cfStone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SoilPitHorizonDescriptionData &&
          other.id == this.id &&
          other.soilPitSummaryId == this.soilPitSummaryId &&
          other.soilPitCodeField == this.soilPitCodeField &&
          other.horizonNum == this.horizonNum &&
          other.horizon == this.horizon &&
          other.horizonUpper == this.horizonUpper &&
          other.thickness == this.thickness &&
          other.color == this.color &&
          other.mineralType == this.mineralType &&
          other.texture == this.texture &&
          other.cfGrav == this.cfGrav &&
          other.cfCobb == this.cfCobb &&
          other.cfStone == this.cfStone);
}

class SoilPitHorizonDescriptionCompanion
    extends UpdateCompanion<SoilPitHorizonDescriptionData> {
  final Value<int> id;
  final Value<int> soilPitSummaryId;
  final Value<String> soilPitCodeField;
  final Value<int> horizonNum;
  final Value<String> horizon;
  final Value<double> horizonUpper;
  final Value<double> thickness;
  final Value<String> color;
  final Value<String> mineralType;
  final Value<String> texture;
  final Value<int> cfGrav;
  final Value<int> cfCobb;
  final Value<int> cfStone;
  const SoilPitHorizonDescriptionCompanion({
    this.id = const Value.absent(),
    this.soilPitSummaryId = const Value.absent(),
    this.soilPitCodeField = const Value.absent(),
    this.horizonNum = const Value.absent(),
    this.horizon = const Value.absent(),
    this.horizonUpper = const Value.absent(),
    this.thickness = const Value.absent(),
    this.color = const Value.absent(),
    this.mineralType = const Value.absent(),
    this.texture = const Value.absent(),
    this.cfGrav = const Value.absent(),
    this.cfCobb = const Value.absent(),
    this.cfStone = const Value.absent(),
  });
  SoilPitHorizonDescriptionCompanion.insert({
    this.id = const Value.absent(),
    required int soilPitSummaryId,
    required String soilPitCodeField,
    required int horizonNum,
    required String horizon,
    required double horizonUpper,
    required double thickness,
    required String color,
    required String mineralType,
    required String texture,
    required int cfGrav,
    required int cfCobb,
    required int cfStone,
  })  : soilPitSummaryId = Value(soilPitSummaryId),
        soilPitCodeField = Value(soilPitCodeField),
        horizonNum = Value(horizonNum),
        horizon = Value(horizon),
        horizonUpper = Value(horizonUpper),
        thickness = Value(thickness),
        color = Value(color),
        mineralType = Value(mineralType),
        texture = Value(texture),
        cfGrav = Value(cfGrav),
        cfCobb = Value(cfCobb),
        cfStone = Value(cfStone);
  static Insertable<SoilPitHorizonDescriptionData> custom({
    Expression<int>? id,
    Expression<int>? soilPitSummaryId,
    Expression<String>? soilPitCodeField,
    Expression<int>? horizonNum,
    Expression<String>? horizon,
    Expression<double>? horizonUpper,
    Expression<double>? thickness,
    Expression<String>? color,
    Expression<String>? mineralType,
    Expression<String>? texture,
    Expression<int>? cfGrav,
    Expression<int>? cfCobb,
    Expression<int>? cfStone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (soilPitSummaryId != null) 'soil_pit_summary_id': soilPitSummaryId,
      if (soilPitCodeField != null) 'soil_pit_code_field': soilPitCodeField,
      if (horizonNum != null) 'horizon_num': horizonNum,
      if (horizon != null) 'horizon': horizon,
      if (horizonUpper != null) 'horizon_upper': horizonUpper,
      if (thickness != null) 'thickness': thickness,
      if (color != null) 'color': color,
      if (mineralType != null) 'mineral_type': mineralType,
      if (texture != null) 'texture': texture,
      if (cfGrav != null) 'cf_grav': cfGrav,
      if (cfCobb != null) 'cf_cobb': cfCobb,
      if (cfStone != null) 'cf_stone': cfStone,
    });
  }

  SoilPitHorizonDescriptionCompanion copyWith(
      {Value<int>? id,
      Value<int>? soilPitSummaryId,
      Value<String>? soilPitCodeField,
      Value<int>? horizonNum,
      Value<String>? horizon,
      Value<double>? horizonUpper,
      Value<double>? thickness,
      Value<String>? color,
      Value<String>? mineralType,
      Value<String>? texture,
      Value<int>? cfGrav,
      Value<int>? cfCobb,
      Value<int>? cfStone}) {
    return SoilPitHorizonDescriptionCompanion(
      id: id ?? this.id,
      soilPitSummaryId: soilPitSummaryId ?? this.soilPitSummaryId,
      soilPitCodeField: soilPitCodeField ?? this.soilPitCodeField,
      horizonNum: horizonNum ?? this.horizonNum,
      horizon: horizon ?? this.horizon,
      horizonUpper: horizonUpper ?? this.horizonUpper,
      thickness: thickness ?? this.thickness,
      color: color ?? this.color,
      mineralType: mineralType ?? this.mineralType,
      texture: texture ?? this.texture,
      cfGrav: cfGrav ?? this.cfGrav,
      cfCobb: cfCobb ?? this.cfCobb,
      cfStone: cfStone ?? this.cfStone,
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
    if (mineralType.present) {
      map['mineral_type'] = Variable<String>(mineralType.value);
    }
    if (texture.present) {
      map['texture'] = Variable<String>(texture.value);
    }
    if (cfGrav.present) {
      map['cf_grav'] = Variable<int>(cfGrav.value);
    }
    if (cfCobb.present) {
      map['cf_cobb'] = Variable<int>(cfCobb.value);
    }
    if (cfStone.present) {
      map['cf_stone'] = Variable<int>(cfStone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SoilPitHorizonDescriptionCompanion(')
          ..write('id: $id, ')
          ..write('soilPitSummaryId: $soilPitSummaryId, ')
          ..write('soilPitCodeField: $soilPitCodeField, ')
          ..write('horizonNum: $horizonNum, ')
          ..write('horizon: $horizon, ')
          ..write('horizonUpper: $horizonUpper, ')
          ..write('thickness: $thickness, ')
          ..write('color: $color, ')
          ..write('mineralType: $mineralType, ')
          ..write('texture: $texture, ')
          ..write('cfGrav: $cfGrav, ')
          ..write('cfCobb: $cfCobb, ')
          ..write('cfStone: $cfStone')
          ..write(')'))
        .toString();
  }
}

class $LtpSummaryTable extends LtpSummary
    with TableInfo<$LtpSummaryTable, LtpSummaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpSummaryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _notAssessedMeta =
      const VerificationMeta('notAssessed');
  @override
  late final GeneratedColumn<bool> notAssessed = GeneratedColumn<bool>(
      'not_assessed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("not_assessed" IN (0, 1))'),
      defaultValue: const Constant(false));
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
      [id, surveyId, measDate, notAssessed, complete];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ltp_summary';
  @override
  VerificationContext validateIntegrity(Insertable<LtpSummaryData> instance,
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
    if (data.containsKey('not_assessed')) {
      context.handle(
          _notAssessedMeta,
          notAssessed.isAcceptableOrUnknown(
              data['not_assessed']!, _notAssessedMeta));
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
  LtpSummaryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpSummaryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      measDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}meas_date'])!,
      notAssessed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}not_assessed'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $LtpSummaryTable createAlias(String alias) {
    return $LtpSummaryTable(attachedDatabase, alias);
  }
}

class LtpSummaryData extends DataClass implements Insertable<LtpSummaryData> {
  final int id;
  final int surveyId;
  final DateTime measDate;
  final bool notAssessed;
  final bool complete;
  const LtpSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      required this.notAssessed,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['meas_date'] = Variable<DateTime>(measDate);
    map['not_assessed'] = Variable<bool>(notAssessed);
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  LtpSummaryCompanion toCompanion(bool nullToAbsent) {
    return LtpSummaryCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      measDate: Value(measDate),
      notAssessed: Value(notAssessed),
      complete: Value(complete),
    );
  }

  factory LtpSummaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpSummaryData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      measDate: serializer.fromJson<DateTime>(json['measDate']),
      notAssessed: serializer.fromJson<bool>(json['notAssessed']),
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
      'notAssessed': serializer.toJson<bool>(notAssessed),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  LtpSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          bool? notAssessed,
          bool? complete}) =>
      LtpSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        notAssessed: notAssessed ?? this.notAssessed,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('LtpSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, surveyId, measDate, notAssessed, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LtpSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.notAssessed == this.notAssessed &&
          other.complete == this.complete);
}

class LtpSummaryCompanion extends UpdateCompanion<LtpSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<bool> notAssessed;
  final Value<bool> complete;
  const LtpSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  });
  LtpSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate);
  static Insertable<LtpSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<bool>? notAssessed,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (notAssessed != null) 'not_assessed': notAssessed,
      if (complete != null) 'complete': complete,
    });
  }

  LtpSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<bool>? notAssessed,
      Value<bool>? complete}) {
    return LtpSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      notAssessed: notAssessed ?? this.notAssessed,
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
    if (notAssessed.present) {
      map['not_assessed'] = Variable<bool>(notAssessed.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LtpSummaryCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $LtpTreeTable extends LtpTree with TableInfo<$LtpTreeTable, LtpTreeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpTreeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lptSummaryIdMeta =
      const VerificationMeta('lptSummaryId');
  @override
  late final GeneratedColumn<int> lptSummaryId = GeneratedColumn<int>(
      'lpt_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ltp_summary (id)'));
  static const VerificationMeta _sectorMeta = const VerificationMeta('sector');
  @override
  late final GeneratedColumn<int> sector = GeneratedColumn<int>(
      'sector', aliasedName, false,
      check: () => sector.isBetweenValues(-1, 8),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _treeNumMeta =
      const VerificationMeta('treeNum');
  @override
  late final GeneratedColumn<int> treeNum = GeneratedColumn<int>(
      'tree_num', aliasedName, false,
      check: () => treeNum.isBetweenValues(1, 9999),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _origPlotAreaMeta =
      const VerificationMeta('origPlotArea');
  @override
  late final GeneratedColumn<String> origPlotArea = GeneratedColumn<String>(
      'orig_plot_area', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lgTreeGenusMeta =
      const VerificationMeta('lgTreeGenus');
  @override
  late final GeneratedColumn<String> lgTreeGenus = GeneratedColumn<String>(
      'lg_tree_genus', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lgTreeSpeciesMeta =
      const VerificationMeta('lgTreeSpecies');
  @override
  late final GeneratedColumn<String> lgTreeSpecies = GeneratedColumn<String>(
      'lg_tree_species', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lgTreeVarietyMeta =
      const VerificationMeta('lgTreeVariety');
  @override
  late final GeneratedColumn<String> lgTreeVariety = GeneratedColumn<String>(
      'lg_tree_variety', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lgTreeStatusMeta =
      const VerificationMeta('lgTreeStatus');
  @override
  late final GeneratedColumn<String> lgTreeStatus = GeneratedColumn<String>(
      'lg_tree_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dbhMeta = const VerificationMeta('dbh');
  @override
  late final GeneratedColumn<double> dbh = GeneratedColumn<double>(
      'dbh', aliasedName, false,
      check: () => dbh.isBetweenValues(-1, 999.9),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _measEstDbhMeta =
      const VerificationMeta('measEstDbh');
  @override
  late final GeneratedColumn<String> measEstDbh = GeneratedColumn<String>(
      'meas_est_dbh', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      check: () => height.isBetweenValues(-1, 99.9),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _measEstHeightMeta =
      const VerificationMeta('measEstHeight');
  @override
  late final GeneratedColumn<String> measEstHeight = GeneratedColumn<String>(
      'meas_est_height', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _crownClassMeta =
      const VerificationMeta('crownClass');
  @override
  late final GeneratedColumn<String> crownClass = GeneratedColumn<String>(
      'crown_class', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _crownBaseMeta =
      const VerificationMeta('crownBase');
  @override
  late final GeneratedColumn<double> crownBase = GeneratedColumn<double>(
      'crown_base', aliasedName, false,
      check: () => crownBase.isBetweenValues(-9, 99.9),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _crownTopMeta =
      const VerificationMeta('crownTop');
  @override
  late final GeneratedColumn<double> crownTop = GeneratedColumn<double>(
      'crown_top', aliasedName, false,
      check: () => crownTop.isBetweenValues(-9, 99.9),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _stemCondMeta =
      const VerificationMeta('stemCond');
  @override
  late final GeneratedColumn<String> stemCond = GeneratedColumn<String>(
      'stem_cond', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _crownCondMeta =
      const VerificationMeta('crownCond');
  @override
  late final GeneratedColumn<int> crownCond = GeneratedColumn<int>(
      'crown_cond', aliasedName, false,
      check: () => crownCond.isBetweenValues(-1, 6),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _barkRetMeta =
      const VerificationMeta('barkRet');
  @override
  late final GeneratedColumn<int> barkRet = GeneratedColumn<int>(
      'bark_ret', aliasedName, false,
      check: () => barkRet.isBetweenValues(-1, 7),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _woodCondMeta =
      const VerificationMeta('woodCond');
  @override
  late final GeneratedColumn<int> woodCond = GeneratedColumn<int>(
      'wood_cond', aliasedName, false,
      check: () => woodCond.isBetweenValues(-1, 8),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _azimuthMeta =
      const VerificationMeta('azimuth');
  @override
  late final GeneratedColumn<int> azimuth = GeneratedColumn<int>(
      'azimuth', aliasedName, false,
      check: () => azimuth.isBetweenValues(-1, 360),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _distanceMeta =
      const VerificationMeta('distance');
  @override
  late final GeneratedColumn<double> distance = GeneratedColumn<double>(
      'distance', aliasedName, false,
      check: () => distance.isBetweenValues(-1, 99.99),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _renumberedMeta =
      const VerificationMeta('renumbered');
  @override
  late final GeneratedColumn<int> renumbered = GeneratedColumn<int>(
      'renumbered', aliasedName, false,
      check: () => renumbered.isBetweenValues(-1, 360),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lptSummaryId,
        sector,
        treeNum,
        origPlotArea,
        lgTreeGenus,
        lgTreeSpecies,
        lgTreeVariety,
        lgTreeStatus,
        dbh,
        measEstDbh,
        height,
        measEstHeight,
        crownClass,
        crownBase,
        crownTop,
        stemCond,
        crownCond,
        barkRet,
        woodCond,
        azimuth,
        distance,
        renumbered
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ltp_tree';
  @override
  VerificationContext validateIntegrity(Insertable<LtpTreeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lpt_summary_id')) {
      context.handle(
          _lptSummaryIdMeta,
          lptSummaryId.isAcceptableOrUnknown(
              data['lpt_summary_id']!, _lptSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_lptSummaryIdMeta);
    }
    if (data.containsKey('sector')) {
      context.handle(_sectorMeta,
          sector.isAcceptableOrUnknown(data['sector']!, _sectorMeta));
    } else if (isInserting) {
      context.missing(_sectorMeta);
    }
    if (data.containsKey('tree_num')) {
      context.handle(_treeNumMeta,
          treeNum.isAcceptableOrUnknown(data['tree_num']!, _treeNumMeta));
    } else if (isInserting) {
      context.missing(_treeNumMeta);
    }
    if (data.containsKey('orig_plot_area')) {
      context.handle(
          _origPlotAreaMeta,
          origPlotArea.isAcceptableOrUnknown(
              data['orig_plot_area']!, _origPlotAreaMeta));
    } else if (isInserting) {
      context.missing(_origPlotAreaMeta);
    }
    if (data.containsKey('lg_tree_genus')) {
      context.handle(
          _lgTreeGenusMeta,
          lgTreeGenus.isAcceptableOrUnknown(
              data['lg_tree_genus']!, _lgTreeGenusMeta));
    } else if (isInserting) {
      context.missing(_lgTreeGenusMeta);
    }
    if (data.containsKey('lg_tree_species')) {
      context.handle(
          _lgTreeSpeciesMeta,
          lgTreeSpecies.isAcceptableOrUnknown(
              data['lg_tree_species']!, _lgTreeSpeciesMeta));
    } else if (isInserting) {
      context.missing(_lgTreeSpeciesMeta);
    }
    if (data.containsKey('lg_tree_variety')) {
      context.handle(
          _lgTreeVarietyMeta,
          lgTreeVariety.isAcceptableOrUnknown(
              data['lg_tree_variety']!, _lgTreeVarietyMeta));
    } else if (isInserting) {
      context.missing(_lgTreeVarietyMeta);
    }
    if (data.containsKey('lg_tree_status')) {
      context.handle(
          _lgTreeStatusMeta,
          lgTreeStatus.isAcceptableOrUnknown(
              data['lg_tree_status']!, _lgTreeStatusMeta));
    } else if (isInserting) {
      context.missing(_lgTreeStatusMeta);
    }
    if (data.containsKey('dbh')) {
      context.handle(
          _dbhMeta, dbh.isAcceptableOrUnknown(data['dbh']!, _dbhMeta));
    } else if (isInserting) {
      context.missing(_dbhMeta);
    }
    if (data.containsKey('meas_est_dbh')) {
      context.handle(
          _measEstDbhMeta,
          measEstDbh.isAcceptableOrUnknown(
              data['meas_est_dbh']!, _measEstDbhMeta));
    } else if (isInserting) {
      context.missing(_measEstDbhMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('meas_est_height')) {
      context.handle(
          _measEstHeightMeta,
          measEstHeight.isAcceptableOrUnknown(
              data['meas_est_height']!, _measEstHeightMeta));
    } else if (isInserting) {
      context.missing(_measEstHeightMeta);
    }
    if (data.containsKey('crown_class')) {
      context.handle(
          _crownClassMeta,
          crownClass.isAcceptableOrUnknown(
              data['crown_class']!, _crownClassMeta));
    } else if (isInserting) {
      context.missing(_crownClassMeta);
    }
    if (data.containsKey('crown_base')) {
      context.handle(_crownBaseMeta,
          crownBase.isAcceptableOrUnknown(data['crown_base']!, _crownBaseMeta));
    } else if (isInserting) {
      context.missing(_crownBaseMeta);
    }
    if (data.containsKey('crown_top')) {
      context.handle(_crownTopMeta,
          crownTop.isAcceptableOrUnknown(data['crown_top']!, _crownTopMeta));
    } else if (isInserting) {
      context.missing(_crownTopMeta);
    }
    if (data.containsKey('stem_cond')) {
      context.handle(_stemCondMeta,
          stemCond.isAcceptableOrUnknown(data['stem_cond']!, _stemCondMeta));
    } else if (isInserting) {
      context.missing(_stemCondMeta);
    }
    if (data.containsKey('crown_cond')) {
      context.handle(_crownCondMeta,
          crownCond.isAcceptableOrUnknown(data['crown_cond']!, _crownCondMeta));
    } else if (isInserting) {
      context.missing(_crownCondMeta);
    }
    if (data.containsKey('bark_ret')) {
      context.handle(_barkRetMeta,
          barkRet.isAcceptableOrUnknown(data['bark_ret']!, _barkRetMeta));
    } else if (isInserting) {
      context.missing(_barkRetMeta);
    }
    if (data.containsKey('wood_cond')) {
      context.handle(_woodCondMeta,
          woodCond.isAcceptableOrUnknown(data['wood_cond']!, _woodCondMeta));
    } else if (isInserting) {
      context.missing(_woodCondMeta);
    }
    if (data.containsKey('azimuth')) {
      context.handle(_azimuthMeta,
          azimuth.isAcceptableOrUnknown(data['azimuth']!, _azimuthMeta));
    } else if (isInserting) {
      context.missing(_azimuthMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta));
    } else if (isInserting) {
      context.missing(_distanceMeta);
    }
    if (data.containsKey('renumbered')) {
      context.handle(
          _renumberedMeta,
          renumbered.isAcceptableOrUnknown(
              data['renumbered']!, _renumberedMeta));
    } else if (isInserting) {
      context.missing(_renumberedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LtpTreeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpTreeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lptSummaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lpt_summary_id'])!,
      sector: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sector'])!,
      treeNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tree_num'])!,
      origPlotArea: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}orig_plot_area'])!,
      lgTreeGenus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lg_tree_genus'])!,
      lgTreeSpecies: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}lg_tree_species'])!,
      lgTreeVariety: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}lg_tree_variety'])!,
      lgTreeStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lg_tree_status'])!,
      dbh: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dbh'])!,
      measEstDbh: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meas_est_dbh'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      measEstHeight: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}meas_est_height'])!,
      crownClass: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}crown_class'])!,
      crownBase: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}crown_base'])!,
      crownTop: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}crown_top'])!,
      stemCond: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stem_cond'])!,
      crownCond: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}crown_cond'])!,
      barkRet: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bark_ret'])!,
      woodCond: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wood_cond'])!,
      azimuth: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}azimuth'])!,
      distance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}distance'])!,
      renumbered: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}renumbered'])!,
    );
  }

  @override
  $LtpTreeTable createAlias(String alias) {
    return $LtpTreeTable(attachedDatabase, alias);
  }
}

class LtpTreeData extends DataClass implements Insertable<LtpTreeData> {
  final int id;
  final int lptSummaryId;
  final int sector;
  final int treeNum;
  final String origPlotArea;
  final String lgTreeGenus;
  final String lgTreeSpecies;
  final String lgTreeVariety;
  final String lgTreeStatus;
  final double dbh;
  final String measEstDbh;
  final double height;
  final String measEstHeight;
  final String crownClass;
  final double crownBase;
  final double crownTop;
  final String stemCond;
  final int crownCond;
  final int barkRet;
  final int woodCond;
  final int azimuth;
  final double distance;
  final int renumbered;
  const LtpTreeData(
      {required this.id,
      required this.lptSummaryId,
      required this.sector,
      required this.treeNum,
      required this.origPlotArea,
      required this.lgTreeGenus,
      required this.lgTreeSpecies,
      required this.lgTreeVariety,
      required this.lgTreeStatus,
      required this.dbh,
      required this.measEstDbh,
      required this.height,
      required this.measEstHeight,
      required this.crownClass,
      required this.crownBase,
      required this.crownTop,
      required this.stemCond,
      required this.crownCond,
      required this.barkRet,
      required this.woodCond,
      required this.azimuth,
      required this.distance,
      required this.renumbered});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lpt_summary_id'] = Variable<int>(lptSummaryId);
    map['sector'] = Variable<int>(sector);
    map['tree_num'] = Variable<int>(treeNum);
    map['orig_plot_area'] = Variable<String>(origPlotArea);
    map['lg_tree_genus'] = Variable<String>(lgTreeGenus);
    map['lg_tree_species'] = Variable<String>(lgTreeSpecies);
    map['lg_tree_variety'] = Variable<String>(lgTreeVariety);
    map['lg_tree_status'] = Variable<String>(lgTreeStatus);
    map['dbh'] = Variable<double>(dbh);
    map['meas_est_dbh'] = Variable<String>(measEstDbh);
    map['height'] = Variable<double>(height);
    map['meas_est_height'] = Variable<String>(measEstHeight);
    map['crown_class'] = Variable<String>(crownClass);
    map['crown_base'] = Variable<double>(crownBase);
    map['crown_top'] = Variable<double>(crownTop);
    map['stem_cond'] = Variable<String>(stemCond);
    map['crown_cond'] = Variable<int>(crownCond);
    map['bark_ret'] = Variable<int>(barkRet);
    map['wood_cond'] = Variable<int>(woodCond);
    map['azimuth'] = Variable<int>(azimuth);
    map['distance'] = Variable<double>(distance);
    map['renumbered'] = Variable<int>(renumbered);
    return map;
  }

  LtpTreeCompanion toCompanion(bool nullToAbsent) {
    return LtpTreeCompanion(
      id: Value(id),
      lptSummaryId: Value(lptSummaryId),
      sector: Value(sector),
      treeNum: Value(treeNum),
      origPlotArea: Value(origPlotArea),
      lgTreeGenus: Value(lgTreeGenus),
      lgTreeSpecies: Value(lgTreeSpecies),
      lgTreeVariety: Value(lgTreeVariety),
      lgTreeStatus: Value(lgTreeStatus),
      dbh: Value(dbh),
      measEstDbh: Value(measEstDbh),
      height: Value(height),
      measEstHeight: Value(measEstHeight),
      crownClass: Value(crownClass),
      crownBase: Value(crownBase),
      crownTop: Value(crownTop),
      stemCond: Value(stemCond),
      crownCond: Value(crownCond),
      barkRet: Value(barkRet),
      woodCond: Value(woodCond),
      azimuth: Value(azimuth),
      distance: Value(distance),
      renumbered: Value(renumbered),
    );
  }

  factory LtpTreeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpTreeData(
      id: serializer.fromJson<int>(json['id']),
      lptSummaryId: serializer.fromJson<int>(json['lptSummaryId']),
      sector: serializer.fromJson<int>(json['sector']),
      treeNum: serializer.fromJson<int>(json['treeNum']),
      origPlotArea: serializer.fromJson<String>(json['origPlotArea']),
      lgTreeGenus: serializer.fromJson<String>(json['lgTreeGenus']),
      lgTreeSpecies: serializer.fromJson<String>(json['lgTreeSpecies']),
      lgTreeVariety: serializer.fromJson<String>(json['lgTreeVariety']),
      lgTreeStatus: serializer.fromJson<String>(json['lgTreeStatus']),
      dbh: serializer.fromJson<double>(json['dbh']),
      measEstDbh: serializer.fromJson<String>(json['measEstDbh']),
      height: serializer.fromJson<double>(json['height']),
      measEstHeight: serializer.fromJson<String>(json['measEstHeight']),
      crownClass: serializer.fromJson<String>(json['crownClass']),
      crownBase: serializer.fromJson<double>(json['crownBase']),
      crownTop: serializer.fromJson<double>(json['crownTop']),
      stemCond: serializer.fromJson<String>(json['stemCond']),
      crownCond: serializer.fromJson<int>(json['crownCond']),
      barkRet: serializer.fromJson<int>(json['barkRet']),
      woodCond: serializer.fromJson<int>(json['woodCond']),
      azimuth: serializer.fromJson<int>(json['azimuth']),
      distance: serializer.fromJson<double>(json['distance']),
      renumbered: serializer.fromJson<int>(json['renumbered']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lptSummaryId': serializer.toJson<int>(lptSummaryId),
      'sector': serializer.toJson<int>(sector),
      'treeNum': serializer.toJson<int>(treeNum),
      'origPlotArea': serializer.toJson<String>(origPlotArea),
      'lgTreeGenus': serializer.toJson<String>(lgTreeGenus),
      'lgTreeSpecies': serializer.toJson<String>(lgTreeSpecies),
      'lgTreeVariety': serializer.toJson<String>(lgTreeVariety),
      'lgTreeStatus': serializer.toJson<String>(lgTreeStatus),
      'dbh': serializer.toJson<double>(dbh),
      'measEstDbh': serializer.toJson<String>(measEstDbh),
      'height': serializer.toJson<double>(height),
      'measEstHeight': serializer.toJson<String>(measEstHeight),
      'crownClass': serializer.toJson<String>(crownClass),
      'crownBase': serializer.toJson<double>(crownBase),
      'crownTop': serializer.toJson<double>(crownTop),
      'stemCond': serializer.toJson<String>(stemCond),
      'crownCond': serializer.toJson<int>(crownCond),
      'barkRet': serializer.toJson<int>(barkRet),
      'woodCond': serializer.toJson<int>(woodCond),
      'azimuth': serializer.toJson<int>(azimuth),
      'distance': serializer.toJson<double>(distance),
      'renumbered': serializer.toJson<int>(renumbered),
    };
  }

  LtpTreeData copyWith(
          {int? id,
          int? lptSummaryId,
          int? sector,
          int? treeNum,
          String? origPlotArea,
          String? lgTreeGenus,
          String? lgTreeSpecies,
          String? lgTreeVariety,
          String? lgTreeStatus,
          double? dbh,
          String? measEstDbh,
          double? height,
          String? measEstHeight,
          String? crownClass,
          double? crownBase,
          double? crownTop,
          String? stemCond,
          int? crownCond,
          int? barkRet,
          int? woodCond,
          int? azimuth,
          double? distance,
          int? renumbered}) =>
      LtpTreeData(
        id: id ?? this.id,
        lptSummaryId: lptSummaryId ?? this.lptSummaryId,
        sector: sector ?? this.sector,
        treeNum: treeNum ?? this.treeNum,
        origPlotArea: origPlotArea ?? this.origPlotArea,
        lgTreeGenus: lgTreeGenus ?? this.lgTreeGenus,
        lgTreeSpecies: lgTreeSpecies ?? this.lgTreeSpecies,
        lgTreeVariety: lgTreeVariety ?? this.lgTreeVariety,
        lgTreeStatus: lgTreeStatus ?? this.lgTreeStatus,
        dbh: dbh ?? this.dbh,
        measEstDbh: measEstDbh ?? this.measEstDbh,
        height: height ?? this.height,
        measEstHeight: measEstHeight ?? this.measEstHeight,
        crownClass: crownClass ?? this.crownClass,
        crownBase: crownBase ?? this.crownBase,
        crownTop: crownTop ?? this.crownTop,
        stemCond: stemCond ?? this.stemCond,
        crownCond: crownCond ?? this.crownCond,
        barkRet: barkRet ?? this.barkRet,
        woodCond: woodCond ?? this.woodCond,
        azimuth: azimuth ?? this.azimuth,
        distance: distance ?? this.distance,
        renumbered: renumbered ?? this.renumbered,
      );
  @override
  String toString() {
    return (StringBuffer('LtpTreeData(')
          ..write('id: $id, ')
          ..write('lptSummaryId: $lptSummaryId, ')
          ..write('sector: $sector, ')
          ..write('treeNum: $treeNum, ')
          ..write('origPlotArea: $origPlotArea, ')
          ..write('lgTreeGenus: $lgTreeGenus, ')
          ..write('lgTreeSpecies: $lgTreeSpecies, ')
          ..write('lgTreeVariety: $lgTreeVariety, ')
          ..write('lgTreeStatus: $lgTreeStatus, ')
          ..write('dbh: $dbh, ')
          ..write('measEstDbh: $measEstDbh, ')
          ..write('height: $height, ')
          ..write('measEstHeight: $measEstHeight, ')
          ..write('crownClass: $crownClass, ')
          ..write('crownBase: $crownBase, ')
          ..write('crownTop: $crownTop, ')
          ..write('stemCond: $stemCond, ')
          ..write('crownCond: $crownCond, ')
          ..write('barkRet: $barkRet, ')
          ..write('woodCond: $woodCond, ')
          ..write('azimuth: $azimuth, ')
          ..write('distance: $distance, ')
          ..write('renumbered: $renumbered')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        lptSummaryId,
        sector,
        treeNum,
        origPlotArea,
        lgTreeGenus,
        lgTreeSpecies,
        lgTreeVariety,
        lgTreeStatus,
        dbh,
        measEstDbh,
        height,
        measEstHeight,
        crownClass,
        crownBase,
        crownTop,
        stemCond,
        crownCond,
        barkRet,
        woodCond,
        azimuth,
        distance,
        renumbered
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LtpTreeData &&
          other.id == this.id &&
          other.lptSummaryId == this.lptSummaryId &&
          other.sector == this.sector &&
          other.treeNum == this.treeNum &&
          other.origPlotArea == this.origPlotArea &&
          other.lgTreeGenus == this.lgTreeGenus &&
          other.lgTreeSpecies == this.lgTreeSpecies &&
          other.lgTreeVariety == this.lgTreeVariety &&
          other.lgTreeStatus == this.lgTreeStatus &&
          other.dbh == this.dbh &&
          other.measEstDbh == this.measEstDbh &&
          other.height == this.height &&
          other.measEstHeight == this.measEstHeight &&
          other.crownClass == this.crownClass &&
          other.crownBase == this.crownBase &&
          other.crownTop == this.crownTop &&
          other.stemCond == this.stemCond &&
          other.crownCond == this.crownCond &&
          other.barkRet == this.barkRet &&
          other.woodCond == this.woodCond &&
          other.azimuth == this.azimuth &&
          other.distance == this.distance &&
          other.renumbered == this.renumbered);
}

class LtpTreeCompanion extends UpdateCompanion<LtpTreeData> {
  final Value<int> id;
  final Value<int> lptSummaryId;
  final Value<int> sector;
  final Value<int> treeNum;
  final Value<String> origPlotArea;
  final Value<String> lgTreeGenus;
  final Value<String> lgTreeSpecies;
  final Value<String> lgTreeVariety;
  final Value<String> lgTreeStatus;
  final Value<double> dbh;
  final Value<String> measEstDbh;
  final Value<double> height;
  final Value<String> measEstHeight;
  final Value<String> crownClass;
  final Value<double> crownBase;
  final Value<double> crownTop;
  final Value<String> stemCond;
  final Value<int> crownCond;
  final Value<int> barkRet;
  final Value<int> woodCond;
  final Value<int> azimuth;
  final Value<double> distance;
  final Value<int> renumbered;
  const LtpTreeCompanion({
    this.id = const Value.absent(),
    this.lptSummaryId = const Value.absent(),
    this.sector = const Value.absent(),
    this.treeNum = const Value.absent(),
    this.origPlotArea = const Value.absent(),
    this.lgTreeGenus = const Value.absent(),
    this.lgTreeSpecies = const Value.absent(),
    this.lgTreeVariety = const Value.absent(),
    this.lgTreeStatus = const Value.absent(),
    this.dbh = const Value.absent(),
    this.measEstDbh = const Value.absent(),
    this.height = const Value.absent(),
    this.measEstHeight = const Value.absent(),
    this.crownClass = const Value.absent(),
    this.crownBase = const Value.absent(),
    this.crownTop = const Value.absent(),
    this.stemCond = const Value.absent(),
    this.crownCond = const Value.absent(),
    this.barkRet = const Value.absent(),
    this.woodCond = const Value.absent(),
    this.azimuth = const Value.absent(),
    this.distance = const Value.absent(),
    this.renumbered = const Value.absent(),
  });
  LtpTreeCompanion.insert({
    this.id = const Value.absent(),
    required int lptSummaryId,
    required int sector,
    required int treeNum,
    required String origPlotArea,
    required String lgTreeGenus,
    required String lgTreeSpecies,
    required String lgTreeVariety,
    required String lgTreeStatus,
    required double dbh,
    required String measEstDbh,
    required double height,
    required String measEstHeight,
    required String crownClass,
    required double crownBase,
    required double crownTop,
    required String stemCond,
    required int crownCond,
    required int barkRet,
    required int woodCond,
    required int azimuth,
    required double distance,
    required int renumbered,
  })  : lptSummaryId = Value(lptSummaryId),
        sector = Value(sector),
        treeNum = Value(treeNum),
        origPlotArea = Value(origPlotArea),
        lgTreeGenus = Value(lgTreeGenus),
        lgTreeSpecies = Value(lgTreeSpecies),
        lgTreeVariety = Value(lgTreeVariety),
        lgTreeStatus = Value(lgTreeStatus),
        dbh = Value(dbh),
        measEstDbh = Value(measEstDbh),
        height = Value(height),
        measEstHeight = Value(measEstHeight),
        crownClass = Value(crownClass),
        crownBase = Value(crownBase),
        crownTop = Value(crownTop),
        stemCond = Value(stemCond),
        crownCond = Value(crownCond),
        barkRet = Value(barkRet),
        woodCond = Value(woodCond),
        azimuth = Value(azimuth),
        distance = Value(distance),
        renumbered = Value(renumbered);
  static Insertable<LtpTreeData> custom({
    Expression<int>? id,
    Expression<int>? lptSummaryId,
    Expression<int>? sector,
    Expression<int>? treeNum,
    Expression<String>? origPlotArea,
    Expression<String>? lgTreeGenus,
    Expression<String>? lgTreeSpecies,
    Expression<String>? lgTreeVariety,
    Expression<String>? lgTreeStatus,
    Expression<double>? dbh,
    Expression<String>? measEstDbh,
    Expression<double>? height,
    Expression<String>? measEstHeight,
    Expression<String>? crownClass,
    Expression<double>? crownBase,
    Expression<double>? crownTop,
    Expression<String>? stemCond,
    Expression<int>? crownCond,
    Expression<int>? barkRet,
    Expression<int>? woodCond,
    Expression<int>? azimuth,
    Expression<double>? distance,
    Expression<int>? renumbered,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lptSummaryId != null) 'lpt_summary_id': lptSummaryId,
      if (sector != null) 'sector': sector,
      if (treeNum != null) 'tree_num': treeNum,
      if (origPlotArea != null) 'orig_plot_area': origPlotArea,
      if (lgTreeGenus != null) 'lg_tree_genus': lgTreeGenus,
      if (lgTreeSpecies != null) 'lg_tree_species': lgTreeSpecies,
      if (lgTreeVariety != null) 'lg_tree_variety': lgTreeVariety,
      if (lgTreeStatus != null) 'lg_tree_status': lgTreeStatus,
      if (dbh != null) 'dbh': dbh,
      if (measEstDbh != null) 'meas_est_dbh': measEstDbh,
      if (height != null) 'height': height,
      if (measEstHeight != null) 'meas_est_height': measEstHeight,
      if (crownClass != null) 'crown_class': crownClass,
      if (crownBase != null) 'crown_base': crownBase,
      if (crownTop != null) 'crown_top': crownTop,
      if (stemCond != null) 'stem_cond': stemCond,
      if (crownCond != null) 'crown_cond': crownCond,
      if (barkRet != null) 'bark_ret': barkRet,
      if (woodCond != null) 'wood_cond': woodCond,
      if (azimuth != null) 'azimuth': azimuth,
      if (distance != null) 'distance': distance,
      if (renumbered != null) 'renumbered': renumbered,
    });
  }

  LtpTreeCompanion copyWith(
      {Value<int>? id,
      Value<int>? lptSummaryId,
      Value<int>? sector,
      Value<int>? treeNum,
      Value<String>? origPlotArea,
      Value<String>? lgTreeGenus,
      Value<String>? lgTreeSpecies,
      Value<String>? lgTreeVariety,
      Value<String>? lgTreeStatus,
      Value<double>? dbh,
      Value<String>? measEstDbh,
      Value<double>? height,
      Value<String>? measEstHeight,
      Value<String>? crownClass,
      Value<double>? crownBase,
      Value<double>? crownTop,
      Value<String>? stemCond,
      Value<int>? crownCond,
      Value<int>? barkRet,
      Value<int>? woodCond,
      Value<int>? azimuth,
      Value<double>? distance,
      Value<int>? renumbered}) {
    return LtpTreeCompanion(
      id: id ?? this.id,
      lptSummaryId: lptSummaryId ?? this.lptSummaryId,
      sector: sector ?? this.sector,
      treeNum: treeNum ?? this.treeNum,
      origPlotArea: origPlotArea ?? this.origPlotArea,
      lgTreeGenus: lgTreeGenus ?? this.lgTreeGenus,
      lgTreeSpecies: lgTreeSpecies ?? this.lgTreeSpecies,
      lgTreeVariety: lgTreeVariety ?? this.lgTreeVariety,
      lgTreeStatus: lgTreeStatus ?? this.lgTreeStatus,
      dbh: dbh ?? this.dbh,
      measEstDbh: measEstDbh ?? this.measEstDbh,
      height: height ?? this.height,
      measEstHeight: measEstHeight ?? this.measEstHeight,
      crownClass: crownClass ?? this.crownClass,
      crownBase: crownBase ?? this.crownBase,
      crownTop: crownTop ?? this.crownTop,
      stemCond: stemCond ?? this.stemCond,
      crownCond: crownCond ?? this.crownCond,
      barkRet: barkRet ?? this.barkRet,
      woodCond: woodCond ?? this.woodCond,
      azimuth: azimuth ?? this.azimuth,
      distance: distance ?? this.distance,
      renumbered: renumbered ?? this.renumbered,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lptSummaryId.present) {
      map['lpt_summary_id'] = Variable<int>(lptSummaryId.value);
    }
    if (sector.present) {
      map['sector'] = Variable<int>(sector.value);
    }
    if (treeNum.present) {
      map['tree_num'] = Variable<int>(treeNum.value);
    }
    if (origPlotArea.present) {
      map['orig_plot_area'] = Variable<String>(origPlotArea.value);
    }
    if (lgTreeGenus.present) {
      map['lg_tree_genus'] = Variable<String>(lgTreeGenus.value);
    }
    if (lgTreeSpecies.present) {
      map['lg_tree_species'] = Variable<String>(lgTreeSpecies.value);
    }
    if (lgTreeVariety.present) {
      map['lg_tree_variety'] = Variable<String>(lgTreeVariety.value);
    }
    if (lgTreeStatus.present) {
      map['lg_tree_status'] = Variable<String>(lgTreeStatus.value);
    }
    if (dbh.present) {
      map['dbh'] = Variable<double>(dbh.value);
    }
    if (measEstDbh.present) {
      map['meas_est_dbh'] = Variable<String>(measEstDbh.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (measEstHeight.present) {
      map['meas_est_height'] = Variable<String>(measEstHeight.value);
    }
    if (crownClass.present) {
      map['crown_class'] = Variable<String>(crownClass.value);
    }
    if (crownBase.present) {
      map['crown_base'] = Variable<double>(crownBase.value);
    }
    if (crownTop.present) {
      map['crown_top'] = Variable<double>(crownTop.value);
    }
    if (stemCond.present) {
      map['stem_cond'] = Variable<String>(stemCond.value);
    }
    if (crownCond.present) {
      map['crown_cond'] = Variable<int>(crownCond.value);
    }
    if (barkRet.present) {
      map['bark_ret'] = Variable<int>(barkRet.value);
    }
    if (woodCond.present) {
      map['wood_cond'] = Variable<int>(woodCond.value);
    }
    if (azimuth.present) {
      map['azimuth'] = Variable<int>(azimuth.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double>(distance.value);
    }
    if (renumbered.present) {
      map['renumbered'] = Variable<int>(renumbered.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LtpTreeCompanion(')
          ..write('id: $id, ')
          ..write('lptSummaryId: $lptSummaryId, ')
          ..write('sector: $sector, ')
          ..write('treeNum: $treeNum, ')
          ..write('origPlotArea: $origPlotArea, ')
          ..write('lgTreeGenus: $lgTreeGenus, ')
          ..write('lgTreeSpecies: $lgTreeSpecies, ')
          ..write('lgTreeVariety: $lgTreeVariety, ')
          ..write('lgTreeStatus: $lgTreeStatus, ')
          ..write('dbh: $dbh, ')
          ..write('measEstDbh: $measEstDbh, ')
          ..write('height: $height, ')
          ..write('measEstHeight: $measEstHeight, ')
          ..write('crownClass: $crownClass, ')
          ..write('crownBase: $crownBase, ')
          ..write('crownTop: $crownTop, ')
          ..write('stemCond: $stemCond, ')
          ..write('crownCond: $crownCond, ')
          ..write('barkRet: $barkRet, ')
          ..write('woodCond: $woodCond, ')
          ..write('azimuth: $azimuth, ')
          ..write('distance: $distance, ')
          ..write('renumbered: $renumbered')
          ..write(')'))
        .toString();
  }
}

class $LtpTreeDamageTable extends LtpTreeDamage
    with TableInfo<$LtpTreeDamageTable, LtpTreeDamageData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpTreeDamageTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lptSummaryIdMeta =
      const VerificationMeta('lptSummaryId');
  @override
  late final GeneratedColumn<int> lptSummaryId = GeneratedColumn<int>(
      'lpt_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ltp_summary (id)'));
  static const VerificationMeta _treeNumMeta =
      const VerificationMeta('treeNum');
  @override
  late final GeneratedColumn<int> treeNum = GeneratedColumn<int>(
      'tree_num', aliasedName, false,
      check: () => treeNum.isBetweenValues(1, 9999),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _damageAgentMeta =
      const VerificationMeta('damageAgent');
  @override
  late final GeneratedColumn<String> damageAgent = GeneratedColumn<String>(
      'damage_agent', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _damageLocationMeta =
      const VerificationMeta('damageLocation');
  @override
  late final GeneratedColumn<String> damageLocation = GeneratedColumn<String>(
      'damage_location', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _severityPctMeta =
      const VerificationMeta('severityPct');
  @override
  late final GeneratedColumn<int> severityPct = GeneratedColumn<int>(
      'severity_pct', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(-7));
  static const VerificationMeta _severityMeta =
      const VerificationMeta('severity');
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
      'severity', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lptSummaryId,
        treeNum,
        damageAgent,
        damageLocation,
        severityPct,
        severity
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ltp_tree_damage';
  @override
  VerificationContext validateIntegrity(Insertable<LtpTreeDamageData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lpt_summary_id')) {
      context.handle(
          _lptSummaryIdMeta,
          lptSummaryId.isAcceptableOrUnknown(
              data['lpt_summary_id']!, _lptSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_lptSummaryIdMeta);
    }
    if (data.containsKey('tree_num')) {
      context.handle(_treeNumMeta,
          treeNum.isAcceptableOrUnknown(data['tree_num']!, _treeNumMeta));
    } else if (isInserting) {
      context.missing(_treeNumMeta);
    }
    if (data.containsKey('damage_agent')) {
      context.handle(
          _damageAgentMeta,
          damageAgent.isAcceptableOrUnknown(
              data['damage_agent']!, _damageAgentMeta));
    } else if (isInserting) {
      context.missing(_damageAgentMeta);
    }
    if (data.containsKey('damage_location')) {
      context.handle(
          _damageLocationMeta,
          damageLocation.isAcceptableOrUnknown(
              data['damage_location']!, _damageLocationMeta));
    } else if (isInserting) {
      context.missing(_damageLocationMeta);
    }
    if (data.containsKey('severity_pct')) {
      context.handle(
          _severityPctMeta,
          severityPct.isAcceptableOrUnknown(
              data['severity_pct']!, _severityPctMeta));
    }
    if (data.containsKey('severity')) {
      context.handle(_severityMeta,
          severity.isAcceptableOrUnknown(data['severity']!, _severityMeta));
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LtpTreeDamageData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpTreeDamageData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lptSummaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lpt_summary_id'])!,
      treeNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tree_num'])!,
      damageAgent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}damage_agent'])!,
      damageLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}damage_location'])!,
      severityPct: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}severity_pct'])!,
      severity: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}severity'])!,
    );
  }

  @override
  $LtpTreeDamageTable createAlias(String alias) {
    return $LtpTreeDamageTable(attachedDatabase, alias);
  }
}

class LtpTreeDamageData extends DataClass
    implements Insertable<LtpTreeDamageData> {
  final int id;
  final int lptSummaryId;
  final int treeNum;
  final String damageAgent;
  final String damageLocation;
  final int severityPct;
  final String severity;
  const LtpTreeDamageData(
      {required this.id,
      required this.lptSummaryId,
      required this.treeNum,
      required this.damageAgent,
      required this.damageLocation,
      required this.severityPct,
      required this.severity});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lpt_summary_id'] = Variable<int>(lptSummaryId);
    map['tree_num'] = Variable<int>(treeNum);
    map['damage_agent'] = Variable<String>(damageAgent);
    map['damage_location'] = Variable<String>(damageLocation);
    map['severity_pct'] = Variable<int>(severityPct);
    map['severity'] = Variable<String>(severity);
    return map;
  }

  LtpTreeDamageCompanion toCompanion(bool nullToAbsent) {
    return LtpTreeDamageCompanion(
      id: Value(id),
      lptSummaryId: Value(lptSummaryId),
      treeNum: Value(treeNum),
      damageAgent: Value(damageAgent),
      damageLocation: Value(damageLocation),
      severityPct: Value(severityPct),
      severity: Value(severity),
    );
  }

  factory LtpTreeDamageData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpTreeDamageData(
      id: serializer.fromJson<int>(json['id']),
      lptSummaryId: serializer.fromJson<int>(json['lptSummaryId']),
      treeNum: serializer.fromJson<int>(json['treeNum']),
      damageAgent: serializer.fromJson<String>(json['damageAgent']),
      damageLocation: serializer.fromJson<String>(json['damageLocation']),
      severityPct: serializer.fromJson<int>(json['severityPct']),
      severity: serializer.fromJson<String>(json['severity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lptSummaryId': serializer.toJson<int>(lptSummaryId),
      'treeNum': serializer.toJson<int>(treeNum),
      'damageAgent': serializer.toJson<String>(damageAgent),
      'damageLocation': serializer.toJson<String>(damageLocation),
      'severityPct': serializer.toJson<int>(severityPct),
      'severity': serializer.toJson<String>(severity),
    };
  }

  LtpTreeDamageData copyWith(
          {int? id,
          int? lptSummaryId,
          int? treeNum,
          String? damageAgent,
          String? damageLocation,
          int? severityPct,
          String? severity}) =>
      LtpTreeDamageData(
        id: id ?? this.id,
        lptSummaryId: lptSummaryId ?? this.lptSummaryId,
        treeNum: treeNum ?? this.treeNum,
        damageAgent: damageAgent ?? this.damageAgent,
        damageLocation: damageLocation ?? this.damageLocation,
        severityPct: severityPct ?? this.severityPct,
        severity: severity ?? this.severity,
      );
  @override
  String toString() {
    return (StringBuffer('LtpTreeDamageData(')
          ..write('id: $id, ')
          ..write('lptSummaryId: $lptSummaryId, ')
          ..write('treeNum: $treeNum, ')
          ..write('damageAgent: $damageAgent, ')
          ..write('damageLocation: $damageLocation, ')
          ..write('severityPct: $severityPct, ')
          ..write('severity: $severity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lptSummaryId, treeNum, damageAgent,
      damageLocation, severityPct, severity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LtpTreeDamageData &&
          other.id == this.id &&
          other.lptSummaryId == this.lptSummaryId &&
          other.treeNum == this.treeNum &&
          other.damageAgent == this.damageAgent &&
          other.damageLocation == this.damageLocation &&
          other.severityPct == this.severityPct &&
          other.severity == this.severity);
}

class LtpTreeDamageCompanion extends UpdateCompanion<LtpTreeDamageData> {
  final Value<int> id;
  final Value<int> lptSummaryId;
  final Value<int> treeNum;
  final Value<String> damageAgent;
  final Value<String> damageLocation;
  final Value<int> severityPct;
  final Value<String> severity;
  const LtpTreeDamageCompanion({
    this.id = const Value.absent(),
    this.lptSummaryId = const Value.absent(),
    this.treeNum = const Value.absent(),
    this.damageAgent = const Value.absent(),
    this.damageLocation = const Value.absent(),
    this.severityPct = const Value.absent(),
    this.severity = const Value.absent(),
  });
  LtpTreeDamageCompanion.insert({
    this.id = const Value.absent(),
    required int lptSummaryId,
    required int treeNum,
    required String damageAgent,
    required String damageLocation,
    this.severityPct = const Value.absent(),
    required String severity,
  })  : lptSummaryId = Value(lptSummaryId),
        treeNum = Value(treeNum),
        damageAgent = Value(damageAgent),
        damageLocation = Value(damageLocation),
        severity = Value(severity);
  static Insertable<LtpTreeDamageData> custom({
    Expression<int>? id,
    Expression<int>? lptSummaryId,
    Expression<int>? treeNum,
    Expression<String>? damageAgent,
    Expression<String>? damageLocation,
    Expression<int>? severityPct,
    Expression<String>? severity,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lptSummaryId != null) 'lpt_summary_id': lptSummaryId,
      if (treeNum != null) 'tree_num': treeNum,
      if (damageAgent != null) 'damage_agent': damageAgent,
      if (damageLocation != null) 'damage_location': damageLocation,
      if (severityPct != null) 'severity_pct': severityPct,
      if (severity != null) 'severity': severity,
    });
  }

  LtpTreeDamageCompanion copyWith(
      {Value<int>? id,
      Value<int>? lptSummaryId,
      Value<int>? treeNum,
      Value<String>? damageAgent,
      Value<String>? damageLocation,
      Value<int>? severityPct,
      Value<String>? severity}) {
    return LtpTreeDamageCompanion(
      id: id ?? this.id,
      lptSummaryId: lptSummaryId ?? this.lptSummaryId,
      treeNum: treeNum ?? this.treeNum,
      damageAgent: damageAgent ?? this.damageAgent,
      damageLocation: damageLocation ?? this.damageLocation,
      severityPct: severityPct ?? this.severityPct,
      severity: severity ?? this.severity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lptSummaryId.present) {
      map['lpt_summary_id'] = Variable<int>(lptSummaryId.value);
    }
    if (treeNum.present) {
      map['tree_num'] = Variable<int>(treeNum.value);
    }
    if (damageAgent.present) {
      map['damage_agent'] = Variable<String>(damageAgent.value);
    }
    if (damageLocation.present) {
      map['damage_location'] = Variable<String>(damageLocation.value);
    }
    if (severityPct.present) {
      map['severity_pct'] = Variable<int>(severityPct.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LtpTreeDamageCompanion(')
          ..write('id: $id, ')
          ..write('lptSummaryId: $lptSummaryId, ')
          ..write('treeNum: $treeNum, ')
          ..write('damageAgent: $damageAgent, ')
          ..write('damageLocation: $damageLocation, ')
          ..write('severityPct: $severityPct, ')
          ..write('severity: $severity')
          ..write(')'))
        .toString();
  }
}

class $LtpTreeRemovedTable extends LtpTreeRemoved
    with TableInfo<$LtpTreeRemovedTable, LtpTreeRemovedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpTreeRemovedTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lptSummaryIdMeta =
      const VerificationMeta('lptSummaryId');
  @override
  late final GeneratedColumn<int> lptSummaryId = GeneratedColumn<int>(
      'lpt_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ltp_summary (id)'));
  static const VerificationMeta _treeNumMeta =
      const VerificationMeta('treeNum');
  @override
  late final GeneratedColumn<int> treeNum = GeneratedColumn<int>(
      'tree_num', aliasedName, false,
      check: () => treeNum.isBetweenValues(1, 9999),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
      'reason', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, lptSummaryId, treeNum, reason];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ltp_tree_removed';
  @override
  VerificationContext validateIntegrity(Insertable<LtpTreeRemovedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lpt_summary_id')) {
      context.handle(
          _lptSummaryIdMeta,
          lptSummaryId.isAcceptableOrUnknown(
              data['lpt_summary_id']!, _lptSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_lptSummaryIdMeta);
    }
    if (data.containsKey('tree_num')) {
      context.handle(_treeNumMeta,
          treeNum.isAcceptableOrUnknown(data['tree_num']!, _treeNumMeta));
    } else if (isInserting) {
      context.missing(_treeNumMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta,
          reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LtpTreeRemovedData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpTreeRemovedData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lptSummaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lpt_summary_id'])!,
      treeNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tree_num'])!,
      reason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reason'])!,
    );
  }

  @override
  $LtpTreeRemovedTable createAlias(String alias) {
    return $LtpTreeRemovedTable(attachedDatabase, alias);
  }
}

class LtpTreeRemovedData extends DataClass
    implements Insertable<LtpTreeRemovedData> {
  final int id;
  final int lptSummaryId;
  final int treeNum;
  final String reason;
  const LtpTreeRemovedData(
      {required this.id,
      required this.lptSummaryId,
      required this.treeNum,
      required this.reason});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lpt_summary_id'] = Variable<int>(lptSummaryId);
    map['tree_num'] = Variable<int>(treeNum);
    map['reason'] = Variable<String>(reason);
    return map;
  }

  LtpTreeRemovedCompanion toCompanion(bool nullToAbsent) {
    return LtpTreeRemovedCompanion(
      id: Value(id),
      lptSummaryId: Value(lptSummaryId),
      treeNum: Value(treeNum),
      reason: Value(reason),
    );
  }

  factory LtpTreeRemovedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpTreeRemovedData(
      id: serializer.fromJson<int>(json['id']),
      lptSummaryId: serializer.fromJson<int>(json['lptSummaryId']),
      treeNum: serializer.fromJson<int>(json['treeNum']),
      reason: serializer.fromJson<String>(json['reason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lptSummaryId': serializer.toJson<int>(lptSummaryId),
      'treeNum': serializer.toJson<int>(treeNum),
      'reason': serializer.toJson<String>(reason),
    };
  }

  LtpTreeRemovedData copyWith(
          {int? id, int? lptSummaryId, int? treeNum, String? reason}) =>
      LtpTreeRemovedData(
        id: id ?? this.id,
        lptSummaryId: lptSummaryId ?? this.lptSummaryId,
        treeNum: treeNum ?? this.treeNum,
        reason: reason ?? this.reason,
      );
  @override
  String toString() {
    return (StringBuffer('LtpTreeRemovedData(')
          ..write('id: $id, ')
          ..write('lptSummaryId: $lptSummaryId, ')
          ..write('treeNum: $treeNum, ')
          ..write('reason: $reason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lptSummaryId, treeNum, reason);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LtpTreeRemovedData &&
          other.id == this.id &&
          other.lptSummaryId == this.lptSummaryId &&
          other.treeNum == this.treeNum &&
          other.reason == this.reason);
}

class LtpTreeRemovedCompanion extends UpdateCompanion<LtpTreeRemovedData> {
  final Value<int> id;
  final Value<int> lptSummaryId;
  final Value<int> treeNum;
  final Value<String> reason;
  const LtpTreeRemovedCompanion({
    this.id = const Value.absent(),
    this.lptSummaryId = const Value.absent(),
    this.treeNum = const Value.absent(),
    this.reason = const Value.absent(),
  });
  LtpTreeRemovedCompanion.insert({
    this.id = const Value.absent(),
    required int lptSummaryId,
    required int treeNum,
    required String reason,
  })  : lptSummaryId = Value(lptSummaryId),
        treeNum = Value(treeNum),
        reason = Value(reason);
  static Insertable<LtpTreeRemovedData> custom({
    Expression<int>? id,
    Expression<int>? lptSummaryId,
    Expression<int>? treeNum,
    Expression<String>? reason,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lptSummaryId != null) 'lpt_summary_id': lptSummaryId,
      if (treeNum != null) 'tree_num': treeNum,
      if (reason != null) 'reason': reason,
    });
  }

  LtpTreeRemovedCompanion copyWith(
      {Value<int>? id,
      Value<int>? lptSummaryId,
      Value<int>? treeNum,
      Value<String>? reason}) {
    return LtpTreeRemovedCompanion(
      id: id ?? this.id,
      lptSummaryId: lptSummaryId ?? this.lptSummaryId,
      treeNum: treeNum ?? this.treeNum,
      reason: reason ?? this.reason,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lptSummaryId.present) {
      map['lpt_summary_id'] = Variable<int>(lptSummaryId.value);
    }
    if (treeNum.present) {
      map['tree_num'] = Variable<int>(treeNum.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LtpTreeRemovedCompanion(')
          ..write('id: $id, ')
          ..write('lptSummaryId: $lptSummaryId, ')
          ..write('treeNum: $treeNum, ')
          ..write('reason: $reason')
          ..write(')'))
        .toString();
  }
}

class $LtpTreeAgeTable extends LtpTreeAge
    with TableInfo<$LtpTreeAgeTable, LtpTreeAgeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpTreeAgeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lptSummaryIdMeta =
      const VerificationMeta('lptSummaryId');
  @override
  late final GeneratedColumn<int> lptSummaryId = GeneratedColumn<int>(
      'lpt_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ltp_summary (id)'));
  static const VerificationMeta _quadrantMeta =
      const VerificationMeta('quadrant');
  @override
  late final GeneratedColumn<String> quadrant = GeneratedColumn<String>(
      'quadrant', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _treeNumMeta =
      const VerificationMeta('treeNum');
  @override
  late final GeneratedColumn<int> treeNum = GeneratedColumn<int>(
      'tree_num', aliasedName, false,
      check: () => treeNum.isBetweenValues(1, 9999),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _siteTypeMeta =
      const VerificationMeta('siteType');
  @override
  late final GeneratedColumn<String> siteType = GeneratedColumn<String>(
      'site_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _boreDOBMeta =
      const VerificationMeta('boreDOB');
  @override
  late final GeneratedColumn<double> boreDOB = GeneratedColumn<double>(
      'bore_d_o_b', aliasedName, false,
      check: () => boreDOB.isBetweenValues(-1, 999.9),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _boreHtMeta = const VerificationMeta('boreHt');
  @override
  late final GeneratedColumn<double> boreHt = GeneratedColumn<double>(
      'bore_ht', aliasedName, false,
      check: () => boreHt.isBetweenValues(-1, 9.9),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _suitHtMeta = const VerificationMeta('suitHt');
  @override
  late final GeneratedColumn<String> suitHt = GeneratedColumn<String>(
      'suit_ht', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _suitAgeMeta =
      const VerificationMeta('suitAge');
  @override
  late final GeneratedColumn<String> suitAge = GeneratedColumn<String>(
      'suit_age', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _fieldAgeMeta =
      const VerificationMeta('fieldAge');
  @override
  late final GeneratedColumn<int> fieldAge = GeneratedColumn<int>(
      'field_age', aliasedName, false,
      check: () => fieldAge.isBetweenValues(-8, 9999),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _proCodeMeta =
      const VerificationMeta('proCode');
  @override
  late final GeneratedColumn<String> proCode = GeneratedColumn<String>(
      'pro_code', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        lptSummaryId,
        quadrant,
        treeNum,
        siteType,
        boreDOB,
        boreHt,
        suitHt,
        suitAge,
        fieldAge,
        proCode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ltp_tree_age';
  @override
  VerificationContext validateIntegrity(Insertable<LtpTreeAgeData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lpt_summary_id')) {
      context.handle(
          _lptSummaryIdMeta,
          lptSummaryId.isAcceptableOrUnknown(
              data['lpt_summary_id']!, _lptSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_lptSummaryIdMeta);
    }
    if (data.containsKey('quadrant')) {
      context.handle(_quadrantMeta,
          quadrant.isAcceptableOrUnknown(data['quadrant']!, _quadrantMeta));
    } else if (isInserting) {
      context.missing(_quadrantMeta);
    }
    if (data.containsKey('tree_num')) {
      context.handle(_treeNumMeta,
          treeNum.isAcceptableOrUnknown(data['tree_num']!, _treeNumMeta));
    } else if (isInserting) {
      context.missing(_treeNumMeta);
    }
    if (data.containsKey('site_type')) {
      context.handle(_siteTypeMeta,
          siteType.isAcceptableOrUnknown(data['site_type']!, _siteTypeMeta));
    } else if (isInserting) {
      context.missing(_siteTypeMeta);
    }
    if (data.containsKey('bore_d_o_b')) {
      context.handle(_boreDOBMeta,
          boreDOB.isAcceptableOrUnknown(data['bore_d_o_b']!, _boreDOBMeta));
    } else if (isInserting) {
      context.missing(_boreDOBMeta);
    }
    if (data.containsKey('bore_ht')) {
      context.handle(_boreHtMeta,
          boreHt.isAcceptableOrUnknown(data['bore_ht']!, _boreHtMeta));
    } else if (isInserting) {
      context.missing(_boreHtMeta);
    }
    if (data.containsKey('suit_ht')) {
      context.handle(_suitHtMeta,
          suitHt.isAcceptableOrUnknown(data['suit_ht']!, _suitHtMeta));
    } else if (isInserting) {
      context.missing(_suitHtMeta);
    }
    if (data.containsKey('suit_age')) {
      context.handle(_suitAgeMeta,
          suitAge.isAcceptableOrUnknown(data['suit_age']!, _suitAgeMeta));
    } else if (isInserting) {
      context.missing(_suitAgeMeta);
    }
    if (data.containsKey('field_age')) {
      context.handle(_fieldAgeMeta,
          fieldAge.isAcceptableOrUnknown(data['field_age']!, _fieldAgeMeta));
    } else if (isInserting) {
      context.missing(_fieldAgeMeta);
    }
    if (data.containsKey('pro_code')) {
      context.handle(_proCodeMeta,
          proCode.isAcceptableOrUnknown(data['pro_code']!, _proCodeMeta));
    } else if (isInserting) {
      context.missing(_proCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LtpTreeAgeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpTreeAgeData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lptSummaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lpt_summary_id'])!,
      quadrant: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}quadrant'])!,
      treeNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tree_num'])!,
      siteType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}site_type'])!,
      boreDOB: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bore_d_o_b'])!,
      boreHt: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}bore_ht'])!,
      suitHt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}suit_ht'])!,
      suitAge: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}suit_age'])!,
      fieldAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}field_age'])!,
      proCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pro_code'])!,
    );
  }

  @override
  $LtpTreeAgeTable createAlias(String alias) {
    return $LtpTreeAgeTable(attachedDatabase, alias);
  }
}

class LtpTreeAgeData extends DataClass implements Insertable<LtpTreeAgeData> {
  final int id;
  final int lptSummaryId;
  final String quadrant;
  final int treeNum;
  final String siteType;
  final double boreDOB;
  final double boreHt;
  final String suitHt;
  final String suitAge;
  final int fieldAge;
  final String proCode;
  const LtpTreeAgeData(
      {required this.id,
      required this.lptSummaryId,
      required this.quadrant,
      required this.treeNum,
      required this.siteType,
      required this.boreDOB,
      required this.boreHt,
      required this.suitHt,
      required this.suitAge,
      required this.fieldAge,
      required this.proCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lpt_summary_id'] = Variable<int>(lptSummaryId);
    map['quadrant'] = Variable<String>(quadrant);
    map['tree_num'] = Variable<int>(treeNum);
    map['site_type'] = Variable<String>(siteType);
    map['bore_d_o_b'] = Variable<double>(boreDOB);
    map['bore_ht'] = Variable<double>(boreHt);
    map['suit_ht'] = Variable<String>(suitHt);
    map['suit_age'] = Variable<String>(suitAge);
    map['field_age'] = Variable<int>(fieldAge);
    map['pro_code'] = Variable<String>(proCode);
    return map;
  }

  LtpTreeAgeCompanion toCompanion(bool nullToAbsent) {
    return LtpTreeAgeCompanion(
      id: Value(id),
      lptSummaryId: Value(lptSummaryId),
      quadrant: Value(quadrant),
      treeNum: Value(treeNum),
      siteType: Value(siteType),
      boreDOB: Value(boreDOB),
      boreHt: Value(boreHt),
      suitHt: Value(suitHt),
      suitAge: Value(suitAge),
      fieldAge: Value(fieldAge),
      proCode: Value(proCode),
    );
  }

  factory LtpTreeAgeData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpTreeAgeData(
      id: serializer.fromJson<int>(json['id']),
      lptSummaryId: serializer.fromJson<int>(json['lptSummaryId']),
      quadrant: serializer.fromJson<String>(json['quadrant']),
      treeNum: serializer.fromJson<int>(json['treeNum']),
      siteType: serializer.fromJson<String>(json['siteType']),
      boreDOB: serializer.fromJson<double>(json['boreDOB']),
      boreHt: serializer.fromJson<double>(json['boreHt']),
      suitHt: serializer.fromJson<String>(json['suitHt']),
      suitAge: serializer.fromJson<String>(json['suitAge']),
      fieldAge: serializer.fromJson<int>(json['fieldAge']),
      proCode: serializer.fromJson<String>(json['proCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lptSummaryId': serializer.toJson<int>(lptSummaryId),
      'quadrant': serializer.toJson<String>(quadrant),
      'treeNum': serializer.toJson<int>(treeNum),
      'siteType': serializer.toJson<String>(siteType),
      'boreDOB': serializer.toJson<double>(boreDOB),
      'boreHt': serializer.toJson<double>(boreHt),
      'suitHt': serializer.toJson<String>(suitHt),
      'suitAge': serializer.toJson<String>(suitAge),
      'fieldAge': serializer.toJson<int>(fieldAge),
      'proCode': serializer.toJson<String>(proCode),
    };
  }

  LtpTreeAgeData copyWith(
          {int? id,
          int? lptSummaryId,
          String? quadrant,
          int? treeNum,
          String? siteType,
          double? boreDOB,
          double? boreHt,
          String? suitHt,
          String? suitAge,
          int? fieldAge,
          String? proCode}) =>
      LtpTreeAgeData(
        id: id ?? this.id,
        lptSummaryId: lptSummaryId ?? this.lptSummaryId,
        quadrant: quadrant ?? this.quadrant,
        treeNum: treeNum ?? this.treeNum,
        siteType: siteType ?? this.siteType,
        boreDOB: boreDOB ?? this.boreDOB,
        boreHt: boreHt ?? this.boreHt,
        suitHt: suitHt ?? this.suitHt,
        suitAge: suitAge ?? this.suitAge,
        fieldAge: fieldAge ?? this.fieldAge,
        proCode: proCode ?? this.proCode,
      );
  @override
  String toString() {
    return (StringBuffer('LtpTreeAgeData(')
          ..write('id: $id, ')
          ..write('lptSummaryId: $lptSummaryId, ')
          ..write('quadrant: $quadrant, ')
          ..write('treeNum: $treeNum, ')
          ..write('siteType: $siteType, ')
          ..write('boreDOB: $boreDOB, ')
          ..write('boreHt: $boreHt, ')
          ..write('suitHt: $suitHt, ')
          ..write('suitAge: $suitAge, ')
          ..write('fieldAge: $fieldAge, ')
          ..write('proCode: $proCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lptSummaryId, quadrant, treeNum, siteType,
      boreDOB, boreHt, suitHt, suitAge, fieldAge, proCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LtpTreeAgeData &&
          other.id == this.id &&
          other.lptSummaryId == this.lptSummaryId &&
          other.quadrant == this.quadrant &&
          other.treeNum == this.treeNum &&
          other.siteType == this.siteType &&
          other.boreDOB == this.boreDOB &&
          other.boreHt == this.boreHt &&
          other.suitHt == this.suitHt &&
          other.suitAge == this.suitAge &&
          other.fieldAge == this.fieldAge &&
          other.proCode == this.proCode);
}

class LtpTreeAgeCompanion extends UpdateCompanion<LtpTreeAgeData> {
  final Value<int> id;
  final Value<int> lptSummaryId;
  final Value<String> quadrant;
  final Value<int> treeNum;
  final Value<String> siteType;
  final Value<double> boreDOB;
  final Value<double> boreHt;
  final Value<String> suitHt;
  final Value<String> suitAge;
  final Value<int> fieldAge;
  final Value<String> proCode;
  const LtpTreeAgeCompanion({
    this.id = const Value.absent(),
    this.lptSummaryId = const Value.absent(),
    this.quadrant = const Value.absent(),
    this.treeNum = const Value.absent(),
    this.siteType = const Value.absent(),
    this.boreDOB = const Value.absent(),
    this.boreHt = const Value.absent(),
    this.suitHt = const Value.absent(),
    this.suitAge = const Value.absent(),
    this.fieldAge = const Value.absent(),
    this.proCode = const Value.absent(),
  });
  LtpTreeAgeCompanion.insert({
    this.id = const Value.absent(),
    required int lptSummaryId,
    required String quadrant,
    required int treeNum,
    required String siteType,
    required double boreDOB,
    required double boreHt,
    required String suitHt,
    required String suitAge,
    required int fieldAge,
    required String proCode,
  })  : lptSummaryId = Value(lptSummaryId),
        quadrant = Value(quadrant),
        treeNum = Value(treeNum),
        siteType = Value(siteType),
        boreDOB = Value(boreDOB),
        boreHt = Value(boreHt),
        suitHt = Value(suitHt),
        suitAge = Value(suitAge),
        fieldAge = Value(fieldAge),
        proCode = Value(proCode);
  static Insertable<LtpTreeAgeData> custom({
    Expression<int>? id,
    Expression<int>? lptSummaryId,
    Expression<String>? quadrant,
    Expression<int>? treeNum,
    Expression<String>? siteType,
    Expression<double>? boreDOB,
    Expression<double>? boreHt,
    Expression<String>? suitHt,
    Expression<String>? suitAge,
    Expression<int>? fieldAge,
    Expression<String>? proCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lptSummaryId != null) 'lpt_summary_id': lptSummaryId,
      if (quadrant != null) 'quadrant': quadrant,
      if (treeNum != null) 'tree_num': treeNum,
      if (siteType != null) 'site_type': siteType,
      if (boreDOB != null) 'bore_d_o_b': boreDOB,
      if (boreHt != null) 'bore_ht': boreHt,
      if (suitHt != null) 'suit_ht': suitHt,
      if (suitAge != null) 'suit_age': suitAge,
      if (fieldAge != null) 'field_age': fieldAge,
      if (proCode != null) 'pro_code': proCode,
    });
  }

  LtpTreeAgeCompanion copyWith(
      {Value<int>? id,
      Value<int>? lptSummaryId,
      Value<String>? quadrant,
      Value<int>? treeNum,
      Value<String>? siteType,
      Value<double>? boreDOB,
      Value<double>? boreHt,
      Value<String>? suitHt,
      Value<String>? suitAge,
      Value<int>? fieldAge,
      Value<String>? proCode}) {
    return LtpTreeAgeCompanion(
      id: id ?? this.id,
      lptSummaryId: lptSummaryId ?? this.lptSummaryId,
      quadrant: quadrant ?? this.quadrant,
      treeNum: treeNum ?? this.treeNum,
      siteType: siteType ?? this.siteType,
      boreDOB: boreDOB ?? this.boreDOB,
      boreHt: boreHt ?? this.boreHt,
      suitHt: suitHt ?? this.suitHt,
      suitAge: suitAge ?? this.suitAge,
      fieldAge: fieldAge ?? this.fieldAge,
      proCode: proCode ?? this.proCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lptSummaryId.present) {
      map['lpt_summary_id'] = Variable<int>(lptSummaryId.value);
    }
    if (quadrant.present) {
      map['quadrant'] = Variable<String>(quadrant.value);
    }
    if (treeNum.present) {
      map['tree_num'] = Variable<int>(treeNum.value);
    }
    if (siteType.present) {
      map['site_type'] = Variable<String>(siteType.value);
    }
    if (boreDOB.present) {
      map['bore_d_o_b'] = Variable<double>(boreDOB.value);
    }
    if (boreHt.present) {
      map['bore_ht'] = Variable<double>(boreHt.value);
    }
    if (suitHt.present) {
      map['suit_ht'] = Variable<String>(suitHt.value);
    }
    if (suitAge.present) {
      map['suit_age'] = Variable<String>(suitAge.value);
    }
    if (fieldAge.present) {
      map['field_age'] = Variable<int>(fieldAge.value);
    }
    if (proCode.present) {
      map['pro_code'] = Variable<String>(proCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LtpTreeAgeCompanion(')
          ..write('id: $id, ')
          ..write('lptSummaryId: $lptSummaryId, ')
          ..write('quadrant: $quadrant, ')
          ..write('treeNum: $treeNum, ')
          ..write('siteType: $siteType, ')
          ..write('boreDOB: $boreDOB, ')
          ..write('boreHt: $boreHt, ')
          ..write('suitHt: $suitHt, ')
          ..write('suitAge: $suitAge, ')
          ..write('fieldAge: $fieldAge, ')
          ..write('proCode: $proCode')
          ..write(')'))
        .toString();
  }
}

class $LtpTreeRenamedTable extends LtpTreeRenamed
    with TableInfo<$LtpTreeRenamedTable, LtpTreeRenamedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LtpTreeRenamedTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lptSummaryIdMeta =
      const VerificationMeta('lptSummaryId');
  @override
  late final GeneratedColumn<int> lptSummaryId = GeneratedColumn<int>(
      'lpt_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ltp_summary (id)'));
  static const VerificationMeta _treeNumMeta =
      const VerificationMeta('treeNum');
  @override
  late final GeneratedColumn<int> treeNum = GeneratedColumn<int>(
      'tree_num', aliasedName, false,
      check: () => treeNum.isBetweenValues(1, 9999),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _treeNumPrevMeta =
      const VerificationMeta('treeNumPrev');
  @override
  late final GeneratedColumn<int> treeNumPrev = GeneratedColumn<int>(
      'tree_num_prev', aliasedName, false,
      check: () => treeNumPrev.isBetweenValues(1, 9999),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, lptSummaryId, treeNum, treeNumPrev];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ltp_tree_renamed';
  @override
  VerificationContext validateIntegrity(Insertable<LtpTreeRenamedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lpt_summary_id')) {
      context.handle(
          _lptSummaryIdMeta,
          lptSummaryId.isAcceptableOrUnknown(
              data['lpt_summary_id']!, _lptSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_lptSummaryIdMeta);
    }
    if (data.containsKey('tree_num')) {
      context.handle(_treeNumMeta,
          treeNum.isAcceptableOrUnknown(data['tree_num']!, _treeNumMeta));
    } else if (isInserting) {
      context.missing(_treeNumMeta);
    }
    if (data.containsKey('tree_num_prev')) {
      context.handle(
          _treeNumPrevMeta,
          treeNumPrev.isAcceptableOrUnknown(
              data['tree_num_prev']!, _treeNumPrevMeta));
    } else if (isInserting) {
      context.missing(_treeNumPrevMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LtpTreeRenamedData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LtpTreeRenamedData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lptSummaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lpt_summary_id'])!,
      treeNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tree_num'])!,
      treeNumPrev: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tree_num_prev'])!,
    );
  }

  @override
  $LtpTreeRenamedTable createAlias(String alias) {
    return $LtpTreeRenamedTable(attachedDatabase, alias);
  }
}

class LtpTreeRenamedData extends DataClass
    implements Insertable<LtpTreeRenamedData> {
  final int id;
  final int lptSummaryId;
  final int treeNum;
  final int treeNumPrev;
  const LtpTreeRenamedData(
      {required this.id,
      required this.lptSummaryId,
      required this.treeNum,
      required this.treeNumPrev});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lpt_summary_id'] = Variable<int>(lptSummaryId);
    map['tree_num'] = Variable<int>(treeNum);
    map['tree_num_prev'] = Variable<int>(treeNumPrev);
    return map;
  }

  LtpTreeRenamedCompanion toCompanion(bool nullToAbsent) {
    return LtpTreeRenamedCompanion(
      id: Value(id),
      lptSummaryId: Value(lptSummaryId),
      treeNum: Value(treeNum),
      treeNumPrev: Value(treeNumPrev),
    );
  }

  factory LtpTreeRenamedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LtpTreeRenamedData(
      id: serializer.fromJson<int>(json['id']),
      lptSummaryId: serializer.fromJson<int>(json['lptSummaryId']),
      treeNum: serializer.fromJson<int>(json['treeNum']),
      treeNumPrev: serializer.fromJson<int>(json['treeNumPrev']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lptSummaryId': serializer.toJson<int>(lptSummaryId),
      'treeNum': serializer.toJson<int>(treeNum),
      'treeNumPrev': serializer.toJson<int>(treeNumPrev),
    };
  }

  LtpTreeRenamedData copyWith(
          {int? id, int? lptSummaryId, int? treeNum, int? treeNumPrev}) =>
      LtpTreeRenamedData(
        id: id ?? this.id,
        lptSummaryId: lptSummaryId ?? this.lptSummaryId,
        treeNum: treeNum ?? this.treeNum,
        treeNumPrev: treeNumPrev ?? this.treeNumPrev,
      );
  @override
  String toString() {
    return (StringBuffer('LtpTreeRenamedData(')
          ..write('id: $id, ')
          ..write('lptSummaryId: $lptSummaryId, ')
          ..write('treeNum: $treeNum, ')
          ..write('treeNumPrev: $treeNumPrev')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lptSummaryId, treeNum, treeNumPrev);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LtpTreeRenamedData &&
          other.id == this.id &&
          other.lptSummaryId == this.lptSummaryId &&
          other.treeNum == this.treeNum &&
          other.treeNumPrev == this.treeNumPrev);
}

class LtpTreeRenamedCompanion extends UpdateCompanion<LtpTreeRenamedData> {
  final Value<int> id;
  final Value<int> lptSummaryId;
  final Value<int> treeNum;
  final Value<int> treeNumPrev;
  const LtpTreeRenamedCompanion({
    this.id = const Value.absent(),
    this.lptSummaryId = const Value.absent(),
    this.treeNum = const Value.absent(),
    this.treeNumPrev = const Value.absent(),
  });
  LtpTreeRenamedCompanion.insert({
    this.id = const Value.absent(),
    required int lptSummaryId,
    required int treeNum,
    required int treeNumPrev,
  })  : lptSummaryId = Value(lptSummaryId),
        treeNum = Value(treeNum),
        treeNumPrev = Value(treeNumPrev);
  static Insertable<LtpTreeRenamedData> custom({
    Expression<int>? id,
    Expression<int>? lptSummaryId,
    Expression<int>? treeNum,
    Expression<int>? treeNumPrev,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lptSummaryId != null) 'lpt_summary_id': lptSummaryId,
      if (treeNum != null) 'tree_num': treeNum,
      if (treeNumPrev != null) 'tree_num_prev': treeNumPrev,
    });
  }

  LtpTreeRenamedCompanion copyWith(
      {Value<int>? id,
      Value<int>? lptSummaryId,
      Value<int>? treeNum,
      Value<int>? treeNumPrev}) {
    return LtpTreeRenamedCompanion(
      id: id ?? this.id,
      lptSummaryId: lptSummaryId ?? this.lptSummaryId,
      treeNum: treeNum ?? this.treeNum,
      treeNumPrev: treeNumPrev ?? this.treeNumPrev,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lptSummaryId.present) {
      map['lpt_summary_id'] = Variable<int>(lptSummaryId.value);
    }
    if (treeNum.present) {
      map['tree_num'] = Variable<int>(treeNum.value);
    }
    if (treeNumPrev.present) {
      map['tree_num_prev'] = Variable<int>(treeNumPrev.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LtpTreeRenamedCompanion(')
          ..write('id: $id, ')
          ..write('lptSummaryId: $lptSummaryId, ')
          ..write('treeNum: $treeNum, ')
          ..write('treeNumPrev: $treeNumPrev')
          ..write(')'))
        .toString();
  }
}

class $StpSummaryTable extends StpSummary
    with TableInfo<$StpSummaryTable, StpSummaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StpSummaryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _plotTypeMeta =
      const VerificationMeta('plotType');
  @override
  late final GeneratedColumn<String> plotType = GeneratedColumn<String>(
      'plot_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nomPlotSizeMeta =
      const VerificationMeta('nomPlotSize');
  @override
  late final GeneratedColumn<double> nomPlotSize = GeneratedColumn<double>(
      'nom_plot_size', aliasedName, true,
      check: () => nomPlotSize.isBetweenValues(-1, 0.04),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _measPlotSizeMeta =
      const VerificationMeta('measPlotSize');
  @override
  late final GeneratedColumn<double> measPlotSize = GeneratedColumn<double>(
      'meas_plot_size', aliasedName, true,
      check: () => measPlotSize.isBetweenValues(0.0005, 0.04),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _notAssessedMeta =
      const VerificationMeta('notAssessed');
  @override
  late final GeneratedColumn<bool> notAssessed = GeneratedColumn<bool>(
      'not_assessed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("not_assessed" IN (0, 1))'),
      defaultValue: const Constant(false));
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
        surveyId,
        measDate,
        plotType,
        nomPlotSize,
        measPlotSize,
        notAssessed,
        complete
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stp_summary';
  @override
  VerificationContext validateIntegrity(Insertable<StpSummaryData> instance,
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
    if (data.containsKey('plot_type')) {
      context.handle(_plotTypeMeta,
          plotType.isAcceptableOrUnknown(data['plot_type']!, _plotTypeMeta));
    } else if (isInserting) {
      context.missing(_plotTypeMeta);
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
    if (data.containsKey('not_assessed')) {
      context.handle(
          _notAssessedMeta,
          notAssessed.isAcceptableOrUnknown(
              data['not_assessed']!, _notAssessedMeta));
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
  StpSummaryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StpSummaryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      measDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}meas_date'])!,
      plotType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plot_type'])!,
      nomPlotSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}nom_plot_size']),
      measPlotSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}meas_plot_size']),
      notAssessed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}not_assessed'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $StpSummaryTable createAlias(String alias) {
    return $StpSummaryTable(attachedDatabase, alias);
  }
}

class StpSummaryData extends DataClass implements Insertable<StpSummaryData> {
  final int id;
  final int surveyId;
  final DateTime measDate;
  final String plotType;
  final double? nomPlotSize;
  final double? measPlotSize;
  final bool notAssessed;
  final bool complete;
  const StpSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      required this.plotType,
      this.nomPlotSize,
      this.measPlotSize,
      required this.notAssessed,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['meas_date'] = Variable<DateTime>(measDate);
    map['plot_type'] = Variable<String>(plotType);
    if (!nullToAbsent || nomPlotSize != null) {
      map['nom_plot_size'] = Variable<double>(nomPlotSize);
    }
    if (!nullToAbsent || measPlotSize != null) {
      map['meas_plot_size'] = Variable<double>(measPlotSize);
    }
    map['not_assessed'] = Variable<bool>(notAssessed);
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  StpSummaryCompanion toCompanion(bool nullToAbsent) {
    return StpSummaryCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      measDate: Value(measDate),
      plotType: Value(plotType),
      nomPlotSize: nomPlotSize == null && nullToAbsent
          ? const Value.absent()
          : Value(nomPlotSize),
      measPlotSize: measPlotSize == null && nullToAbsent
          ? const Value.absent()
          : Value(measPlotSize),
      notAssessed: Value(notAssessed),
      complete: Value(complete),
    );
  }

  factory StpSummaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StpSummaryData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      measDate: serializer.fromJson<DateTime>(json['measDate']),
      plotType: serializer.fromJson<String>(json['plotType']),
      nomPlotSize: serializer.fromJson<double?>(json['nomPlotSize']),
      measPlotSize: serializer.fromJson<double?>(json['measPlotSize']),
      notAssessed: serializer.fromJson<bool>(json['notAssessed']),
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
      'plotType': serializer.toJson<String>(plotType),
      'nomPlotSize': serializer.toJson<double?>(nomPlotSize),
      'measPlotSize': serializer.toJson<double?>(measPlotSize),
      'notAssessed': serializer.toJson<bool>(notAssessed),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  StpSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          String? plotType,
          Value<double?> nomPlotSize = const Value.absent(),
          Value<double?> measPlotSize = const Value.absent(),
          bool? notAssessed,
          bool? complete}) =>
      StpSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        plotType: plotType ?? this.plotType,
        nomPlotSize: nomPlotSize.present ? nomPlotSize.value : this.nomPlotSize,
        measPlotSize:
            measPlotSize.present ? measPlotSize.value : this.measPlotSize,
        notAssessed: notAssessed ?? this.notAssessed,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('StpSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('plotType: $plotType, ')
          ..write('nomPlotSize: $nomPlotSize, ')
          ..write('measPlotSize: $measPlotSize, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, measDate, plotType, nomPlotSize,
      measPlotSize, notAssessed, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StpSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.plotType == this.plotType &&
          other.nomPlotSize == this.nomPlotSize &&
          other.measPlotSize == this.measPlotSize &&
          other.notAssessed == this.notAssessed &&
          other.complete == this.complete);
}

class StpSummaryCompanion extends UpdateCompanion<StpSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<String> plotType;
  final Value<double?> nomPlotSize;
  final Value<double?> measPlotSize;
  final Value<bool> notAssessed;
  final Value<bool> complete;
  const StpSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.plotType = const Value.absent(),
    this.nomPlotSize = const Value.absent(),
    this.measPlotSize = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  });
  StpSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    required String plotType,
    this.nomPlotSize = const Value.absent(),
    this.measPlotSize = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate),
        plotType = Value(plotType);
  static Insertable<StpSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<String>? plotType,
    Expression<double>? nomPlotSize,
    Expression<double>? measPlotSize,
    Expression<bool>? notAssessed,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (plotType != null) 'plot_type': plotType,
      if (nomPlotSize != null) 'nom_plot_size': nomPlotSize,
      if (measPlotSize != null) 'meas_plot_size': measPlotSize,
      if (notAssessed != null) 'not_assessed': notAssessed,
      if (complete != null) 'complete': complete,
    });
  }

  StpSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<String>? plotType,
      Value<double?>? nomPlotSize,
      Value<double?>? measPlotSize,
      Value<bool>? notAssessed,
      Value<bool>? complete}) {
    return StpSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      plotType: plotType ?? this.plotType,
      nomPlotSize: nomPlotSize ?? this.nomPlotSize,
      measPlotSize: measPlotSize ?? this.measPlotSize,
      notAssessed: notAssessed ?? this.notAssessed,
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
    if (plotType.present) {
      map['plot_type'] = Variable<String>(plotType.value);
    }
    if (nomPlotSize.present) {
      map['nom_plot_size'] = Variable<double>(nomPlotSize.value);
    }
    if (measPlotSize.present) {
      map['meas_plot_size'] = Variable<double>(measPlotSize.value);
    }
    if (notAssessed.present) {
      map['not_assessed'] = Variable<bool>(notAssessed.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StpSummaryCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('plotType: $plotType, ')
          ..write('nomPlotSize: $nomPlotSize, ')
          ..write('measPlotSize: $measPlotSize, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $StpSpeciesTable extends StpSpecies
    with TableInfo<$StpSpeciesTable, StpSpeciesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StpSpeciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _stpSummaryIdMeta =
      const VerificationMeta('stpSummaryId');
  @override
  late final GeneratedColumn<int> stpSummaryId = GeneratedColumn<int>(
      'stp_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES stp_summary (id)'));
  static const VerificationMeta _origPlotAreaMeta =
      const VerificationMeta('origPlotArea');
  @override
  late final GeneratedColumn<String> origPlotArea = GeneratedColumn<String>(
      'orig_plot_area', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _genusMeta = const VerificationMeta('genus');
  @override
  late final GeneratedColumn<String> genus = GeneratedColumn<String>(
      'genus', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _speciesMeta =
      const VerificationMeta('species');
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
      'species', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _varietyMeta =
      const VerificationMeta('variety');
  @override
  late final GeneratedColumn<String> variety = GeneratedColumn<String>(
      'variety', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dbhMeta = const VerificationMeta('dbh');
  @override
  late final GeneratedColumn<double> dbh = GeneratedColumn<double>(
      'dbh', aliasedName, false,
      check: () => dbh.isBetweenValues(-1, 8.9),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      check: () => height.isBetweenValues(-1, 20),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _measHeightMeta =
      const VerificationMeta('measHeight');
  @override
  late final GeneratedColumn<String> measHeight = GeneratedColumn<String>(
      'meas_height', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _stemConditionMeta =
      const VerificationMeta('stemCondition');
  @override
  late final GeneratedColumn<String> stemCondition = GeneratedColumn<String>(
      'stem_condition', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        stpSummaryId,
        origPlotArea,
        genus,
        species,
        variety,
        status,
        dbh,
        height,
        measHeight,
        stemCondition
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stp_species';
  @override
  VerificationContext validateIntegrity(Insertable<StpSpeciesData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('stp_summary_id')) {
      context.handle(
          _stpSummaryIdMeta,
          stpSummaryId.isAcceptableOrUnknown(
              data['stp_summary_id']!, _stpSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_stpSummaryIdMeta);
    }
    if (data.containsKey('orig_plot_area')) {
      context.handle(
          _origPlotAreaMeta,
          origPlotArea.isAcceptableOrUnknown(
              data['orig_plot_area']!, _origPlotAreaMeta));
    } else if (isInserting) {
      context.missing(_origPlotAreaMeta);
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
    } else if (isInserting) {
      context.missing(_varietyMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('dbh')) {
      context.handle(
          _dbhMeta, dbh.isAcceptableOrUnknown(data['dbh']!, _dbhMeta));
    } else if (isInserting) {
      context.missing(_dbhMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('meas_height')) {
      context.handle(
          _measHeightMeta,
          measHeight.isAcceptableOrUnknown(
              data['meas_height']!, _measHeightMeta));
    } else if (isInserting) {
      context.missing(_measHeightMeta);
    }
    if (data.containsKey('stem_condition')) {
      context.handle(
          _stemConditionMeta,
          stemCondition.isAcceptableOrUnknown(
              data['stem_condition']!, _stemConditionMeta));
    } else if (isInserting) {
      context.missing(_stemConditionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StpSpeciesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StpSpeciesData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      stpSummaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stp_summary_id'])!,
      origPlotArea: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}orig_plot_area'])!,
      genus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genus'])!,
      species: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}species'])!,
      variety: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variety'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      dbh: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}dbh'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      measHeight: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meas_height'])!,
      stemCondition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stem_condition'])!,
    );
  }

  @override
  $StpSpeciesTable createAlias(String alias) {
    return $StpSpeciesTable(attachedDatabase, alias);
  }
}

class StpSpeciesData extends DataClass implements Insertable<StpSpeciesData> {
  final int id;
  final int stpSummaryId;
  final String origPlotArea;
  final String genus;
  final String species;
  final String variety;
  final String status;
  final double dbh;
  final double height;
  final String measHeight;
  final String stemCondition;
  const StpSpeciesData(
      {required this.id,
      required this.stpSummaryId,
      required this.origPlotArea,
      required this.genus,
      required this.species,
      required this.variety,
      required this.status,
      required this.dbh,
      required this.height,
      required this.measHeight,
      required this.stemCondition});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stp_summary_id'] = Variable<int>(stpSummaryId);
    map['orig_plot_area'] = Variable<String>(origPlotArea);
    map['genus'] = Variable<String>(genus);
    map['species'] = Variable<String>(species);
    map['variety'] = Variable<String>(variety);
    map['status'] = Variable<String>(status);
    map['dbh'] = Variable<double>(dbh);
    map['height'] = Variable<double>(height);
    map['meas_height'] = Variable<String>(measHeight);
    map['stem_condition'] = Variable<String>(stemCondition);
    return map;
  }

  StpSpeciesCompanion toCompanion(bool nullToAbsent) {
    return StpSpeciesCompanion(
      id: Value(id),
      stpSummaryId: Value(stpSummaryId),
      origPlotArea: Value(origPlotArea),
      genus: Value(genus),
      species: Value(species),
      variety: Value(variety),
      status: Value(status),
      dbh: Value(dbh),
      height: Value(height),
      measHeight: Value(measHeight),
      stemCondition: Value(stemCondition),
    );
  }

  factory StpSpeciesData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StpSpeciesData(
      id: serializer.fromJson<int>(json['id']),
      stpSummaryId: serializer.fromJson<int>(json['stpSummaryId']),
      origPlotArea: serializer.fromJson<String>(json['origPlotArea']),
      genus: serializer.fromJson<String>(json['genus']),
      species: serializer.fromJson<String>(json['species']),
      variety: serializer.fromJson<String>(json['variety']),
      status: serializer.fromJson<String>(json['status']),
      dbh: serializer.fromJson<double>(json['dbh']),
      height: serializer.fromJson<double>(json['height']),
      measHeight: serializer.fromJson<String>(json['measHeight']),
      stemCondition: serializer.fromJson<String>(json['stemCondition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stpSummaryId': serializer.toJson<int>(stpSummaryId),
      'origPlotArea': serializer.toJson<String>(origPlotArea),
      'genus': serializer.toJson<String>(genus),
      'species': serializer.toJson<String>(species),
      'variety': serializer.toJson<String>(variety),
      'status': serializer.toJson<String>(status),
      'dbh': serializer.toJson<double>(dbh),
      'height': serializer.toJson<double>(height),
      'measHeight': serializer.toJson<String>(measHeight),
      'stemCondition': serializer.toJson<String>(stemCondition),
    };
  }

  StpSpeciesData copyWith(
          {int? id,
          int? stpSummaryId,
          String? origPlotArea,
          String? genus,
          String? species,
          String? variety,
          String? status,
          double? dbh,
          double? height,
          String? measHeight,
          String? stemCondition}) =>
      StpSpeciesData(
        id: id ?? this.id,
        stpSummaryId: stpSummaryId ?? this.stpSummaryId,
        origPlotArea: origPlotArea ?? this.origPlotArea,
        genus: genus ?? this.genus,
        species: species ?? this.species,
        variety: variety ?? this.variety,
        status: status ?? this.status,
        dbh: dbh ?? this.dbh,
        height: height ?? this.height,
        measHeight: measHeight ?? this.measHeight,
        stemCondition: stemCondition ?? this.stemCondition,
      );
  @override
  String toString() {
    return (StringBuffer('StpSpeciesData(')
          ..write('id: $id, ')
          ..write('stpSummaryId: $stpSummaryId, ')
          ..write('origPlotArea: $origPlotArea, ')
          ..write('genus: $genus, ')
          ..write('species: $species, ')
          ..write('variety: $variety, ')
          ..write('status: $status, ')
          ..write('dbh: $dbh, ')
          ..write('height: $height, ')
          ..write('measHeight: $measHeight, ')
          ..write('stemCondition: $stemCondition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, stpSummaryId, origPlotArea, genus,
      species, variety, status, dbh, height, measHeight, stemCondition);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StpSpeciesData &&
          other.id == this.id &&
          other.stpSummaryId == this.stpSummaryId &&
          other.origPlotArea == this.origPlotArea &&
          other.genus == this.genus &&
          other.species == this.species &&
          other.variety == this.variety &&
          other.status == this.status &&
          other.dbh == this.dbh &&
          other.height == this.height &&
          other.measHeight == this.measHeight &&
          other.stemCondition == this.stemCondition);
}

class StpSpeciesCompanion extends UpdateCompanion<StpSpeciesData> {
  final Value<int> id;
  final Value<int> stpSummaryId;
  final Value<String> origPlotArea;
  final Value<String> genus;
  final Value<String> species;
  final Value<String> variety;
  final Value<String> status;
  final Value<double> dbh;
  final Value<double> height;
  final Value<String> measHeight;
  final Value<String> stemCondition;
  const StpSpeciesCompanion({
    this.id = const Value.absent(),
    this.stpSummaryId = const Value.absent(),
    this.origPlotArea = const Value.absent(),
    this.genus = const Value.absent(),
    this.species = const Value.absent(),
    this.variety = const Value.absent(),
    this.status = const Value.absent(),
    this.dbh = const Value.absent(),
    this.height = const Value.absent(),
    this.measHeight = const Value.absent(),
    this.stemCondition = const Value.absent(),
  });
  StpSpeciesCompanion.insert({
    this.id = const Value.absent(),
    required int stpSummaryId,
    required String origPlotArea,
    required String genus,
    required String species,
    required String variety,
    required String status,
    required double dbh,
    required double height,
    required String measHeight,
    required String stemCondition,
  })  : stpSummaryId = Value(stpSummaryId),
        origPlotArea = Value(origPlotArea),
        genus = Value(genus),
        species = Value(species),
        variety = Value(variety),
        status = Value(status),
        dbh = Value(dbh),
        height = Value(height),
        measHeight = Value(measHeight),
        stemCondition = Value(stemCondition);
  static Insertable<StpSpeciesData> custom({
    Expression<int>? id,
    Expression<int>? stpSummaryId,
    Expression<String>? origPlotArea,
    Expression<String>? genus,
    Expression<String>? species,
    Expression<String>? variety,
    Expression<String>? status,
    Expression<double>? dbh,
    Expression<double>? height,
    Expression<String>? measHeight,
    Expression<String>? stemCondition,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stpSummaryId != null) 'stp_summary_id': stpSummaryId,
      if (origPlotArea != null) 'orig_plot_area': origPlotArea,
      if (genus != null) 'genus': genus,
      if (species != null) 'species': species,
      if (variety != null) 'variety': variety,
      if (status != null) 'status': status,
      if (dbh != null) 'dbh': dbh,
      if (height != null) 'height': height,
      if (measHeight != null) 'meas_height': measHeight,
      if (stemCondition != null) 'stem_condition': stemCondition,
    });
  }

  StpSpeciesCompanion copyWith(
      {Value<int>? id,
      Value<int>? stpSummaryId,
      Value<String>? origPlotArea,
      Value<String>? genus,
      Value<String>? species,
      Value<String>? variety,
      Value<String>? status,
      Value<double>? dbh,
      Value<double>? height,
      Value<String>? measHeight,
      Value<String>? stemCondition}) {
    return StpSpeciesCompanion(
      id: id ?? this.id,
      stpSummaryId: stpSummaryId ?? this.stpSummaryId,
      origPlotArea: origPlotArea ?? this.origPlotArea,
      genus: genus ?? this.genus,
      species: species ?? this.species,
      variety: variety ?? this.variety,
      status: status ?? this.status,
      dbh: dbh ?? this.dbh,
      height: height ?? this.height,
      measHeight: measHeight ?? this.measHeight,
      stemCondition: stemCondition ?? this.stemCondition,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stpSummaryId.present) {
      map['stp_summary_id'] = Variable<int>(stpSummaryId.value);
    }
    if (origPlotArea.present) {
      map['orig_plot_area'] = Variable<String>(origPlotArea.value);
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
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (dbh.present) {
      map['dbh'] = Variable<double>(dbh.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (measHeight.present) {
      map['meas_height'] = Variable<String>(measHeight.value);
    }
    if (stemCondition.present) {
      map['stem_condition'] = Variable<String>(stemCondition.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StpSpeciesCompanion(')
          ..write('id: $id, ')
          ..write('stpSummaryId: $stpSummaryId, ')
          ..write('origPlotArea: $origPlotArea, ')
          ..write('genus: $genus, ')
          ..write('species: $species, ')
          ..write('variety: $variety, ')
          ..write('status: $status, ')
          ..write('dbh: $dbh, ')
          ..write('height: $height, ')
          ..write('measHeight: $measHeight, ')
          ..write('stemCondition: $stemCondition')
          ..write(')'))
        .toString();
  }
}

class $ShrubSummaryTable extends ShrubSummary
    with TableInfo<$ShrubSummaryTable, ShrubSummaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShrubSummaryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _plotTypeMeta =
      const VerificationMeta('plotType');
  @override
  late final GeneratedColumn<String> plotType = GeneratedColumn<String>(
      'plot_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nomPlotSizeMeta =
      const VerificationMeta('nomPlotSize');
  @override
  late final GeneratedColumn<double> nomPlotSize = GeneratedColumn<double>(
      'nom_plot_size', aliasedName, true,
      check: () => nomPlotSize.isBetweenValues(-1, 0.04),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _measPlotSizeMeta =
      const VerificationMeta('measPlotSize');
  @override
  late final GeneratedColumn<double> measPlotSize = GeneratedColumn<double>(
      'meas_plot_size', aliasedName, true,
      check: () => measPlotSize.isBetweenValues(0.0005, 0.04),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _notAssessedMeta =
      const VerificationMeta('notAssessed');
  @override
  late final GeneratedColumn<bool> notAssessed = GeneratedColumn<bool>(
      'not_assessed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("not_assessed" IN (0, 1))'),
      defaultValue: const Constant(false));
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
        surveyId,
        measDate,
        plotType,
        nomPlotSize,
        measPlotSize,
        notAssessed,
        complete
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shrub_summary';
  @override
  VerificationContext validateIntegrity(Insertable<ShrubSummaryData> instance,
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
    if (data.containsKey('plot_type')) {
      context.handle(_plotTypeMeta,
          plotType.isAcceptableOrUnknown(data['plot_type']!, _plotTypeMeta));
    } else if (isInserting) {
      context.missing(_plotTypeMeta);
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
    if (data.containsKey('not_assessed')) {
      context.handle(
          _notAssessedMeta,
          notAssessed.isAcceptableOrUnknown(
              data['not_assessed']!, _notAssessedMeta));
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
  ShrubSummaryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShrubSummaryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      measDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}meas_date'])!,
      plotType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plot_type'])!,
      nomPlotSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}nom_plot_size']),
      measPlotSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}meas_plot_size']),
      notAssessed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}not_assessed'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $ShrubSummaryTable createAlias(String alias) {
    return $ShrubSummaryTable(attachedDatabase, alias);
  }
}

class ShrubSummaryData extends DataClass
    implements Insertable<ShrubSummaryData> {
  final int id;
  final int surveyId;
  final DateTime measDate;
  final String plotType;
  final double? nomPlotSize;
  final double? measPlotSize;
  final bool notAssessed;
  final bool complete;
  const ShrubSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      required this.plotType,
      this.nomPlotSize,
      this.measPlotSize,
      required this.notAssessed,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['meas_date'] = Variable<DateTime>(measDate);
    map['plot_type'] = Variable<String>(plotType);
    if (!nullToAbsent || nomPlotSize != null) {
      map['nom_plot_size'] = Variable<double>(nomPlotSize);
    }
    if (!nullToAbsent || measPlotSize != null) {
      map['meas_plot_size'] = Variable<double>(measPlotSize);
    }
    map['not_assessed'] = Variable<bool>(notAssessed);
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  ShrubSummaryCompanion toCompanion(bool nullToAbsent) {
    return ShrubSummaryCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      measDate: Value(measDate),
      plotType: Value(plotType),
      nomPlotSize: nomPlotSize == null && nullToAbsent
          ? const Value.absent()
          : Value(nomPlotSize),
      measPlotSize: measPlotSize == null && nullToAbsent
          ? const Value.absent()
          : Value(measPlotSize),
      notAssessed: Value(notAssessed),
      complete: Value(complete),
    );
  }

  factory ShrubSummaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShrubSummaryData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      measDate: serializer.fromJson<DateTime>(json['measDate']),
      plotType: serializer.fromJson<String>(json['plotType']),
      nomPlotSize: serializer.fromJson<double?>(json['nomPlotSize']),
      measPlotSize: serializer.fromJson<double?>(json['measPlotSize']),
      notAssessed: serializer.fromJson<bool>(json['notAssessed']),
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
      'plotType': serializer.toJson<String>(plotType),
      'nomPlotSize': serializer.toJson<double?>(nomPlotSize),
      'measPlotSize': serializer.toJson<double?>(measPlotSize),
      'notAssessed': serializer.toJson<bool>(notAssessed),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  ShrubSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          String? plotType,
          Value<double?> nomPlotSize = const Value.absent(),
          Value<double?> measPlotSize = const Value.absent(),
          bool? notAssessed,
          bool? complete}) =>
      ShrubSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        plotType: plotType ?? this.plotType,
        nomPlotSize: nomPlotSize.present ? nomPlotSize.value : this.nomPlotSize,
        measPlotSize:
            measPlotSize.present ? measPlotSize.value : this.measPlotSize,
        notAssessed: notAssessed ?? this.notAssessed,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('ShrubSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('plotType: $plotType, ')
          ..write('nomPlotSize: $nomPlotSize, ')
          ..write('measPlotSize: $measPlotSize, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, measDate, plotType, nomPlotSize,
      measPlotSize, notAssessed, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShrubSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.plotType == this.plotType &&
          other.nomPlotSize == this.nomPlotSize &&
          other.measPlotSize == this.measPlotSize &&
          other.notAssessed == this.notAssessed &&
          other.complete == this.complete);
}

class ShrubSummaryCompanion extends UpdateCompanion<ShrubSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<String> plotType;
  final Value<double?> nomPlotSize;
  final Value<double?> measPlotSize;
  final Value<bool> notAssessed;
  final Value<bool> complete;
  const ShrubSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.plotType = const Value.absent(),
    this.nomPlotSize = const Value.absent(),
    this.measPlotSize = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  });
  ShrubSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    required String plotType,
    this.nomPlotSize = const Value.absent(),
    this.measPlotSize = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate),
        plotType = Value(plotType);
  static Insertable<ShrubSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<String>? plotType,
    Expression<double>? nomPlotSize,
    Expression<double>? measPlotSize,
    Expression<bool>? notAssessed,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (plotType != null) 'plot_type': plotType,
      if (nomPlotSize != null) 'nom_plot_size': nomPlotSize,
      if (measPlotSize != null) 'meas_plot_size': measPlotSize,
      if (notAssessed != null) 'not_assessed': notAssessed,
      if (complete != null) 'complete': complete,
    });
  }

  ShrubSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<String>? plotType,
      Value<double?>? nomPlotSize,
      Value<double?>? measPlotSize,
      Value<bool>? notAssessed,
      Value<bool>? complete}) {
    return ShrubSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      plotType: plotType ?? this.plotType,
      nomPlotSize: nomPlotSize ?? this.nomPlotSize,
      measPlotSize: measPlotSize ?? this.measPlotSize,
      notAssessed: notAssessed ?? this.notAssessed,
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
    if (plotType.present) {
      map['plot_type'] = Variable<String>(plotType.value);
    }
    if (nomPlotSize.present) {
      map['nom_plot_size'] = Variable<double>(nomPlotSize.value);
    }
    if (measPlotSize.present) {
      map['meas_plot_size'] = Variable<double>(measPlotSize.value);
    }
    if (notAssessed.present) {
      map['not_assessed'] = Variable<bool>(notAssessed.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShrubSummaryCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('plotType: $plotType, ')
          ..write('nomPlotSize: $nomPlotSize, ')
          ..write('measPlotSize: $measPlotSize, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $ShrubListEntryTable extends ShrubListEntry
    with TableInfo<$ShrubListEntryTable, ShrubListEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShrubListEntryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _shrubSummaryIdMeta =
      const VerificationMeta('shrubSummaryId');
  @override
  late final GeneratedColumn<int> shrubSummaryId = GeneratedColumn<int>(
      'shrub_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES shrub_summary (id)'));
  static const VerificationMeta _recordNumMeta =
      const VerificationMeta('recordNum');
  @override
  late final GeneratedColumn<int> recordNum = GeneratedColumn<int>(
      'record_num', aliasedName, false,
      check: () => recordNum.isBetweenValues(1, 9999),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _shrubGenusMeta =
      const VerificationMeta('shrubGenus');
  @override
  late final GeneratedColumn<String> shrubGenus = GeneratedColumn<String>(
      'shrub_genus', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _shrubSpeciesMeta =
      const VerificationMeta('shrubSpecies');
  @override
  late final GeneratedColumn<String> shrubSpecies = GeneratedColumn<String>(
      'shrub_species', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _shrubVarietyMeta =
      const VerificationMeta('shrubVariety');
  @override
  late final GeneratedColumn<String> shrubVariety = GeneratedColumn<String>(
      'shrub_variety', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _shrubStatusMeta =
      const VerificationMeta('shrubStatus');
  @override
  late final GeneratedColumn<String> shrubStatus = GeneratedColumn<String>(
      'shrub_status', aliasedName, false,
      check: () => shrubStatus.isIn(['LV' 'DS']),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _bdClassMeta =
      const VerificationMeta('bdClass');
  @override
  late final GeneratedColumn<int> bdClass = GeneratedColumn<int>(
      'bd_class', aliasedName, false,
      check: () => bdClass.isBetweenValues(0, 10) | bdClass.equals(-1),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _frequencyMeta =
      const VerificationMeta('frequency');
  @override
  late final GeneratedColumn<int> frequency = GeneratedColumn<int>(
      'frequency', aliasedName, false,
      check: () => frequency.isBetweenValues(1, 999),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        shrubSummaryId,
        recordNum,
        shrubGenus,
        shrubSpecies,
        shrubVariety,
        shrubStatus,
        bdClass,
        frequency
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shrub_list_entry';
  @override
  VerificationContext validateIntegrity(Insertable<ShrubListEntryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shrub_summary_id')) {
      context.handle(
          _shrubSummaryIdMeta,
          shrubSummaryId.isAcceptableOrUnknown(
              data['shrub_summary_id']!, _shrubSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_shrubSummaryIdMeta);
    }
    if (data.containsKey('record_num')) {
      context.handle(_recordNumMeta,
          recordNum.isAcceptableOrUnknown(data['record_num']!, _recordNumMeta));
    } else if (isInserting) {
      context.missing(_recordNumMeta);
    }
    if (data.containsKey('shrub_genus')) {
      context.handle(
          _shrubGenusMeta,
          shrubGenus.isAcceptableOrUnknown(
              data['shrub_genus']!, _shrubGenusMeta));
    } else if (isInserting) {
      context.missing(_shrubGenusMeta);
    }
    if (data.containsKey('shrub_species')) {
      context.handle(
          _shrubSpeciesMeta,
          shrubSpecies.isAcceptableOrUnknown(
              data['shrub_species']!, _shrubSpeciesMeta));
    } else if (isInserting) {
      context.missing(_shrubSpeciesMeta);
    }
    if (data.containsKey('shrub_variety')) {
      context.handle(
          _shrubVarietyMeta,
          shrubVariety.isAcceptableOrUnknown(
              data['shrub_variety']!, _shrubVarietyMeta));
    } else if (isInserting) {
      context.missing(_shrubVarietyMeta);
    }
    if (data.containsKey('shrub_status')) {
      context.handle(
          _shrubStatusMeta,
          shrubStatus.isAcceptableOrUnknown(
              data['shrub_status']!, _shrubStatusMeta));
    } else if (isInserting) {
      context.missing(_shrubStatusMeta);
    }
    if (data.containsKey('bd_class')) {
      context.handle(_bdClassMeta,
          bdClass.isAcceptableOrUnknown(data['bd_class']!, _bdClassMeta));
    } else if (isInserting) {
      context.missing(_bdClassMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(_frequencyMeta,
          frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta));
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShrubListEntryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShrubListEntryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      shrubSummaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}shrub_summary_id'])!,
      recordNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}record_num'])!,
      shrubGenus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shrub_genus'])!,
      shrubSpecies: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shrub_species'])!,
      shrubVariety: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shrub_variety'])!,
      shrubStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shrub_status'])!,
      bdClass: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bd_class'])!,
      frequency: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}frequency'])!,
    );
  }

  @override
  $ShrubListEntryTable createAlias(String alias) {
    return $ShrubListEntryTable(attachedDatabase, alias);
  }
}

class ShrubListEntryData extends DataClass
    implements Insertable<ShrubListEntryData> {
  final int id;
  final int shrubSummaryId;
  final int recordNum;
  final String shrubGenus;
  final String shrubSpecies;
  final String shrubVariety;
  final String shrubStatus;
  final int bdClass;
  final int frequency;
  const ShrubListEntryData(
      {required this.id,
      required this.shrubSummaryId,
      required this.recordNum,
      required this.shrubGenus,
      required this.shrubSpecies,
      required this.shrubVariety,
      required this.shrubStatus,
      required this.bdClass,
      required this.frequency});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['shrub_summary_id'] = Variable<int>(shrubSummaryId);
    map['record_num'] = Variable<int>(recordNum);
    map['shrub_genus'] = Variable<String>(shrubGenus);
    map['shrub_species'] = Variable<String>(shrubSpecies);
    map['shrub_variety'] = Variable<String>(shrubVariety);
    map['shrub_status'] = Variable<String>(shrubStatus);
    map['bd_class'] = Variable<int>(bdClass);
    map['frequency'] = Variable<int>(frequency);
    return map;
  }

  ShrubListEntryCompanion toCompanion(bool nullToAbsent) {
    return ShrubListEntryCompanion(
      id: Value(id),
      shrubSummaryId: Value(shrubSummaryId),
      recordNum: Value(recordNum),
      shrubGenus: Value(shrubGenus),
      shrubSpecies: Value(shrubSpecies),
      shrubVariety: Value(shrubVariety),
      shrubStatus: Value(shrubStatus),
      bdClass: Value(bdClass),
      frequency: Value(frequency),
    );
  }

  factory ShrubListEntryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShrubListEntryData(
      id: serializer.fromJson<int>(json['id']),
      shrubSummaryId: serializer.fromJson<int>(json['shrubSummaryId']),
      recordNum: serializer.fromJson<int>(json['recordNum']),
      shrubGenus: serializer.fromJson<String>(json['shrubGenus']),
      shrubSpecies: serializer.fromJson<String>(json['shrubSpecies']),
      shrubVariety: serializer.fromJson<String>(json['shrubVariety']),
      shrubStatus: serializer.fromJson<String>(json['shrubStatus']),
      bdClass: serializer.fromJson<int>(json['bdClass']),
      frequency: serializer.fromJson<int>(json['frequency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'shrubSummaryId': serializer.toJson<int>(shrubSummaryId),
      'recordNum': serializer.toJson<int>(recordNum),
      'shrubGenus': serializer.toJson<String>(shrubGenus),
      'shrubSpecies': serializer.toJson<String>(shrubSpecies),
      'shrubVariety': serializer.toJson<String>(shrubVariety),
      'shrubStatus': serializer.toJson<String>(shrubStatus),
      'bdClass': serializer.toJson<int>(bdClass),
      'frequency': serializer.toJson<int>(frequency),
    };
  }

  ShrubListEntryData copyWith(
          {int? id,
          int? shrubSummaryId,
          int? recordNum,
          String? shrubGenus,
          String? shrubSpecies,
          String? shrubVariety,
          String? shrubStatus,
          int? bdClass,
          int? frequency}) =>
      ShrubListEntryData(
        id: id ?? this.id,
        shrubSummaryId: shrubSummaryId ?? this.shrubSummaryId,
        recordNum: recordNum ?? this.recordNum,
        shrubGenus: shrubGenus ?? this.shrubGenus,
        shrubSpecies: shrubSpecies ?? this.shrubSpecies,
        shrubVariety: shrubVariety ?? this.shrubVariety,
        shrubStatus: shrubStatus ?? this.shrubStatus,
        bdClass: bdClass ?? this.bdClass,
        frequency: frequency ?? this.frequency,
      );
  @override
  String toString() {
    return (StringBuffer('ShrubListEntryData(')
          ..write('id: $id, ')
          ..write('shrubSummaryId: $shrubSummaryId, ')
          ..write('recordNum: $recordNum, ')
          ..write('shrubGenus: $shrubGenus, ')
          ..write('shrubSpecies: $shrubSpecies, ')
          ..write('shrubVariety: $shrubVariety, ')
          ..write('shrubStatus: $shrubStatus, ')
          ..write('bdClass: $bdClass, ')
          ..write('frequency: $frequency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, shrubSummaryId, recordNum, shrubGenus,
      shrubSpecies, shrubVariety, shrubStatus, bdClass, frequency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShrubListEntryData &&
          other.id == this.id &&
          other.shrubSummaryId == this.shrubSummaryId &&
          other.recordNum == this.recordNum &&
          other.shrubGenus == this.shrubGenus &&
          other.shrubSpecies == this.shrubSpecies &&
          other.shrubVariety == this.shrubVariety &&
          other.shrubStatus == this.shrubStatus &&
          other.bdClass == this.bdClass &&
          other.frequency == this.frequency);
}

class ShrubListEntryCompanion extends UpdateCompanion<ShrubListEntryData> {
  final Value<int> id;
  final Value<int> shrubSummaryId;
  final Value<int> recordNum;
  final Value<String> shrubGenus;
  final Value<String> shrubSpecies;
  final Value<String> shrubVariety;
  final Value<String> shrubStatus;
  final Value<int> bdClass;
  final Value<int> frequency;
  const ShrubListEntryCompanion({
    this.id = const Value.absent(),
    this.shrubSummaryId = const Value.absent(),
    this.recordNum = const Value.absent(),
    this.shrubGenus = const Value.absent(),
    this.shrubSpecies = const Value.absent(),
    this.shrubVariety = const Value.absent(),
    this.shrubStatus = const Value.absent(),
    this.bdClass = const Value.absent(),
    this.frequency = const Value.absent(),
  });
  ShrubListEntryCompanion.insert({
    this.id = const Value.absent(),
    required int shrubSummaryId,
    required int recordNum,
    required String shrubGenus,
    required String shrubSpecies,
    required String shrubVariety,
    required String shrubStatus,
    required int bdClass,
    required int frequency,
  })  : shrubSummaryId = Value(shrubSummaryId),
        recordNum = Value(recordNum),
        shrubGenus = Value(shrubGenus),
        shrubSpecies = Value(shrubSpecies),
        shrubVariety = Value(shrubVariety),
        shrubStatus = Value(shrubStatus),
        bdClass = Value(bdClass),
        frequency = Value(frequency);
  static Insertable<ShrubListEntryData> custom({
    Expression<int>? id,
    Expression<int>? shrubSummaryId,
    Expression<int>? recordNum,
    Expression<String>? shrubGenus,
    Expression<String>? shrubSpecies,
    Expression<String>? shrubVariety,
    Expression<String>? shrubStatus,
    Expression<int>? bdClass,
    Expression<int>? frequency,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shrubSummaryId != null) 'shrub_summary_id': shrubSummaryId,
      if (recordNum != null) 'record_num': recordNum,
      if (shrubGenus != null) 'shrub_genus': shrubGenus,
      if (shrubSpecies != null) 'shrub_species': shrubSpecies,
      if (shrubVariety != null) 'shrub_variety': shrubVariety,
      if (shrubStatus != null) 'shrub_status': shrubStatus,
      if (bdClass != null) 'bd_class': bdClass,
      if (frequency != null) 'frequency': frequency,
    });
  }

  ShrubListEntryCompanion copyWith(
      {Value<int>? id,
      Value<int>? shrubSummaryId,
      Value<int>? recordNum,
      Value<String>? shrubGenus,
      Value<String>? shrubSpecies,
      Value<String>? shrubVariety,
      Value<String>? shrubStatus,
      Value<int>? bdClass,
      Value<int>? frequency}) {
    return ShrubListEntryCompanion(
      id: id ?? this.id,
      shrubSummaryId: shrubSummaryId ?? this.shrubSummaryId,
      recordNum: recordNum ?? this.recordNum,
      shrubGenus: shrubGenus ?? this.shrubGenus,
      shrubSpecies: shrubSpecies ?? this.shrubSpecies,
      shrubVariety: shrubVariety ?? this.shrubVariety,
      shrubStatus: shrubStatus ?? this.shrubStatus,
      bdClass: bdClass ?? this.bdClass,
      frequency: frequency ?? this.frequency,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (shrubSummaryId.present) {
      map['shrub_summary_id'] = Variable<int>(shrubSummaryId.value);
    }
    if (recordNum.present) {
      map['record_num'] = Variable<int>(recordNum.value);
    }
    if (shrubGenus.present) {
      map['shrub_genus'] = Variable<String>(shrubGenus.value);
    }
    if (shrubSpecies.present) {
      map['shrub_species'] = Variable<String>(shrubSpecies.value);
    }
    if (shrubVariety.present) {
      map['shrub_variety'] = Variable<String>(shrubVariety.value);
    }
    if (shrubStatus.present) {
      map['shrub_status'] = Variable<String>(shrubStatus.value);
    }
    if (bdClass.present) {
      map['bd_class'] = Variable<int>(bdClass.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<int>(frequency.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShrubListEntryCompanion(')
          ..write('id: $id, ')
          ..write('shrubSummaryId: $shrubSummaryId, ')
          ..write('recordNum: $recordNum, ')
          ..write('shrubGenus: $shrubGenus, ')
          ..write('shrubSpecies: $shrubSpecies, ')
          ..write('shrubVariety: $shrubVariety, ')
          ..write('shrubStatus: $shrubStatus, ')
          ..write('bdClass: $bdClass, ')
          ..write('frequency: $frequency')
          ..write(')'))
        .toString();
  }
}

class $StumpSummaryTable extends StumpSummary
    with TableInfo<$StumpSummaryTable, StumpSummaryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StumpSummaryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _plotTypeMeta =
      const VerificationMeta('plotType');
  @override
  late final GeneratedColumn<String> plotType = GeneratedColumn<String>(
      'plot_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nomPlotSizeMeta =
      const VerificationMeta('nomPlotSize');
  @override
  late final GeneratedColumn<double> nomPlotSize = GeneratedColumn<double>(
      'nom_plot_size', aliasedName, true,
      check: () => nomPlotSize.isBetweenValues(-1, 0.04),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _measPlotSizeMeta =
      const VerificationMeta('measPlotSize');
  @override
  late final GeneratedColumn<double> measPlotSize = GeneratedColumn<double>(
      'meas_plot_size', aliasedName, true,
      check: () => measPlotSize.isBetweenValues(0.0005, 0.04),
      type: DriftSqlType.double,
      requiredDuringInsert: false);
  static const VerificationMeta _notAssessedMeta =
      const VerificationMeta('notAssessed');
  @override
  late final GeneratedColumn<bool> notAssessed = GeneratedColumn<bool>(
      'not_assessed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("not_assessed" IN (0, 1))'),
      defaultValue: const Constant(false));
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
        surveyId,
        measDate,
        plotType,
        nomPlotSize,
        measPlotSize,
        notAssessed,
        complete
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stump_summary';
  @override
  VerificationContext validateIntegrity(Insertable<StumpSummaryData> instance,
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
    if (data.containsKey('plot_type')) {
      context.handle(_plotTypeMeta,
          plotType.isAcceptableOrUnknown(data['plot_type']!, _plotTypeMeta));
    } else if (isInserting) {
      context.missing(_plotTypeMeta);
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
    if (data.containsKey('not_assessed')) {
      context.handle(
          _notAssessedMeta,
          notAssessed.isAcceptableOrUnknown(
              data['not_assessed']!, _notAssessedMeta));
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
  StumpSummaryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StumpSummaryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      surveyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}survey_id'])!,
      measDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}meas_date'])!,
      plotType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plot_type'])!,
      nomPlotSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}nom_plot_size']),
      measPlotSize: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}meas_plot_size']),
      notAssessed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}not_assessed'])!,
      complete: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}complete'])!,
    );
  }

  @override
  $StumpSummaryTable createAlias(String alias) {
    return $StumpSummaryTable(attachedDatabase, alias);
  }
}

class StumpSummaryData extends DataClass
    implements Insertable<StumpSummaryData> {
  final int id;
  final int surveyId;
  final DateTime measDate;
  final String plotType;
  final double? nomPlotSize;
  final double? measPlotSize;
  final bool notAssessed;
  final bool complete;
  const StumpSummaryData(
      {required this.id,
      required this.surveyId,
      required this.measDate,
      required this.plotType,
      this.nomPlotSize,
      this.measPlotSize,
      required this.notAssessed,
      required this.complete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['survey_id'] = Variable<int>(surveyId);
    map['meas_date'] = Variable<DateTime>(measDate);
    map['plot_type'] = Variable<String>(plotType);
    if (!nullToAbsent || nomPlotSize != null) {
      map['nom_plot_size'] = Variable<double>(nomPlotSize);
    }
    if (!nullToAbsent || measPlotSize != null) {
      map['meas_plot_size'] = Variable<double>(measPlotSize);
    }
    map['not_assessed'] = Variable<bool>(notAssessed);
    map['complete'] = Variable<bool>(complete);
    return map;
  }

  StumpSummaryCompanion toCompanion(bool nullToAbsent) {
    return StumpSummaryCompanion(
      id: Value(id),
      surveyId: Value(surveyId),
      measDate: Value(measDate),
      plotType: Value(plotType),
      nomPlotSize: nomPlotSize == null && nullToAbsent
          ? const Value.absent()
          : Value(nomPlotSize),
      measPlotSize: measPlotSize == null && nullToAbsent
          ? const Value.absent()
          : Value(measPlotSize),
      notAssessed: Value(notAssessed),
      complete: Value(complete),
    );
  }

  factory StumpSummaryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StumpSummaryData(
      id: serializer.fromJson<int>(json['id']),
      surveyId: serializer.fromJson<int>(json['surveyId']),
      measDate: serializer.fromJson<DateTime>(json['measDate']),
      plotType: serializer.fromJson<String>(json['plotType']),
      nomPlotSize: serializer.fromJson<double?>(json['nomPlotSize']),
      measPlotSize: serializer.fromJson<double?>(json['measPlotSize']),
      notAssessed: serializer.fromJson<bool>(json['notAssessed']),
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
      'plotType': serializer.toJson<String>(plotType),
      'nomPlotSize': serializer.toJson<double?>(nomPlotSize),
      'measPlotSize': serializer.toJson<double?>(measPlotSize),
      'notAssessed': serializer.toJson<bool>(notAssessed),
      'complete': serializer.toJson<bool>(complete),
    };
  }

  StumpSummaryData copyWith(
          {int? id,
          int? surveyId,
          DateTime? measDate,
          String? plotType,
          Value<double?> nomPlotSize = const Value.absent(),
          Value<double?> measPlotSize = const Value.absent(),
          bool? notAssessed,
          bool? complete}) =>
      StumpSummaryData(
        id: id ?? this.id,
        surveyId: surveyId ?? this.surveyId,
        measDate: measDate ?? this.measDate,
        plotType: plotType ?? this.plotType,
        nomPlotSize: nomPlotSize.present ? nomPlotSize.value : this.nomPlotSize,
        measPlotSize:
            measPlotSize.present ? measPlotSize.value : this.measPlotSize,
        notAssessed: notAssessed ?? this.notAssessed,
        complete: complete ?? this.complete,
      );
  @override
  String toString() {
    return (StringBuffer('StumpSummaryData(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('plotType: $plotType, ')
          ..write('nomPlotSize: $nomPlotSize, ')
          ..write('measPlotSize: $measPlotSize, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surveyId, measDate, plotType, nomPlotSize,
      measPlotSize, notAssessed, complete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StumpSummaryData &&
          other.id == this.id &&
          other.surveyId == this.surveyId &&
          other.measDate == this.measDate &&
          other.plotType == this.plotType &&
          other.nomPlotSize == this.nomPlotSize &&
          other.measPlotSize == this.measPlotSize &&
          other.notAssessed == this.notAssessed &&
          other.complete == this.complete);
}

class StumpSummaryCompanion extends UpdateCompanion<StumpSummaryData> {
  final Value<int> id;
  final Value<int> surveyId;
  final Value<DateTime> measDate;
  final Value<String> plotType;
  final Value<double?> nomPlotSize;
  final Value<double?> measPlotSize;
  final Value<bool> notAssessed;
  final Value<bool> complete;
  const StumpSummaryCompanion({
    this.id = const Value.absent(),
    this.surveyId = const Value.absent(),
    this.measDate = const Value.absent(),
    this.plotType = const Value.absent(),
    this.nomPlotSize = const Value.absent(),
    this.measPlotSize = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  });
  StumpSummaryCompanion.insert({
    this.id = const Value.absent(),
    required int surveyId,
    required DateTime measDate,
    required String plotType,
    this.nomPlotSize = const Value.absent(),
    this.measPlotSize = const Value.absent(),
    this.notAssessed = const Value.absent(),
    this.complete = const Value.absent(),
  })  : surveyId = Value(surveyId),
        measDate = Value(measDate),
        plotType = Value(plotType);
  static Insertable<StumpSummaryData> custom({
    Expression<int>? id,
    Expression<int>? surveyId,
    Expression<DateTime>? measDate,
    Expression<String>? plotType,
    Expression<double>? nomPlotSize,
    Expression<double>? measPlotSize,
    Expression<bool>? notAssessed,
    Expression<bool>? complete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surveyId != null) 'survey_id': surveyId,
      if (measDate != null) 'meas_date': measDate,
      if (plotType != null) 'plot_type': plotType,
      if (nomPlotSize != null) 'nom_plot_size': nomPlotSize,
      if (measPlotSize != null) 'meas_plot_size': measPlotSize,
      if (notAssessed != null) 'not_assessed': notAssessed,
      if (complete != null) 'complete': complete,
    });
  }

  StumpSummaryCompanion copyWith(
      {Value<int>? id,
      Value<int>? surveyId,
      Value<DateTime>? measDate,
      Value<String>? plotType,
      Value<double?>? nomPlotSize,
      Value<double?>? measPlotSize,
      Value<bool>? notAssessed,
      Value<bool>? complete}) {
    return StumpSummaryCompanion(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      measDate: measDate ?? this.measDate,
      plotType: plotType ?? this.plotType,
      nomPlotSize: nomPlotSize ?? this.nomPlotSize,
      measPlotSize: measPlotSize ?? this.measPlotSize,
      notAssessed: notAssessed ?? this.notAssessed,
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
    if (plotType.present) {
      map['plot_type'] = Variable<String>(plotType.value);
    }
    if (nomPlotSize.present) {
      map['nom_plot_size'] = Variable<double>(nomPlotSize.value);
    }
    if (measPlotSize.present) {
      map['meas_plot_size'] = Variable<double>(measPlotSize.value);
    }
    if (notAssessed.present) {
      map['not_assessed'] = Variable<bool>(notAssessed.value);
    }
    if (complete.present) {
      map['complete'] = Variable<bool>(complete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StumpSummaryCompanion(')
          ..write('id: $id, ')
          ..write('surveyId: $surveyId, ')
          ..write('measDate: $measDate, ')
          ..write('plotType: $plotType, ')
          ..write('nomPlotSize: $nomPlotSize, ')
          ..write('measPlotSize: $measPlotSize, ')
          ..write('notAssessed: $notAssessed, ')
          ..write('complete: $complete')
          ..write(')'))
        .toString();
  }
}

class $StumpEntryTable extends StumpEntry
    with TableInfo<$StumpEntryTable, StumpEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StumpEntryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _shrubSummaryIdMeta =
      const VerificationMeta('shrubSummaryId');
  @override
  late final GeneratedColumn<int> shrubSummaryId = GeneratedColumn<int>(
      'shrub_summary_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES stump_summary (id)'));
  static const VerificationMeta _stumpNumMeta =
      const VerificationMeta('stumpNum');
  @override
  late final GeneratedColumn<int> stumpNum = GeneratedColumn<int>(
      'stump_num', aliasedName, false,
      check: () => stumpNum.isBetweenValues(1, 9999),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _origPlotAreaMeta =
      const VerificationMeta('origPlotArea');
  @override
  late final GeneratedColumn<String> origPlotArea = GeneratedColumn<String>(
      'orig_plot_area', aliasedName, false,
      check: () => origPlotArea.isIn(['Y' 'N' 'X' 'U']),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _stumpGenusMeta =
      const VerificationMeta('stumpGenus');
  @override
  late final GeneratedColumn<String> stumpGenus = GeneratedColumn<String>(
      'stump_genus', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _stumpSpeciesMeta =
      const VerificationMeta('stumpSpecies');
  @override
  late final GeneratedColumn<String> stumpSpecies = GeneratedColumn<String>(
      'stump_species', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _stumpVarietyMeta =
      const VerificationMeta('stumpVariety');
  @override
  late final GeneratedColumn<String> stumpVariety = GeneratedColumn<String>(
      'stump_variety', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 3),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _stumpDibMeta =
      const VerificationMeta('stumpDib');
  @override
  late final GeneratedColumn<double> stumpDib = GeneratedColumn<double>(
      'stump_dib', aliasedName, false,
      check: () => stumpDib.isBetweenValues(4.0, 999.9) | stumpDib.equals(-1.0),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _stumpDiameterMeta =
      const VerificationMeta('stumpDiameter');
  @override
  late final GeneratedColumn<double> stumpDiameter = GeneratedColumn<double>(
      'stump_diameter', aliasedName, false,
      check: () =>
          stumpDiameter.isBetweenValues(4.0, 999.9) |
          stumpDiameter.equals(-1.0),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  static const VerificationMeta _stumpDecayMeta =
      const VerificationMeta('stumpDecay');
  @override
  late final GeneratedColumn<int> stumpDecay = GeneratedColumn<int>(
      'stump_decay', aliasedName, false,
      check: () => stumpDecay.isBetweenValues(-1, 5),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _stumpLengthMeta =
      const VerificationMeta('stumpLength');
  @override
  late final GeneratedColumn<double> stumpLength = GeneratedColumn<double>(
      'stump_length', aliasedName, false,
      check: () =>
          stumpLength.isBetweenValues(0.01, 1.29) | stumpLength.equals(-1.0),
      type: DriftSqlType.double,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        shrubSummaryId,
        stumpNum,
        origPlotArea,
        stumpGenus,
        stumpSpecies,
        stumpVariety,
        stumpDib,
        stumpDiameter,
        stumpDecay,
        stumpLength
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stump_entry';
  @override
  VerificationContext validateIntegrity(Insertable<StumpEntryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shrub_summary_id')) {
      context.handle(
          _shrubSummaryIdMeta,
          shrubSummaryId.isAcceptableOrUnknown(
              data['shrub_summary_id']!, _shrubSummaryIdMeta));
    } else if (isInserting) {
      context.missing(_shrubSummaryIdMeta);
    }
    if (data.containsKey('stump_num')) {
      context.handle(_stumpNumMeta,
          stumpNum.isAcceptableOrUnknown(data['stump_num']!, _stumpNumMeta));
    } else if (isInserting) {
      context.missing(_stumpNumMeta);
    }
    if (data.containsKey('orig_plot_area')) {
      context.handle(
          _origPlotAreaMeta,
          origPlotArea.isAcceptableOrUnknown(
              data['orig_plot_area']!, _origPlotAreaMeta));
    } else if (isInserting) {
      context.missing(_origPlotAreaMeta);
    }
    if (data.containsKey('stump_genus')) {
      context.handle(
          _stumpGenusMeta,
          stumpGenus.isAcceptableOrUnknown(
              data['stump_genus']!, _stumpGenusMeta));
    } else if (isInserting) {
      context.missing(_stumpGenusMeta);
    }
    if (data.containsKey('stump_species')) {
      context.handle(
          _stumpSpeciesMeta,
          stumpSpecies.isAcceptableOrUnknown(
              data['stump_species']!, _stumpSpeciesMeta));
    } else if (isInserting) {
      context.missing(_stumpSpeciesMeta);
    }
    if (data.containsKey('stump_variety')) {
      context.handle(
          _stumpVarietyMeta,
          stumpVariety.isAcceptableOrUnknown(
              data['stump_variety']!, _stumpVarietyMeta));
    } else if (isInserting) {
      context.missing(_stumpVarietyMeta);
    }
    if (data.containsKey('stump_dib')) {
      context.handle(_stumpDibMeta,
          stumpDib.isAcceptableOrUnknown(data['stump_dib']!, _stumpDibMeta));
    } else if (isInserting) {
      context.missing(_stumpDibMeta);
    }
    if (data.containsKey('stump_diameter')) {
      context.handle(
          _stumpDiameterMeta,
          stumpDiameter.isAcceptableOrUnknown(
              data['stump_diameter']!, _stumpDiameterMeta));
    } else if (isInserting) {
      context.missing(_stumpDiameterMeta);
    }
    if (data.containsKey('stump_decay')) {
      context.handle(
          _stumpDecayMeta,
          stumpDecay.isAcceptableOrUnknown(
              data['stump_decay']!, _stumpDecayMeta));
    } else if (isInserting) {
      context.missing(_stumpDecayMeta);
    }
    if (data.containsKey('stump_length')) {
      context.handle(
          _stumpLengthMeta,
          stumpLength.isAcceptableOrUnknown(
              data['stump_length']!, _stumpLengthMeta));
    } else if (isInserting) {
      context.missing(_stumpLengthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StumpEntryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StumpEntryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      shrubSummaryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}shrub_summary_id'])!,
      stumpNum: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stump_num'])!,
      origPlotArea: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}orig_plot_area'])!,
      stumpGenus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stump_genus'])!,
      stumpSpecies: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stump_species'])!,
      stumpVariety: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stump_variety'])!,
      stumpDib: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stump_dib'])!,
      stumpDiameter: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stump_diameter'])!,
      stumpDecay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stump_decay'])!,
      stumpLength: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stump_length'])!,
    );
  }

  @override
  $StumpEntryTable createAlias(String alias) {
    return $StumpEntryTable(attachedDatabase, alias);
  }
}

class StumpEntryData extends DataClass implements Insertable<StumpEntryData> {
  final int id;
  final int shrubSummaryId;
  final int stumpNum;
  final String origPlotArea;
  final String stumpGenus;
  final String stumpSpecies;
  final String stumpVariety;
  final double stumpDib;
  final double stumpDiameter;
  final int stumpDecay;
  final double stumpLength;
  const StumpEntryData(
      {required this.id,
      required this.shrubSummaryId,
      required this.stumpNum,
      required this.origPlotArea,
      required this.stumpGenus,
      required this.stumpSpecies,
      required this.stumpVariety,
      required this.stumpDib,
      required this.stumpDiameter,
      required this.stumpDecay,
      required this.stumpLength});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['shrub_summary_id'] = Variable<int>(shrubSummaryId);
    map['stump_num'] = Variable<int>(stumpNum);
    map['orig_plot_area'] = Variable<String>(origPlotArea);
    map['stump_genus'] = Variable<String>(stumpGenus);
    map['stump_species'] = Variable<String>(stumpSpecies);
    map['stump_variety'] = Variable<String>(stumpVariety);
    map['stump_dib'] = Variable<double>(stumpDib);
    map['stump_diameter'] = Variable<double>(stumpDiameter);
    map['stump_decay'] = Variable<int>(stumpDecay);
    map['stump_length'] = Variable<double>(stumpLength);
    return map;
  }

  StumpEntryCompanion toCompanion(bool nullToAbsent) {
    return StumpEntryCompanion(
      id: Value(id),
      shrubSummaryId: Value(shrubSummaryId),
      stumpNum: Value(stumpNum),
      origPlotArea: Value(origPlotArea),
      stumpGenus: Value(stumpGenus),
      stumpSpecies: Value(stumpSpecies),
      stumpVariety: Value(stumpVariety),
      stumpDib: Value(stumpDib),
      stumpDiameter: Value(stumpDiameter),
      stumpDecay: Value(stumpDecay),
      stumpLength: Value(stumpLength),
    );
  }

  factory StumpEntryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StumpEntryData(
      id: serializer.fromJson<int>(json['id']),
      shrubSummaryId: serializer.fromJson<int>(json['shrubSummaryId']),
      stumpNum: serializer.fromJson<int>(json['stumpNum']),
      origPlotArea: serializer.fromJson<String>(json['origPlotArea']),
      stumpGenus: serializer.fromJson<String>(json['stumpGenus']),
      stumpSpecies: serializer.fromJson<String>(json['stumpSpecies']),
      stumpVariety: serializer.fromJson<String>(json['stumpVariety']),
      stumpDib: serializer.fromJson<double>(json['stumpDib']),
      stumpDiameter: serializer.fromJson<double>(json['stumpDiameter']),
      stumpDecay: serializer.fromJson<int>(json['stumpDecay']),
      stumpLength: serializer.fromJson<double>(json['stumpLength']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'shrubSummaryId': serializer.toJson<int>(shrubSummaryId),
      'stumpNum': serializer.toJson<int>(stumpNum),
      'origPlotArea': serializer.toJson<String>(origPlotArea),
      'stumpGenus': serializer.toJson<String>(stumpGenus),
      'stumpSpecies': serializer.toJson<String>(stumpSpecies),
      'stumpVariety': serializer.toJson<String>(stumpVariety),
      'stumpDib': serializer.toJson<double>(stumpDib),
      'stumpDiameter': serializer.toJson<double>(stumpDiameter),
      'stumpDecay': serializer.toJson<int>(stumpDecay),
      'stumpLength': serializer.toJson<double>(stumpLength),
    };
  }

  StumpEntryData copyWith(
          {int? id,
          int? shrubSummaryId,
          int? stumpNum,
          String? origPlotArea,
          String? stumpGenus,
          String? stumpSpecies,
          String? stumpVariety,
          double? stumpDib,
          double? stumpDiameter,
          int? stumpDecay,
          double? stumpLength}) =>
      StumpEntryData(
        id: id ?? this.id,
        shrubSummaryId: shrubSummaryId ?? this.shrubSummaryId,
        stumpNum: stumpNum ?? this.stumpNum,
        origPlotArea: origPlotArea ?? this.origPlotArea,
        stumpGenus: stumpGenus ?? this.stumpGenus,
        stumpSpecies: stumpSpecies ?? this.stumpSpecies,
        stumpVariety: stumpVariety ?? this.stumpVariety,
        stumpDib: stumpDib ?? this.stumpDib,
        stumpDiameter: stumpDiameter ?? this.stumpDiameter,
        stumpDecay: stumpDecay ?? this.stumpDecay,
        stumpLength: stumpLength ?? this.stumpLength,
      );
  @override
  String toString() {
    return (StringBuffer('StumpEntryData(')
          ..write('id: $id, ')
          ..write('shrubSummaryId: $shrubSummaryId, ')
          ..write('stumpNum: $stumpNum, ')
          ..write('origPlotArea: $origPlotArea, ')
          ..write('stumpGenus: $stumpGenus, ')
          ..write('stumpSpecies: $stumpSpecies, ')
          ..write('stumpVariety: $stumpVariety, ')
          ..write('stumpDib: $stumpDib, ')
          ..write('stumpDiameter: $stumpDiameter, ')
          ..write('stumpDecay: $stumpDecay, ')
          ..write('stumpLength: $stumpLength')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      shrubSummaryId,
      stumpNum,
      origPlotArea,
      stumpGenus,
      stumpSpecies,
      stumpVariety,
      stumpDib,
      stumpDiameter,
      stumpDecay,
      stumpLength);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StumpEntryData &&
          other.id == this.id &&
          other.shrubSummaryId == this.shrubSummaryId &&
          other.stumpNum == this.stumpNum &&
          other.origPlotArea == this.origPlotArea &&
          other.stumpGenus == this.stumpGenus &&
          other.stumpSpecies == this.stumpSpecies &&
          other.stumpVariety == this.stumpVariety &&
          other.stumpDib == this.stumpDib &&
          other.stumpDiameter == this.stumpDiameter &&
          other.stumpDecay == this.stumpDecay &&
          other.stumpLength == this.stumpLength);
}

class StumpEntryCompanion extends UpdateCompanion<StumpEntryData> {
  final Value<int> id;
  final Value<int> shrubSummaryId;
  final Value<int> stumpNum;
  final Value<String> origPlotArea;
  final Value<String> stumpGenus;
  final Value<String> stumpSpecies;
  final Value<String> stumpVariety;
  final Value<double> stumpDib;
  final Value<double> stumpDiameter;
  final Value<int> stumpDecay;
  final Value<double> stumpLength;
  const StumpEntryCompanion({
    this.id = const Value.absent(),
    this.shrubSummaryId = const Value.absent(),
    this.stumpNum = const Value.absent(),
    this.origPlotArea = const Value.absent(),
    this.stumpGenus = const Value.absent(),
    this.stumpSpecies = const Value.absent(),
    this.stumpVariety = const Value.absent(),
    this.stumpDib = const Value.absent(),
    this.stumpDiameter = const Value.absent(),
    this.stumpDecay = const Value.absent(),
    this.stumpLength = const Value.absent(),
  });
  StumpEntryCompanion.insert({
    this.id = const Value.absent(),
    required int shrubSummaryId,
    required int stumpNum,
    required String origPlotArea,
    required String stumpGenus,
    required String stumpSpecies,
    required String stumpVariety,
    required double stumpDib,
    required double stumpDiameter,
    required int stumpDecay,
    required double stumpLength,
  })  : shrubSummaryId = Value(shrubSummaryId),
        stumpNum = Value(stumpNum),
        origPlotArea = Value(origPlotArea),
        stumpGenus = Value(stumpGenus),
        stumpSpecies = Value(stumpSpecies),
        stumpVariety = Value(stumpVariety),
        stumpDib = Value(stumpDib),
        stumpDiameter = Value(stumpDiameter),
        stumpDecay = Value(stumpDecay),
        stumpLength = Value(stumpLength);
  static Insertable<StumpEntryData> custom({
    Expression<int>? id,
    Expression<int>? shrubSummaryId,
    Expression<int>? stumpNum,
    Expression<String>? origPlotArea,
    Expression<String>? stumpGenus,
    Expression<String>? stumpSpecies,
    Expression<String>? stumpVariety,
    Expression<double>? stumpDib,
    Expression<double>? stumpDiameter,
    Expression<int>? stumpDecay,
    Expression<double>? stumpLength,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shrubSummaryId != null) 'shrub_summary_id': shrubSummaryId,
      if (stumpNum != null) 'stump_num': stumpNum,
      if (origPlotArea != null) 'orig_plot_area': origPlotArea,
      if (stumpGenus != null) 'stump_genus': stumpGenus,
      if (stumpSpecies != null) 'stump_species': stumpSpecies,
      if (stumpVariety != null) 'stump_variety': stumpVariety,
      if (stumpDib != null) 'stump_dib': stumpDib,
      if (stumpDiameter != null) 'stump_diameter': stumpDiameter,
      if (stumpDecay != null) 'stump_decay': stumpDecay,
      if (stumpLength != null) 'stump_length': stumpLength,
    });
  }

  StumpEntryCompanion copyWith(
      {Value<int>? id,
      Value<int>? shrubSummaryId,
      Value<int>? stumpNum,
      Value<String>? origPlotArea,
      Value<String>? stumpGenus,
      Value<String>? stumpSpecies,
      Value<String>? stumpVariety,
      Value<double>? stumpDib,
      Value<double>? stumpDiameter,
      Value<int>? stumpDecay,
      Value<double>? stumpLength}) {
    return StumpEntryCompanion(
      id: id ?? this.id,
      shrubSummaryId: shrubSummaryId ?? this.shrubSummaryId,
      stumpNum: stumpNum ?? this.stumpNum,
      origPlotArea: origPlotArea ?? this.origPlotArea,
      stumpGenus: stumpGenus ?? this.stumpGenus,
      stumpSpecies: stumpSpecies ?? this.stumpSpecies,
      stumpVariety: stumpVariety ?? this.stumpVariety,
      stumpDib: stumpDib ?? this.stumpDib,
      stumpDiameter: stumpDiameter ?? this.stumpDiameter,
      stumpDecay: stumpDecay ?? this.stumpDecay,
      stumpLength: stumpLength ?? this.stumpLength,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (shrubSummaryId.present) {
      map['shrub_summary_id'] = Variable<int>(shrubSummaryId.value);
    }
    if (stumpNum.present) {
      map['stump_num'] = Variable<int>(stumpNum.value);
    }
    if (origPlotArea.present) {
      map['orig_plot_area'] = Variable<String>(origPlotArea.value);
    }
    if (stumpGenus.present) {
      map['stump_genus'] = Variable<String>(stumpGenus.value);
    }
    if (stumpSpecies.present) {
      map['stump_species'] = Variable<String>(stumpSpecies.value);
    }
    if (stumpVariety.present) {
      map['stump_variety'] = Variable<String>(stumpVariety.value);
    }
    if (stumpDib.present) {
      map['stump_dib'] = Variable<double>(stumpDib.value);
    }
    if (stumpDiameter.present) {
      map['stump_diameter'] = Variable<double>(stumpDiameter.value);
    }
    if (stumpDecay.present) {
      map['stump_decay'] = Variable<int>(stumpDecay.value);
    }
    if (stumpLength.present) {
      map['stump_length'] = Variable<double>(stumpLength.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StumpEntryCompanion(')
          ..write('id: $id, ')
          ..write('shrubSummaryId: $shrubSummaryId, ')
          ..write('stumpNum: $stumpNum, ')
          ..write('origPlotArea: $origPlotArea, ')
          ..write('stumpGenus: $stumpGenus, ')
          ..write('stumpSpecies: $stumpSpecies, ')
          ..write('stumpVariety: $stumpVariety, ')
          ..write('stumpDib: $stumpDib, ')
          ..write('stumpDiameter: $stumpDiameter, ')
          ..write('stumpDecay: $stumpDecay, ')
          ..write('stumpLength: $stumpLength')
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
  late final $EcpPlotTypeTable ecpPlotType = $EcpPlotTypeTable(this);
  late final $SoilPitClassificationTable soilPitClassification =
      $SoilPitClassificationTable(this);
  late final $SoilDrainageClassTable soilDrainageClass =
      $SoilDrainageClassTable(this);
  late final $SoilMoistureClassTable soilMoistureClass =
      $SoilMoistureClassTable(this);
  late final $SoilDepositionTable soilDeposition = $SoilDepositionTable(this);
  late final $SoilHumusFormTable soilHumusForm = $SoilHumusFormTable(this);
  late final $SoilPitCodeTable soilPitCode = $SoilPitCodeTable(this);
  late final $SoilPitFeatureClassTable soilPitFeatureClass =
      $SoilPitFeatureClassTable(this);
  late final $SoilHorizonDesignationTable soilHorizonDesignation =
      $SoilHorizonDesignationTable(this);
  late final $SoilColorTable soilColor = $SoilColorTable(this);
  late final $SoilTextureTable soilTexture = $SoilTextureTable(this);
  late final $StpTypeTable stpType = $StpTypeTable(this);
  late final $StpOrigPlotAreaTable stpOrigPlotArea =
      $StpOrigPlotAreaTable(this);
  late final $StpStatusFieldTable stpStatusField = $StpStatusFieldTable(this);
  late final $StpHeightTable stpHeight = $StpHeightTable(this);
  late final $StpStemConditionTable stpStemCondition =
      $StpStemConditionTable(this);
  late final $ShrubPlotTypeTable shrubPlotType = $ShrubPlotTypeTable(this);
  late final $ShrubStatusFieldTable shrubStatusField =
      $ShrubStatusFieldTable(this);
  late final $ShrubBasalDiameterTable shrubBasalDiameter =
      $ShrubBasalDiameterTable(this);
  late final $StumpPlotTypeTable stumpPlotType = $StumpPlotTypeTable(this);
  late final $StumpOrigPlotAreaTable stumpOrigPlotArea =
      $StumpOrigPlotAreaTable(this);
  late final $LtpPlotTypeTable ltpPlotType = $LtpPlotTypeTable(this);
  late final $LtpPlotSplitTable ltpPlotSplit = $LtpPlotSplitTable(this);
  late final $LtpOrigPlotAreaTable ltpOrigPlotArea =
      $LtpOrigPlotAreaTable(this);
  late final $LtpStatusFieldTable ltpStatusField = $LtpStatusFieldTable(this);
  late final $LtpGenusTable ltpGenus = $LtpGenusTable(this);
  late final $LtpCrownClassFieldTable ltpCrownClassField =
      $LtpCrownClassFieldTable(this);
  late final $LtpBarkConditionTable ltpBarkCondition =
      $LtpBarkConditionTable(this);
  late final $LtpCrownConditionTable ltpCrownCondition =
      $LtpCrownConditionTable(this);
  late final $LtpStemConditionTable ltpStemCondition =
      $LtpStemConditionTable(this);
  late final $LtpWoodConditionTable ltpWoodCondition =
      $LtpWoodConditionTable(this);
  late final $LtpQuadrantTable ltpQuadrant = $LtpQuadrantTable(this);
  late final $LtpTreeTypeTable ltpTreeType = $LtpTreeTypeTable(this);
  late final $LtpSiteHeightSuitabilityTable ltpSiteHeightSuitability =
      $LtpSiteHeightSuitabilityTable(this);
  late final $LtpSiteAgeSuitabilityTable ltpSiteAgeSuitability =
      $LtpSiteAgeSuitabilityTable(this);
  late final $LtpProrateTable ltpProrate = $LtpProrateTable(this);
  late final $SurveyHeadersTable surveyHeaders = $SurveyHeadersTable(this);
  late final $MetaCommentTable metaComment = $MetaCommentTable(this);
  late final $SurveySummaryTable surveySummary = $SurveySummaryTable(this);
  late final $SurveyHeaderGroundPhotoTable surveyHeaderGroundPhoto =
      $SurveyHeaderGroundPhotoTable(this);
  late final $SurveyHeaderTreeTable surveyHeaderTree =
      $SurveyHeaderTreeTable(this);
  late final $SurveyHeaderEcologicalTable surveyHeaderEcological =
      $SurveyHeaderEcologicalTable(this);
  late final $SurveyHeaderSoilTable surveyHeaderSoil =
      $SurveyHeaderSoilTable(this);
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
  late final $SoilPitFeatureTable soilPitFeature = $SoilPitFeatureTable(this);
  late final $SoilPitHorizonDescriptionTable soilPitHorizonDescription =
      $SoilPitHorizonDescriptionTable(this);
  late final $LtpSummaryTable ltpSummary = $LtpSummaryTable(this);
  late final $LtpTreeTable ltpTree = $LtpTreeTable(this);
  late final $LtpTreeDamageTable ltpTreeDamage = $LtpTreeDamageTable(this);
  late final $LtpTreeRemovedTable ltpTreeRemoved = $LtpTreeRemovedTable(this);
  late final $LtpTreeAgeTable ltpTreeAge = $LtpTreeAgeTable(this);
  late final $LtpTreeRenamedTable ltpTreeRenamed = $LtpTreeRenamedTable(this);
  late final $StpSummaryTable stpSummary = $StpSummaryTable(this);
  late final $StpSpeciesTable stpSpecies = $StpSpeciesTable(this);
  late final $ShrubSummaryTable shrubSummary = $ShrubSummaryTable(this);
  late final $ShrubListEntryTable shrubListEntry = $ShrubListEntryTable(this);
  late final $StumpSummaryTable stumpSummary = $StumpSummaryTable(this);
  late final $StumpEntryTable stumpEntry = $StumpEntryTable(this);
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
        ecpPlotType,
        soilPitClassification,
        soilDrainageClass,
        soilMoistureClass,
        soilDeposition,
        soilHumusForm,
        soilPitCode,
        soilPitFeatureClass,
        soilHorizonDesignation,
        soilColor,
        soilTexture,
        stpType,
        stpOrigPlotArea,
        stpStatusField,
        stpHeight,
        stpStemCondition,
        shrubPlotType,
        shrubStatusField,
        shrubBasalDiameter,
        stumpPlotType,
        stumpOrigPlotArea,
        ltpPlotType,
        ltpPlotSplit,
        ltpOrigPlotArea,
        ltpStatusField,
        ltpGenus,
        ltpCrownClassField,
        ltpBarkCondition,
        ltpCrownCondition,
        ltpStemCondition,
        ltpWoodCondition,
        ltpQuadrant,
        ltpTreeType,
        ltpSiteHeightSuitability,
        ltpSiteAgeSuitability,
        ltpProrate,
        surveyHeaders,
        metaComment,
        surveySummary,
        surveyHeaderGroundPhoto,
        surveyHeaderTree,
        surveyHeaderEcological,
        surveyHeaderSoil,
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
        soilPitFeature,
        soilPitHorizonDescription,
        ltpSummary,
        ltpTree,
        ltpTreeDamage,
        ltpTreeRemoved,
        ltpTreeAge,
        ltpTreeRenamed,
        stpSummary,
        stpSpecies,
        shrubSummary,
        shrubListEntry,
        stumpSummary,
        stumpEntry
      ];
}
