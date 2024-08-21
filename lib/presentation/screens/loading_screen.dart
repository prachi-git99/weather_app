import '../consts/consts.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/loading_img.gif",
          ),
          const Text(
            "Please wait....",
            style: TextStyle(
                fontFamily: poppins,
                color: Colors.deepPurple,
                fontSize: mediumFont),
          )
        ],
      )),
    );
  }
}
