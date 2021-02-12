import 'package:rinsho_collect/enum/symptom_disorder.dart';
import 'package:rinsho_collect/enum/joint.dart';

class ArticleMode {
  ArticleMode({
    this.jointMode,
    this.symptomDisorder,
  });
  JointMode jointMode;
  SymptomDisorder symptomDisorder;
}
