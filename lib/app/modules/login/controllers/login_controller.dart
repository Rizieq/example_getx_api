import 'package:example_hit_api_dokar/app/config/api_provider.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final ApiProvider apiProvider = ApiProvider();

  Future<void> login(String email, String password) async {
    try {
      final response = await apiProvider.login(email, password);

      switch (response['statusCode']) {
        case 201:
          Get.snackbar(
            'Login Success',
            response['message'], // Pesan sukses dari respons API
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
          print("Login berhasil: ${response['message']}");
          break;
        case 429: // Rate limit exceeded
          Get.snackbar(
            'Error',
            'Too Many Requests',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
          break;
        case 400:
          Get.snackbar(
            'Error',
            response['message'],
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
          break;
        case 404:
          Get.snackbar(
            'Error',
            'Invalid Email',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
          print("Error: Invalid Email");
          break;

        case 500:
          if (response['message'] == 'Invalid password') {
            Get.snackbar(
              'Login Failed',
              'Invalid password',
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 2),
            );
            print("Login gagal: Invalid password");
          } else if (response['message'] == 'Invalid Email') {
            Get.snackbar(
              'Login Failed',
              'Invalid Email',
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 2),
            );
            print("Login gagal: Invalid Email");
          } else {
            Get.snackbar(
              'Server Error',
              'An unknown server error occurred',
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 2),
            );
            print("Error: An unknown server error occurred");
          }
          break;

        default:
          Get.snackbar(
            'Error',
            'Unexpected error occurred',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
          print("Error: Unexpected error occurred");
          break;
      }
    } catch (e) {
      // Jika gagal terhubung ke server
      Get.snackbar(
        'Error',
        'Failed to connect to the server', // Pesan error koneksi
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      print("Error: Failed to connect to the server");
    }
  }
}
