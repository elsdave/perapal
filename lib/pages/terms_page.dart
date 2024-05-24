import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:perapal/contents/terms_eng.dart';
import 'package:perapal/contents/terms_ph.dart';
import 'package:perapal/utils/style.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

const List<String> list = <String>['US', 'PH'];

class _TermsAndConditionsState extends State<TermsAndConditions> {
  String dropdownValue = list.first;
  Widget? terms;

  @override
  void initState() {
    super.initState();
    terms = TermsEng();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: white,
        actions: [
          Padding(
            padding: EdgeInsets.all(small),
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: CountryFlag.fromCountryCode(
                dropdownValue,
                height: 25,
                width: 25,
                borderRadius: 30,
              ),
              elevation: 0,
              style: pBold,
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                  if (dropdownValue == 'US') {
                    terms = TermsEng();
                  } else if (dropdownValue == 'PH') {
                    terms = TermsPh();
                  }
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(medium),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    terms?? Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}