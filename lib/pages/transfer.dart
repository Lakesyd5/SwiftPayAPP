import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  void _showModal () {
    if (Platform.isIOS) {
      showCupertinoModalPopup(context: context, builder: (ctx) => CupertinoAlertDialog(title: Text('Select Bank'), actions: [
        Wrap(children: [
          
        ],)
      ],));
    } else {
      
    }
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
          Form(
              child: Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Bank Account Number',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 35),
              SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Card Number',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 35),
              ElevatedButton.icon(
                onPressed: _showModal,
                icon: Icon(Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.background),
                label: Text(
                  'Select Bank',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.background),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    minimumSize: const Size(double.infinity, 45.0)),
              ),
            ],
          ))
        ],
      ),
    ));
  }
}
