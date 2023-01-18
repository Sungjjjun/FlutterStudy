import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String currency, symbol, money;
  final IconData icons;
  final bool isInverted;
  final int order;

  final Color black = const Color(0xFF1F2123);

  const CurrencyCard({
    super.key,
    required this.currency,
    required this.symbol,
    required this.money,
    required this.icons,
    required this.isInverted,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, (order - 1) * -20),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : black,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currency,
                    style: TextStyle(
                      color: isInverted ? black : Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        money,
                        style: TextStyle(
                          color: isInverted ? black : Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        symbol,
                        style: TextStyle(
                          color: isInverted
                              ? black.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Transform.scale(
                scale: 2.2,
                child: Transform.translate(
                  offset: const Offset(-5, 13),
                  child: Icon(
                    icons,
                    color: isInverted ? black : Colors.white,
                    size: 88,
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
