import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.red,
              child: Image(
                  image: NetworkImage(
                      'https://www.travelblog.id/wp-content/uploads/2019/03/kineruku-3-1-1024x488.jpg')),
            ),
            Spacer(),
            Container(
              child:Row(
                children: <Widget>[
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text
                        ("Kineruku", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0))
                      ),
                      Text("Bandung, Jawa Barat", style: TextStyle(color: Colors.grey, fontSize: 15.0))
                    ]
                  ),
                  Spacer(),
                  Icon(Icons.star, color: Colors.red, size: 30.0),
                  Text("41"),
                  Spacer()
                ]
              )
            ),
            Spacer(),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Spacer(),
                      Icon(Icons.phone, size: 35.0, color: Colors.blue),
                      Spacer(),
                      Icon(Icons.near_me, size: 35.0, color: Colors.blue),
                      Spacer(),
                      Icon(Icons.share, size: 35.0, color: Colors.blue),
                      Spacer()
                    ]),
                  Row(
                    children: <Widget>[
                      Spacer(flex: 6),
                      Text('CALL', style: TextStyle(color: Colors.blue)),
                      Spacer(flex: 5),
                      Text('ROUTE', style: TextStyle(color: Colors.blue)),
                      Spacer(flex: 5),
                      Text('SHARE', style: TextStyle(color: Colors.blue)),
                      Spacer(flex: 5)
                    ])
                ]
              )
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(30.0),
              child: Text(
                """Perpustakaan Kineruku merupakan salah satu perpustakaan yang pada awalnya bernama Rumah Buku. Nama Kineruku sendiri berasal dari dua suku kata, yaitu “kine” dan “ruku”. “Kine” diambil dari kata cinematic yang berarti “sinematik” dan “ruku” diambil dari singkatan “Rumah Buku”. Perpustakaan ini berawal terinspirasi ketika pendiri melanjutkan studi di Chicago, Amerika. Sepulangnya, beliau mendirikan perpustakaan ini di sebuah rumah peninggalan kakeknya yang telah berdiri sejak 29 Maret 2003. Perpustakaan ini terletak di Jalan Hegarmanah No. 52, Kota Bandung.""",
                textAlign: TextAlign.justify)
            )
          ],
        ),
      ),
    );
  }
}