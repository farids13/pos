// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetJournalCollection on Isar {
  IsarCollection<Journal> get journals => this.collection();
}

const JournalSchema = CollectionSchema(
  name: r'Journal',
  id: -4704215588566915531,
  properties: {
    r'code': PropertySchema(
      id: 0,
      name: r'code',
      type: IsarType.string,
    ),
    r'created': PropertySchema(
      id: 1,
      name: r'created',
      type: IsarType.dateTime,
    ),
    r'journalStatus': PropertySchema(
      id: 2,
      name: r'journalStatus',
      type: IsarType.byte,
      enumMap: _JournaljournalStatusEnumValueMap,
    ),
    r'journalType': PropertySchema(
      id: 3,
      name: r'journalType',
      type: IsarType.byte,
      enumMap: _JournaljournalTypeEnumValueMap,
    )
  },
  estimateSize: _journalEstimateSize,
  serialize: _journalSerialize,
  deserialize: _journalDeserialize,
  deserializeProp: _journalDeserializeProp,
  idName: r'id',
  indexes: {
    r'code': IndexSchema(
      id: 329780482934683790,
      name: r'code',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'code',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'details': LinkSchema(
      id: 7445585635100612369,
      name: r'details',
      target: r'JournalDetail',
      single: false,
      linkName: r'journal',
    )
  },
  embeddedSchemas: {},
  getId: _journalGetId,
  getLinks: _journalGetLinks,
  attach: _journalAttach,
  version: '3.1.0+1',
);

int _journalEstimateSize(
  Journal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.code.length * 3;
  return bytesCount;
}

void _journalSerialize(
  Journal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.code);
  writer.writeDateTime(offsets[1], object.created);
  writer.writeByte(offsets[2], object.journalStatus.index);
  writer.writeByte(offsets[3], object.journalType.index);
}

Journal _journalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Journal(
    journalStatus:
        _JournaljournalStatusValueEnumMap[reader.readByteOrNull(offsets[2])] ??
            JournalStatus.opened,
  );
  object.code = reader.readString(offsets[0]);
  object.created = reader.readDateTime(offsets[1]);
  object.id = id;
  object.journalType =
      _JournaljournalTypeValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          JournalType.purchase;
  return object;
}

P _journalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (_JournaljournalStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          JournalStatus.opened) as P;
    case 3:
      return (_JournaljournalTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          JournalType.purchase) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _JournaljournalStatusEnumValueMap = {
  'opened': 0,
  'posted': 1,
  'cancelled': 2,
};
const _JournaljournalStatusValueEnumMap = {
  0: JournalStatus.opened,
  1: JournalStatus.posted,
  2: JournalStatus.cancelled,
};
const _JournaljournalTypeEnumValueMap = {
  'purchase': 0,
  'sale': 1,
  'incoming': 2,
  'outgoing': 3,
  'stockAdjustment': 4,
  'startingStock': 5,
};
const _JournaljournalTypeValueEnumMap = {
  0: JournalType.purchase,
  1: JournalType.sale,
  2: JournalType.incoming,
  3: JournalType.outgoing,
  4: JournalType.stockAdjustment,
  5: JournalType.startingStock,
};

Id _journalGetId(Journal object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _journalGetLinks(Journal object) {
  return [object.details];
}

void _journalAttach(IsarCollection<dynamic> col, Id id, Journal object) {
  object.id = id;
  object.details
      .attach(col, col.isar.collection<JournalDetail>(), r'details', id);
}

extension JournalByIndex on IsarCollection<Journal> {
  Future<Journal?> getByCode(String code) {
    return getByIndex(r'code', [code]);
  }

  Journal? getByCodeSync(String code) {
    return getByIndexSync(r'code', [code]);
  }

  Future<bool> deleteByCode(String code) {
    return deleteByIndex(r'code', [code]);
  }

  bool deleteByCodeSync(String code) {
    return deleteByIndexSync(r'code', [code]);
  }

  Future<List<Journal?>> getAllByCode(List<String> codeValues) {
    final values = codeValues.map((e) => [e]).toList();
    return getAllByIndex(r'code', values);
  }

  List<Journal?> getAllByCodeSync(List<String> codeValues) {
    final values = codeValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'code', values);
  }

  Future<int> deleteAllByCode(List<String> codeValues) {
    final values = codeValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'code', values);
  }

  int deleteAllByCodeSync(List<String> codeValues) {
    final values = codeValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'code', values);
  }

  Future<Id> putByCode(Journal object) {
    return putByIndex(r'code', object);
  }

  Id putByCodeSync(Journal object, {bool saveLinks = true}) {
    return putByIndexSync(r'code', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCode(List<Journal> objects) {
    return putAllByIndex(r'code', objects);
  }

  List<Id> putAllByCodeSync(List<Journal> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'code', objects, saveLinks: saveLinks);
  }
}

