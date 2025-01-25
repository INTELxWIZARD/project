import 'package:flutter/material.dart';

void main() {
  runApp(const AddVehicleApp());
}

class AddVehicleApp extends StatelessWidget {
  const AddVehicleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddVehicleHomePage(),
    );
  }
}

class AddVehicleHomePage extends StatelessWidget {
  const AddVehicleHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
        centerTitle: true,
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 72), // 3 cm space from the heading
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    'assets/carss.png', // Replace with your image path
                    fit: BoxFit.cover,
                    height: 400,
                    width: 400,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () {
                _showAddVehicleBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Add Vehicle',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddVehicleBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Make the bottom sheet scrollable
      backgroundColor:
          Colors.transparent, // Remove background to make it smooth
      builder: (BuildContext context) {
        return AddVehiclePopup();
      },
    );
  }
}

class AddVehiclePopup extends StatefulWidget {
  const AddVehiclePopup({Key? key}) : super(key: key);

  @override
  _AddVehiclePopupState createState() => _AddVehiclePopupState();
}

class _AddVehiclePopupState extends State<AddVehiclePopup> {
  String? selectedVehicleType;
  String? selectedVehicleBrand;
  final TextEditingController numberPlateController = TextEditingController();
  String? numberPlateError;

  final Map<String, List<String>> vehicleBrands = {
    'Car': ['BMW', 'Toyota', 'Audi', 'Ford', 'Hyundai'],
    'Bike': ['Yamaha', 'Kawasaki', 'Honda', 'Suzuki', 'KTM'],
  };

  final RegExp numberPlateRegExp = RegExp(
    r'^[A-Z]{2}\s\d{2}\s[A-Z]{1,2}\s\d{1,4}$',
  );

  bool _validateNumberPlate() {
    final input = numberPlateController.text.trim();
    if (numberPlateRegExp.hasMatch(input)) {
      setState(() {
        numberPlateError = null;
      });
      return true;
    } else {
      setState(() {
        numberPlateError = 'Invalid number plate format';
      });
      return false;
    }
  }

  void _submitDetails() {
    if (!_validateNumberPlate() ||
        selectedVehicleType == null ||
        selectedVehicleBrand == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly.')),
      );
      return;
    }

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Vehicle added successfully: \nType: $selectedVehicleType\nBrand: $selectedVehicleBrand\nPlate: ${numberPlateController.text}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 3, 0, 0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Vehicle Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              hint: 'Select Vehicle Type',
              value: selectedVehicleType,
              items: ['Car', 'Bike'],
              onChanged: (value) {
                setState(() {
                  selectedVehicleType = value;
                  selectedVehicleBrand = null; // Reset brand when type changes
                });
              },
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              hint: 'Select Vehicle Brand',
              value: selectedVehicleBrand,
              items:
                  selectedVehicleType != null
                      ? vehicleBrands[selectedVehicleType!] ?? []
                      : [],
              onChanged: (value) {
                setState(() {
                  selectedVehicleBrand = value;
                });
              },
            ),
            const SizedBox(height: 40),
            _buildNumberPlateField(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _submitDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 60,
                ), // Increased padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(
                  30,
                  60,
                ), // Set a minimum height for the button
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 22, // Increased font size
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: const TextStyle(color: Colors.grey)),
          isExpanded: true,
          items:
              items.map((item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildNumberPlateField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: numberPlateController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.tag),
          hintText: 'Number Plate (e.g. MH 12 AB 1234)',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
