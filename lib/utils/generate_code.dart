import 'dart:math';
class GenerateCode {
  static String generateFolio(int length) {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    String folio = '';

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(characters.length);
      folio += characters[randomIndex];
    }

    // Puedes agregar información adicional si es necesario
    DateTime now = DateTime.now();
    folio += now.microsecondsSinceEpoch.toString();

    return folio;
  }
}
