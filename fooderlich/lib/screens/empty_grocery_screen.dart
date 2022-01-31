import 'package:flutter/material.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Padding: Adds 30 pixels on all sides.
    return Padding(
      padding: const EdgeInsets.all(30),
      // Center: Places all the other widgets in the center.
      child: Center(
        // Column: Handles the vertical layouts of the other widgets.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TODO 4: Add empty image
            // TODO 5: Add empty screen title
            // TODO 6: Add empty screen subtitle
            // TODO 7: Add browse recipes button
          ],
        ),
      ),
    );
  }
}
