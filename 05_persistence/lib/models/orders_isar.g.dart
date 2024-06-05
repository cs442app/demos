// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_isar.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetCustomerCollection on Isar {
  IsarCollection<int, Customer> get customers => this.collection();
}

const CustomerSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'Customer',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'name',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'email',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'orders',
        type: IsarType.objectList,
        target: 'Order',
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<int, Customer>(
    serialize: serializeCustomer,
    deserialize: deserializeCustomer,
    deserializeProperty: deserializeCustomerProp,
  ),
  embeddedSchemas: [OrderSchema],
);

@isarProtected
int serializeCustomer(IsarWriter writer, Customer object) {
  {
    final value = object.name;
    if (value == null) {
      IsarCore.writeNull(writer, 1);
    } else {
      IsarCore.writeString(writer, 1, value);
    }
  }
  {
    final value = object.email;
    if (value == null) {
      IsarCore.writeNull(writer, 2);
    } else {
      IsarCore.writeString(writer, 2, value);
    }
  }
  {
    final list = object.orders;
    final listWriter = IsarCore.beginList(writer, 3, list.length);
    for (var i = 0; i < list.length; i++) {
      {
        final value = list[i];
        final objectWriter = IsarCore.beginObject(listWriter, i);
        serializeOrder(objectWriter, value);
        IsarCore.endObject(listWriter, objectWriter);
      }
    }
    IsarCore.endList(writer, listWriter);
  }
  return object.id;
}

@isarProtected
Customer deserializeCustomer(IsarReader reader) {
  final object = Customer();
  object.id = IsarCore.readId(reader);
  object.name = IsarCore.readString(reader, 1);
  object.email = IsarCore.readString(reader, 2);
  {
    final length = IsarCore.readList(reader, 3, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        object.orders = const <Order>[];
      } else {
        final list = List<Order>.filled(length, Order(), growable: true);
        for (var i = 0; i < length; i++) {
          {
            final objectReader = IsarCore.readObject(reader, i);
            if (objectReader.isNull) {
              list[i] = Order();
            } else {
              final embedded = deserializeOrder(objectReader);
              IsarCore.freeReader(objectReader);
              list[i] = embedded;
            }
          }
        }
        IsarCore.freeReader(reader);
        object.orders = list;
      }
    }
  }
  return object;
}

@isarProtected
dynamic deserializeCustomerProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1);
    case 2:
      return IsarCore.readString(reader, 2);
    case 3:
      {
        final length = IsarCore.readList(reader, 3, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const <Order>[];
          } else {
            final list = List<Order>.filled(length, Order(), growable: true);
            for (var i = 0; i < length; i++) {
              {
                final objectReader = IsarCore.readObject(reader, i);
                if (objectReader.isNull) {
                  list[i] = Order();
                } else {
                  final embedded = deserializeOrder(objectReader);
                  IsarCore.freeReader(objectReader);
                  list[i] = embedded;
                }
              }
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _CustomerUpdate {
  bool call({
    required int id,
    String? name,
    String? email,
  });
}

class _CustomerUpdateImpl implements _CustomerUpdate {
  const _CustomerUpdateImpl(this.collection);

  final IsarCollection<int, Customer> collection;

  @override
  bool call({
    required int id,
    Object? name = ignore,
    Object? email = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (name != ignore) 1: name as String?,
          if (email != ignore) 2: email as String?,
        }) >
        0;
  }
}

sealed class _CustomerUpdateAll {
  int call({
    required List<int> id,
    String? name,
    String? email,
  });
}

class _CustomerUpdateAllImpl implements _CustomerUpdateAll {
  const _CustomerUpdateAllImpl(this.collection);

  final IsarCollection<int, Customer> collection;

  @override
  int call({
    required List<int> id,
    Object? name = ignore,
    Object? email = ignore,
  }) {
    return collection.updateProperties(id, {
      if (name != ignore) 1: name as String?,
      if (email != ignore) 2: email as String?,
    });
  }
}

extension CustomerUpdate on IsarCollection<int, Customer> {
  _CustomerUpdate get update => _CustomerUpdateImpl(this);

  _CustomerUpdateAll get updateAll => _CustomerUpdateAllImpl(this);
}

sealed class _CustomerQueryUpdate {
  int call({
    String? name,
    String? email,
  });
}

class _CustomerQueryUpdateImpl implements _CustomerQueryUpdate {
  const _CustomerQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<Customer> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? email = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (name != ignore) 1: name as String?,
      if (email != ignore) 2: email as String?,
    });
  }
}

extension CustomerQueryUpdate on IsarQuery<Customer> {
  _CustomerQueryUpdate get updateFirst =>
      _CustomerQueryUpdateImpl(this, limit: 1);

