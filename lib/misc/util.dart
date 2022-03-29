import 'dart:io';

import 'package:dart_base45/dart_base45.dart';
import 'package:cbor/cbor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:koronapassi/misc/pass.dart';

import 'package:koronapassi/misc/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

const storage = FlutterSecureStorage();

final inst = Cbor();

Pass? parseQR(String data) {
  try {
    inst.clearDecodeStack();
    String b45 = data.substring(4);
    var decoded = zlib.decode(Base45.decode(b45));
    inst.decodeFromList(decoded);
    var result = inst.getDecodedData();
    inst.clearDecodeStack();
    inst.decodeFromList(result!.first[2]);
    debugPrint(inst.decodedPrettyPrint());
    return Pass.fromJSON(inst.getDecodedData()!.first, data);
  } catch (e) {
    debugPrint('Error: $e');
    return null;
  }
}

void setBoolean(String name, bool value) async {
  var prefs = await SharedPreferences.getInstance();
  prefs.setBool(name, value);
}

void toggleButton(String name, bool value) {
  if (name == 'name') {
    globals.showName = value;
    setBoolean(name, value);
  } else if (name == 'birthdate') {
    globals.showBirthdate = value;
    setBoolean(name, value);
  } else if (name == 'vaccinationDate') {
    globals.showVaccinationDate = value;
    setBoolean(name, value);
  } else if (name == 'vaccinatioType') {
    globals.showVaccinationType = value;
    setBoolean(name, value);
  } else if (name == 'manufacturer') {
    globals.showManufacturer = value;
    setBoolean(name, value);
  } else if (name == 'doses') {
    globals.showDoses = value;
    setBoolean(name, value);
  } else if (name == 'expiration') {
    globals.showExpirationDate = value;
    setBoolean(name, value);
  }
}

extension Toast on BuildContext {
  void toast(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
