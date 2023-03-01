import 'package:flutter/material.dart';
import 'homepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: 'myPRs')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.red,
            image: const DecorationImage(
              image: AssetImage('images/clear_background_logo.png'),
            ),
            border: Border.all(
                color: Colors.red, width: 5, style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            boxShadow: const [
              BoxShadow(color: Colors.red, blurRadius: 6.0, spreadRadius: 5.0)
            ],
          ),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
