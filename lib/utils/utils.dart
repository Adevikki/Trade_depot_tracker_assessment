import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

// used for biometrics
enum BiometricStatus {
  passed,
  failed,
  pending,
}

bool isIos() {
  if (Platform.isIOS) {
    return true;
  } else {
    return false;
  }
}


void changeStatusBarColor(Color color) async {
  FlutterStatusbarcolor.setStatusBarColor(color);
  if (useWhiteForeground(color)) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  } else {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }
//  await FlutterStatusbarManager.setColor(color, animated: true);
}

void setStatusBarToTranslucent({isWhiteIcons = true}) async {
  FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  if (isWhiteIcons) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  } else {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }
}

double roundDown(double value, int precision) {
  final isNegative = value.isNegative;
  final mod = pow(10.0, precision);
  final roundDown = (((value.abs() * mod).floor()) / mod);
  return isNegative ? -roundDown : roundDown;
}

bool stringContainsUpperCase(String password) {
  return password.contains(RegExp(r'[A-Z]'));
}

bool stringContainsLowerCase(String password) {
  return password.contains(RegExp(r'[a-z]'));
}

bool stringContainsNumber(String password) {
  return password.contains(RegExp(r'[0-9]'));
}

bool passwordCharacterLength(String password) {
  return password.length >= 8;
}

// String displayUserDateOfBirth(String? date) {
//   return Jiffy('$date').format("do MMMM, yyyy");
// }

String removeSpaces(String? string) {
  return string!.replaceAll(RegExp(r"\s+"), "");
}

String removeSpacesDashesParentheses(String? string) {
  return string!.replaceAll(RegExp(r'[^0-9]'), '');
}

String removeCommas(String string) {
  return string.replaceAll(RegExp(r","), "");
}

String removeDashes(String string) {
  return string.replaceAll(RegExp(r"\-+"), "");
}

String removeUnderScores(String string) {
  return string.replaceAll(RegExp(r"\_+"), " ");
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    double mod = pow(10, fractionDigits.toDouble()) as double;
    return ((this * mod).round().toDouble() / mod);
  }
}

extension CapExtension on String {
  String get inCaps =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstOfEach => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

// fromEpochTimeToTimeAgo(epochTime) {
//   String formatted = formatTime(epochTime * 1000);
//   return formatted;
// }

fromEpochTimeToDate(int epochTime) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000);
  var format = DateFormat('dd MMM yyyy').format(date);
  return format;
}

fromEpochTimeToTime(int epochTime) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000);
  var format = DateFormat('jm').format(date);
  return format;
}

String moneyFormatterAmountWithoutDecimal(String amount) {
  String newAmount = amount.split('.')[0];
  return newAmount;
}

String moneyFormatterAmountAfterDecimal(String amount) {
  String newAmount = double.parse(amount).toStringAsFixed(2);
  return newAmount.split('.')[1].substring(0, 2);
}
