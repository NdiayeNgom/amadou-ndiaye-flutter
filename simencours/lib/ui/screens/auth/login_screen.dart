import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simen_cours/providers/auth_provider.dart';
import 'package:simen_cours/ui/screens/auth/register_screen.dart';
import 'package:simen_cours/ui/screens/cours/cours_list_screen.dart';

import '../../../exceptions/http_exception.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    var _isLoading = false;

    final _passwordController = TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey();

    final Map<String, String> _authData = {
      'email': '',
      'password': '',
    };

    void _showAlertError(String message) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('D\'accord'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    void _submit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        await Provider.of<AuthProvider>(context, listen: false).login(
          _authData['email']!,
          _authData['password']!,
        );
        Navigator.of(context).pushReplacementNamed(CoursListScreen.routeName);
      } on HttpException catch (error) {
        var errorMessage = 'Connexion Echouée';
        if (error.toString().contains('EMAIL_EXISTS')) {
          errorMessage = 'L\'adresse email existe dèja.';
        } else if (error.toString().contains('INVALID_EMAIL')) {
          errorMessage = 'L\'adresse email n\'est pas valide.';
        } else if (error.toString().contains('WEAK_PASSWORD')) {
          errorMessage = 'Informations non valides.';
        } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
          errorMessage = 'Informations non valides.';
        } else if (error.toString().contains('INVALID_PASSWORD')) {
          errorMessage = 'Informations non valides.';
        }
        _showAlertError(errorMessage);
      } catch (error) {
        const errorMessage = 'Connexion echouée! Merci de reessayer.';
        _showAlertError(errorMessage);
      }

      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Image.network(
                        'https://senprof.education.sn/GUIDES%20ET%20DOCUMENTATIONS/GUIDE%20GREEN/res/logo_SIMEN.png'),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Email'),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value != null && value.isEmpty ||
                                    !value!.contains('@')) {
                                  return 'Votre email est invalide !';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['email'] = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Mot de passe'),
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                if (value != null && value.isEmpty ||
                                    value!.length < 8) {
                                  return 'Mot de passe trop court!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['password'] = value!;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (_isLoading)
                              const CircularProgressIndicator()
                            else
                              ElevatedButton(
                                onPressed: _submit,
                                child: const Text('Se Connecter'),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterScreen.routeName);
                      },
                      child: const Text('Rejoignez-nous ! S\'inscrire'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
