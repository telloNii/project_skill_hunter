import 'package:flutter/material.dart';

class HomeScreenWidget extends StatelessWidget {
  HomeScreenWidget(
      {required this.image, required this.fullName, required this.email});
  late final String image, fullName, email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Color(0xffaaccbb))],
          border: Border.all(width: 0.2),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(email),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
