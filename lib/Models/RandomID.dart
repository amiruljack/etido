import 'dart:math';

final random = Random.secure();

class RandomID {
  static String letterLowerCase = "abcdefghijklmnopqrstuvwxyz";
  static String letterUpperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  static String number = '0123456789';

  static String generateRandomID() {
    String allValidCharacters = '$letterLowerCase$letterUpperCase$number';

    var rest = [
      for (var i = 0; i < 16; i += 1) allValidCharacters[random.nextInt(allValidCharacters.length)],
    ];

    return (rest..shuffle(random)).join();
  }
}
