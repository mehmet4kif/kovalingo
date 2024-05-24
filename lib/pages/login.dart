import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kovalingo/pages/signup.dart';
import 'main_menu.dart';
import 'package:kovalingo/main.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:nice_buttons/nice_buttons.dart'; // Main menu ekranının olduğu dosyanın import edildiğini varsayalım.

String _translateFirebaseError(String errorCode) {
  switch (errorCode) {
    case "invalid-email":
      return "Geçersiz e-posta adresi formatı.";
    case "user-disabled":
      return "Kullanıcı hesabı devre dışı bırakıldı.";
    case "user-not-found":
      return "Kullanıcı bulunamadı.";
    case "wrong-password":
      return "Yanlış şifre.";
    // Diğer hata durumları için gerekirse switch case ekleyebilirsiniz
    default:
      return "Bir hata oluştu. Lütfen tekrar deneyin.";
  }
}

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  void _signInWithEmailAndPassword(BuildContext context) async {
    try {
      // E-posta ve şifre ile giriş yap
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Giriş yapılamadı: ${e.message}'),
        ),
      );
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String backgroundImage = "lib/assets/images/blob-scene-haikei.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Giriş Yap',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 0, 15),
                              icon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal, width: 40),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.teal.shade200, width: 3),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Şifre',
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 0, 15),
                              icon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal, width: 40),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.teal.shade200, width: 3),
                              ),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 16),
                          SignInButton(
                            Buttons.email,
                            text: "E-mail İle Giriş Yap",
                            onPressed: () =>
                                _signInWithEmailAndPassword(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'Hesabın yok mu?',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 13),
                          ),
                        ),
                        SizedBox(height: 8),
                        NiceButtons(
                          stretch: true,
                          gradientOrientation: GradientOrientation.Horizontal,
                          borderColor: Colors.teal,
                          startColor: Colors.teal,
                          endColor: Colors.teal.shade300,
                          onTap: (finish) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text(
                            'Kayıt Ol',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
