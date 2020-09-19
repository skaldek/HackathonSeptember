import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/home_page.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        new Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.all(30),
          child: FlatButton(
            shape: RoundedRectangleBorder(side: BorderSide(
                color: Colors.white,
                width: 1,
                style: BorderStyle.solid
            ), borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NextPage()));
            },
            child: Text('Давайте начнём!', style: TextStyle(fontSize: 15, color: Colors.white)),
          ),
        )
      ],
    ));
  }
}

class NextPage extends StatefulWidget {
  @override
  _NextPage createState() => _NextPage();
}

class _NextPage extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('123'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 200,
                  child: Column(children: <Widget>[
                    TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    )),
                    TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        )),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NextPage()));
                      },
                      child: Text('Butt', style: TextStyle(fontSize: 15)),
                    )
                  ])),
            ],
          ),
        ));
  }
}
