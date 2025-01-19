import 'package:flutter/material.dart';
import 'package:frontend/constent/my_string.dart';
import 'package:frontend/src/deposit/deposit_view.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DespoiseDetailsView extends StatelessWidget {
  final String? id;
  final bool isDesposit;
  final double amount;
  final double percentage;
  

  const DespoiseDetailsView({
    super.key,
    this.id,
    this.isDesposit = false,
    this.amount = 4000,
    this.percentage = 0.0,
  });

  @override
  Widget build(BuildContext context) {

    print(id);
    return Scaffold(
      backgroundColor: AppColors.accent,
      appBar: AppBar(
        title: Text('Deposit Details'),
        backgroundColor: AppColors.seconde,
        shadowColor: AppColors.primary,
        elevation: 2,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16)
            .copyWith(top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 8.0,
                      percent: percentage / 100,
                      center: Text(
                        "${percentage.toStringAsFixed(1)} %",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      progressColor: AppColors.primary,
                      backgroundColor: Colors.grey[300]!,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 12),
                        Text(
                          '${amount.toStringAsFixed(2)} MRU',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isDesposit) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  DepositView(
                            address: id??'',
                          ),
                        ),
                      ),
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
                  ),
                ],
              ),
            ],
            const SizedBox(height: 20),
            const Text(
              'Transactions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '1000 MRU',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '2025-01-08 09:43:24',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        const Text(
                          '0x179a282Ca6c4C8FBFF0e467C889896322AD6E1cad',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(bottom: 16),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '2000 MRU',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '2025-01-07 11:43:24',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        const Text(
                          '0x179a282Ca6c4C8FBFF0e467C889896322AD6E1Ba',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '3000 MRU',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '2025-01-06 10:55:24',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        const Text(
                          '0x179a282Ca6c4C8FBFF0e467C889896322AD6Earb',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
