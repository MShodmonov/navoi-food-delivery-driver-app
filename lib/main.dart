import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:some_flutter/service/requests.dart';
import 'package:some_flutter/view/activeOrders.dart';
import 'package:some_flutter/view/historyOrders.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'view/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery Drivers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ApiClient apiClient = ApiClient();
  String username = "998900000000";
  String fullName = "Some person";
  String token = "";
  late StompClient stompClient;

  bool noInternet = false;
  int index = 0;

  late SharedPreferences sharedPreferences;

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
        destination: '/topic/driver/2',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            Map<String, dynamic> obj = json.decode(frame.body!);
            print(frame.body);
            setState(() {
              index = index;
            });

          }
        });
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    getUserInfo();
      stompClient = StompClient(
          config: StompConfig.SockJS(
            url: "http://92.63.206.30:8000/mb-websocket",
            onConnect: onConnect,
            onWebSocketError: (dynamic error) => print(error.toString()),
          ));
      stompClient.activate();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("food_delivery_access_token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      token = sharedPreferences.getString("food_delivery_access_token")!;
    }
  }

  getUserInfo() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("food_delivery_access_token")) {
      apiClient
          .getUSerInfo(
              sharedPreferences.getString("food_delivery_access_token"))
          .then((response) {
            if (response.statusCode == 401) {
              handleTokenExpired();
            } else {
              var jsonResponse = json.decode(response.body);
              setState(() {
                username = jsonResponse['username'];
                fullName = jsonResponse['fullName'] ?? "None";
                noInternet = false;
              });
            }
          })
          .catchError((error) => makeNoInternetPage(),
              test: (e) => e is SocketException)
          .catchError((error) =>
              errorCallback("Error: ${error?.toString() ?? "Empty"}", context));
    }
  }

  handleTokenExpired() {
    if (sharedPreferences.containsKey("food_delivery_access_token")) {
      sharedPreferences.remove("food_delivery_access_token");
      checkLoginStatus();
    }
  }

  makeNoInternetPage() {
    setState(() {
      noInternet = true;
    });
  }

  checkInternet() {
    getUserInfo();
  }

  errorCallback(errorMessage, context) {
    apiClient.showError(context, errorMessage);
  }

  @override
  Widget build(BuildContext context) {
    print("Parent Updated");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.remove("food_delivery_access_token");
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      body: noInternet
          ? Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: [
                  const Center(
                    child: Text(
                      'You don`t have access to the internet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Refresh',
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => checkInternet()),
                    ),
                  ),
                ],
              ),
            )
          : ( index == 0 ? ActiveOrders(token: token) : HistoryOrders(token: token)),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(username),
              accountEmail: Text(fullName),
            ),
            ListTile(
              title: const Text('Active Orders'),
              trailing: const Icon(Icons.list),
              onTap: (){
                setState(() {
                  index = 0;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: const Text('Order History'),
              trailing: const Icon(Icons.add),
              onTap: (){
                setState(() {
                  index = 1;
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