  _CustomerQueryUpdate get updateAll => _CustomerQueryUpdateImpl(this);
}

class _CustomerQueryBuilderUpdateImpl implements _CustomerQueryUpdate {
  const _CustomerQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<Customer, Customer, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? name = ignore,
    Object? email = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (name != ignore) 1: name as String?,
        if (email != ignore) 2: email as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension CustomerQueryBuilderUpdate
    on QueryBuilder<Customer, Customer, QOperations> {
  _CustomerQueryUpdate get updateFirst =>
      _CustomerQueryBuilderUpdateImpl(this, limit: 1);

  _CustomerQueryUpdate get updateAll => _CustomerQueryBuilderUpdateImpl(this);
}

extension CustomerQueryFilter
    on QueryBuilder<Customer, Customer, QFilterCondition> {
  QueryBuilder<Customer, Customer, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      idGreaterThanOrEqualTo(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> idLessThanOrEqualTo(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      nameGreaterThanOrEqualTo(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameLessThanOrEqualTo(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailEqualTo(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailGreaterThan(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      emailGreaterThanOrEqualTo(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailLessThan(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition>
      emailLessThanOrEqualTo(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailBetween(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailStartsWith(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailEndsWith(
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
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

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> ordersIsEmpty() {
    return not().ordersIsNotEmpty();
  }

  QueryBuilder<Customer, Customer, QAfterFilterCondition> ordersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 3, value: null),
      );
    });
  }
}

extension CustomerQueryObject
    on QueryBuilder<Customer, Customer, QFilterCondition> {}

extension CustomerQuerySortBy on QueryBuilder<Customer, Customer, QSortBy> {
  QueryBuilder<Customer, Customer, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> sortByEmailDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension CustomerQuerySortThenBy
    on QueryBuilder<Customer, Customer, QSortThenBy> {
  QueryBuilder<Customer, Customer, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QAfterSortBy> thenByEmailDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension CustomerQueryWhereDistinct
    on QueryBuilder<Customer, Customer, QDistinct> {
  QueryBuilder<Customer, Customer, QAfterDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Customer, Customer, QAfterDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }
}

extension CustomerQueryProperty1
    on QueryBuilder<Customer, Customer, QProperty> {
  QueryBuilder<Customer, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Customer, String?, QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Customer, String?, QAfterProperty> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Customer, List<Order>, QAfterProperty> ordersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension CustomerQueryProperty2<R>
    on QueryBuilder<Customer, R, QAfterProperty> {
  QueryBuilder<Customer, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Customer, (R, String?), QAfterProperty> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Customer, (R, String?), QAfterProperty> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Customer, (R, List<Order>), QAfterProperty> ordersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension CustomerQueryProperty3<R1, R2>
    on QueryBuilder<Customer, (R1, R2), QAfterProperty> {
  QueryBuilder<Customer, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Customer, (R1, R2, String?), QOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Customer, (R1, R2, String?), QOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Customer, (R1, R2, List<Order>), QOperations> ordersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

// **************************************************************************
// _IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

const OrderSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'Order',
    embedded: true,
    properties: [
      IsarPropertySchema(
        name: 'description',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'price',
        type: IsarType.double,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<void, Order>(
    serialize: serializeOrder,
    deserialize: deserializeOrder,
  ),
);

@isarProtected
int serializeOrder(IsarWriter writer, Order object) {
  {
    final value = object.description;
    if (value == null) {
      IsarCore.writeNull(writer, 1);
    } else {
      IsarCore.writeString(writer, 1, value);
    }
  }
  IsarCore.writeDouble(writer, 2, object.price ?? double.nan);
  return 0;
}

@isarProtected
Order deserializeOrder(IsarReader reader) {
  final object = Order();
  object.description = IsarCore.readString(reader, 1);
  {
    final value = IsarCore.readDouble(reader, 2);
    if (value.isNaN) {
      object.price = null;
    } else {
      object.price = value;
    }
  }
  return object;
}

extension OrderQueryFilter on QueryBuilder<Order, Order, QFilterCondition> {
  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 1));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionEqualTo(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionGreaterThan(
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

  QueryBuilder<Order, Order, QAfterFilterCondition>
      descriptionGreaterThanOrEqualTo(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionLessThan(
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

  QueryBuilder<Order, Order, QAfterFilterCondition>
      descriptionLessThanOrEqualTo(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionBetween(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionStartsWith(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionEndsWith(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionContains(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionMatches(
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

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 2));
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Order, Order, QAfterFilterCondition> priceBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          epsilon: epsilon,
        ),
      );
    });
  }
}

extension OrderQueryObject on QueryBuilder<Order, Order, QFilterCondition> {}
