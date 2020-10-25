// import 'dart:convert';

class Detail {
  String createTime;
  String measureId;
  String memberId;
  // String height;
  String detailJsonData;

  String tfr;
  String tfrType;

  String bodyAge;
  String bodyAgeType;
  String bodyAgeGuide;

  String bmr;
  String bmrType;

  String weight;
  String weightType;
  String weightRange;
  String weightRangeDesc;

  String bmi;
  String bmiType;
  String bmiGuide;

  String score;
  String scoreType;
  String bodyEvaluation;

  String msw;
  String mswType;

  String protein;
  String proteinType;

  String muscle;
  String muscleType;
  String bodyLegFatMuscle;
  String leftHandMuscle;
  String rightHandMuscle;
  String leftLegFatMuscle;
  String rightLegFatMuscle;

  String bodyFat;
  String bodyFatType;
  String visceralFat;
  String visceralFatType;
  String leftLegFatRate;
  String rightLegFatRate;

  String sharp;
  String leftHandFatRate;
  String rightHandFatRate;
  String electrodeNumber;

  Detail.fromJson(Map<String, dynamic> data) {
    measureId = data['measureId'];
    memberId = data['memberId'];
    bodyAgeGuide = data['bodyAgeGuide'];
    createTime = data['createTime'];
    // detailJsonData = jsonDecode(data['detailJsonData']);
    // 身体得分
    score = data['score'];
    scoreType = data['scoreType'];
    bodyEvaluation = data['bodyEvaluation'];
    // 体重
    weight = data['weight'];
    weightType = data['weightType'];
    weightRange = data['weightRange'];
    weightRangeDesc = data['weightRangeDesc'];
    // BMI
    bmi = data['bmi'];
    bmiType = data['bmiType'];
    bmiGuide = data['bmiGuide'];
    // 身体年龄
    bodyAge = data['bodyAge'];
    bodyAgeType = data['bodyAgeType'];
    bodyAgeGuide = data['bodyAgeGuide'];
    // 体脂
    bodyFat = data['bodyFat'];
    bodyFatType = data['bodyFatType'];
    visceralFat = data['visceralFat'];
    visceralFatType = data['visceralFatType'];
    leftLegFatRate = data['leftLegFatRate'];
    rightLegFatRate = data['rightLegFatRate'];
    // 体型
    sharp = data['sharp'];
    // 肌肉
    muscle = data['muscle'];
    muscleType = data['muscleType'];
    bodyLegFatMuscle = data['bodyLegFatMuscle'];
    leftHandMuscle = data['leftHandMuscle'];
    rightHandMuscle = data['rightHandMuscle'];
    leftLegFatMuscle = data['leftLegFatMuscle'];
    rightLegFatMuscle = data['rightLegFatMuscle'];
    // 骨量
    msw = data['msw'];
    mswType = data['mswType'];
    // 水分
    tfr = data['tfr'];
    tfrType = data['tfrType'];
    // 内脏脂肪等级
    visceralFat = data['visceralFat'];
    visceralFatType = data['visceralFatType'];
    // 基础代谢(kcal)
    bmr = data['bmr'];
    bmrType = data['bmrType'];
    // 蛋白质
    protein = data['protein'];
    proteinType = data['proteinType'];
  }
}
