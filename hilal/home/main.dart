import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ParkingUI());
  }
}

class ParkingUI extends StatefulWidget {
  @override
  _ParkingUIState createState() => _ParkingUIState();
}

class _ParkingUIState extends State<ParkingUI> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Frame11.png"), // Background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuItem("Home", 0),
                  SizedBox(width: 40),
                  menuItem("Services", 1),
                  SizedBox(width: 40),
                  menuItem("Join us", 2),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.04,
                        bottom: 50,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AutoSpaXe",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                              height: 1.0,
                            ),
                          ),
                          Text(
                            "Perfected",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 4,
                                height:
                                    240, // Extended the height of the orange line
                                color: Colors.orange,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Park Smarter with",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                  Text(
                                    "the Next-Gen",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                  Text(
                                    "Parking Solution",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "Streamlined parking. Professional Service.\n",
                                          style: TextStyle(
                                            fontFamily:
                                                "Calibri Light", // Updated font family
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight
                                                .w300, // Reduced font weight
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              "Streamlined parking. Professional Service.\n",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight
                                                .w300, // Reduced font weight
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Professional Service.",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight
                                                .w300, // Reduced font weight
                                            fontFamily: 'SourceSansPro',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment(
                          -0.8, 0.0), // Adjusted alignment to move the button
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1; // Select 'Services' menu
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Learn More",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight:
                  _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 3,
            width: 50,
            color: _selectedIndex == index ? Colors.orange : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

