
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const StudentInfoApp());
}
// MAIN APPLICATION
class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}
// STUDENT PROFILE SCREEN
class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor:
        Theme.of(context).colorScheme.primaryContainer,
      ),

      // ORIENTATION BUILDER
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  // PORTRAIT LAYOUT
  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        StudentDetailsSection(),

        SizedBox(height: 16),

        Card(
          child: TitleSection(
            name: 'Hogwarts School of Witchcraft and Wizardry',
            location: 'Hogsmeade, Scotland',
            starCount: 41,
          ),
        ),

        SizedBox(height: 16),

        ImageSection(
          imagePath: 'assets/images/hogwarts.jpg',
        ),
        const SizedBox(height: 16),

        PickerSection(),
      ],
    );
  }

  // LANDSCAPE LAYOUT
  Widget _buildLandscapeView() {
    return Row(
      children: [
        // LEFT SIDE: STUDENT PROFILE
        const Expanded(
          child: SingleChildScrollView(
            child: StudentDetailsSection(),
          ),
        ),

        // RIGHT SIDE: LOCATION AND LAKE IMAGE
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: const [
              Card(
                child: TitleSection(
                  name: 'Hogwarts School of Witchcraft and Wizardry',
                  location: 'Hogsmeade, Scotland',
                  starCount: 41,
                ),
              ),

              SizedBox(height: 16),

              ImageSection(
                imagePath: 'assets/images/hogwarts.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// STUDENT DETAILS SECTION
class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // YOUR PROFILE PICTURE
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/picture.jpg'),
            ),

            const SizedBox(height: 20),

            // YOUR FULL NAME
            const Text(
              'KHARUNAAMETTA A/P PARAMANATHAN',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // STUDENT ID
            const Text(
              'Student ID: BCS24020055',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const Divider(
              height: 32,
              thickness: 1,
            ),

            const Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              '"TO GROW MORE MATURE & WISE, TO HAVE FINANCIAL FREEDOM"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TITLE SECTION (EXERCISE 2.1)
class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.star,
            color: Colors.red[500],
          ),

          const SizedBox(width: 4),

          Text('$starCount'),
        ],
      ),
    );
  }
}

// IMAGE SECTION (EXERCISE 2.2)
class ImageSection extends StatelessWidget {
  final String imagePath;

  const ImageSection({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 240,
        fit: BoxFit.cover,
      ),
    );
  }
}

class PickerSection extends StatefulWidget {
  const PickerSection({super.key});

  @override
  State<PickerSection> createState() => _PickerSectionState();
}

class _PickerSectionState extends State<PickerSection> {

  // Store selected date and role
  DateTime _selectedDate = DateTime.now();
  String _selectedRole = 'Student';

  final List<String> _roles = [
    'Student',
    'Developer',
    'Designer',
  ];

  // =================================
  // 1. MATERIAL DATE PICKER
  // =================================

  Future<void> _selectMaterialDate(
      BuildContext context) async {

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // =================================
  // 2. CUPERTINO DATE PICKER
  // =================================

  void _showCupertinoDatePicker(BuildContext context) {

    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) => Container(
        height: 260,
        color: CupertinoColors.systemBackground
            .resolveFrom(popupContext),
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  onPressed: () =>
                      Navigator.of(popupContext).pop(),
                  child: const Text('Done'),
                ),
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                minimumDate: DateTime(1950),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =================================
  // 3. CUPERTINO ROLE WHEEL PICKER
  // =================================

  void _showCupertinoRolePicker(BuildContext context) {

    showCupertinoModalPopup<void>(
      context: context,
      builder: (popupContext) => Container(
        height: 220,
        color: CupertinoColors.systemBackground
            .resolveFrom(popupContext),
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  onPressed: () =>
                      Navigator.of(popupContext).pop(),
                  child: const Text('Done'),
                ),
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                  initialItem: _roles.indexOf(_selectedRole),
                ),
                itemExtent: 32,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _selectedRole = _roles[index];
                  });
                },
                children: _roles.map((role) {
                  return Center(
                    child: Text(role),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // DISPLAY ALL FOUR PICKERS
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Interactive Pickers',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Selected Date: '
                  '${MaterialLocalizations.of(context).formatMediumDate(_selectedDate)}',
            ),

            Text('Selected Role: $_selectedRole'),

            const Divider(height: 24),

            // MATERIAL DATE PICKER
            const Text(
              'Date Selection:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _selectMaterialDate(context),
                icon: const Icon(Icons.calendar_month),
                label: const Text('Material Date Picker'),
              ),
            ),

            const SizedBox(height: 8),

            // CUPERTINO DATE PICKER
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    _showCupertinoDatePicker(context),
                icon: const Icon(Icons.date_range),
                label: const Text(
                  'Cupertino Date Picker (Modal Sheet)',
                ),
              ),
            ),

            const SizedBox(height: 20),

            // MATERIAL DROPDOWN
            const Text(
              'Material Dropdown:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            DropdownButton<String>(
              value: _selectedRole,
              isExpanded: true,
              items: _roles.map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                }
              },
            ),

            const SizedBox(height: 12),

            // CUPERTINO WHEEL PICKER
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    _showCupertinoRolePicker(context),
                icon: const Icon(Icons.swap_vert),
                label: const Text(
                  'Cupertino Wheel Picker',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
