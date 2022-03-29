import 'package:intl/intl.dart';
import 'package:koronapassi/misc/manufacturer_types.dart';
import 'package:koronapassi/misc/vaccination_types.dart';

class Pass {
  final String ln;
  final String fn;
  final String birthdate;
  final String lastVaccine;
  final String qr;
  final String type;
  final String manufacturer;
  final num doses;
  final String expirationDate;

  Pass(this.ln, this.fn, this.birthdate, this.lastVaccine, this.qr, this.type,
      this.doses, this.expirationDate, this.manufacturer);
  Pass.fromJSON(Map<dynamic, dynamic> json, this.qr)
      : ln = json[-260][1]['nam']['fn'],
        fn = json[-260][1]['nam']['gn'],
        birthdate = json[-260][1]['dob'],
        lastVaccine = json[-260][1]['v'][0]['dt'],
        type = vaccinationTypes[json[-260][1]['v'][0]['mp']] ?? 'Unknown',
        manufacturer =
            manufacturerTypes[json[-260][1]['v'][0]['ma']] ?? 'Unknown',
        doses = json[-260][1]['v'][0]['dn'],
        expirationDate = DateFormat('yyyy-MM-dd')
            .format(DateTime.fromMillisecondsSinceEpoch(json[4] * 1000));

  @override
  String toString() {
    return 'First name: $fn \nLast name: $ln \nBirthdate: $birthdate \nLast vaccine $lastVaccine \nType $type \nManufacturer $manufacturer \nDoses $doses \nExpiration date $expirationDate';
  }

  String get fullName {
    return '$fn $ln';
  }
}
