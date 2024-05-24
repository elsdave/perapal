import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:perapal/contents/contents.dart';
import 'package:perapal/pages/login.dart';
import 'package:perapal/utils/style.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}
const List<String> list = <String>['US', 'PH'];

class _OnboardingState extends State<Onboarding> {
int currentIndex = 0;
 // Initialize contents with the default value

  String dropdownValue = list.first;

  @override
Widget build(BuildContext context) {
  return Scaffold(
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
                    contents = contentsEN;
                  } else if (dropdownValue == 'PH') {
                    contents = contentsPH;
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
    backgroundColor: white,
    body: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: small, vertical: small),
              child: Image.asset('assets/logo1.png'),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: contents.length,
                onPageChanged: (int index){
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: large, vertical: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
        
                        Image(image: AssetImage(contents[i].image), 
                        height: double.parse(contents[i].size),
                        ),             
                        Text(contents[i].title, style: heading3,),
                        SizedBox(height: small,),
                        
                        Text(contents[i].text, style: p1,)
                      ],
                    ),
                  );
                },
              ),
            ), 
            SizedBox(
              height: xsmall,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                    List.generate(
                      contents.length, 
                      (index) => buildDot(index, context)
                      ) 
              )
              ),
            Container(
              height: large,
              margin: EdgeInsets.only(top: medium, bottom: large, left: large, right: large),
              width: double.infinity,
              child: FloatingActionButton(
                backgroundColor: blue,
                onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const LoginPage())
                    );
                },
                child: Text("Get Started",
                style: heading2L,)),
            ),
          ],
        ),
    ),
  );
}

Container buildDot(int index, BuildContext context) {
  return Container(
                  height: 5,
                  width: currentIndex == index ? 15:5,
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(small),
                    color: blue
                  ),
                );
}
}