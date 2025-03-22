// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_cache_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimetableCacheModelCollection on Isar {
  IsarCollection<TimetableCacheModel> get timetableCacheModels =>
      this.collection();
}

const TimetableCacheModelSchema = CollectionSchema(
  name: r'TimetableCacheModel',
  id: -8626340955125680275,
  properties: {
    r'classes': PropertySchema(
      id: 0,
      name: r'classes',
      type: IsarType.objectList,
      target: r'TimetableClass',
    )
  },
  estimateSize: _timetableCacheModelEstimateSize,
  serialize: _timetableCacheModelSerialize,
  deserialize: _timetableCacheModelDeserialize,
  deserializeProp: _timetableCacheModelDeserializeProp,
  idName: r'cacheKey',
  indexes: {},
  links: {},
  embeddedSchemas: {r'TimetableClass': TimetableClassSchema},
  getId: _timetableCacheModelGetId,
  getLinks: _timetableCacheModelGetLinks,
  attach: _timetableCacheModelAttach,
  version: '3.1.0+1',
);

int _timetableCacheModelEstimateSize(
  TimetableCacheModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.classes;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[TimetableClass]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              TimetableClassSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _timetableCacheModelSerialize(
  TimetableCacheModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<TimetableClass>(
    offsets[0],
    allOffsets,
    TimetableClassSchema.serialize,
    object.classes,
  );
}

TimetableCacheModel _timetableCacheModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimetableCacheModel();
  object.cacheKey = id;
  object.classes = reader.readObjectList<TimetableClass>(
    offsets[0],
    TimetableClassSchema.deserialize,
    allOffsets,
    TimetableClass(),
  );
  return object;
}

P _timetableCacheModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<TimetableClass>(
        offset,
        TimetableClassSchema.deserialize,
        allOffsets,
        TimetableClass(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timetableCacheModelGetId(TimetableCacheModel object) {
  return object.cacheKey ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _timetableCacheModelGetLinks(
    TimetableCacheModel object) {
  return [];
}

void _timetableCacheModelAttach(
    IsarCollection<dynamic> col, Id id, TimetableCacheModel object) {
  object.cacheKey = id;
}

extension TimetableCacheModelQueryWhereSort
    on QueryBuilder<TimetableCacheModel, TimetableCacheModel, QWhere> {
  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterWhere>
      anyCacheKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TimetableCacheModelQueryWhere
    on QueryBuilder<TimetableCacheModel, TimetableCacheModel, QWhereClause> {
  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterWhereClause>
      cacheKeyEqualTo(Id cacheKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: cacheKey,
        upper: cacheKey,
      ));
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterWhereClause>
      cacheKeyNotEqualTo(Id cacheKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: cacheKey, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: cacheKey, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: cacheKey, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: cacheKey, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterWhereClause>
      cacheKeyGreaterThan(Id cacheKey, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: cacheKey, includeLower: include),
      );
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterWhereClause>
      cacheKeyLessThan(Id cacheKey, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: cacheKey, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterWhereClause>
      cacheKeyBetween(
    Id lowerCacheKey,
    Id upperCacheKey, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerCacheKey,
        includeLower: includeLower,
        upper: upperCacheKey,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimetableCacheModelQueryFilter on QueryBuilder<TimetableCacheModel,
    TimetableCacheModel, QFilterCondition> {
  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      cacheKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cacheKey',
      ));
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      cacheKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cacheKey',
      ));
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      cacheKeyEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cacheKey',
        value: value,
      ));
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      cacheKeyGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cacheKey',
        value: value,
      ));
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      cacheKeyLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cacheKey',
        value: value,
      ));
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      cacheKeyBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cacheKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      classesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'classes',
      ));
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      classesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'classes',
      ));
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      classesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      classesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      classesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      classesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      classesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      classesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'classes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension TimetableCacheModelQueryObject on QueryBuilder<TimetableCacheModel,
    TimetableCacheModel, QFilterCondition> {
  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterFilterCondition>
      classesElement(FilterQuery<TimetableClass> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'classes');
    });
  }
}

extension TimetableCacheModelQueryLinks on QueryBuilder<TimetableCacheModel,
    TimetableCacheModel, QFilterCondition> {}

extension TimetableCacheModelQuerySortBy
    on QueryBuilder<TimetableCacheModel, TimetableCacheModel, QSortBy> {}

extension TimetableCacheModelQuerySortThenBy
    on QueryBuilder<TimetableCacheModel, TimetableCacheModel, QSortThenBy> {
  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterSortBy>
      thenByCacheKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheKey', Sort.asc);
    });
  }

  QueryBuilder<TimetableCacheModel, TimetableCacheModel, QAfterSortBy>
      thenByCacheKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cacheKey', Sort.desc);
    });
  }
}

extension TimetableCacheModelQueryWhereDistinct
    on QueryBuilder<TimetableCacheModel, TimetableCacheModel, QDistinct> {}

extension TimetableCacheModelQueryProperty
    on QueryBuilder<TimetableCacheModel, TimetableCacheModel, QQueryProperty> {
  QueryBuilder<TimetableCacheModel, int, QQueryOperations> cacheKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cacheKey');
    });
  }

  QueryBuilder<TimetableCacheModel, List<TimetableClass>?, QQueryOperations>
      classesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'classes');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const TimetableClassSchema = Schema(
  name: r'TimetableClass',
  id: 1099254660594408841,
  properties: {},
  estimateSize: _timetableClassEstimateSize,
  serialize: _timetableClassSerialize,
  deserialize: _timetableClassDeserialize,
  deserializeProp: _timetableClassDeserializeProp,
);

int _timetableClassEstimateSize(
  TimetableClass object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _timetableClassSerialize(
  TimetableClass object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {}
TimetableClass _timetableClassDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimetableClass();
  return object;
}

P _timetableClassDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension TimetableClassQueryFilter
    on QueryBuilder<TimetableClass, TimetableClass, QFilterCondition> {}

extension TimetableClassQueryObject
    on QueryBuilder<TimetableClass, TimetableClass, QFilterCondition> {}
