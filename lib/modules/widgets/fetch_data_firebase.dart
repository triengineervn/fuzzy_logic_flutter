// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_fuzzy/modules/widgets/value_extractor.dart';

Stream<String> fetchDataV1FromFirebase() {
  DatabaseReference reference = FirebaseDatabase.instance.ref();

  return reference.child('v1tv').onValue.map((event) {
    // print(event.snapshot.value.toString());
    var v1 = event.snapshot.value.toString();
    return v1;
  });
}

Stream<String> fetchDataV2FromFirebase() {
  DatabaseReference reference = FirebaseDatabase.instance.ref();

  return reference.child('v2tv').onValue.map((event) {
    // print(event.snapshot.value.toString());
    var v2 = event.snapshot.value.toString();
    return v2;
  });
}

Stream<String> fetchDataEnableFromFirebase() {
  DatabaseReference reference = FirebaseDatabase.instance.ref();

  return reference.child('chophep').onValue.map((event) {
    // print(event.snapshot.value.toString());
    var chophep = event.snapshot.value.toString();
    return chophep;
  });
}

Stream<String> fetchAllDataFromFirebase() {
  DatabaseReference reference = FirebaseDatabase.instance.ref();

  return reference.onValue.map((event) {
    // print(event.snapshot.value.toString());
    String text = event.snapshot.value.toString();
    ValueExtractor extractor = ValueExtractor();

    var checkV1 = extractor.extractValue(text, "v1tv");
    var checkV2 = extractor.extractValue(text, "v2tv");
    int value1 = int.parse(checkV1);
    int value2 = int.parse(checkV2);

    int dhvalue = value1 - value2;
    var output;

    if (dhvalue > -3 && dhvalue < 3) {
      output = '{PWM1: 0, PWM2: 0, v2tv: $checkV2}';
    } else if (dhvalue >= 3 && dhvalue <= 8) {
      output = '{PWM1: 70, PWM2: 0, v2tv: $checkV2}';
    } else if (dhvalue > 8 && dhvalue <= 14) {
      output = '{PWM1: 80, PWM2: 0, v2tv: $checkV2}';
    } else if (dhvalue > 14 && dhvalue <= 28) {
      output = '{PWM1: 90, PWM2: 0, v2tv: $checkV2}';
    } else if (dhvalue > 28) {
      output = '{PWM1: 100, PWM2: 0, v2tv: $checkV2}';
    } else if (dhvalue >= -8 && dhvalue <= -3) {
      output = '{PWM1: 0, PWM2: 70, v2tv: $checkV2}';
    } else if (dhvalue >= -14 && dhvalue < -8) {
      output = '{PWM1: 0, PWM2: 80, v2tv: $checkV2}';
    } else if (dhvalue >= -28 && dhvalue < -14) {
      output = '{PWM1: 0, PWM2: 90, v2tv: $checkV2}';
    } else if (dhvalue < -28) {
      output = '{PWM1: 0, PWM2: 100, v2tv: $checkV2}';
    }

    // print(output);
    return output;
  });
}
