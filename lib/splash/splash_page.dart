import 'package:ai_eng_tutor/pages/home_page.dart';
import 'package:ai_eng_tutor/pages/home_screen.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  PageController controller = PageController();
  int currentPage = 0; // To keep track of the current page

  List<String> splashImages = [
    'asset/splash/ai_robot.png',
    'asset/splash/community.png', // Add the second and third images here
    'asset/splash/img.png',
  ];
  List<String> splashInfo = [
    '24/7 teacher',
    'Easy communication', // Add the second and third images here
    'Cheaper,Faster,Good',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              itemCount: splashImages.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        splashImages[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: 260,
                      child: Text(
                        splashInfo[index],
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple),textAlign: TextAlign.center,
                        maxLines: 3,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (currentPage == splashImages.length - 1) {
                    // Navigate to HomePage if it's the last page
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  } else {
                    // Go to the next page
                    controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  backgroundColor:
                  MaterialStateProperty.all(Colors.deepPurple),
                ),
                child: Text(
                  currentPage == splashImages.length - 1 ? "Get Started" : "Next",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
