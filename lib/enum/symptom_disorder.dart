enum SymptomDisorder {
  all,
  romFailure,
  weakness,
  numbnessPain,
  motorParalysis,
  relocationDisorder,
  dysbasia,
  adl,
  other,
}

extension TypeExtension on SymptomDisorder {
  static final typeNames = {
    SymptomDisorder.all: '全て',
    SymptomDisorder.romFailure: 'ROM制限',
    SymptomDisorder.weakness: '筋力低下',
    SymptomDisorder.numbnessPain: '疼痛・痺れ',
    SymptomDisorder.motorParalysis: '運動麻痺',
    SymptomDisorder.relocationDisorder: '起居障害',
    SymptomDisorder.dysbasia: '歩行障害',
    SymptomDisorder.adl: 'ADL',
    SymptomDisorder.other: 'その他',
  };

  String get typeName => typeNames[this];
}
