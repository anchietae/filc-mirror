// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetTokenModelCollection on Isar {
  IsarCollection<int, TokenModel> get tokenModels => this.collection();
}

const TokenModelSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'TokenModel',
    idName: 'studentId',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'tokenId',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'accessToken',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'refreshToken',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'expiryDate',
        type: IsarType.dateTime,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, TokenModel>(
    serialize: serializeTokenModel,
    deserialize: deserializeTokenModel,
    deserializeProperty: deserializeTokenModelProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeTokenModel(IsarWriter writer, TokenModel object) {
  {
    final value = object.tokenId;
    if (value == null) {
      IsarCore.writeNull(writer, 1);
    } else {
      IsarCore.writeString(writer, 1, value);
    }
  }
  {
    final value = object.accessToken;
    if (value == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      IsarCore.writeString(writer, 2, value);
    }
  }
  {
    final value = object.refreshToken;
    if (value == null) {
      IsarCore.writeNull(writer, 3);
    } else {
      IsarCore.writeString(writer, 3, value);
    }
  }
  IsarCore.writeLong(
      writer,
      4,
      object.expiryDate?.toUtc().microsecondsSinceEpoch ??
          -9223372036854775808);
  return object.studentId;
}

@isarProtected
TokenModel deserializeTokenModel(IsarReader reader) {
  final object = TokenModel();
  object.studentId = IsarCore.readId(reader);
  object.tokenId = IsarCore.readString(reader, 1);
  object.accessToken = IsarCore.readString(reader, 2);
  object.refreshToken = IsarCore.readString(reader, 3);
  {
    final value = IsarCore.readLong(reader, 4);
    if (value == -9223372036854775808) {
      object.expiryDate = null;
    } else {
      object.expiryDate =
          DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true).toLocal();
    }
  }
  return object;
}

@isarProtected
dynamic deserializeTokenModelProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1);
    case 2:
      return IsarCore.readString(reader, 2);
    case 3:
      return IsarCore.readString(reader, 3);
    case 4:
      {
        final value = IsarCore.readLong(reader, 4);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)
              .toLocal();
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _TokenModelUpdate {
  bool call({
    required int studentId,
    String? tokenId,
    String? accessToken,
    String? refreshToken,
    DateTime? expiryDate,
  });
}

class _TokenModelUpdateImpl implements _TokenModelUpdate {
  const _TokenModelUpdateImpl(this.collection);

  final IsarCollection<int, TokenModel> collection;

  @override
  bool call({
    required int studentId,
    Object? tokenId = ignore,
    Object? accessToken = ignore,
    Object? refreshToken = ignore,
    Object? expiryDate = ignore,
  }) {
    return collection.updateProperties([
          studentId
        ], {
          if (tokenId != ignore) 1: tokenId as String?,
          if (accessToken != ignore) 2: accessToken as String?,
          if (refreshToken != ignore) 3: refreshToken as String?,
          if (expiryDate != ignore) 4: expiryDate as DateTime?,
        }) >
        0;
  }
}

sealed class _TokenModelUpdateAll {
  int call({
    required List<int> studentId,
    String? tokenId,
    String? accessToken,
    String? refreshToken,
    DateTime? expiryDate,
  });
}

class _TokenModelUpdateAllImpl implements _TokenModelUpdateAll {
  const _TokenModelUpdateAllImpl(this.collection);

  final IsarCollection<int, TokenModel> collection;

  @override
  int call({
    required List<int> studentId,
    Object? tokenId = ignore,
    Object? accessToken = ignore,
    Object? refreshToken = ignore,
    Object? expiryDate = ignore,
  }) {
    return collection.updateProperties(studentId, {
      if (tokenId != ignore) 1: tokenId as String?,
      if (accessToken != ignore) 2: accessToken as String?,
      if (refreshToken != ignore) 3: refreshToken as String?,
      if (expiryDate != ignore) 4: expiryDate as DateTime?,
    });
  }
}

extension TokenModelUpdate on IsarCollection<int, TokenModel> {
  _TokenModelUpdate get update => _TokenModelUpdateImpl(this);

  _TokenModelUpdateAll get updateAll => _TokenModelUpdateAllImpl(this);
}

sealed class _TokenModelQueryUpdate {
  int call({
    String? tokenId,
    String? accessToken,
    String? refreshToken,
    DateTime? expiryDate,
  });
}

class _TokenModelQueryUpdateImpl implements _TokenModelQueryUpdate {
  const _TokenModelQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<TokenModel> query;
  final int? limit;

