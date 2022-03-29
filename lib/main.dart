import 'package:flutter/material.dart';
import 'package:koronapassi/misc/pass.dart';
import 'package:koronapassi/misc/util.dart';
import 'package:koronapassi/pages/first_page.dart';
import 'package:koronapassi/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koronapassi/misc/globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool? name = prefs.getBool('name');
  bool? birthdate = prefs.getBool('birthdate');
  bool? vaccinationDate = prefs.getBool('vaccinationDate');
  if (name != null) {
    globals.showName = name;
  }
  if (vaccinationDate != null) {
    globals.showVaccinationDate = vaccinationDate;
  }
  if (birthdate != null) {
    globals.showBirthdate = birthdate;
  }
  String? data = await storage.read(key: 'pass');
  Pass? pass = parseQR(data ?? '');
  runApp(Main(pass: pass));
}

class Main extends StatelessWidget {
  final Pass? pass;
  const Main({Key? key, this.pass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koronapassi',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.indigo.shade50,
          primarySwatch: Colors.indigo,
          cardTheme: CardTheme(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ))),
      home: pass != null ? HomePage(pass: pass!) : const FirstPage(),
    );
  }
}
