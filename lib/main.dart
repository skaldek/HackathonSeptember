import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        resizeToAvoidBottomPadding: false,
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
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.white,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text('Давайте начнём!',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
            )
          ],
        ));
  }
}

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/login.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      width: 300,
                      child: Column(children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Имя пользователя',
                          ),
                          onChanged: (text) {
                            username = text;
                          },
                        ),
                        SizedBox(height: 10),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Пароль',
                          ),
                          onChanged: (text) {
                            password = text;
                          },
                        ),
                        SizedBox(height: 10),
                        Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.blueAccent,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(8)),
                                  onPressed: () {
                                    // testReq(username, password).then((value) => {
                                    //   print(value),
                                    //       if (value)
                                    //         {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Admin()));
                                    //     }
                                    // });
                                  },
                                  child: Text('Войти',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueAccent)),
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  onPressed: () {},
                                  child: Text('Забыли пароль?',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueAccent)),
                                ),
                              ],
                            )),
                      ])),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 30),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Registration()));
                },
                child: Text('Зарегистрируйтесь',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
            ),
          ],
        ));
  }
}

Future<bool> testReq(String login, String pass) async {
  var response = await http.get(
      'https://hackathon-september.herokuapp.com/login?username=' +
          login +
          '&password=' +
          pass);
  print(response.body);
  if (response.body == 'ok')
    return true;
  else
    return false;
}

class Registration extends StatefulWidget {
  @override
  _Registration createState() => _Registration();
}

class _Registration extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Stack(children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/register.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10, top: 50),
                    width: 300,
                    child: Column(children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: 'Имя пользователя',
                        ),
                        onChanged: (text) {},
                      ),
                      SizedBox(height: 10),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: 'Пароль',
                        ),
                        onChanged: (text) {},
                      ),
                      SizedBox(height: 10),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: 'Пароль',
                        ),
                        onChanged: (text) {},
                      ),
                      SizedBox(height: 10),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.blueAccent,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () {},
                                child: Text('Регистрация',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blueAccent)),
                              ),
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                onPressed: () {},
                                child: Text('Забыли пароль?',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blueAccent)),
                              ),
                            ],
                          )),
                    ])),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 30),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text('Войти',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
            ),
          ),
        ]));
  }
}

class Admin extends StatefulWidget {
  @override
  _Admin createState() => _Admin();
}

class _Admin extends State<Admin> {
  List<String> numberTruthList = new List<String>();
  List<bool> states = new List<bool>();

  @override
  initState() {
    super.initState();

    getApps('abc123').then((value) => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          resizeToAvoidBottomPadding: false,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewApp()));
            },
          ),
          appBar: AppBar(
            title: Text('Admin', style: TextStyle(color: Colors.white)),
          ),
          body: Center(
              child: ListView.builder(
            itemCount: numberTruthList.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(numberTruthList[i]),
                trailing: Icon(
                  // NEW from here...
                  states[i] ? Icons.check : Icons.cancel,
                  color: states[i] ? Colors.green : Colors.red,
                ),
                onTap: () {
                  setState(() {
                    states[i] = !states[i];
                  });
                },
              );
            },
          ))),
    );
  }

  Future getApps(String id) async {
    var response = await http.get(
        'https://hackathon-september.herokuapp.com/application_list?userId=' +
            id);
    print(response.body);
    List<dynamic> data = jsonDecode(response.body);
    print(data.length);
    for (int i = 0; i < data.length; i++) {
      numberTruthList.add(data[i]['description']);
      states.add(false);
    }
  }
}

class NewApp extends StatefulWidget {
  @override
  _NewApp createState() => _NewApp();
}

class _NewApp extends State<NewApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text('Добавить вход',
                  style: TextStyle(color: Colors.white)),
            ),
            body: Container(
              padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget> [
                    TextField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        labelText: 'Ф.И.О',
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        Container(
                          width: 150,
                          child: TextField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              labelText: 'Серия',
                            ),
                            onChanged: (text) {},
                          ),
                        ),
                        Container(
                          width: 150,
                          child: TextField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              labelText: 'Номер',
                            ),
                            onChanged: (text) {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        labelText: 'Телефон',
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 2,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        labelText: 'О Заявке',
                      ),
                      onChanged: (text) {},
                    ),
                    SizedBox(height: 50),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.blueAccent,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Admin()));
                        },
                        child: Text('Добавить запись!',
                            style: TextStyle(fontSize: 18, color: Colors.blueAccent)),
                      ),
                    ),
                  ],
                ),
            )));
  }
}
