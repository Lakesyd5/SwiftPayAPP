// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RecipientScreen extends StatefulWidget {
  const RecipientScreen({super.key, required this.recipientData});

  final Map<String, dynamic> recipientData;

  @override
  State<RecipientScreen> createState() => _RecipientScreenState();
}

class _RecipientScreenState extends State<RecipientScreen> {
  final _form = GlobalKey<FormState>();
  bool isLoading = false;

  void _submit () {
    final _isValid = _form.currentState!.validate();

    if (!_isValid) {
      return;
    }

    _form.currentState!.save();

    setState(() {
      isLoading = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display Receiver Information
              SizedBox(
                height: 40,
              ),
              Image.asset('assets/images/banks/swiftpay.png'),
              SizedBox(height: 15),
              Text('${widget.recipientData['Firstname']} ${widget.recipientData['Lastname']}',
                  style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 5),
              Text(
                'SWIFTPAY(${widget.recipientData['Account Number']})',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 10),
              Text('Available Balance:'),
              SizedBox(height: 90),

              // Form Filed
              Form(
                key: _form,
                child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text('How much do you want to send?')),
                  SizedBox(height: 10,),  
                  TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Enter amount'),
                    validator: (value) {
                      if (value!.isEmpty || int.tryParse(value) == null) {
                        return 'Please input an amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: Text('Transaction Narration')),
                  SizedBox(height: 10,),  
                  TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Narration'),
                    keyboardType: TextInputType.number,
                    
                    
                  ),
                  SizedBox(height: 40),

                  // Next Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primaryContainer, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), minimumSize: Size(double.infinity, 45)),
                    onPressed: () {}, child: Text('Next',style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onBackground),)),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
