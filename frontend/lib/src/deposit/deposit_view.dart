import 'package:flutter/material.dart';
import 'package:frontend/constent/my_string.dart';
import 'package:frontend/src/deposit/deposit_controller.dart';
import 'package:provider/provider.dart';

class DepositView extends StatelessWidget {
  final String address;
  const DepositView({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DepositController(address: address),
        child: _DespoistBody(),);
  }
}

class _DespoistBody extends StatelessWidget {
  const _DespoistBody();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DepositController>();
    return Scaffold(
      backgroundColor: AppColors.accent,
      appBar: AppBar(
        title: const Text('Deposit'),
        backgroundColor: AppColors.seconde,
      ),
      body: Container(
        margin: const EdgeInsets.all(16).copyWith(top: 80),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
          
              TextFormField(
                controller: controller.amountController,
                decoration: InputDecoration(
                  hintText: 'Enter The Amount',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primary, width: 2),
                  ),
                  
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Deposit Button
              InkWell(
                onTap: controller.deposit,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary,
                  ),
                  child: const Center(
                    child: Text(
                      '+ DEPOSIT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
