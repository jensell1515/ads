import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'clases_record.g.dart';

abstract class ClasesRecord
    implements Built<ClasesRecord, ClasesRecordBuilder> {
  static Serializer<ClasesRecord> get serializer => _$clasesRecordSerializer;

  String? get nombre;

  String? get cursos;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ClasesRecordBuilder builder) => builder
    ..nombre = ''
    ..cursos = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('clases');

  static Stream<ClasesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ClasesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ClasesRecord._();
  factory ClasesRecord([void Function(ClasesRecordBuilder) updates]) =
      _$ClasesRecord;

  static ClasesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createClasesRecordData({
  String? nombre,
  String? cursos,
}) {
  final firestoreData = serializers.toFirestore(
    ClasesRecord.serializer,
    ClasesRecord(
      (c) => c
        ..nombre = nombre
        ..cursos = cursos,
    ),
  );

  return firestoreData;
}
