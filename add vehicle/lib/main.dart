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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
              SizedBox(height: screenHeight * 0.1), // 10% of screen height
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    'assets/carss.png', // Replace with your image path
                    fit: BoxFit.cover,
                    height: screenHeight * 0.4, // 40% of screen height
                    width: screenWidth * 0.8, // 80% of screen width
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.03),
            child: ElevatedButton(
              onPressed: () {
                _showAddVehicleBottomSheet(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.2,
                  vertical: screenHeight * 0.02,
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
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const AddVehiclePopup();
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Vehicle Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildDropdownField(
              hint: 'Select Vehicle Type',
              value: selectedVehicleType,
              items: ['Car', 'Bike'],
              onChanged: (value) {
                setState(() {
                  selectedVehicleType = value;
                  selectedVehicleBrand = null;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.02),
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
            SizedBox(height: screenHeight * 0.02),
            _buildNumberPlateField(),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              onPressed: _submitDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.3,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 20, color: Colors.white),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
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
          dropdownColor: Colors.white,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildNumberPlateField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
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
