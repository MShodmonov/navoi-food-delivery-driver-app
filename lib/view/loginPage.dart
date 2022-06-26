import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../service/requests.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  late Timer _timer;
  int _start = 0;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ApiClient apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.tealAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      heardSection(),
                      textSection(),
                      buttonSection(),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 20.0,
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: null,
                      ),
                      _start == 0 ? sendSms() : countDown(),
                    ],
                  ),
                )),
    );
  }

  signIn(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    apiClient
        .getToken(username, password)
        .then((response) => loginSuccessCallback(response, sharedPreferences),
            onError: (e) => errorCallback("Error: ${e?.toString() ?? "empty"}", context))
        .catchError((error) =>
            errorCallback("You entered wrong code or phone Number!", context));
  }

  loginSuccessCallback(response, SharedPreferences sharedPreferences) {
    if(response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        _isLoading = false;
      });
      sharedPreferences.setString(
          "food_delivery_access_token", jsonResponse['access_token']);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => MainPage()),
              (Route<dynamic> route) => false);
    } else {
      errorCallback("Wrong Phone Number or Code", context);
    }
  }

  errorCallback(errorMessage, context) {
    setState(() {
      _isLoading = false;
    });
    apiClient.showError(context, errorMessage);
  }

  sendCode(String phoneNumber) {
    apiClient.sendSms(phoneNumber).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
          _start = 60;
          startTimer();
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        apiClient.showError(
            context, "Wrong phone number");
      }
    })
    .catchError((error) => errorCallback(
        error?.toString() ?? "Please check your internet", context));
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _isLoading = true;
            });
            signIn(emailController.text, passwordController.text);
          }
        },
        elevation: 0.0,
        color: Colors.purple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: const Text(
          'SignIn',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Container sendSms() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              _isLoading = true;
            });
            sendCode(emailController.text);
          }
        },
        elevation: 0.0,
        color: Colors.greenAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: const Text(
          'Send Code with SMS',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }



  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.phone,
                  color: Colors.white70,
                ),
                hintText: "998900000000",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                hintStyle: TextStyle(color: Colors.white)),
            validator: (value) {
              if ((value?.length ?? 0) != 12) {
                return '🚩 Phone number is not valid.';
              } else if (!(value?.startsWith('9989') ?? false)) {
                return '🚩 Phone number should start with: 9989';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white70),
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white70,
                ),
                hintText: "Code",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70)),
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Container heardSection() {
    return Container(
      margin: const EdgeInsets.only(
        top: 50.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: const Text(
        "Authentication",
        style: TextStyle(
            color: Colors.white70, fontSize: 40.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container countDown() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Resend Code in",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(width: 10),
          Text(
            _start.toString(),
            style: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ],
      ),
    );
  }
}
