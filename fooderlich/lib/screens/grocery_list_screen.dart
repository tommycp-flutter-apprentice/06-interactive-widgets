import 'package:flutter/material.dart';
import '../components/grocery_tile.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  const GroceryListScreen({Key? key, required this.manager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the list of grocery items from the manager.
    final groceryItems = manager.groceryItems;
    // Apply padding of 16 pixels all around this screen.
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // Add ListView.
      child: ListView.separated(
        // Set the number of items in the list.
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          // TODO 28: Wrap in a Dismissable
          // You wrap GroceryTile inside an InkWell.
          return InkWell(
            // For each item in the list,
            // get the current item and construct a GroceryTile.
            child: GroceryTile(
                key: Key(item.id),
                item: item,
                // Return onComplete when the user taps the checkbox.
                onComplete: (change) {
                  // Check if there is a change and update
                  // the item’s isComplete status.
                  if (change != null) {
                    manager.completeItem(index, change);
                  }
                }),
            // When the gesture recognizes a tap, it presents GroceryItemScreen,
            // letting the user edit the current item.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroceryItemScreen(
                    originalItem: item,
                    // GroceryItemScreen calls onUpdate when
                    // the user updates an item.
                    onUpdate: (item) {
                      // GroceryManager updates the item at the particular index
                      manager.updateItem(item, index);
                      // Dismisses GroceryItemScreen.
                      Navigator.pop(context);
                    },
                    // onCreate will not be called since
                    // you are updating an existing item.
                    onCreate: (item) {},
                  ),
                ),
              );
            },
          );
        },
        // Space each grocery item 16 pixels apart.
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
