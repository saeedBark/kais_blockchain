import 'package:flutter/material.dart';
import 'package:frontend/src/dashboard/dashboard_service.dart';

class DashboardController extends ChangeNotifier {
  DashboardController() {
    getAccounts();
  }

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

  List<dynamic> accounts = [];
  bool isLoading = false;

  Future<void> getAccounts() async {
    isLoading = true;

    final response = await DashboardService().getAccounts();

    isLoading = false;



  accounts = response['accounts_with_balances'].skip(1).toList();

    notifyListeners();
  }
}
