// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clases_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ClasesRecord> _$clasesRecordSerializer =
    new _$ClasesRecordSerializer();

class _$ClasesRecordSerializer implements StructuredSerializer<ClasesRecord> {
  @override
  final Iterable<Type> types = const [ClasesRecord, _$ClasesRecord];
  @override
  final String wireName = 'ClasesRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ClasesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.nombre;
    if (value != null) {
      result
        ..add('nombre')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.cursos;
    if (value != null) {
      result
        ..add('cursos')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  ClasesRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClasesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'nombre':
          result.nombre = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'cursos':
          result.cursos = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$ClasesRecord extends ClasesRecord {
  @override
  final String? nombre;
  @override
  final String? cursos;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ClasesRecord([void Function(ClasesRecordBuilder)? updates]) =>
      (new ClasesRecordBuilder()..update(updates))._build();

  _$ClasesRecord._({this.nombre, this.cursos, this.ffRef}) : super._();

  @override
  ClasesRecord rebuild(void Function(ClasesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClasesRecordBuilder toBuilder() => new ClasesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClasesRecord &&
        nombre == other.nombre &&
        cursos == other.cursos &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, nombre.hashCode), cursos.hashCode), ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClasesRecord')
          ..add('nombre', nombre)
          ..add('cursos', cursos)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ClasesRecordBuilder
    implements Builder<ClasesRecord, ClasesRecordBuilder> {
  _$ClasesRecord? _$v;

  String? _nombre;
  String? get nombre => _$this._nombre;
  set nombre(String? nombre) => _$this._nombre = nombre;

  String? _cursos;
  String? get cursos => _$this._cursos;
  set cursos(String? cursos) => _$this._cursos = cursos;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ClasesRecordBuilder() {
    ClasesRecord._initializeBuilder(this);
  }

  ClasesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nombre = $v.nombre;
      _cursos = $v.cursos;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClasesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ClasesRecord;
  }

  @override
  void update(void Function(ClasesRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClasesRecord build() => _build();

  _$ClasesRecord _build() {
    final _$result = _$v ??
        new _$ClasesRecord._(nombre: nombre, cursos: cursos, ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
