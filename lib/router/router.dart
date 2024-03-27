import '../features/crypto_details/view/crypto_details_screen.dart';
import '../features/crypto_list/view/crypto_list_screen.dart';

final routes = {
  "/": (context) => const CryptoListScreen(),
  "/coin": (context) => const CryptoCoinScreen(),
};
