import 'package:flutter/material.dart';
import 'package:koronapassi/pages/first_page.dart';
import 'package:koronapassi/widgets/card_text_button.dart';
import 'package:koronapassi/widgets/row_text_toggle.dart';
import 'package:koronapassi/widgets/settings_text_left.dart';
import 'package:koronapassi/misc/util.dart';
import 'package:koronapassi/misc/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  void toFirstPage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const FirstPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ListView(
        children: [
          const LeftText(
              text: 'Asetukset', textSize: 28, fontWeight: FontWeight.bold),
          Card(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  RowTextToggle(
                      initialValue: globals.showName,
                      text: 'Näytä nimi',
                      onChanged: (value) => {toggleButton('name', value)}),
                  const Divider(thickness: 2),
                  RowTextToggle(
                      initialValue: globals.showBirthdate,
                      text: 'Näytä syntymäaika',
                      onChanged: (value) => {toggleButton('birthdate', value)}),
                  const Divider(
                    thickness: 2,
                  ),
                  RowTextToggle(
                      initialValue: globals.showVaccinationDate,
                      text: 'Näytä rokotusaika',
                      onChanged: (value) =>
                          {toggleButton('vaccinationDate', value)}),
                  const Divider(thickness: 2),
                  RowTextToggle(
                      initialValue: globals.showVaccinationType,
                      text: 'Näytä rokotetyyppi',
                      onChanged: (value) =>
                          {toggleButton('vaccinatioType', value)}),
                  const Divider(thickness: 2),
                  RowTextToggle(
                      initialValue: globals.showManufacturer,
                      text: 'Näytä rokotevalmistaja',
                      onChanged: (value) =>
                          {toggleButton('manufacturer', value)}),
                  const Divider(thickness: 2),
                  RowTextToggle(
                      initialValue: globals.showDoses,
                      text: 'Näytä saadut annokset',
                      onChanged: (value) => {toggleButton('doses', value)}),
                  const Divider(thickness: 2),
                  RowTextToggle(
                      initialValue: globals.showExpirationDate,
                      text: 'Näytä passin vahnentumispäivä',
                      onChanged: (value) =>
                          {toggleButton('expiration', value)}),
                ],
              ),
            ),
          ),
          const LeftText(text: 'Passi', textSize: 15),
          Card(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardTextButton(
                          text: 'Skannaa passi',
                          onPressed: () => {toFirstPage(context)},
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 0,
                          thickness: 2,
                        ),
                      ),
                      CardTextButton(
                          text: 'Poista data',
                          onPressed: () => {
                                storage.deleteAll(),
                                SharedPreferences.getInstance()
                                    .then((value) => {
                                          value.remove('name'),
                                          value.remove('birthdate'),
                                          value.remove('vaccinationDate'),
                                        }),
                                toFirstPage(context),
                                context.toast('Data poistettu')
                              },
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12))),
                    ])),
          ),
          const LeftText(text: 'Sovellus', textSize: 15),
          Card(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardTextButton(
                          text: 'Vaihda kieli',
                          onPressed: () => {},
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 0,
                          thickness: 2,
                        ),
                      ),
                      CardTextButton(
                        text: 'Lähdekoodi',
                        onPressed: () => {
                          _launchURL(
                              'https://github.com/enoquemaculuba/koronapassi')
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 0,
                          thickness: 2,
                        ),
                      ),
                      CardTextButton(
                          text: 'Avoimen lähdekoodin lisenssit',
                          onPressed: () => {
                                showLicensePage(
                                    context: context,
                                    applicationVersion: '1.0.0')
                              },
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12))),
                    ])),
          ),
        ]
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }
}

void _launchURL(String url) async {
  if (!await launch(url)) debugPrint('could not launch url $url');
}
