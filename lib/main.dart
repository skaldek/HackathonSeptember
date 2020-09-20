import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hackathonseptember/QrGen.dart';
import 'package:hackathonseptember/QrScan.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

String usernameg;

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
                                    usernameg = username;
                                    testReq(username, password)
                                        .then((value) => {
                                              if (value == 'user\n')
                                                {
                                                  print(123),
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              User()))
                                                }
                                              else if (value == 'admin\n')
                                                {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Admin()))
                                                }
                                              else if (value == 'controller\n')
                                                {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              QrScan()))
                                                }
                                            });
                                  },
                                  child: Text('Войти',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueAccent)),
                                ),
                                // FlatButton(
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(8)),
                                //   onPressed: () {},
                                //   child: Text('Забыли пароль?',
                                //       style: TextStyle(
                                //           fontSize: 15,
                                //           color: Colors.blueAccent)),
                                // ),
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

Future<String> testReq(String login, String pass) async {
  var response = await http.get(
      'http://167.172.188.11:8081/server-1.0-SNAPSHOT/login?username=' +
          login +
          '&password=' +
          pass);
  print(response.body);
  return response.body;
}

class Registration extends StatefulWidget {
  @override
  _Registration createState() => _Registration();
}

class _Registration extends State<Registration> {
  String dropdownValue = 'Пользователь';

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
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 32,
                                elevation: 16,
                                style: TextStyle(color: Colors.blueAccent),
                                underline: Container(
                                  height: 2,
                                  color: Colors.blueAccent,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Администратор',
                                  'Пользователь',
                                  'Контроллер',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                              // FlatButton(
                              //   shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(8)),
                              //   onPressed: () {},
                              //   child: Text('Забыли пароль?',
                              //       style: TextStyle(
                              //           fontSize: 15,
                              //           color: Colors.blueAccent)),
                              // ),
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
  List<String> states = new List<String>();

  @override
  initState() {
    super.initState();
    getApps(usernameg).then((value) => setState(() => {}));
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
              var icon;
              var color;
              if (states[i] == 'waiting') {
                icon = Icons.access_time;
                color = Colors.grey;
              } else if (states[i] == 'ok') {
                icon = Icons.check;
                color = Colors.green;
              } else if (states[i] == 'no') {
                icon = Icons.cancel;
                color = Colors.red;
              }
              return ListTile(
                title: Text(numberTruthList[i]),
                trailing: Icon(
                  icon,
                  color: color,
                ),
                onTap: () {
                  setState(() {
                    if (states[i] == 'waiting')
                      states[i] = 'ok';
                    else if (states[i] == 'ok')
                      states[i] = 'no';
                    else if (states[i] == 'no') states[i] = 'waiting';
                  });
                },
              );
            },
          ))),
    );
  }

  Future getApps(String id) async {
    var response = await http
        .get('http://167.172.188.11:8081/server-1.0-SNAPSHOT/get_applications');
    print(response.body);
    List<dynamic> data = jsonDecode(response.body);
    print(data.length);
    for (int i = 0; i < data.length; i++) {
      numberTruthList.add(data[i]['description']);
      states.add(data[i]['state']);
    }
  }
}

class NewApp extends StatefulWidget {
  @override
  _NewApp createState() => _NewApp();
}

class _NewApp extends State<NewApp> {
  String _desc;
  String _pass1;
  String _pass2;
  String _name;
  String _phone;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text('Добавить запись',
                  style: TextStyle(color: Colors.white)),
            ),
            body: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'Ф.И.О',
                    ),
                    onChanged: (text) {
                      _name = text;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            labelText: 'Серия',
                          ),
                          onChanged: (text) {
                            _pass1 = text;
                          },
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
                          onChanged: (text) {
                            _pass2 = text;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'Телефон',
                    ),
                    onChanged: (text) {
                      _phone = text;
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 2,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'О Заявке',
                    ),
                    onChanged: (text) {
                      _desc = text;
                    },
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
                        addApp(usernameg, _desc, _pass1 + _pass2, _phone, _name)
                            .then((value) => {Navigator.pop(context)});
                      },
                      child: Text('Добавить запись!',
                          style: TextStyle(
                              fontSize: 18, color: Colors.blueAccent)),
                    ),
                  ),
                ],
              ),
            )));
  }

  Future addApp(
      String id, String desc, String pass, String phone, String name) async {
    await http.get(
        'http://167.172.188.11:8081/server-1.0-SNAPSHOT/add_application?userId=' +
            id +
            '&description=' +
            desc +
            '&passport=' +
            pass +
            '&phone=' +
            phone +
            '&name=' +
            name);
  }
}

class User extends StatefulWidget {
  @override
  _User createState() => _User();
}

class _User extends State<User> {
  List<String> numberTruthList = new List<String>();
  List<String> states = new List<String>();
  List<String> ids = new List<String>();

  @override
  initState() {
    super.initState();

    getApps(usernameg).then((value) => setState(() => {}));
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
            title: Text('User', style: TextStyle(color: Colors.white)),
          ),
          body: Center(
              child: ListView.builder(
            itemCount: numberTruthList.length,
            itemBuilder: (context, i) {
              var icon;
              var color;
              if (states[i] == 'waiting') {
                icon = Icons.access_time;
                color = Colors.grey;
              } else if (states[i] == 'ok') {
                icon = Icons.check;
                color = Colors.green;
              } else if (states[i] == 'no') {
                icon = Icons.cancel;
                color = Colors.red;
              }
              return ListTile(
                title: Text(numberTruthList[i]),
                trailing: Icon(
                  icon,
                  color: color,
                ),
                onTap: () {
                  if (states[i] == 'ok')
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QrGen(ids[i])));
                },
              );
            },
          ))),
    );
  }

  Future getApps(String id) async {
    var response = await http.get(
        'http://167.172.188.11:8081/server-1.0-SNAPSHOT/application_list?userId=' +
            id);
    print(response.body);
    List<dynamic> data = jsonDecode(response.body);
    print(data.length);
    for (int i = 0; i < data.length; i++) {
      numberTruthList.add(data[i]['description']);
      states.add(data[i]['state']);
      ids.add(data[i]['id'].toString());
    }
  }
}

class AppCheck extends StatefulWidget {
  @override
  _AppCheck createState() => _AppCheck();
}

class _AppCheck extends State<AppCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Проверка заявки', style: TextStyle(color: Colors.white)),
        ),
        body: Center());
  }
}
