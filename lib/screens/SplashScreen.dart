// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Future.delayed(Duration(seconds: 3), () {
//     //   Get.offNamed("/home");
//     // });
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.flutter_dash,
//               size: 100,
//               color: Colors.white,
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Quotes App ",
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> iconScaleAnimation;
  late Animation<double> textFadeAnimation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    iconScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );


    textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    animationController.forward();

    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed("/home");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: iconScaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: iconScaleAnimation.value,
                  child: Image.asset("assts/quote-left.png",color: Colors.white,height: 100,width: 100,),
                );
              },
            ),
            SizedBox(height: 20),
            AnimatedBuilder(
              animation: textFadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: textFadeAnimation.value,
                  child: Text(
                    "Quotes App",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
