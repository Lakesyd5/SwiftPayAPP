import 'package:flutter/material.dart';

import 'package:swiftpay/widgets/modal_screen.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final _form = GlobalKey<FormState>();

  void _submit () {
    final _isValid = _form.currentState!.validate();

    if (!_isValid) {
      return;
    }

    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 37.0),
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(height: 150),
          // Transfer Details form
          Form(
            key: _form,
            child: Column(
              children: [
                // Recipients Input
                SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Recipient\'s Account Number',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter 10-digit Account Number'),
                      keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty || value.trim().length < 9+1) {
                      return 'Input a valid account number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // SelectBank Button
                ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context, builder: (context) => ModalScreen());
                  },
                  icon: Icon(Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.background),
                  label: Text(
                    'Select Bank',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.background),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      minimumSize: const Size(double.infinity, 45.0)),
                ),
                const SizedBox(height: 35),

                // Proceed to pay button
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    'Proceed to pay',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground, fontSize: 17, ),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          minimumSize: Size(double.infinity, 40)
                          ),
                          
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
