import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftpay/screens/airtime_ui/topup_verify.dart';

class SelectNetworkScreen extends StatefulWidget {
  const SelectNetworkScreen({super.key});

  @override
  State<SelectNetworkScreen> createState() => _SelectNetworkScreenState();
}

class _SelectNetworkScreenState extends State<SelectNetworkScreen> {
  final formKey = GlobalKey<FormState>();
  var phoneNumber = '';
  var airtimeAmount = '';
  var selectedAirtimeName = '';
  var selectedAirtimeImage = '';

  void topUp() {
    formKey.currentState!.save();

    if (selectedAirtimeName.isEmpty) {
      if (Platform.isIOS) {
        showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: const Text(
              'Select Airtime Network',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: const Text(
              'Select Airtime Network',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }
    } else {
      final isValid = formKey.currentState!.validate();

      if (isValid) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopupVerify(
              phone: phoneNumber,
              amount: airtimeAmount,
              airtime: selectedAirtimeName,
              airtimeImage: selectedAirtimeImage,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 90),
              const Text(
                'Select Network',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Network Display
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Airtel
                    Opacity(
                      opacity: selectedAirtimeName == 'Airtel' ? 1.0 : 0.5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAirtimeName = 'Airtel';
                            selectedAirtimeImage = 'assets/images/airtel.png';
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/airtel.png',
                              width: 55,
                              height: 55,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 8),
                            const Text('Airtel'),
                          ],
                        ),
                      ),
                    ),

                    // MTN
                    Opacity(
                      opacity: selectedAirtimeName == 'Mtn' ? 1.0 : 0.5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAirtimeName = 'Mtn';
                            selectedAirtimeImage = 'assets/images/mtn.png';
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/mtn.png',
                              width: 55,
                              height: 55,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 8),
                            const Text('MTN'),
                          ],
                        ),
                      ),
                    ),

                    // Glo
                    Opacity(
                      opacity: selectedAirtimeName == 'Glo' ? 1.0 : 0.5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAirtimeName = 'Glo';
                            selectedAirtimeImage = 'assets/images/glo.png';
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/glo.png',
                              width: 55,
                              height: 55,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 8),
                            const Text('Glo'),
                          ],
                        ),
                      ),
                    ),

                    // 9mobile
                    Opacity(
                      opacity: selectedAirtimeName == '9mobile' ? 1.0 : 0.5,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAirtimeName = '9mobile';
                            selectedAirtimeImage = 'assets/images/9mobile.png';
                          });
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/9mobile.png',
                              width: 55,
                              height: 55,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 8),
                            const Text('9mobile'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Form Input
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input for receiving number
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(fontSize: 13)),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty ||
                            int.tryParse(value) == null ||
                            value.trim().length < 11 || value.trim().length > 11) {
                          return 'Please provide a phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        phoneNumber = value!;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Enter Amount input and Top up button
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter how much you want to top up',
                                hintStyle: TextStyle(fontSize: 13),
                                prefixText: '₦',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    int.tryParse(value) == null) {
                                  return 'Please input an input';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                airtimeAmount = value!;
                              },
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                minimumSize: const Size(15, 30)),
                            onPressed: topUp,
                            child: Text(
                              'Top Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
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
