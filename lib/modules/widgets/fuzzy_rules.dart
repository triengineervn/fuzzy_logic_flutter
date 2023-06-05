fuzzyCheck(String data) {
  late String output;

  if (data == 'PWM1: 0, PWM2: 0') {
    output = 'of1 of2';
  } else if (data == 'PWM1: 70, PWM2: 0') {
    output = 'sl1 of2';
  } else if (data == 'PWM1: 80, PWM2: 0') {
    output = 'me1 of2';
  } else if (data == 'PWM1: 90, PWM2: 0') {
    output = 'fa1 of2';
  } else if (data == 'PWM1: 100, PWM2: 0') {
    output = 'fu1 of2';
  } else if (data == 'PWM1: 0, PWM2: 70') {
    output = 'of1 sl2';
  } else if (data == 'PWM1: 0, PWM2: 80') {
    output = 'of1 me2';
  } else if (data == 'PWM1: 0, PWM2: 90') {
    output = 'of1 fa2';
  } else if (data == 'PWM1: 0, PWM2: 100') {
    output = 'of1 fu2';
  }
  return output;
}
