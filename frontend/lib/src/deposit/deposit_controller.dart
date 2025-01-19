import 'package:flutter/material.dart';
import 'package:frontend/src/dashboard/dashboard_service.dart';
import 'package:frontend/src/deposit/deposit_service.dart';

class DepositController extends ChangeNotifier {
  final String address;
  DepositController({required this.address}) {
    getAccount();
  }
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String addressadmin = '';

  Future<void> getAccount() async {
    isLoading = true;

    final response = await DashboardService().getAccounts();

    isLoading = false;

    addressadmin = response['accounts_with_balances'].first['address'];

    notifyListeners();
  }

  Future<void> deposit() async {
    isLoading = true;

    await DepositService().deposit(
      sender: address,
      recipient: addressadmin,
      amount:double.tryParse( amountController.text)?? 2,
    );

    isLoading = false;

    notifyListeners();
  }
}
