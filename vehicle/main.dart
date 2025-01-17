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
      home: AddVehiclePage(),
    );
  }
}

class AddVehiclePage extends StatefulWidget {
  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  String? selectedVehicleType;
  String? selectedVehicleBrand;
  final TextEditingController numberPlateController = TextEditingController();
  String? numberPlateError;

  final Map<String, List<String>> vehicleBrands = {
    'Car': [
      'BMW',
      'Mercedes-Benz',
      'Audi',
      'Toyota',
      'Honda',
      'Ford',
      'Chevrolet',
      'Nissan',
      'Hyundai',
      'Volkswagen',
    ],
    'Bike': [
      'Harley-Davidson',
      'Kawasaki',
      'Yamaha',
      'Ducati',
      'Royal Enfield',
      'Suzuki',
      'KTM',
      'BMW Motorrad',
      'Honda',
      'Triumph',
    ],
  };

  final RegExp numberPlateRegExp = RegExp(
    r'^[A-Z]{2}\s\d{2}\s[A-Z]{1,2}\s\d{1,4}$',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              const Text(
                'Add a vehicle',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey[300],
                child: ClipOval(
                  child: Image.asset(
                    'assets/carss.png',
                    fit: BoxFit.cover,
                    width: 190,
                    height: 190,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'vehicle details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'add your vehicle details below',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 102, 101, 101),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildDropdownField(
                hint: 'your vehicle Type',
                value: selectedVehicleType,
                items: ['Car', 'Bike'],
                onChanged: (value) {
                  setState(() {
                    selectedVehicleType = value;
                    selectedVehicleBrand = null;
                  });
                },
              ),
              const SizedBox(height: 15),
              _buildNumberPlateField(),
              const SizedBox(height: 15),
              _buildDropdownField(
                hint: 'vehicle brand',
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateNumberPlate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Vehicle added successfully'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberPlateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: numberPlateController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.tag, color: Colors.grey[700]),
                hintText: 'Enter number plate (e.g., MH 12 AB 1234)',
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          if (numberPlateError != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                numberPlateError!,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(hint, style: const TextStyle(color: Colors.grey)),
            isExpanded: true,
            items:
                items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

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
}
