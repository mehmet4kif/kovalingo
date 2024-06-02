import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/styles.dart';
import 'signup.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:nice_buttons/nice_buttons.dart';

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
  String backgroundImage = "assets/images/blob-scene-haikei.png";

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
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Giriş Yap',
                              style: CustomStyles.headerStyle,
                            ),
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: CustomStyles.inputDecoration(
                              labelText: 'E-mail',
                              icon: Icons.email_outlined,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _passwordController,
                            decoration: CustomStyles.inputDecoration(
                              labelText: 'Şifre',
                              icon: Icons.lock_outline,
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 16),
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
                const SizedBox(height: 20),
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
                            style: CustomStyles.blackAndBoldTextStyleM,
                          ),
                        ),
                        const SizedBox(height: 8),
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
                                  builder: (context) => const SignUpScreen()),
                            );
                          },
                          child: const Text(
                            'Kayıt Ol',
                            style: CustomStyles.buttonTextStyle,
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
