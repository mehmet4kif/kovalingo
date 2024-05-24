import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kovalingo/main.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Kullanıcı adını Firebase Authentication'da güncelle
      await userCredential.user!.updateDisplayName(_nameController.text);

      // Kayıt işlemi başarılı oldu
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => AuthenticationWrapper()),
          (Route<dynamic> route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Kayıt başarılı! Hoş geldiniz, ${_nameController.text}!'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kayıt yapılamadı: ${e.message}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    String backgroundImage = "lib/assets/images/blob-scene-haikei.png";

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Sadece içeriği kadar yer kaplar
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),

                    // tranform
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      autocorrect: true,
                      controller: _nameController,
                      decoration: InputDecoration(
                          labelText: 'İsim',
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                          icon: Icon(Icons.person_2_rounded),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 40)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.teal.shade200, width: 1.5))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: 'E-mail',
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                          icon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 40)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.teal.shade200, width: 1.5))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: 'Şifre',
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                          icon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 40)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.teal.shade200, width: 1.5))),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _signUp(context),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(Icons.person_add),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Kayıt Ol',
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
