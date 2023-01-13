import 'package:flutter/material.dart';
import 'package:toonflix/widgets/button.dart';
import 'package:toonflix/widgets/card.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Hey, Selena',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Total Balance',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '\$5 194 482',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Button(
                      text: 'Transfer',
                      bgcolor: Color(0xFFF2B33A),
                      textcolor: Colors.black,
                    ),
                    Button(
                      text: 'Request',
                      bgcolor: const Color(0xFF1F2123),
                      textcolor: Colors.white.withOpacity(0.7),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Wallets',
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const CurrencyCard(
                  currency: 'Euro',
                  symbol: 'EUR',
                  money: '6 428',
                  icons: Icons.euro_rounded,
                  isInverted: false,
                  order: 1,
                ),
                const CurrencyCard(
                  currency: 'Dollar',
                  symbol: 'USD',
                  money: '55 622',
                  icons: Icons.attach_money_rounded,
                  isInverted: true,
                  order: 2,
                ),
                const CurrencyCard(
                  currency: 'Bitcoin',
                  symbol: 'BTC',
                  money: '9 785',
                  icons: Icons.currency_bitcoin_rounded,
                  isInverted: false,
                  order: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
