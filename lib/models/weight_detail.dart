import 'dart:convert';

import './detail_json_data.dart';

class WeightDetail {
  String measureId;
  String tfr;
  String bodyAgeGuide;
  String bmr;
  String leftLegFatRate;
  String scoreType;
  String bmiType;
  String bodyLegFatMuscle;
  String bodyEvaluation;
  String msw;
  String score;
  String bodyFat;
  String visceralFatType;
  String mswType;
  String weightRangeDesc;
  String tfrType;
  String protein;
  String muscle;
  String bmiGuide;
  String leftHandMuscle;
  String rightLegFatMuscle;
  String rightHandFatRate;
  String memberId;
  String height;
  String leftLegFatMuscle;
  String bodyFatType;
  String electrodeNumber;
  String leftHandFatRate;
  String weight;
  String bodyAgeType;
  String sharp;
  String bmrType;
  String weightType;
  String proteinType;
  String bodyLegFatRate;
  DateTime createTime;
  String muscleType;
  DetailJsonData detailJsonData;
  String bodyAge;
  String weightRange;
  String visceralFat;
  String rightLegFatRate;
  String age;
  String rightHandMuscle;
  String bmi;

  WeightDetail({
    this.measureId,
    this.tfr,
    this.bodyAgeGuide,
    this.bmr,
    this.leftLegFatRate,
    this.scoreType,
    this.bmiType,
    this.bodyLegFatMuscle,
    this.bodyEvaluation,
    this.msw,
    this.score,
    this.bodyFat,
    this.visceralFatType,
    this.mswType,
    this.weightRangeDesc,
    this.tfrType,
    this.protein,
    this.muscle,
    this.bmiGuide,
    this.leftHandMuscle,
    this.rightLegFatMuscle,
    this.rightHandFatRate,
    this.memberId,
    this.height,
    this.leftLegFatMuscle,
    this.bodyFatType,
    this.electrodeNumber,
    this.leftHandFatRate,
    this.weight,
    this.bodyAgeType,
    this.sharp,
    this.bmrType,
    this.weightType,
    this.proteinType,
    this.bodyLegFatRate,
    this.createTime,
    this.muscleType,
    this.detailJsonData,
    this.bodyAge,
    this.weightRange,
    this.visceralFat,
    this.rightLegFatRate,
    this.age,
    this.rightHandMuscle,
    this.bmi,
  });

  factory WeightDetail.fromJson(Map<String, dynamic> json) => new WeightDetail(
        measureId: json["measureId"],
        tfr: json["tfr"],
        bodyAgeGuide: json["bodyAgeGuide"],
        bmr: json["bmr"],
        leftLegFatRate: json["leftLegFatRate"],
        scoreType: json["scoreType"],
        bmiType: json["bmiType"],
        bodyLegFatMuscle: json["bodyLegFatMuscle"],
        bodyEvaluation: json["bodyEvaluation"],
        msw: json["msw"],
        score: json["score"],
        bodyFat: json["bodyFat"],
        visceralFatType: json["visceralFatType"],
        mswType: json["mswType"],
        weightRangeDesc: json["weightRangeDesc"],
        tfrType: json["tfrType"],
        protein: json["protein"],
        muscle: json["muscle"],
        bmiGuide: json["bmiGuide"],
        leftHandMuscle: json["leftHandMuscle"],
        rightLegFatMuscle: json["rightLegFatMuscle"],
        rightHandFatRate: json["rightHandFatRate"],
        memberId: json["memberId"],
        height: json["height"],
        leftLegFatMuscle: json["leftLegFatMuscle"],
        bodyFatType: json["bodyFatType"],
        electrodeNumber: json["electrodeNumber"],
        leftHandFatRate: json["leftHandFatRate"],
        weight: json["weight"],
        bodyAgeType: json["bodyAgeType"],
        sharp: json["sharp"],
        bmrType: json["bmrType"],
        weightType: json["weightType"],
        proteinType: json["proteinType"],
        bodyLegFatRate: json["bodyLegFatRate"],
        createTime: DateTime.parse(json["createTime"]),
        muscleType: json["muscleType"],
        detailJsonData:
            DetailJsonData.fromJson(jsonDecode(json["detailJsonData"])),
        bodyAge: json["bodyAge"],
        weightRange: json["weightRange"],
        visceralFat: json["visceralFat"],
        rightLegFatRate: json["rightLegFatRate"],
        age: json["age"],
        rightHandMuscle: json["rightHandMuscle"],
        bmi: json["bmi"],
      );

  Map<String, dynamic> toJson() => {
        "measureId": measureId,
        "tfr": tfr,
        "bodyAgeGuide": bodyAgeGuide,
        "bmr": bmr,
        "leftLegFatRate": leftLegFatRate,
        "scoreType": scoreType,
        "bmiType": bmiType,
        "bodyLegFatMuscle": bodyLegFatMuscle,
        "bodyEvaluation": bodyEvaluation,
        "msw": msw,
        "score": score,
        "bodyFat": bodyFat,
        "visceralFatType": visceralFatType,
        "mswType": mswType,
        "weightRangeDesc": weightRangeDesc,
        "tfrType": tfrType,
        "protein": protein,
        "muscle": muscle,
        "bmiGuide": bmiGuide,
        "leftHandMuscle": leftHandMuscle,
        "rightLegFatMuscle": rightLegFatMuscle,
        "rightHandFatRate": rightHandFatRate,
        "memberId": memberId,
        "height": height,
        "leftLegFatMuscle": leftLegFatMuscle,
        "bodyFatType": bodyFatType,
        "electrodeNumber": electrodeNumber,
        "leftHandFatRate": leftHandFatRate,
        "weight": weight,
        "bodyAgeType": bodyAgeType,
        "sharp": sharp,
        "bmrType": bmrType,
        "weightType": weightType,
        "proteinType": proteinType,
        "bodyLegFatRate": bodyLegFatRate,
        "createTime": createTime.toIso8601String(),
        "muscleType": muscleType,
        "detailJsonData": detailJsonData.toJson().toString(),
        "bodyAge": bodyAge,
        "weightRange": weightRange,
        "visceralFat": visceralFat,
        "rightLegFatRate": rightLegFatRate,
        "age": age,
        "rightHandMuscle": rightHandMuscle,
        "bmi": bmi,
      };
}