extension JournalQueryWhereSort on QueryBuilder<Journal, Journal, QWhere> {
  QueryBuilder<Journal, Journal, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension JournalQueryWhere on QueryBuilder<Journal, Journal, QWhereClause> {
  QueryBuilder<Journal, Journal, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Journal, Journal, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Journal, Journal, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Journal, Journal, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterWhereClause> codeEqualTo(String code) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'code',
        value: [code],
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterWhereClause> codeNotEqualTo(
      String code) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [],
              upper: [code],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [code],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [code],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'code',
              lower: [],
              upper: [code],
              includeUpper: false,
            ));
      }
    });
  }
}

extension JournalQueryFilter
    on QueryBuilder<Journal, Journal, QFilterCondition> {
  QueryBuilder<Journal, Journal, QAfterFilterCondition> codeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> codeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> codeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> codeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'code',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> codeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> codeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> codeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'code',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> codeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'code',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> codeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> codeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'code',
        value: '',
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> createdEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> createdGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> createdLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> createdBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'created',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> journalStatusEqualTo(
      JournalStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'journalStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition>
      journalStatusGreaterThan(
    JournalStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'journalStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> journalStatusLessThan(
    JournalStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'journalStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> journalStatusBetween(
    JournalStatus lower,
    JournalStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'journalStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> journalTypeEqualTo(
      JournalType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'journalType',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> journalTypeGreaterThan(
    JournalType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'journalType',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> journalTypeLessThan(
    JournalType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'journalType',
        value: value,
      ));
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> journalTypeBetween(
    JournalType lower,
    JournalType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'journalType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension JournalQueryObject
    on QueryBuilder<Journal, Journal, QFilterCondition> {}

extension JournalQueryLinks
    on QueryBuilder<Journal, Journal, QFilterCondition> {
  QueryBuilder<Journal, Journal, QAfterFilterCondition> details(
      FilterQuery<JournalDetail> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'details');
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> detailsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'details', length, true, length, true);
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> detailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'details', 0, true, 0, true);
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> detailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'details', 0, false, 999999, true);
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> detailsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'details', 0, true, length, include);
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition>
      detailsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'details', length, include, 999999, true);
    });
  }

  QueryBuilder<Journal, Journal, QAfterFilterCondition> detailsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'details', lower, includeLower, upper, includeUpper);
    });
  }
}

extension JournalQuerySortBy on QueryBuilder<Journal, Journal, QSortBy> {
  QueryBuilder<Journal, Journal, QAfterSortBy> sortByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> sortByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> sortByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> sortByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> sortByJournalStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'journalStatus', Sort.asc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> sortByJournalStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'journalStatus', Sort.desc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> sortByJournalType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'journalType', Sort.asc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> sortByJournalTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'journalType', Sort.desc);
    });
  }
}

extension JournalQuerySortThenBy
    on QueryBuilder<Journal, Journal, QSortThenBy> {
  QueryBuilder<Journal, Journal, QAfterSortBy> thenByCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.asc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> thenByCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'code', Sort.desc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> thenByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> thenByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> thenByJournalStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'journalStatus', Sort.asc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> thenByJournalStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'journalStatus', Sort.desc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> thenByJournalType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'journalType', Sort.asc);
    });
  }

  QueryBuilder<Journal, Journal, QAfterSortBy> thenByJournalTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'journalType', Sort.desc);
    });
  }
}

extension JournalQueryWhereDistinct
    on QueryBuilder<Journal, Journal, QDistinct> {
  QueryBuilder<Journal, Journal, QDistinct> distinctByCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'code', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Journal, Journal, QDistinct> distinctByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'created');
    });
  }

  QueryBuilder<Journal, Journal, QDistinct> distinctByJournalStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'journalStatus');
    });
  }

  QueryBuilder<Journal, Journal, QDistinct> distinctByJournalType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'journalType');
    });
  }
}

extension JournalQueryProperty
    on QueryBuilder<Journal, Journal, QQueryProperty> {
  QueryBuilder<Journal, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Journal, String, QQueryOperations> codeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'code');
    });
  }

  QueryBuilder<Journal, DateTime, QQueryOperations> createdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'created');
    });
  }

  QueryBuilder<Journal, JournalStatus, QQueryOperations>
      journalStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'journalStatus');
    });
  }

  QueryBuilder<Journal, JournalType, QQueryOperations> journalTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'journalType');
    });
  }
}
