import 'package:flutter/material.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final _formKey = GlobalKey<FormState>();
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
              validator: (value) {
                if (value == null || value.trim().isEmpty || value.length < 4 || value.length > 4 || value.characters == String) {
                  return 'Please input a valid transaction PIN.';
                }
              },
            )),
            const SizedBox(height: 110),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    minimumSize: const Size(double.infinity, 43)
                ),
                child: Text('Set Transaction Pin', style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),))
          ],
        ),
      ),
    );
  }
}
