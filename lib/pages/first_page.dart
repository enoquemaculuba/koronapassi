import 'package:flutter/material.dart';
import 'package:koronapassi/pages/qr_page.dart';
import 'package:koronapassi/widgets/button_rounded.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.qr_code_scanner,
                size: 150,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Aloita skannaamalla koronapassi. Passi tallennetaan laitteeseen.',
                  textAlign: TextAlign.center,
                ),
              ),
              RoundedButton(
                onPressed: () => {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const QRPage()))
                },
                text: 'skannaa',
              )
            ],
          ),
        ),
      )),
    );
  }
}
