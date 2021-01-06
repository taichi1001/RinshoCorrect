enum JointMode {
  all,
  hipJoint,
  kneeJoint,
  ankleJoint,
  shoulderJoint,
  handJoint,
  spine,
  higherBrainFunctions,
}

extension TypeExtension on JointMode {
  static final typeNames = {
    JointMode.all: '全て',
    JointMode.hipJoint: '股関節',
    JointMode.kneeJoint: '膝関節',
    JointMode.ankleJoint: '足関節',
    JointMode.shoulderJoint: '肩関節',
    JointMode.handJoint: '手関節',
    JointMode.spine: '脊椎',
    JointMode.higherBrainFunctions: '高次脳機能'
  };

  String get typeName => typeNames[this];
}
