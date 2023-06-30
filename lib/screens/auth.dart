import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swiftpay/screens/account_splash.dart';

import 'package:swiftpay/screens/dashboard.dart';

final _firebase = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = false;
  var _enteredFirstname = '';
  var _enteredLastname = '';
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredPhoneNumber = '';
  var _isAuthenticating = false;

  void _submit() async {
    final _isValid = _form.currentState!.validate();

    if (!_isValid) {
      return;
    }

    _form.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (!_isLogin) {
        // Login an Existing User...
        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ));
      } else {
        // Create New User...
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);

        final userData = {
          'Firstname': _enteredFirstname,
          'Lastname': _enteredLastname,
          'email': _enteredEmail,
          'Phone Number': _enteredPhoneNumber,
        };

        db.collection('users').doc(userCredentials.user!.uid).set(userData);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountGenerateScreen(data: userData),
            ));
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed')));

      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 70),
              Image.asset('assets/images/swiftpay.png', width: 115),
              const SizedBox(height: 35),
              Text(
                _isLogin ? 'Create account' : 'Log in to account',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Theme.of(context).colorScheme.background),
              ),
              const SizedBox(height: 5),
              Text(
                _isLogin
                    ? 'Create an account with SwiftPay to get started'
                    : 'Login to your SwiftPay account to continue',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 45),
              // FORM
              Form(
                key: _form,
                child: Column(
                  children: [
                    // First Name Area
                    if (_isLogin)
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'First name',
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                        ),
                      ),
                    if (_isLogin) const SizedBox(height: 15),
                    if (_isLogin)
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Firstname',
                        ),
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.sentences,
                        autocorrect: false,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Firstname can not be empty.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredFirstname = value!;
                        },
                      ),

                    // Last Name Area
                    if (_isLogin)
                      const SizedBox(
                        height: 20,
                      ),
                    if (_isLogin)
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Last name',
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                        ),
                      ),
                    if (_isLogin) const SizedBox(height: 15),
                    if (_isLogin)
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Lastname',
                        ),
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.sentences,
                        autocorrect: false,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Lastname can not be empty.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredLastname = value!;
                        },
                      ),

                    // Email Area
                    if (_isLogin)
                      const SizedBox(
                        height: 20,
                      ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'E-mail',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please fill in a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredEmail = value!;
                      },
                    ),

                    // Phone Number Area
                    if (_isLogin) SizedBox(height: 20),
                    if (_isLogin)
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Phone Number',
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                        ),
                      ),
                    if (_isLogin) const SizedBox(height: 15),
                    if (_isLogin)
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Valid Phone Number'),
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              int.tryParse(value) == null ||
                              value.length < 11) {
                            return 'Please input a valid phone number.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredPhoneNumber = value!;
                        },
                      ),

                    // Password Area
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Password',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.background),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Minimum 6 characters.',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 6) {
                          return 'Please input a valid password.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredPassword = value!;
                      },
                    ),
                    const SizedBox(height: 40),
                    if (_isAuthenticating) const CircularProgressIndicator(),

                    // Login Or Sign Up Button
                    if (!_isAuthenticating)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: const Size(double.infinity, 55),
                        ),
                        onPressed: _submit,
                        child: Text(
                          _isLogin ? 'Create Account' : 'Log In',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ),

                    // Have An Account Or Not
                    if (!_isAuthenticating)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin
                              ? 'Have an account? Log in'
                              : 'Don\'t have an account? Create one',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
