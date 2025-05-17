import 'dart:io';

const steps = [
  [5, 'things you can see'],
  [4, 'things you can feel'],
  [3, 'things you can hear'],
  [2, 'things you can smell'],
  [1, 'thing you can taste'],
];

void waitForTrigger() {
  stdin.echoMode = false;
  stdin.lineMode = false;
  while (true) {
    final byte = stdin.readByteSync();
    if (byte == 32 || byte == 10 || byte == 13) {
      break;
    }
  }
  stdin.echoMode = true;
  stdin.lineMode = true;
}

void main() {
  print('Welcome to the 5-4-3-2-1 grounding technique.');
  print('Press SPACE or ENTER after you identify each item.');

  for (var step in steps) {
    final count = step[0] as int;
    final description = step[1] as String;
    print('\nIdentify $count $description.');
    for (var i = count; i >= 1; i--) {
      stdout.write('$i... ');
      stdout.flush();
      waitForTrigger();
    }
    print('');
  }

  print('Grounding exercise complete. Take a deep breath.');
}
