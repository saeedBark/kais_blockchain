import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constent/my_string.dart';
import 'package:frontend/src/dashboard/dashboard_controller.dart';
import 'package:frontend/src/deposit_details/deposit_details_view.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DashboardController>();
    return Scaffold(
      backgroundColor: AppColors.accent,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DespoiseDetailsView(
                    id: controller.accounts[0]['address'],
                    isDesposit: true,
                    amount: controller.accounts[0]['balance'],

                  ),
                ),
              ),
              child: Text(
                'Deposit',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
        backgroundColor: AppColors.seconde,
        elevation: 2,
      ),
      body: controller.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.only(top: 20),
              child: const _DashboardDetailsView()),
    );
  }
}

/// Widget displaying a list of accounts with details
class _DashboardDetailsView extends StatelessWidget {
  const _DashboardDetailsView();

  static const List<String> names = [
    "Ahmed salem",
    "John Doe",
    "Mary Smith",
    "Fatima  Abdullah",
    "Ali saeed",
    "Sara Ali",
    "Kareem Amir",
    "Aisha Hassan",
    "Hassan"
  ];

  static const List<String> images = [
    "https://st.depositphotos.com/2931363/3703/i/950/depositphotos_37034497-stock-photo-young-black-man-smiling-at.jpg",
    "https://st.depositphotos.com/1743476/2514/i/950/depositphotos_25144755-stock-photo-presenting-your-text.jpg",
    "https://st3.depositphotos.com/12985790/17521/i/1600/depositphotos_175218564-stock-photo-smiling-handsome-man-holding-cup.jpg",
    "https://st5.depositphotos.com/1049680/64158/i/1600/depositphotos_641589546-stock-photo-hispanic-man-standing-blue-background.jpg",
    "https://st4.depositphotos.com/13193658/30158/i/1600/depositphotos_301586860-stock-photo-handsome-businessman-formal-wear-smiling.jpg",
    "https://st3.depositphotos.com/12985790/16264/i/1600/depositphotos_162644654-stock-photo-happy-african-american-man.jpg",
    "https://st5.depositphotos.com/88369228/74460/i/1600/depositphotos_744609920-stock-photo-high-resolution-ultrarealistic-image-photograph.jpg",
    "https://st5.depositphotos.com/62628780/73296/i/1600/depositphotos_732968602-stock-photo-happy-man-portrait-outdoor-relax.jpg",
    "https://st.depositphotos.com/1269204/1219/i/950/depositphotos_12196477-stock-photo-smiling-men-isolated-on-the.jpg"
  ];

  List<Map<String, dynamic>> _generateAccountData(BuildContext context) {
    final accounts = context.watch<DashboardController>().accounts;

    return List.generate(
      names.length,
      (index) {
        return {
          "name": names[index],
          "account": accounts[index]['address'],
          "amount": accounts[index]['balance'],
          "image": images[index],
          "usage_percentage": accounts[index]['usage_percentage'],
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountData = _generateAccountData(context);

    return ListView.builder(
      itemCount: accountData.length,
      itemBuilder: (context, index) => AccountCard(data: accountData[index]),
    );
  }
}

/// Widget displaying account details with a circular progress indicator
class AccountCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const AccountCard({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DespoiseDetailsView(
            amount: data['amount'],
            percentage: data['usage_percentage'],
          ),
        ),
      ),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(data['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data['name']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Address: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          TextSpan(
                            text: data['account'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Amount: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          TextSpan(
                            text: '${data['amount'].toStringAsFixed(2)} MRU',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
