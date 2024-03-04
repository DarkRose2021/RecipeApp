import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_app/common/bottom-nav.dart';
import 'package:recipe_app/common/drawer.dart';
import 'package:recipe_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scan/scan.dart';
import 'package:http/http.dart' as http;

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});
  @override
  State<BarcodeScanner> createState() => _BarcodeScanner();
}

enum AccountItems { profile, settings, logout }

class _BarcodeScanner extends State<BarcodeScanner> {
  ScanController controller = ScanController();
  var _scanResult = '';
  List<String> scanResults = [];
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadDarkModePreference();
  }

  void loadDarkModePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  void saveDarkModePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: isDarkMode ? Colors.white : Colors.teal,
          ),
          centerTitle: true,
          title: RichText(
            text: const TextSpan(
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 32,
                  fontFamily: 'Nexus',
                ),
                children: [
                  TextSpan(
                      text: 'Neu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  TextSpan(
                    text: 'Foods',
                  ),
                ]),
          ),
          actions: [
            // profileButton(),
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
                saveDarkModePreference(value);
              },
              activeColor: Colors.teal,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: scanResults
                      .map((title) => Text(
                            title,
                            style: const TextStyle(fontSize: 24),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showBarcodeScanner,
          tooltip: 'Scan Barcode',
          backgroundColor: Colors.teal,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: const Icon(
            Icons.scanner,
            color: Colors.white,
          ),
        ),
      ),
      theme: isDarkMode ? darkTheme : lightTheme,
    );
  }

  _showBarcodeScanner() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Scaffold(
                appBar: _buildBarcodeScannerAppBar(),
                body: _buildBarcodeScannerBody(),
              ));
        });
      },
    );
  }

  AppBar _buildBarcodeScannerAppBar() {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(color: Colors.tealAccent, height: 4.0),
      ),
      title: Text(
        'Scan Your Barcode',
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      elevation: 0.0,
      backgroundColor: const Color(0xFF333333),
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Center(
            child: Icon(
          Icons.cancel,
          color: Colors.white,
        )),
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () => controller.toggleTorchMode(),
            child: const Icon(
              Icons.flashlight_on,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarcodeScannerBody() {
    return SizedBox(
      height: 400,
      child: ScanView(
        controller: controller,
        scanAreaScale: .7,
        scanLineColor: Colors.tealAccent,
        onCapture: (data) {
          setState(() {
            _scanResult = data;
            Navigator.of(context).pop();
            _sendBarcodeDataToAPI(data);
          });
        },
      ),
    );
  }

  _sendBarcodeDataToAPI(String barcodeData) async {
    await dotenv.load();
    final String apiKey = dotenv.env['API_KEY'] ?? '';
    final Uri uri =
        Uri.parse('https://api.spoonacular.com/food/products/upc/$barcodeData');
    final Map<String, String> headers = {
      'x-api-key': apiKey,
    };

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        String productTitle = responseData['title'];
        setState(() {
          scanResults.add(productTitle);
        });
      } else {
        // Handle the error case
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
