// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OtherActions extends StatelessWidget {
  const OtherActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 23.0, // gap between adjacent chips
      runSpacing: 10.0, // gap between lines
      // crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        // Internet Button
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(132, 235, 232, 232),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.wifi,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('Internet')
            ],
          ),
        ),

        // Betting Button
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(132, 235, 232, 232),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.sports_soccer_outlined,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('Betting')
            ],
          ),
        ),
        
        // Fast Food Button
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(132, 235, 232, 232),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.fastfood_outlined,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('Fast Food')
            ],
          ),
        ),

        // Tv Button
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(132, 235, 232, 232),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.tv_rounded,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('Internet')
            ],
          ),
        ),

        // Electricity Button
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(132, 235, 232, 232),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.electric_bolt_sharp,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('Electricity')
            ],
          ),
        ),

        // Transport Button
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(132, 235, 232, 232),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.emoji_transportation_outlined,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('Transport')
            ],
          ),
        ),

        // Loan Button
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(132, 235, 232, 232),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.monetization_on_outlined,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('Loan')
            ],
          ),
        ),

        // More Button
        Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(132, 235, 232, 232),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  Icons.arrow_forward_outlined,
                  size: 30,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text('More')
            ],
          ),
        ),
      ],
    );
  }
}

