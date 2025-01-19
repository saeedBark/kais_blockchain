import 'package:frontend/network/api_path.dart';
import 'package:frontend/network/dio_client.dart';

class DepositService {
  Future<void> deposit({
    required String sender,
    required String recipient,
    required double amount,
  }) async {
    await DioHelper().post(
      ApiPath.deposit,
      data: {
        'sender': sender,
        'recipient': recipient,
        'amount': amount,
      },
    );
  }
}
