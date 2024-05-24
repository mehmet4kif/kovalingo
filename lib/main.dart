import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kovalingo/firebase_options.dart';
import 'package:kovalingo/pages/main_menu.dart';
import 'package:nice_buttons/nice_buttons.dart';
import 'package:kovalingo/theme_provider.dart';
import 'package:kovalingo/pages/signup.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isLoading;
  late bool _isConnected;

  late StreamSubscription<ConnectivityResult> _connectionSubscription;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _isConnected = true;

    // Firebase'in başlatılması
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectionSubscription.cancel(); // Aboneliği iptal et
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, ThemeProvider value, Widget? child) {
          // Eğer internet bağlantısı yoksa uygun bir mesaj gösterin
          if (!_isConnected) {
            return MaterialApp(
              theme: ThemeData.light(),
              debugShowCheckedModeBanner: false,
              home: const Scaffold(
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off,
                        size: 50,
                      ),
                      Text(
                        'İnternet bağlantınız yok :(',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          // Eğer internet bağlantısı varsa normal şekilde devam edin
          return MaterialApp(
            theme: Provider.of<ThemeProvider>(context).isNightMode
                ? ThemeData.dark()
                : ThemeData.light().copyWith(
                    primaryColor: Colors.teal,
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.teal,
                    ),
                  ),
            debugShowCheckedModeBanner: false,
            home: _isLoading
                ? const CircularProgressIndicator()
                : const AuthenticationWrapper(),
          );
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      return const MainMenu();
    } else {
      return SignInScreen();
    }
  }
}


class SignInScreen extends StatelessWidget {
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
                          const Padding(
                            padding: EdgeInsets.all(8.0),
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
                                  const EdgeInsets.fromLTRB(20, 15, 0, 15),
                              icon: const Icon(Icons.email_outlined),
                              border: const OutlineInputBorder(
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
                          const SizedBox(height: 10),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Şifre',
                              filled: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 0, 15),
                              icon: const Icon(Icons.lock_outline),
                              border: const OutlineInputBorder(
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
                        const Center(
                          child: Text(
                            'Hesabın yok mu?',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 13),
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
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: const Text(
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
