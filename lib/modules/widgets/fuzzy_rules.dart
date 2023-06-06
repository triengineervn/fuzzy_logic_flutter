fuzzyCheck(String data) {
  String searchStringR1 = "PWM1: 0, PWM2: 0";
  String searchStringR2 = "PWM1: 70, PWM2: 0";
  String searchStringR3 = "PWM1: 80, PWM2: 0";
  String searchStringR4 = "PWM1: 90, PWM2: 0";
  String searchStringR5 = "PWM1: 100, PWM2: 0";
  String searchStringR6 = "PWM1: 0, PWM2: 70";
  String searchStringR7 = "PWM1: 0, PWM2: 80";
  String searchStringR8 = "PWM1: 0, PWM2: 90";
  String searchStringR9 = "PWM1: 0, PWM2: 100";

  bool isContained;
  if (isContained = data.contains(searchStringR1)) {
    return data = 'of1 of2';
  } else if (isContained = data.contains(searchStringR2)) {
    return data = 'sl1 of2';
  } else if (isContained = data.contains(searchStringR3)) {
    return data = 'me1 of2';
  } else if (isContained = data.contains(searchStringR4)) {
    return data = 'fa1 of2';
  } else if (isContained = data.contains(searchStringR5)) {
    return data = 'fu1 of2';
  } else if (isContained = data.contains(searchStringR6)) {
    return data = 'of1 sl2';
  } else if (isContained = data.contains(searchStringR7)) {
    return data = 'of1 me2';
  } else if (isContained = data.contains(searchStringR8)) {
    return data = 'of1 fa2';
  } else if (isContained = data.contains(searchStringR9)) {
    return data = 'of1 fu2';
  }
}
