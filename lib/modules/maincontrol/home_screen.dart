// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fuzzy/modules/widgets/fetch_data_firebase.dart';
import 'package:flutter_fuzzy/modules/widgets/fuzzy_rules.dart';
import 'package:flutter_fuzzy/modules/widgets/show_toast.dart';
import 'package:flutter_fuzzy/modules/widgets/value_extractor.dart';
import 'package:flutter_fuzzy/modules/widgets/water_animation.dart';
import 'package:flutter_fuzzy/themes/app_assets.dart';

import 'package:flutter_fuzzy/themes/app_colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseReference reference = FirebaseDatabase.instance.ref();
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  final databaseReference = FirebaseDatabase.instance.ref();
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuzzy Logic Control'),
        centerTitle: true,
        backgroundColor: AppColors.APP_PRIMARY_BUTTON,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return StreamBuilder(
                    stream: fetchAllDataFromFirebase(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      ValueExtractor extractor = ValueExtractor();
                      String text = snapshot.data.toString();
                      String pwm1 = extractor.extractValue(text, "PWM1");
                      String pwm2 = extractor.extractValue(text, "PWM2");
                      String tankWater = extractor.extractValue(text, "v2tv");
                      if (snapshot.hasData) {
                        return Container(
                          margin: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: AppColors.APP_SECONDARY_BUTTON,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: Text(
                                              'set water'.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.APP_PRIMARY_BUTTON),
                                            ),
                                          ),
                                          Slider(
                                            value: _currentSliderValue,
                                            max: 99,
                                            divisions: 28,
                                            label: _currentSliderValue.round().toString(),
                                            onChanged: (double value) {
                                              setState(() {
                                                _currentSliderValue = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 32,
                                            width: 64,
                                            decoration: BoxDecoration(
                                              color: AppColors.APP_PRIMARY_BUTTON,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: StreamBuilder(
                                              stream: fetchDataEnableFromFirebase(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String> snapshot) {
                                                if (snapshot.data == 'true') {
                                                  return TextButton(
                                                    onPressed: () {
                                                      showToast();
                                                      reference.update({
                                                        "vdat": checkValueGet(
                                                            _currentSliderValue.toInt())
                                                      });
                                                    },
                                                    child: const Center(
                                                      child: Text(
                                                        'SET',
                                                        style: TextStyle(
                                                            color: AppColors.WHITE,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return const Center(
                                                    child: Text(
                                                      'SET',
                                                      style: TextStyle(
                                                          color: AppColors.WHITE,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                              '${checkValueGet(_currentSliderValue.toInt())}%',
                                              style: const TextStyle(
                                                  fontSize: 36,
                                                  color: AppColors.PRUSSIAN_BLUE,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: size.height / 6,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: AppColors.UT_ORANGE,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                'set volume v1'.toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.WHITE),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Center(
                                                child: StreamBuilder(
                                                  stream: fetchDataV1FromFirebase(),
                                                  builder: (BuildContext context,
                                                      AsyncSnapshot<String> snapshot) {
                                                    if (snapshot.connectionState ==
                                                        ConnectionState.waiting) {
                                                      return const Center(
                                                        child: CircularProgressIndicator(
                                                          strokeAlign: 3,
                                                        ),
                                                      );
                                                    } else if (snapshot.hasError) {
                                                      return Text('${snapshot.error}');
                                                    } else {
                                                      return Text(
                                                        '${snapshot.data}%',
                                                        style: const TextStyle(
                                                            fontSize: 50,
                                                            color: AppColors.PRUSSIAN_BLUE,
                                                            fontWeight: FontWeight.bold),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: size.height / 6,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: AppColors.UT_ORANGE,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                'get volumn v2'.toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.WHITE),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 4),
                                              child: Center(
                                                child: StreamBuilder(
                                                  stream: fetchDataV2FromFirebase(),
                                                  builder: (BuildContext context,
                                                      AsyncSnapshot<String> snapshot) {
                                                    if (snapshot.connectionState ==
                                                        ConnectionState.waiting) {
                                                      return const Center(
                                                        child: CircularProgressIndicator(
                                                          strokeAlign: 3,
                                                        ),
                                                      );
                                                    } else if (snapshot.hasError) {
                                                      return Text('${snapshot.error}');
                                                    } else {
                                                      return Text(
                                                        '${snapshot.data}%',
                                                        style: const TextStyle(
                                                            fontSize: 50,
                                                            color: AppColors.PRUSSIAN_BLUE,
                                                            fontWeight: FontWeight.bold),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              WaterAnimation(
                                duration: const Duration(seconds: 1),
                                firstValue: double.parse(tankWater) / 3.57 * 8,
                                secondValue: double.parse(tankWater) / 3.57 * 8,
                                thirdValue: double.parse(tankWater) / 3.57 * 8,
                                fourthValue: double.parse(tankWater) / 3.57 * 8,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 12),
                                child: const Row(
                                  children: [
                                    AppIcons.sunny,
                                    Text(
                                      ' Luật mờ:',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                                    ),
                                  ],
                                ),
                              ),
                              StreamBuilder<Object>(
                                stream: fetchAllDataFromFirebase(),
                                builder: (context, snapshot) {
                                  String temp = fuzzyCheck(snapshot.data.toString());
                                  // print(temp);

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        strokeAlign: 3,
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  } else {
                                    return Center(
                                      child: Container(
                                        height: size.height / 15,
                                        width: size.width / 2,
                                        decoration: BoxDecoration(
                                          color: AppColors.APP_PRIMARY_BUTTON,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            temp,
                                            style: const TextStyle(
                                                color: AppColors.WHITE,
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 32),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: CircularPercentIndicator(
                                              radius: 75,
                                              lineWidth: 16,
                                              percent: double.parse(pwm1) / 100,
                                              progressColor: AppColors.APP_PRIMARY_BUTTON,
                                              circularStrokeCap: CircularStrokeCap.round,
                                              center: Text(
                                                pwm1,
                                                style: const TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'PWM1'.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.APP_TEXT),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Center(
                                            child: CircularPercentIndicator(
                                              radius: 75,
                                              lineWidth: 16,
                                              percent: double.parse(pwm2) / 100,
                                              progressColor: AppColors.APP_PRIMARY_BUTTON,
                                              circularStrokeCap: CircularStrokeCap.round,
                                              center: Text(
                                                pwm2,
                                                style: const TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              'PWM2'.toUpperCase(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.APP_TEXT),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 3),
                        );
                      }
                    },
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkValueGet(int int) {
    int = _currentSliderValue.toInt();
    if (_currentSliderValue.toInt() == 24) {
      return int = 25;
    } else if (_currentSliderValue.toInt() == 31) {
      return int = 32;
    } else if (_currentSliderValue.toInt() == 38) {
      return int = 39;
    } else if (_currentSliderValue.toInt() == 45) {
      return int = 46;
    } else if (_currentSliderValue.toInt() == 49) {
      return int = 50;
    } else if (_currentSliderValue.toInt() == 56) {
      return int = 57;
    } else if (_currentSliderValue.toInt() == 70) {
      return int = 71;
    } else if (_currentSliderValue.toInt() == 74) {
      return int = 75;
    } else if (_currentSliderValue.toInt() == 77) {
      return int = 78;
    } else if (_currentSliderValue.toInt() == 81) {
      return int = 82;
    } else if (_currentSliderValue.toInt() == 84) {
      return int = 86;
    } else if (_currentSliderValue.toInt() == 88) {
      return int = 89;
    } else if (_currentSliderValue.toInt() == 91) {
      return int = 92;
    } else if (_currentSliderValue.toInt() == 95) {
      return int = 96;
    } else {
      return int;
    }
  }
}
