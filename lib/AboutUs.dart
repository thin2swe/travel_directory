import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_directory/home.dart';

void main() {
  runApp(AboutUs());
}

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AboutUsPage(),
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 25, 173, 199),
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color.fromARGB(255, 25, 173, 199),
        ),
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //Navigator.of(context).pop();
            Get.to(HomePage());
          },
        ),
      ),
      body: AboutUsContent(),
      backgroundColor: Color.fromARGB(255, 25, 173, 199),
    );
  }
}

class AboutUsContent extends StatefulWidget {
  @override
  _AboutUsContentState createState() => _AboutUsContentState();
}

class _AboutUsContentState extends State<AboutUsContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      'Welcome to Smile Tour Agency!',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'At Smile Tour Agency, we believe that travel is about more than just seeing new places—it\'s about creating unforgettable experiences and cherished memories. We are passionate about helping you explore the world and discover its many wonders.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Our Mission',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Our mission is to provide exceptional travel experiences that cater to your interests and preferences. We strive to offer personalized service, expert guidance, and a seamless booking process to make your journey as enjoyable and stress-free as possible.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              /* SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Why Choose Us?',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Expertise: With years of experience in the travel industry, our team has the knowledge and insights to help you plan the perfect trip.\n'
                      //'• Personalized Service: We take the time to understand your travel preferences and create customized itineraries tailored to your needs.\n'
                      '• Exceptional Value: We work hard to provide you with the best travel deals and exclusive offers.\n'
                      '• Commitment to Quality: We partner with trusted providers to ensure that you have a safe, comfortable, and memorable travel experience.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),*/
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Our Services',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• Tour Packages: Explore our wide range of tour packages, designed to suit every traveler\'s taste and budget.\n'
                      //'• Customized Itineraries: Let us create a personalized travel plan that caters to your unique interests and schedule.\n'
                      '• Travel Assistance: From visa applications to travel insurance, we offer comprehensive support to ensure your trip is hassle-free.\n'
                      '• Local Expertise: Benefit from our extensive network of local guides and experts who can provide insider knowledge and recommendations.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 8),
                    Text(
                      // 'We\'d love to hear from you! Whether you have a question about our services or need help planning your next adventure, our team is here to assist you. Get in touch with us at:\n'
                      'Email: info@smiletouragency.com\n'
                      'Phone: +1 (555) 123-4567\n'
                      'Address: 123 Travel Lane, kkkkk City, Country',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Thank you for choosing Smile Tour Agency. We look forward to helping you create unforgettable travel experiences!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
