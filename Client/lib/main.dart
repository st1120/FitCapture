import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:async';
import 'package:numberpicker/numberpicker.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the landing page after 5 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff021A5A),
      body:
      Stack(
        children: [
          Positioned(
            child: Image(
              image: AssetImage('Images/bg1.png'),
              height: 199,
            ),
            top: 0,
            right: 0,
          ),
          Positioned(
            child: Image(
              image: AssetImage('Images/bg2.png'),
              height: 199,
            ),
            bottom: 0,
            left: 0,
          ),
          Center(
          child: Column(
            children: [
              SizedBox(height: 250,),
              Image(
                image: AssetImage('Images/image1.png'),
              ),
              SizedBox(height: 250),
              Text('Powered By', style: TextStyle(fontSize: 12, color: Color(0xffd9d9d9), fontWeight: FontWeight.w600, fontFamily: 'Jost'),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('Images/Logo.png'),
                    height: 20,
                  ),
                  SizedBox(width: 5,)
                ],
              ),
            ],
          ),
        ),
    ],
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff021A5A),
      body: Stack(
        children: [
          Positioned(
            child: Image(
              image: AssetImage('Images/bg1.png'),
              height: 199,
            ),
            top: 0,
            right: 0,
          ),
          Positioned(
            child: Image(
              image: AssetImage('Images/bg2.png'),
              height: 199,
            ),
            bottom: 0,
            left: 0,
          ),
          Container(
            child: Column(
              children: [
                SizedBox(height: 120,),
                Center(
                  child: Text(
                    'Welcome to FitCapture AI',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 20),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Accurate Body Measurements from a Single Image. Capture, Analyze, and Discover Your Perfect Fit with Advanced AI Technology.',
                    style: TextStyle(

                      fontSize: 14,
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Image(
                  image: AssetImage('Images/Group.png'),
                  height: 300,
                ),
                SizedBox(height: 40,),
                SizedBox(
                  width: 230,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff00B15C),
                      foregroundColor: Color(0xffF6F6F6),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    },
                    child: Text('Get Started', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  ),
                ),
                SizedBox(height: 30,),
                Text('Powered By', style: TextStyle(fontSize: 12, color: Color(0xffd9d9d9), fontWeight: FontWeight.w600, fontFamily: 'Jost'),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('Images/Logo.png'),
                      height: 20,
                    ),
                    SizedBox(width: 5,)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayImagePage(image: File(pickedFile.path)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff021A5A),
      body: Stack(
        children: [
          Positioned(
            child: Image(
              image: AssetImage('Images/bg1.png'),
              height: 199,
            ),
            top: 0,
            right: 0,
          ),
          Positioned(
            child: Image(
              image: AssetImage('Images/bg2.png'),
              height: 199,
            ),
            bottom: 0,
            left: 0,
          ),
          Container(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Image(
                  image: AssetImage('Images/image1.png'),
                  height: 60,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Image(
                image: AssetImage('Images/Measuring_illstrations.png'),
                height: 300,
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  'Choose Your Image',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Jost',
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text(
                  'Use a full body standing photo for best results.',
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 12,
                    color: Color(0xffFFD600),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 230,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff00B15C),
                          foregroundColor: Color(0xffF6F6F6),
                        ),
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                        },
                        child: Text('Upload', style: TextStyle(fontSize: 22, fontFamily: 'Jost', fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 55,
                      width: 230,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff00B15C),
                          foregroundColor: Color(0xffF6F6F6),
                        ),
                        onPressed: () {
                          _pickImage(ImageSource.camera);
                        },
                        child: Text('Camera', style: TextStyle(fontSize: 22, fontFamily: 'Jost', fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    ],
      ),
    );
  }
}

class DisplayImagePage extends StatefulWidget {
  final File image;

  const DisplayImagePage({Key? key, required this.image}) : super(key: key);

  @override
  State<DisplayImagePage> createState() => _DisplayImagePageState();
}

class _DisplayImagePageState extends State<DisplayImagePage> {
  int _currentValue=150;
  Map<String, dynamic> measurements = {}; // This will hold your measurements
  final TextEditingController _heightController = TextEditingController();

  Future<void> uploadImage() async {
    // Show the loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            children: [
              SizedBox(
                height: 350,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(height: 20,),
              Text(
                'Fetching Measurements...',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  color: Colors.white,

                ),

              ),
            ],
          ),
        );
      },
    );

    final uri = Uri.parse('http://192.168.1.197:5000/upload');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('file', widget.image.path))
      ..fields['height'] =  _currentValue.toString();


    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final result = json.decode(responseBody);

      setState(() {
        measurements = result; // Update measurements
      });

      print(measurements);

      // Dismiss the loading dialog
      Navigator.pop(context);

      // Navigate to MeasurementsPage after getting the measurements
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeasurementsPage(measurements: measurements),
        ),
      );
    } catch (error) {
      print('Error uploading file: $error');
      // Dismiss the loading dialog in case of error
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff021A5A),
      body: Stack(
        children: [
          Positioned(
            child: Image(
              image: AssetImage('Images/bg1.png'),
              height: 199,
            ),
            top: 0,
            right: 0,
          ),
          Positioned(
            child: Image(
              image: AssetImage('Images/bg2.png'),
              height: 199,
            ),
            bottom: 0,
            left: 0,
          ),
          Container(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.fromLTRB(12, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image(
                          image: AssetImage('Images/Frame5.png'),
                          height: 32,
                        ),
                      ),
                    ),
                    Center(
                      child: Image(
                        image: AssetImage('Images/image1.png'),
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 45,),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                      widget.image
                  ),
                ),
                height: 350,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xff00B15C),
                      width: 2
                    ),
                  borderRadius: BorderRadius.circular(12)
                ),
              ),

              SizedBox(height: 30,),
              Container(
                child: Text(
                  'Enter Your Height in CM',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                child: NumberPicker(
                  value: _currentValue,
                  minValue: 10,
                  maxValue: 200,
                  onChanged: (value) => setState(() => _currentValue = value),
                  textStyle: TextStyle(
                    color: Colors.grey, // Unselected numbers color
                    fontSize: 25,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Colors.white, // Selected number color
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 230,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff00B15C),
                    foregroundColor: Color(0xffF6F6F6),
                  ),
                  onPressed: () {
                    uploadImage();
                  },
                  child: Text('Get Measurements', style: TextStyle(fontSize: 20, fontFamily: 'Jost', fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
    ],
      ),
    );
  }
}

