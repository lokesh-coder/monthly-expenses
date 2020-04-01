import 'package:flutter/material.dart';

class Ledger extends StatelessWidget {
  const Ledger({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = TextStyle(
      color: Color(0xff997D6A),
      fontWeight: FontWeight.w500,
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 0,
              // color: MonexColors.card,
              color: Color(0xffE4E2E0),
              child: ListTile(
                onTap: () {},
                title: Text(
                  'Citibank EMI',
                  style: style,
                ),
                trailing: Text(
                  '14000',
                ),
              ),
            ),
            Card(
              elevation: 0,
              color: Color(0xffE4E2E0),
              child: ListTile(
                onTap: () {},
                title: Text(
                  'HDFC personal loan',
                  style: style,
                ),
                trailing: Text(
                  '14000',
                ),
              ),
            ),
            Card(
              elevation: 0,
              color: Color(0xffE4E2E0),
              child: ListTile(
                onTap: () {},
                title: Text(
                  'Bangalore home rent',
                  style: style,
                ),
                trailing: Text('14000'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
