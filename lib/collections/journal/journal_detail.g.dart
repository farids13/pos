// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_detail.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetJournalDetailCollection on Isar {
  IsarCollection<JournalDetail> get journalDetails => this.collection();
}

const JournalDetailSchema = CollectionSchema(
  name: r'JournalDetail',
  id: -2120944175665488683,
  properties: {
    r'additionalData': PropertySchema(
      id: 0,
      name: r'additionalData',
      type: IsarType.string,
    ),
    r'amount': PropertySchema(
      id: 1,
      name: r'amount',
      type: IsarType.double,
    ),
    r'created': PropertySchema(
      id: 2,
      name: r'created',
      type: IsarType.dateTime,
    ),
    r'price': PropertySchema(
      id: 3,
      name: r'price',
      type: IsarType.double,
    )
  },
  estimateSize: _journalDetailEstimateSize,
  serialize: _journalDetailSerialize,
  deserialize: _journalDetailDeserialize,
  deserializeProp: _journalDetailDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'journal': LinkSchema(
      id: -8654608621362859274,
      name: r'journal',
      target: r'Journal',
      single: true,
    ),
    r'product': LinkSchema(
      id: 9047288592230588115,
      name: r'product',
      target: r'Product',
      single: true,
    ),
    r'storage': LinkSchema(
      id: -2301002334517709821,
      name: r'storage',
      target: r'Storage',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _journalDetailGetId,
  getLinks: _journalDetailGetLinks,
  attach: _journalDetailAttach,
  version: '3.1.0+1',
);

int _journalDetailEstimateSize(
  JournalDetail object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.additionalData.length * 3;
  return bytesCount;
}

void _journalDetailSerialize(
  JournalDetail object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.additionalData);
  writer.writeDouble(offsets[1], object.amount);
  writer.writeDateTime(offsets[2], object.created);
  writer.writeDouble(offsets[3], object.price);
}

JournalDetail _journalDetailDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = JournalDetail(
    amount: reader.readDoubleOrNull(offsets[1]) ?? 0,
    price: reader.readDoubleOrNull(offsets[3]) ?? 0,
  );
  object.additionalData = reader.readString(offsets[0]);
  object.created = reader.readDateTime(offsets[2]);
  object.id = id;
  return object;
}

P _journalDetailDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _journalDetailGetId(JournalDetail object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _journalDetailGetLinks(JournalDetail object) {
  return [object.journal, object.product, object.storage];
}

void _journalDetailAttach(
    IsarCollection<dynamic> col, Id id, JournalDetail object) {
  object.id = id;
  object.journal.attach(col, col.isar.collection<Journal>(), r'journal', id);
  object.product.attach(col, col.isar.collection<Product>(), r'product', id);
  object.storage.attach(col, col.isar.collection<Storage>(), r'storage', id);
}

extension JournalDetailQueryWhereSort
    on QueryBuilder<JournalDetail, JournalDetail, QWhere> {
  QueryBuilder<JournalDetail, JournalDetail, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension JournalDetailQueryWhere
    on QueryBuilder<JournalDetail, JournalDetail, QWhereClause> {
  QueryBuilder<JournalDetail, JournalDetail, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<JournalDetail, JournalDetail, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterWhereClause> idBetween(
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
}

extension JournalDetailQueryFilter
    on QueryBuilder<JournalDetail, JournalDetail, QFilterCondition> {
  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      additionalDataEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'additionalData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      additionalDataGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'additionalData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      additionalDataLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'additionalData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      additionalDataBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'additionalData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      additionalDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'additionalData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      additionalDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'additionalData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      additionalDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'additionalData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      additionalDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'additionalData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      additionalDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'additionalData',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      additionalDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'additionalData',
        value: '',
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      createdEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'created',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      createdGreaterThan(
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

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      createdLessThan(
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

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      createdBetween(
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

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition> idBetween(
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

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension JournalDetailQueryObject
    on QueryBuilder<JournalDetail, JournalDetail, QFilterCondition> {}

extension JournalDetailQueryLinks
    on QueryBuilder<JournalDetail, JournalDetail, QFilterCondition> {
  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition> journal(
      FilterQuery<Journal> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'journal');
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      journalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'journal', 0, true, 0, true);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition> product(
      FilterQuery<Product> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'product');
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      productIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'product', 0, true, 0, true);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition> storage(
      FilterQuery<Storage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'storage');
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterFilterCondition>
      storageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'storage', 0, true, 0, true);
    });
  }
}

extension JournalDetailQuerySortBy
    on QueryBuilder<JournalDetail, JournalDetail, QSortBy> {
  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy>
      sortByAdditionalData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalData', Sort.asc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy>
      sortByAdditionalDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalData', Sort.desc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> sortByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> sortByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }
}

extension JournalDetailQuerySortThenBy
    on QueryBuilder<JournalDetail, JournalDetail, QSortThenBy> {
  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy>
      thenByAdditionalData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalData', Sort.asc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy>
      thenByAdditionalDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'additionalData', Sort.desc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> thenByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.asc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> thenByCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'created', Sort.desc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }
}

extension JournalDetailQueryWhereDistinct
    on QueryBuilder<JournalDetail, JournalDetail, QDistinct> {
  QueryBuilder<JournalDetail, JournalDetail, QDistinct>
      distinctByAdditionalData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'additionalData',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QDistinct> distinctByCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'created');
    });
  }

  QueryBuilder<JournalDetail, JournalDetail, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }
}

extension JournalDetailQueryProperty
    on QueryBuilder<JournalDetail, JournalDetail, QQueryProperty> {
  QueryBuilder<JournalDetail, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<JournalDetail, String, QQueryOperations>
      additionalDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'additionalData');
    });
  }

  QueryBuilder<JournalDetail, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<JournalDetail, DateTime, QQueryOperations> createdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'created');
    });
  }

  QueryBuilder<JournalDetail, double, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }
}
