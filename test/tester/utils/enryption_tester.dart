import 'package:flutter_test/flutter_test.dart';
import 'package:twipe_flutter_core/utils/encryption/crypt.dart';
import 'package:twipe_flutter_core/utils/test/tester.dart';

class EncryptionTester extends Tester {
  @override
  Future<void> doTest() async {
    testCrypt('Hallo, wie geht es dir heute?',
        'nd9n3na8b12wdf02nrwe7f2vfuwenf289fbzuefbwef');
    testCrypt('Hallo, wie geht es dir heute?', 'test');
  }

  void testCrypt(String value, String key) {
    test('Checking Crypt with Key: ' + key + ' Value: ' + value, () {
      String enrypted = Crypt.encrypt(key, value);
      expect(true, (value != enrypted));
      String decrypted = Crypt.decrypt(key, enrypted);
      expect(value, decrypted);
    });
  }
}