class MeasurementsPage extends StatelessWidget {
  final Map<String, dynamic> measurements;
  String capitalizeWords(String str) {
    return str.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return word;
    }).join(' ');
  }
  int getShirtSize(String s) {
    double size = double.parse(s);
    if(size<=100.3){
      return 38;
    }
    else if(size<=107.3){
      return 40;
    }
    else if(size<=114.9){
      return 42;
    }
    else if(size<=122.6){
      return 44;
    }
    else{
      return 46;
    }
  }

  int getPantsSize(String s) {
    double size = double.parse(s);
    if(size<=76.2){
      return 30;
    }
    else if(size<=81.3){
      return 32;
    }
    else if(size<=86.4){
      return 34;
    }
    else if(size<=91.4){
      return 36;
    }
    else{
      return 38;
    }
  }

  void _shareMeasurements() {
    String measurementText = "Here are my measurements:\n\n";
    measurements.forEach((key, value) {
      measurementText += "${capitalizeWords(key)}: ${value.toStringAsFixed(3)}\n";
    });

    int shirtSize = getShirtSize(measurements['chest'].toString());
    int pantsSize = getPantsSize(measurements['waist'].toString());

    measurementText += "\nPreferred Sizes:\n\n";
    measurementText += "Shirt Size: $shirtSize\n";
    measurementText += "Pants Size: $pantsSize\n";

    Share.share(measurementText);
  }

  const MeasurementsPage({Key? key, required this.measurements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff021A5A),
      body: Stack(
        children: [
          Positioned(
            child: Image(
              image: AssetImage('Images/bg1.png'),
              height: 199,
            ),
            top: 0,
            right: 0,
          ),
          Positioned(
            child: Image(
              image: AssetImage('Images/bg2.png'),
              height: 199,
            ),
            bottom: 0,
            left: 0,
          ),
          Container(
          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image(
                          image: AssetImage('Images/Frame5.png'),
                          height: 32,
                        ),
                      ),
                    ),
                    Center(
                      child: Image(
                        image: AssetImage('Images/image1.png'),
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 50,),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Measurements',
                style: TextStyle(fontSize: 30,color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Jost'),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...measurements.entries.map((entry) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${capitalizeWords(entry.key)}:',
                            style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Jost',),
                          ),
                          Text(
                            '${entry.value.toStringAsFixed(3)}',
                            style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Jost',),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Preferred Sizes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white, fontFamily: 'Jost',), ),
                    Container(
                      padding: EdgeInsets.fromLTRB(80, 20, 80, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage('Images/tabler_shirt.png'),
                            height: 50,
                          ),
                          Text(
                            getShirtSize(measurements['chest'].toStringAsFixed(3).toString()).toString(),
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white,),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(80, 5, 80, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(image: AssetImage('Images/ph_pants-light.png'),
                          height: 50,),
                          Text(
                              getPantsSize(measurements['waist'].toStringAsFixed(3).toString()).toString(),
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white,),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton.icon(
                        onPressed: _shareMeasurements,
                        icon: Icon(Icons.share),
                        label: Text("Share"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff00B15C),
                          foregroundColor: Color(0xffF6F6F6),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          textStyle: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
    ],
      ),
    );
  }
}
