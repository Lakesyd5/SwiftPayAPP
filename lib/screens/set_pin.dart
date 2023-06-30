import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiftpay/screens/dashboard.dart';

final userId = FirebaseAuth.instance.currentUser!.uid;
final db = FirebaseFirestore.instance;

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final _formKey = GlobalKey<FormState>();
  var _userPin = '';

  void _submit () {
    final _isValid = _formKey.currentState!.validate();

    if (!_isValid) {
      return;
    }

    _formKey.currentState!.save();

    // saves the user pin to the database
    final data = {'Pin' : _userPin};
    db.collection('users').doc(userId).set(data, SetOptions(merge: true));

    Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen(),));


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Image.asset('assets/images/swiftpay.png', width: 115),
            const SizedBox(height: 215),
            Text(
              'Set your pin',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25),
            Form(
              key: _formKey,
                child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Just four digits'),
              keyboardType: TextInputType.number,
              obscureText: true,
              maxLength: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty || value.length < 4 || value.length > 4 ) {
                  return 'Please input a valid transaction PIN.';
                }
                return null;
              },
              onSaved: (value) {
                _userPin = value!;
              },
            )),
            const SizedBox(height: 110),
            ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    minimumSize: const Size(double.infinity, 43)
                ),
                child: Text('Set Transaction Pin', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),)),
          ],
        ),
      ),
    );
  }
}
