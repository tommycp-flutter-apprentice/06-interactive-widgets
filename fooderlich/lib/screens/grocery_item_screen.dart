import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';

class GroceryItemScreen extends StatefulWidget {
  // onCreate is a callback that lets you know when a new item is created.
  final Function(GroceryItem) onCreate;
  // onUpdate is a callback that returns the updated grocery item.
  final Function(GroceryItem) onUpdate;
  // The grocery item that the user clicked.
  final GroceryItem? originalItem;
  // isUpdating determines whether the user is creating or editing an item.
  final bool isUpdating;

  const GroceryItemScreen(
      {Key? key,
      required this.onCreate,
      required this.onUpdate,
      this.originalItem})
      : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  // _nameController is a TextEditingController.
  // This controller listens for text changes.
  // It controls the value displayed in a text field.
  final _nameController = TextEditingController();
  // _name stores the name of the item.
  String _name = '';
  // _importance stores the importance level.
  Importance _importance = Importance.low;
  // _dueDate stores the current date and time.
  DateTime _dueDate = DateTime.now();
  // _timeOfDay stores the current time.
  TimeOfDay _timeOfDay = TimeOfDay.now();
  // _currentColor stores the color label.
  Color _currentColor = Colors.green;
  // _currentSliderValue stores the quantity of an item.
  int _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
    // When the originalItem is not null, the user is editing an existing item.
    // In this case, you must configure the widget to show the item’s values.
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _nameController.text = originalItem.name;
      _name = originalItem.name;
      _currentSliderValue = originalItem.quantity;
      _importance = originalItem.importance;
      _currentColor = originalItem.color;
      final date = originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    // Adds a listener to listen for text field changes.
    // When the text changes, you set the _name.
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold defines the main layout and structure of the entire screen.
    return Scaffold(
      // Includes an app bar with one action button.
      // The user will tap this button when they’ve finished creating an item.
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // TODO 24: Add callback handler
            },
          )
        ],
        // Sets elevation to 0.0, removing the shadow under the app bar.
        elevation: 0.0,
        // Sets the title of the app bar.
        title: Text(
          'Grocery Item',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
      ),
      // Shows a ListView, padded by 16 pixels on every side,
      // within the body of the scaffold. You’ll fill this list view with
      // a bunch of interactive widgets soon.
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            // TODO 17: Add color picker
            // TODO 18: Add slider
            // TODO 19: Add Grocery Tile
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    // Creates a Column to lay elements out vertically.
    return Column(
      // Aligns all widgets in the column to the left.
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Adds a Text that’s styled using GoogleFonts.
        Text(
          'Item Name',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        // Adds a TextField to enter the name of the item.
        TextField(
          // Sets the TextField’s TextEditingController.
          controller: _nameController,
          // Sets the cursor color.
          cursorColor: _currentColor,
          // Styles the text field using InputDecoration.
          decoration: InputDecoration(
            // Includes a hint to give users an example of what to write.
            hintText: 'E.g. Apples, Banana, 1 Bag of salt',
            // Customizes the text field’s border color.
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: _currentColor),
            ),
          ),
        )
      ],
    );
  }

  Widget buildImportanceField() {
    // Use a Column to lay out the widgets vertically.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add Text.
        Text(
          'Importance',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        // Add Wrap and space each child widget 10 pixels apart.
        // Wrap lays out children horizontally. When there’s no more room,
        // it wraps to the next line.
        Wrap(
          spacing: 10.0,
          children: [
            // Create a ChoiceChip for the user to select the low priority.
            ChoiceChip(
              // Set the selected chip’s background color to black.
              selectedColor: Colors.black,
              // Check whether the user selected this ChoiceChip.
              selected: _importance == Importance.low,
              label: const Text(
                'low',
                style: TextStyle(color: Colors.white),
              ),
              // Update _importance, if the user selected this choice.
              onSelected: (selected) {
                setState(() => _importance = Importance.low);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.medium,
              label: const Text(
                'medium',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() => _importance = Importance.medium);
              },
            ),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.high,
              label: const Text(
                'high',
                style: TextStyle(color: Colors.white),
              ),
              onSelected: (selected) {
                setState(() => _importance = Importance.high);
              },
            ),
          ],
        )
      ],
    );
  }

  // TODO: ADD buildDateField()
  Widget buildDateField(BuildContext context) {
    // Adds a Column to lay out elements vertically.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Adds a Row to lay out elements horizontally.
        Row(
          // Adds a space between elements in the row.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Adds the date Text.
            Text(
              'Date',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            // Adds a TextButton to confirm the selected value.
            TextButton(
              child: const Text('Select'),
              // Gets the current date when the user presses the button.
              onPressed: () async {
                final currentDate = DateTime.now();
                // Presents the date picker. You restrict the date picker
                // and only allow the user to pick a date from today
                // until five years in the future.
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );
                // Sets _dueDate after the user selects a date.
                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
              },
            ),
          ],
        ),
        // Format the current date and display it with a Text.
        Text('${DateFormat('yyyy-MM-dd').format(_dueDate)}'),
      ],
    );
  }

  Widget buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Time of Day',
              style: GoogleFonts.lato(fontSize: 28.0),
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () async {
                // Shows the time picker when the user taps the Select button.
                final timeOfDay = await showTimePicker(
                  // Sets the initial time displayed in the
                  // time picker to the current time.
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                // Once the user selects the time widget, it updates _timeOfDay.
                setState(() {
                  if (timeOfDay != null) {
                    _timeOfDay = timeOfDay;
                  }
                });
              },
            ),
          ],
        ),
        Text('${_timeOfDay.format(context)}'),
      ],
    );
  }

  // TODO: Add buildColorPicker()

  // TODO: Add buildQuantityField()
}