  @override
  int call({
    Object? tokenId = ignore,
    Object? accessToken = ignore,
    Object? refreshToken = ignore,
    Object? expiryDate = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (tokenId != ignore) 1: tokenId as String?,
      if (accessToken != ignore) 2: accessToken as String?,
      if (refreshToken != ignore) 3: refreshToken as String?,
      if (expiryDate != ignore) 4: expiryDate as DateTime?,
    });
  }
}

extension TokenModelQueryUpdate on IsarQuery<TokenModel> {
  _TokenModelQueryUpdate get updateFirst =>
      _TokenModelQueryUpdateImpl(this, limit: 1);

  _TokenModelQueryUpdate get updateAll => _TokenModelQueryUpdateImpl(this);
}

class _TokenModelQueryBuilderUpdateImpl implements _TokenModelQueryUpdate {
  const _TokenModelQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<TokenModel, TokenModel, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? tokenId = ignore,
    Object? accessToken = ignore,
    Object? refreshToken = ignore,
    Object? expiryDate = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (tokenId != ignore) 1: tokenId as String?,
        if (accessToken != ignore) 2: accessToken as String?,
        if (refreshToken != ignore) 3: refreshToken as String?,
        if (expiryDate != ignore) 4: expiryDate as DateTime?,
      });
    } finally {
      q.close();
    }
  }
}

extension TokenModelQueryBuilderUpdate
    on QueryBuilder<TokenModel, TokenModel, QOperations> {
  _TokenModelQueryUpdate get updateFirst =>
      _TokenModelQueryBuilderUpdateImpl(this, limit: 1);

  _TokenModelQueryUpdate get updateAll =>
      _TokenModelQueryBuilderUpdateImpl(this);
}

extension TokenModelQueryFilter
    on QueryBuilder<TokenModel, TokenModel, QFilterCondition> {
  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> studentIdEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      studentIdGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      studentIdGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> studentIdLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      studentIdLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> studentIdBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> tokenIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      tokenIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> tokenIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      tokenIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      tokenIdGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> tokenIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      tokenIdLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> tokenIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> tokenIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> tokenIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> tokenIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> tokenIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> tokenIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      tokenIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      accessTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 3));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      refreshTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      expiryDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      expiryDateIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> expiryDateEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      expiryDateGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      expiryDateGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      expiryDateLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition>
      expiryDateLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterFilterCondition> expiryDateBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension TokenModelQueryObject
    on QueryBuilder<TokenModel, TokenModel, QFilterCondition> {}

extension TokenModelQuerySortBy
    on QueryBuilder<TokenModel, TokenModel, QSortBy> {
  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByStudentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByStudentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByTokenId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByTokenIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByAccessToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByAccessTokenDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByRefreshToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByRefreshTokenDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> sortByExpiryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }
}

extension TokenModelQuerySortThenBy
    on QueryBuilder<TokenModel, TokenModel, QSortThenBy> {
  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByStudentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByStudentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByTokenId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByTokenIdDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByAccessToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByAccessTokenDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByRefreshToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByRefreshTokenDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterSortBy> thenByExpiryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }
}

extension TokenModelQueryWhereDistinct
    on QueryBuilder<TokenModel, TokenModel, QDistinct> {
  QueryBuilder<TokenModel, TokenModel, QAfterDistinct> distinctByTokenId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterDistinct> distinctByAccessToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterDistinct> distinctByRefreshToken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TokenModel, TokenModel, QAfterDistinct> distinctByExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }
}

extension TokenModelQueryProperty1
    on QueryBuilder<TokenModel, TokenModel, QProperty> {
  QueryBuilder<TokenModel, int, QAfterProperty> studentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<TokenModel, String?, QAfterProperty> tokenIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TokenModel, String?, QAfterProperty> accessTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TokenModel, String?, QAfterProperty> refreshTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TokenModel, DateTime?, QAfterProperty> expiryDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension TokenModelQueryProperty2<R>
    on QueryBuilder<TokenModel, R, QAfterProperty> {
  QueryBuilder<TokenModel, (R, int), QAfterProperty> studentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<TokenModel, (R, String?), QAfterProperty> tokenIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TokenModel, (R, String?), QAfterProperty> accessTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TokenModel, (R, String?), QAfterProperty>
      refreshTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TokenModel, (R, DateTime?), QAfterProperty>
      expiryDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension TokenModelQueryProperty3<R1, R2>
    on QueryBuilder<TokenModel, (R1, R2), QAfterProperty> {
  QueryBuilder<TokenModel, (R1, R2, int), QOperations> studentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<TokenModel, (R1, R2, String?), QOperations> tokenIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<TokenModel, (R1, R2, String?), QOperations>
      accessTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<TokenModel, (R1, R2, String?), QOperations>
      refreshTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<TokenModel, (R1, R2, DateTime?), QOperations>
      expiryDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}
