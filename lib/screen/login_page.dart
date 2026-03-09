import 'package:flutter/material.dart';
import 'package:teknologimobile_tugas2/models/user_model.dart';
import 'package:teknologimobile_tugas2/screen/menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoggedIn = false;
  bool isLoginFailed = false;

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == user1.username && password == user1.password) {
      setState(() {
        isLoggedIn = true;
        isLoginFailed = false;
      });
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MenuPage(username: username)));
    } else {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login gagal: Username atau Password salah'),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        isLoggedIn = false;
        isLoginFailed = true;
      });
    }
  }

  Widget _loginHeader() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Welcome back to MiniLens!',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required bool isLoginFailed,
    bool obscure = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(
              color: isLoginFailed ? Colors.red : Colors.blue,
            ),
          ),
        ),
        obscureText: obscure,
      ),
    );
  }

  Widget _usernameField(TextEditingController controller, bool isLoginFailed) {
    return _inputField(
      controller: controller,
      hint: 'Username',
      isLoginFailed: isLoginFailed,
    );
  }

  Widget _passwordField(TextEditingController controller, bool isLoginFailed) {
    return _inputField(
      controller: controller,
      hint: 'Password',
      isLoginFailed: isLoginFailed,
      obscure: true,
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: Colors.grey,
      ),
      onPressed: () {
        _login();
      },
      child: Text('Login', style: TextStyle(color: Colors.black)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _loginHeader(),

            SizedBox(height: 20),

            _usernameField(_usernameController, isLoginFailed),

            _passwordField(_passwordController, isLoginFailed),

            SizedBox(height: 20),

            _loginButton(),
          ],
        ),
      ),
    );
  }
}
