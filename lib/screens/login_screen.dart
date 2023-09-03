import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login_screen';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    String mail = _emailController.text;
    String psw = _passwordController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        mail: mail,
        psw: psw,
      );

      if (userCredential.user != null) {
        Provider.of<LoginProvider>(context, listen: false).login();
        // Mostrar un SnackBar de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Exito :3')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      // Mostrar un SnackBar de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar sesión en Pokedex')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.4,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.mail),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _login(context),
                child: Text('Iniciar sesión'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

