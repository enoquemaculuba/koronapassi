import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:koronapassi/misc/pass.dart';
import 'package:koronapassi/pages/qr_full_screen_page.dart';
import 'package:koronapassi/pages/settings_page.dart';
import 'package:koronapassi/widgets/row_text.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:koronapassi/misc/globals.dart' as globals;

class HomePage extends StatefulWidget {
  final Pass pass;
  const HomePage({Key? key, required this.pass}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextStyle style = TextStyle(color: Colors.indigo.shade300);
  // ignore: prefer_final_fields
  int _index = 0;
  final ListQueue<int> _navigationQueue = ListQueue();
  void _onItemTapped(int index) {
    if (index != _index) {
      _navigationQueue.removeWhere((element) => element == index);
      _navigationQueue.addLast(index);
      setState(() {
        _index = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [HomeView(pass: widget.pass), const SettingsPage()];
    return WillPopScope(
      onWillPop: () async {
        if (_navigationQueue.isEmpty) return true;
        setState(() {
          _navigationQueue.removeLast();
          int position = _navigationQueue.isEmpty ? 0 : _navigationQueue.last;
          _index = position;
        });
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            elevation: 0,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Koti',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Asetukset',
              ),
            ],
            iconSize: 30,
            elevation: 10,
            currentIndex: _index,
            onTap: _onItemTapped,
          ),
          body: IndexedStack(
            index: _index,
            children: pages,
          )),
    );
  }
}

class HomeView extends StatelessWidget {
  final Pass pass;
  const HomeView({Key? key, required this.pass}) : super(key: key);

  Widget? w(bool value, Widget widget) {
    return value ? widget : null;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget?> children = [
      w(globals.showName, RowText(leftText: 'Nimi', rightText: pass.fullName)),
      w(globals.showBirthdate,
          RowText(leftText: 'Syntymäaika', rightText: pass.birthdate)),
      w(globals.showVaccinationDate,
          RowText(leftText: 'Rokotuspäivä', rightText: pass.lastVaccine)),
      w(
        globals.showVaccinationType,
        RowText(leftText: 'Rokote', rightText: pass.type),
      ),
      w(globals.showManufacturer,
          RowText(leftText: 'Valmistaja', rightText: pass.manufacturer)),
      w(globals.showDoses,
          RowText(leftText: 'Annokset', rightText: pass.doses.toString())),
      w(
          globals.showExpirationDate,
          RowText(
              leftText: 'Vanhentumispäivä', rightText: pass.expirationDate)),
    ];

    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 325,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Koronapassi',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor)),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            QrFullScreen(qr: pass.qr)))
                  },
                  child: QrImage(
                    data: pass.qr,
                    version: QrVersions.auto,
                    size: 270,
                  ),
                ),
              ),
              for (Widget? child in children) ...[
                if (child != null)
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: child)
              ]
            ],
          ),
        ),
      ),
    );
  }
}
