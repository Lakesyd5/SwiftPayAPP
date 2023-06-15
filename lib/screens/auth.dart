import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredFirstname = '';
  var _enteredLastname = '';
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() {
    final _isValid = _form.currentState!.validate();
    

    if (!_isValid) {
      return;
    }

    _form.currentState!.save();

    if (_isLogin) {
      // Log Users in
    } else {}
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
              const SizedBox(height: 60),
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
                      },
                      onSaved: (value) {
                        _enteredPassword = value!;
                      },
                    ),
                    const SizedBox(height: 40),
                    // Login Or Sign Up Button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: const Size(double.infinity, 55),
                          // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 120)
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
                        )),
                    // Have An Account Or Not
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
                        )),
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
